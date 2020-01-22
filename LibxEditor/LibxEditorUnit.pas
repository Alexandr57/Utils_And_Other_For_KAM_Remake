unit LibxEditorUnit;
{$I ..\General\Compiling.inc}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.WinXCtrls,
  Vcl.CheckLst, Vcl.ComCtrls, Vcl.ExtCtrls,
  KM_ResLocales, KM_Defaults,
  TextsUnit, MyThreads, CONSTS;

type
  TfrmLibxEditorMain = class(TForm)
    pnlInfo: TPanel;
    lblSelectFile: TLabel;
    PageControlParam: TPageControl;
    tabEdit: TTabSheet;
    tabSettings: TTabSheet;
    tabFiles: TTabSheet;
    GroupBoxDir: TGroupBox;
    CheckListBoxFolders: TCheckListBox;
    SearchBox: TSearchBox;
    GroupBoxFiles: TGroupBox;
    ListBoxFiles: TListBox;
    pnlSelTabList: TPanel;
    rbtnSelListFiles: TRadioButton;
    rbtnSelListText: TRadioButton;
    GroupBoxLangs: TGroupBox;
    clbShowLang: TCheckListBox;
    pnlMain: TPanel;
    pnlProcess: TPanel;
    lblTextProcess: TLabel;
    EditProcessText: TEdit;
    lblProgress: TLabel;
    Progress: TProgressBar;
    pnlSelListColor: TPanel;
    ListBoxTexts: TListBox;
    CheckBoxReplaceSearchLine: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure FormPaint(Sender: TObject);
    procedure rbtnSelList_MouseEnter(Sender: TObject);
    procedure rbtnSelList_MouseLeave(Sender: TObject);
    procedure rbtnSelListFilesClick(Sender: TObject);
    procedure rbtnSelListTextClick(Sender: TObject);
    procedure CheckListBoxFoldersClickCheck(Sender: TObject);
    procedure ListBox_DrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure SearchBoxInvokeSearch(Sender: TObject);
    procedure ListBoxFilesClick(Sender: TObject);
  private
    fIsOneRun: Boolean;

    fIndexSelectList: Integer;
    fIndexSelectFileInList: Integer;

    AddingFiles: Boolean;

    fTextManager: TTextManager;

    procedure OnFileSearch(aFileName: string);
    procedure OnProgressSearch(aProgress: Integer);
    procedure OnSearchDone(aTextManager: TTextManager);

    procedure StartSerchingFiles;

    procedure SelList;

    procedure SelectFileInList(aIndexSelectFileInList: Integer);
  public
    { Public declarations }
  end;

var
  frmLibxEditorMain: TfrmLibxEditorMain;
  PathKMR: String;

implementation


{$R *.dfm}


procedure TfrmLibxEditorMain.FormCreate(Sender: TObject);
var I: Integer;
begin
  {$IFDEF DEV}
     PathKMR := ExtractFilePath(ParamStr(0)) + '..\..\kam_remake\';
  {$ELSE}
     PathKMR := ExtractFilePath(ParamStr(0));
  {$ENDIF}
  gResLocales := TKMLocales.Create(PathKMR + 'data\locales.txt', DEFAULT_LOCALE);

  if gResLocales.Count <= 0 then
  begin
    Application.Terminate;
  end;

  for I := 0 to LENGTH_FOLDERS_LIBX - 1 do
  begin
    CheckListBoxFolders.Items.Add(FOLDERS_LIBX_KMR_TEXT[I]);
    CheckListBoxFolders.Checked[I] := True;
  end;

  clbShowLang.Items.Add('All');

  for I := 0 to gResLocales.Count - 1 do
  begin
    clbShowLang.Items.Add(gResLocales[I].Title + ' (' + String(gResLocales[I].Code) + ')');
    clbShowLang.Checked[I+1]       := True;
    if AnsiLowerCase(String(gResLocales[I].Code)) = 'eng' then
      clbShowLang.ItemEnabled[I+1] := False;
  end;

  fTextManager := TTextManager.Create(PathKMR, gResLocales.Count);

  AddingFiles := False;

  fIndexSelectList := 0;

  fIsOneRun := False;

