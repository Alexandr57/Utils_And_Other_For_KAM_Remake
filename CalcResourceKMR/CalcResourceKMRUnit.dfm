object frmCalcResourceKMR: TfrmCalcResourceKMR
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmCalcResourceKMR'
  ClientHeight = 476
  ClientWidth = 696
  Color = clBtnFace
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
    Width = 312
    Height = 460
    ActivePage = tbsHouse
    Align = alLeft
    TabOrder = 0
    ExplicitHeight = 652
    object tbsHouse: TTabSheet
      Caption = 'House'
      ExplicitLeft = 2
      ExplicitHeight = 569
    end
  end
  object grbStorehouse: TGroupBox
    Left = 320
    Top = 8
    Width = 368
    Height = 460
    Align = alClient
    Caption = 'Storehouse'
    TabOrder = 1
    ExplicitLeft = 488
    ExplicitTop = 344
    ExplicitWidth = 185
    ExplicitHeight = 105
  end
end
