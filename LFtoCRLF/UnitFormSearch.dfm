object FormSearch: TFormSearch
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = #1055#1088#1086#1094#1077#1089#1089' '#1087#1086#1080#1089#1082#1072' '#1080' '#1087#1088#1077#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077':'
  ClientHeight = 309
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 30
    Height = 13
    Caption = #1060#1072#1081#1083':'
  end
  object Label2: TLabel
    Left = 8
    Top = 54
    Width = 50
    Height = 13
    Caption = #1055#1088#1086#1075#1088#1077#1089#1089':'
  end
  object Label3: TLabel
    Left = 8
    Top = 96
    Width = 26
    Height = 13
    Caption = 'Logs:'
  end
  object Label4: TLabel
    Left = 8
    Top = 238
    Width = 151
    Height = 13
    Caption = #1053#1072#1081#1076#1077#1085#1086' '#1082#1086#1083#1080#1095#1077#1089#1090#1074#1086' '#1092#1072#1081#1083#1086#1074':'
  end
  object Label5: TLabel
    Left = 8
    Top = 257
    Width = 111
    Height = 13
    Caption = #1048#1080#1089#1087#1088#1072#1074#1083#1077#1085#1086' '#1092#1072#1081#1083#1086#1074':'
  end
  object LabelSearchingFiles: TLabel
    Left = 165
    Top = 238
    Width = 6
    Height = 13
    Caption = '0'
  end
  object LabelFixedFiles: TLabel
    Left = 125
    Top = 257
    Width = 6
    Height = 13
    Caption = '0'
  end
  object EditFile: TEdit
    Left = 15
    Top = 27
    Width = 297
    Height = 21
    ReadOnly = True
    TabOrder = 0
  end
  object ProgressBar1: TProgressBar
    Left = 15
    Top = 73
    Width = 297
    Height = 17
    TabOrder = 1
  end
  object MemoLogs: TMemo
    Left = 15
    Top = 115
    Width = 297
    Height = 117
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object Button1: TButton
    Left = 8
    Top = 276
    Width = 304
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100' '#1086#1082#1085#1086
    TabOrder = 3
    OnClick = Button1Click
  end
  object PopupMenu1: TPopupMenu
    Left = 40
    Top = 120
    object N1: TMenuItem
      Caption = #1057#1082#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1074#1089#1077
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074' '#1051#1086#1075
      OnClick = N2Click
    end
  end
end
