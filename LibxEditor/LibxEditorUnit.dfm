object frmLibxEditorMain: TfrmLibxEditorMain
  Left = 0
  Top = 0
  ClientHeight = 720
  ClientWidth = 960
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnPaint = FormPaint
  PixelsPerInch = 96
  TextHeight = 13
  object pnlInfo: TPanel
    Left = 0
    Top = 0
    Width = 960
    Height = 26
    Align = alTop
    AutoSize = True
    TabOrder = 0
    object lblSelectFile: TLabel
      Left = 1
      Top = 1
      Width = 958
      Height = 24
      Align = alTop
      Alignment = taCenter
      AutoSize = False
      Layout = tlCenter
      ExplicitTop = 2
    end
  end
  object pnlMain: TPanel
    Left = 0
    Top = 26
    Width = 960
    Height = 694
    Align = alClient
    TabOrder = 1
    object PageControlParam: TPageControl
      Left = 1
      Top = 1
      Width = 336
      Height = 692
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      ActivePage = tabFiles
      Align = alLeft
      Style = tsButtons
      TabHeight = 24
      TabOrder = 0
      TabWidth = 108
      object tabFiles: TTabSheet
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Caption = #1042#1099#1073#1086#1088' '#1090#1077#1082#1089#1090#1072
        ImageIndex = 3
        object GroupBoxDir: TGroupBox
          Left = 0
          Top = 0
          Width = 328
          Height = 153
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Folders'
          Padding.Left = 8
          Padding.Top = 8
          Padding.Right = 8
          Padding.Bottom = 8
          TabOrder = 0
          object CheckListBoxFolders: TCheckListBox
            Left = 10
            Top = 23
            Width = 308
            Height = 120
            OnClickCheck = CheckListBoxFoldersClickCheck
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
        object GroupBoxFiles: TGroupBox
          Left = 0
          Top = 153
          Width = 328
          Height = 505
          Align = alClient
          Caption = 'Files'
          Color = clWhite
          Padding.Left = 8
          Padding.Top = 8
          Padding.Right = 8
          Padding.Bottom = 8
          ParentBackground = False
          ParentColor = False
          TabOrder = 1
          object SearchBox: TSearchBox
            Left = 10
            Top = 75
            Width = 308
            Height = 21
            Align = alTop
            TabOrder = 0
            OnInvokeSearch = SearchBoxInvokeSearch
          end
          object pnlSelTabList: TPanel
            Left = 10
            Top = 23
            Width = 308
            Height = 28
            Align = alTop
            BevelOuter = bvNone
            Color = clWhite
            ParentBackground = False
            TabOrder = 1
            object rbtnSelListFiles: TRadioButton
              Left = 0
              Top = 0
              Width = 154
              Height = 24
              Cursor = crHandPoint
              Caption = #1060#1072#1081#1083#1099
              Checked = True
              TabOrder = 0
              TabStop = True
              OnClick = rbtnSelListFilesClick
              OnMouseEnter = rbtnSelList_MouseEnter
              OnMouseLeave = rbtnSelList_MouseLeave
            end
            object rbtnSelListText: TRadioButton
              Left = 154
              Top = 0
              Width = 154
              Height = 24
              Cursor = crHandPoint
              Caption = #1058#1077#1082#1089#1090#1099
              TabOrder = 1
              OnClick = rbtnSelListTextClick
              OnMouseEnter = rbtnSelList_MouseEnter
              OnMouseLeave = rbtnSelList_MouseLeave
            end
            object pnlSelListColor: TPanel
              Left = 0
              Top = 24
              Width = 154
              Height = 4
              Color = 3355443
              ParentBackground = False
              TabOrder = 2
            end
          end
          object ListBoxFiles: TListBox
            Left = 10
            Top = 96
            Width = 308
            Height = 399
            Style = lbOwnerDrawFixed
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ItemHeight = 24
            ParentFont = False
            TabOrder = 2
            OnClick = ListBoxFilesClick
            OnDrawItem = ListBox_DrawItem
          end
          object ListBoxTexts: TListBox
            Left = 10
            Top = 96
            Width = 308
            Height = 399
            Style = lbOwnerDrawFixed
            Align = alClient
            ItemHeight = 24
            TabOrder = 3
            Visible = False
            OnDrawItem = ListBox_DrawItem
          end
          object CheckBoxReplaceSearchLine: TCheckBox
            Left = 10
            Top = 51
            Width = 308
            Height = 24
            Cursor = crHandPoint
            Align = alTop
            Caption = #1040#1074#1090#1086#1079#1072#1084#1077#1085#1072' '#1082#1086#1085#1089#1090#1072#1085#1090#1085#1099#1093' '#1089#1083#1086#1074
            TabOrder = 4
          end
        end
      end
      object tabEdit: TTabSheet
        Caption = #1056#1072#1073#1086#1090#1072' '#1089' '#1090#1077#1082#1089#1090#1086#1084
      end
      object tabSettings: TTabSheet
        Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1080
        ImageIndex = 2
        object GroupBoxLangs: TGroupBox
          Left = 0
          Top = 0
          Width = 328
          Height = 217
          Margins.Left = 0
          Margins.Top = 0
          Margins.Right = 0
          Margins.Bottom = 0
          Align = alTop
          Caption = 'Languages'
          Padding.Left = 8
          Padding.Top = 8
          Padding.Right = 8
          Padding.Bottom = 8
          TabOrder = 0
          object clbShowLang: TCheckListBox
            Left = 10
            Top = 23
            Width = 308
            Height = 184
            Align = alClient
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
          end
        end
      end
    end
  end
  object pnlProcess: TPanel
    Left = -471
    Top = 123
    Width = 480
    Height = 128
    Color = clSilver
    ParentBackground = False
    TabOrder = 2
    Visible = False
    DesignSize = (
      480
      128)
    object lblTextProcess: TLabel
      Left = 8
      Top = 8
      Width = 464
      Height = 24
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = #1055#1088#1086#1094#1077#1089#1089
      Layout = tlCenter
    end
    object lblProgress: TLabel
      Left = 8
      Top = 61
      Width = 464
      Height = 24
      Alignment = taCenter
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      Caption = '0 %'
      Layout = tlCenter
    end
    object EditProcessText: TEdit
      Left = 8
      Top = 32
      Width = 464
      Height = 21
      Margins.Left = 0
      Margins.Top = 0
      Margins.Right = 0
      Margins.Bottom = 0
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
    end
    object Progress: TProgressBar
      Left = 8
      Top = 85
      Width = 464
      Height = 15
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 1
    end
  end
end
