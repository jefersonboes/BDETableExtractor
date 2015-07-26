unit MainUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBTables, StdCtrls;

type
  TMainForm = class(TForm)
    Database: TDatabase;
    Table: TTable;
    ListBox: TListBox;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
    procedure GetAliasNames;
  public
    { Public declarations }
  end;

var
  MainForm: TMainForm;

implementation

{$R *.dfm}

procedure WriteInteger(Stream: TFileStream; Value: Integer);
begin
  Stream.Write(Value, 4);
end;

procedure WriteString(Stream: TFileStream; Str: String);
var
  Size: Integer;
begin
  Size := Length(Str);
  WriteInteger(Stream, Size);
  Stream.Write(Pointer(Str)^, Size);
end;

procedure WriteTableData(Database: TDataBase; Table: TTable; TableName: String);
var
  i: Integer;
  TableData: TFileStream;
begin
  Table.Close;
  Table.TableName := TableName;
  Table.DatabaseName := Database.DatabaseName;
  Table.Open;

  TableData := TFileStream.Create(ExtractFilePath(Application.ExeName) + TableName + '.txt', fmOpenWrite or fmCreate);
  try
    WriteInteger(TableData, Table.Fields.Count);

    for i := 0 to Table.Fields.Count -1 do
    begin
      WriteString(TableData, Table.Fields[i].FieldName);
    end;

    WriteInteger(TableData, Table.RecordCount);

    while not Table.Eof do
    begin
      for i := 0 to Table.Fields.Count -1 do
      begin
        WriteString(TableData, Table.Fields[i].AsString);
      end;

      Table.Next;
    end;
  finally
    TableData.Free;
    Table.Close;
  end;
end;

procedure WriteData(DataBase: TDatabase; Table: TTable);
var
  Tables: TStringList;
  i: Integer;
  FileTables: TFileStream;
  TableName: String;
begin
  FileTables := TFileStream.Create(ExtractFilePath(Application.ExeName) + 'Tables.txt', fmOpenWrite or fmCreate);
  Tables := TStringList.Create;
  try
    Database.GetTableNames(Tables, False);

    WriteInteger(FileTables, Tables.Count);

    for i := 0 to Tables.Count - 1 do
    begin
      TableName := Tables[i];
      WriteString(FileTables, TableName);
      WriteTableData(DataBase, Table, TableName);
    end;
  finally
    Tables.Free;
    FileTables.Free;
  end;
end;

procedure TMainForm.FormCreate(Sender: TObject);
begin
  GetAliasNames;
end;

procedure TMainForm.GetAliasNames;
begin
  Session.GetAliasNames(ListBox.Items);
end;

procedure TMainForm.Button1Click(Sender: TObject);
begin
  if ListBox.ItemIndex = -1 then
    ListBox.ItemIndex := 0;

  Database.Close;
  Database.AliasName := ListBox.Items[ListBox.ItemIndex];
  WriteData(DataBase, Table);
  Database.Close;
end;

end.