end;


procedure TfrmLibxEditorMain.FormPaint(Sender: TObject);
begin
  if fIsOneRun then Exit;

  StartSerchingFiles;

  fIsOneRun := True;
end;


{$region 'Отрисовка и анимация'}


procedure TfrmLibxEditorMain.ListBox_DrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
var List:TListBox;
begin
  List:=Control as TListBox;
  with List.Canvas, Rect do
  begin
    if odSelected in State then
    begin
      Brush.Color := clMenuHighlight;
      Font.Color:=clHighlightText;
    end
    else
    begin
      Brush.Color:=clWindow;
      Font.Color:=clWindowText;
    end;

    FillRect(Rect);
    if odFocused in State then
      DrawFocusRect(Rect);
    TextOut(Left + 8, Top + (Rect.Height div 2) - (TextHeight(List.Items[Index]) div 2), List.Items[Index]);
  end;
end;




{$endregion}


{$region 'Поиск файлов libx'}


procedure TfrmLibxEditorMain.OnProgressSearch(aProgress: Integer);
begin
  lblProgress.Caption := IntToStr(aProgress) + ' %';
  Progress.Position := aProgress;
end;


procedure TfrmLibxEditorMain.OnFileSearch(aFileName: string);
begin
  ListBoxFiles.Items.Add(aFileName);
end;


procedure TfrmLibxEditorMain.OnSearchDone(aTextManager: TTextManager);
begin
  fTextManager := aTextManager;
  pnlMain.Enabled := True;
  pnlProcess.Visible := False;
  SelList;
  AddingFiles := False;
end;


procedure TfrmLibxEditorMain.StartSerchingFiles;
begin
  if AddingFiles then Exit;

  lblTextProcess.Caption := 'Идет процесс поиска файлов...';
  EditProcessText.Clear;
  lblProgress.Caption := '0 %';
  Progress.Position := 0;

  ListBoxFiles.Clear;
  fTextManager.ClearFiles;
  fIndexSelectFileInList := -1;

  pnlMain.Enabled := False;
  pnlProcess.Left := (Self.ClientWidth div 2) - (pnlProcess.Width div 2);
  pnlProcess.Top := (Self.ClientHeight div 2) - (pnlProcess.Height div 2);
  pnlProcess.Visible := True;

  AddingFiles := True;

  with TMySearchThread.Create(PathKMR, FOLDERS_LIBX_KMR,
    SCAN_SUB_FOLDERS_LIBX_KMR_BOOL, CheckListBoxFolders,
    fTextManager) do begin
    OnThreadFileSearch := OnFileSearch;
    OnThreadProgressSearch := OnProgressSearch;
    OnThreadSearchDone := OnSearchDone;
    FreeOnTerminate := true; // Освободить память после окончания работы
  end;
end;

{$endregion}


procedure TfrmLibxEditorMain.CheckListBoxFoldersClickCheck(Sender: TObject);
begin
  StartSerchingFiles;
end;


procedure TfrmLibxEditorMain.rbtnSelList_MouseLeave(Sender: TObject);
begin
  pnlSelListColor.Color := $00333333;
end;


procedure TfrmLibxEditorMain.rbtnSelList_MouseEnter(Sender: TObject);
begin
  pnlSelListColor.Color := $00D77800;
end;


procedure TfrmLibxEditorMain.SelList;
begin
  if fIndexSelectList = 0 then
  begin
    ListBoxFiles.Visible := True;
    ListBoxTexts.Visible := False;
  end else if fIndexSelectList = 1 then
  begin
    ListBoxTexts.Visible := True;
    ListBoxFiles.Visible := False;
  end;
end;


