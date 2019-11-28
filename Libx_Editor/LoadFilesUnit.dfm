object frmLoadFiles: TfrmLoadFiles
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  ClientHeight = 118
  ClientWidth = 320
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 16
  object lblFiles: TLabel
    Left = 8
    Top = 8
    Width = 57
    Height = 16
    Caption = 'Scan File:'
  end
  object MemoFiles: TMemo
    Left = 8
    Top = 30
    Width = 304
    Height = 82
    TabOrder = 0
  end
end
