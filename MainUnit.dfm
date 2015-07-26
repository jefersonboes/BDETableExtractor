object MainForm: TMainForm
  Left = 492
  Top = 235
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'BDE Table Extractor'
  ClientHeight = 226
  ClientWidth = 437
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox: TListBox
    Left = 16
    Top = 8
    Width = 297
    Height = 201
    ItemHeight = 13
    TabOrder = 0
  end
  object Button1: TButton
    Left = 328
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Start'
    TabOrder = 1
    OnClick = Button1Click
  end
  object Database: TDatabase
    AliasName = 'Test'
    DatabaseName = 'Test'
    SessionName = 'Default'
    Left = 336
    Top = 48
  end
  object Table: TTable
    SessionName = 'Default'
    Left = 392
    Top = 48
  end
end