procedure TfrmLibxEditorMain.rbtnSelListFilesClick(Sender: TObject);
begin
  if fIndexSelectList = 0 then Exit;

  pnlSelListColor.Left := rbtnSelListFiles.Left;

  fIndexSelectList := 0;

  SelList;
end;


procedure TfrmLibxEditorMain.rbtnSelListTextClick(Sender: TObject);
begin
  if fIndexSelectList = 1 then Exit;

  pnlSelListColor.Left := rbtnSelListText.Left;

  fIndexSelectList := 1;

  SelList;
end;


procedure TfrmLibxEditorMain.SearchBoxInvokeSearch(Sender: TObject);
var
  I, IndexLine: Integer;
  IsSearchTwo: Boolean;
begin
  if fIndexSelectList = 0 then
  begin
    if ListBoxFiles.Items.Count <= 0 then Exit;

    if CheckBoxReplaceSearchLine.Checked then
    begin
      for I := 0 to Length(CNST_SEARCH_FILES) - 1 do
        if AnsiLowerCase(SearchBox.Text) = CNST_SEARCH_FILES[I] then
        begin
          SearchBox.Text := REPLACE_SEARCH_FILES[I];
          SearchBox.SelStart := Length(SearchBox.Text);
          Break;
        end;
    end;

    IndexLine := ListBoxFiles.ItemIndex;

    if IndexLine < 0 then
    begin
      IndexLine := 0;
      IsSearchTwo := False;
    end
    else if IndexLine < ListBoxFiles.Items.Count - 1 then
    begin
      IndexLine := IndexLine + 1;
      IsSearchTwo := True;
    end
    else begin
      IndexLine := 0;
      IsSearchTwo := False;
    end;

    for I := IndexLine to ListBoxFiles.Items.Count - 1 do
      if Pos(AnsiLowerCase(SearchBox.Text), AnsiLowerCase(ListBoxFiles.Items[i])) > 0 then
      begin
        ListBoxFiles.ItemIndex := I;

        Exit;
      end;

    if IsSearchTwo = False then Exit;

    for I := 0 to ListBoxFiles.Items.Count - 1 do
      if Pos(LowerCase(SearchBox.Text), LowerCase(ListBoxFiles.Items[i])) > 0 then
      begin
        ListBoxFiles.ItemIndex := I;

        Exit;
      end;
  end else if fIndexSelectList = 1 then
  begin
    if ListBoxTexts.Items.Count <= 0 then Exit;

    IndexLine := ListBoxTexts.ItemIndex;

    if IndexLine < 0 then
    begin
      IndexLine := 0;
      IsSearchTwo := False;
    end
    else if IndexLine < ListBoxTexts.Items.Count - 1 then
    begin
      IndexLine := IndexLine + 1;
      IsSearchTwo := True;
    end
    else begin
      IndexLine := 0;
      IsSearchTwo := False;
    end;

    for I := IndexLine to ListBoxTexts.Items.Count - 1 do
      if Pos(LowerCase(SearchBox.Text), LowerCase(ListBoxTexts.Items[i])) > 0 then
      begin
        ListBoxTexts.ItemIndex := I;

        Exit;
      end;

    if IsSearchTwo = False then Exit;

    for I := 0 to ListBoxTexts.Items.Count - 1 do
      if Pos(LowerCase(SearchBox.Text), LowerCase(ListBoxTexts.Items[i])) > 0 then
      begin
        ListBoxTexts.ItemIndex := I;

        Exit;
      end;
  end;

end;


procedure TfrmLibxEditorMain.SelectFileInList(aIndexSelectFileInList: Integer);
begin
  fIndexSelectFileInList := aIndexSelectFileInList;
  lblSelectFile.Caption := 'Select File: ' + fTextManager.FileName[fIndexSelectFileInList];
end;


procedure TfrmLibxEditorMain.ListBoxFilesClick(Sender: TObject);
begin
  if ListBoxFiles.ItemIndex < 0 then Exit;

  SelectFileInList(ListBoxFiles.ItemIndex);
end;


end.
