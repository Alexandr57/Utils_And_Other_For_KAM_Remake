object Form1: TForm1
  Left = 0
  Top = 0
  ClientHeight = 480
  ClientWidth = 640
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 151
    Height = 13
    Caption = #1055#1072#1087#1082#1080' '#1087#1086#1080#1089#1082#1072' '#1080' '#1048#1089#1087#1088#1072#1074#1083#1077#1085#1080#1103':'
  end
  object Label2: TLabel
    Left = 8
    Top = 127
    Width = 115
    Height = 13
    Caption = #1048#1089#1087#1088#1072#1074#1083#1077#1085#1085#1099#1077' '#1092#1072#1081#1083#1099':'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 27
    Width = 498
    Height = 94
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ItemHeight = 19
    ParentFont = False
    TabOrder = 0
  end
  object Memo1: TMemo
    Left = 8
    Top = 146
    Width = 624
    Height = 295
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object Button1: TButton
    Left = 8
    Top = 447
    Width = 624
    Height = 25
    Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1087#1088#1086#1094#1077#1089#1089
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 512
    Top = 27
    Width = 120
    Height = 25
    Cursor = crHandPoint
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1072#1087#1082#1091
    TabOrder = 3
  end
  object Button3: TButton
    Left = 512
    Top = 58
    Width = 120
    Height = 25
    Cursor = crHandPoint
    Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1072#1087#1082#1091
    Enabled = False
    TabOrder = 4
  end
  object Button4: TButton
    Left = 512
    Top = 96
    Width = 120
    Height = 25
    Cursor = crHandPoint
    Caption = #1047#1072#1075#1088#1091#1079#1080#1090#1100' '#1089#1087#1080#1089#1086#1082
    TabOrder = 5
  end
end
