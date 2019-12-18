unit LoadFilesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ComCtrls, Vcl.StdCtrls,
  TEXTS, C_TEXTS,
  KM_Defaults, KM_ResLocales;

type
  TfrmLoadFiles = class(TForm)
    lblFiles: TLabel;
    MemoFiles: TMemo;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    procedure InitFilesLibx;
    procedure InitTextsLibx(aFileID: Integer);
  end;

var
  frmLoadFiles: TfrmLoadFiles;

implementation

{$R *.dfm}

uses LibxEditorUnit;


procedure TfrmLoadFiles.FormShow(Sender: TObject);
begin
  frmLibxEditor.Enabled := False;
  frmLibxEditor.AddingFiles := True;
  Enabled := False;
  Caption := 'Скоро начнется';
  lblFiles.Caption := 'Ожидание сканирование:';
end;


procedure TfrmLoadFiles.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frmLibxEditor.Enabled := True;
  frmLibxEditor.AddingFiles := False;
end;


procedure TfrmLoadFiles.InitFilesLibx;
var
  I, C: Integer;
begin

  frmLibxEditor.ListBoxFiles.Clear;

  fTextManager.ClearFiles;

  Caption := 'Scan Files';

  lblFiles.Caption := 'Scan Files:';

  C := frmLibxEditor.CheckListBoxFolders.Items.Count - 1;

  for I := 0 to C do
  begin
    if frmLibxEditor.CheckListBoxFolders.Checked[I] = False then Continue;

    fTextManager.AddPath(PathKMR, FOLDERS_LIBX_KMR[I], MemoFiles, SCAN_SUB_FOLDERS_LIBX_KMR_BOOL[I]);
  end;

  if fTextManager.CountFiles <= 0 then
  begin
    Close;
    Exit;
  end;

  for I := 0 to fTextManager.CountFiles - 1 do
    frmLibxEditor.ListBoxFiles.Items.Add(fTextManager.Paths[I]);

  Close;
end;


procedure TfrmLoadFiles.InitTextsLibx(aFileID: Integer);
var
  I: Integer;
begin
  frmLibxEditor.ListBoxIndexLibx.Items.Clear;
  frmLibxEditor.ComboBoxIndexLibx.Items.Clear;

  Caption := 'Load File';

  lblFiles.Caption := 'Load File:';

  fTextManager.Load(PathKMR, aFileID, MemoFiles);

  if fTextManager.Count[gResLocales.IndexByCode(DEFAULT_LOCALE)] <= 0 then
    Close;

  for I := 0 to fTextManager.ConstCount - 1 do
    frmLibxEditor.ComboBoxIndexLibx.Items.Add(fTextManager.Consts[I].ConstName);

  frmLibxEditor.ListBoxIndexLibx.Items := frmLibxEditor.ComboBoxIndexLibx.Items;

  Close;
end;


end.
