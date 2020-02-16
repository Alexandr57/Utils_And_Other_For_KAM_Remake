object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = '[KMR] OpCodnik by Alexandr_5'
  ClientHeight = 640
  ClientWidth = 480
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 437
    Width = 480
    Height = 3
    Cursor = crVSplit
    Align = alBottom
    ExplicitTop = 50
    ExplicitWidth = 390
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 480
    Height = 50
    Align = alTop
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 9
      Top = 9
      Width = 462
      Height = 32
      Cursor = crHandPoint
      Align = alClient
      Caption = #1055#1077#1088#1077#1079#1072#1075#1088#1091#1079#1080#1090#1100' '#1054#1087#1082#1086#1076#1099
      TabOrder = 0
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 590
    Width = 480
    Height = 50
    Align = alBottom
    Padding.Left = 8
    Padding.Top = 8
    Padding.Right = 8
    Padding.Bottom = 8
    TabOrder = 1
    object BitBtn2: TBitBtn
      Left = 9
      Top = 9
      Width = 462
      Height = 32
      Cursor = crHandPoint
      Align = alClient
      Caption = #1050#1086#1087#1080#1088#1086#1074#1072#1090#1100' '#1054#1087#1082#1086#1076#1099
      TabOrder = 0
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 440
    Width = 480
    Height = 150
    Align = alBottom
    ScrollBars = ssVertical
    TabOrder = 2
  end
  object PageControlMain: TPageControl
    Left = 0
    Top = 50
    Width = 480
    Height = 387
    ActivePage = TabSheetMainOpCodes
    Align = alClient
    TabOrder = 3
    object TabSheetMainOpCodes: TTabSheet
      Caption = #1054#1087#1082#1086#1076#1099
      object PageControlOpCodes: TPageControl
        Left = 0
        Top = 0
        Width = 472
        Height = 359
        ActivePage = TabSheetStates
        Align = alClient
        TabOrder = 0
        object TabSheetConsts: TTabSheet
          Caption = 'Consts'
          object CheckListConsts: TCheckListBox
            Left = 0
            Top = 0
            Width = 464
            Height = 331
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 19
            ParentFont = False
            TabOrder = 0
          end
        end
        object TabSheetEvents: TTabSheet
          Caption = 'Events'
          ImageIndex = 1
          object CheckListEvents: TCheckListBox
            Left = 0
            Top = 0
            Width = 464
            Height = 331
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 19
            ParentFont = False
            TabOrder = 0
          end
        end
        object TabSheetActions: TTabSheet
          Caption = 'Actions'
          ImageIndex = 2
          object CheckListActions: TCheckListBox
            Left = 0
            Top = 0
            Width = 464
            Height = 331
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 19
            ParentFont = False
            TabOrder = 0
          end
        end
        object TabSheetStates: TTabSheet
          Caption = 'States'
          ImageIndex = 3
          object CheckListStates: TCheckListBox
            Left = 0
            Top = 0
            Width = 464
            Height = 331
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 19
            ParentFont = False
            TabOrder = 0
          end
        end
        object TabSheetUtils: TTabSheet
          Caption = 'Utils'
          ImageIndex = 4
          object CheckListUtils: TCheckListBox
            Left = 0
            Top = 0
            Width = 464
            Height = 331
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -16
            Font.Name = 'Tahoma'
            Font.Style = []
            ItemHeight = 19
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
    object TabSheetMainSettings: TTabSheet
      Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
end
