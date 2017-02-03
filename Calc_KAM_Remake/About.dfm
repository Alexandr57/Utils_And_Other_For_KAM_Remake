object Form2: TForm2
  Left = 0
  Top = 0
  AutoSize = True
  BorderStyle = bsDialog
  Caption = 'About'
  ClientHeight = 208
  ClientWidth = 193
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 193
    Height = 25
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 204
    object Label1: TLabel
      Left = 8
      Top = 6
      Width = 37
      Height = 13
      Caption = 'Author:'
    end
    object Label2: TLabel
      Left = 51
      Top = 6
      Width = 49
      Height = 13
      Caption = 'AlexandrV'
    end
  end
  object pnlLicense: TPanel
    Left = 0
    Top = 25
    Width = 193
    Height = 183
    Caption = 'License:'
    TabOrder = 1
    VerticalAlignment = taAlignTop
    object Label3: TLabel
      Left = 9
      Top = 24
      Width = 119
      Height = 13
      Caption = 'fgrfdgdkgdfhjkghdjgsdfg'
      WordWrap = True
    end
    object Button1: TButton
      Left = 1
      Top = 157
      Width = 191
      Height = 25
      Cursor = crHandPoint
      Align = alBottom
      Caption = 'Close'
      TabOrder = 0
      OnClick = Button1Click
      ExplicitLeft = 51
      ExplicitTop = 128
      ExplicitWidth = 75
    end
  end
end
