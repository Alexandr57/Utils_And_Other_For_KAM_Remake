object frmScanFiles: TfrmScanFiles
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Scan Files'
  ClientHeight = 128
  ClientWidth = 256
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 16
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 31
    Height = 16
    Caption = 'Files:'
  end
  object MemoScanFiles: TMemo
    Left = 8
    Top = 30
    Width = 240
    Height = 90
    Lines.Strings = (
      'MemoScanFiles')
    TabOrder = 0
  end
end
