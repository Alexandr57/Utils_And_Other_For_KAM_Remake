object frmCalcResourceKMR: TfrmCalcResourceKMR
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmCalcResourceKMR'
  ClientHeight = 478
  ClientWidth = 780
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  Padding.Left = 8
  Padding.Top = 8
  Padding.Right = 8
  Padding.Bottom = 8
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 16
  object PageControl1: TPageControl
    Left = 8
    Top = 8
    Width = 396
    Height = 462
    ActivePage = tbsHouse
    Align = alLeft
    TabOrder = 0
    OnChange = PageControl1Change
    object tbsHouse: TTabSheet
      Caption = 'Houses'
      object scrlbHouse: TScrollBox
        Left = 0
        Top = 0
        Width = 388
        Height = 431
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
    object tbsUnit: TTabSheet
      Caption = 'Units'
      ImageIndex = 1
      object scrlbUnit: TScrollBox
        Left = 0
        Top = 0
        Width = 388
        Height = 431
        Align = alClient
        BorderStyle = bsNone
        TabOrder = 0
      end
    end
  end
  object grbStorehouse: TGroupBox
    Left = 404
    Top = 8
    Width = 368
    Height = 462
    Align = alClient
    Caption = 'Storehouse'
    TabOrder = 1
  end
  object pnlInfo: TPanel
    Left = 213
    Top = -12
    Width = 185
    Height = 41
    Caption = 'pnlInfo'
    Color = clAqua
    ParentBackground = False
    TabOrder = 2
  end
end
