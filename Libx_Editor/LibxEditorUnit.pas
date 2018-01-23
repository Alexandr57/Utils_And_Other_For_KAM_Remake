unit LibxEditorUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, System.Actions, Vcl.ActnList, Vcl.Menus,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.CheckLst, Vcl.ComCtrls,
  Vcl.ToolWin, System.ImageList, Vcl.ImgList, Masks,
  LoadFilesUnit, TEXTS, C_TEXTS, Versions,
  KM_Defaults, KM_ResLocales, Vcl.Buttons;

type
  TfrmLibxEditor = class(TForm)
    pnlEdSelect: TPanel;
    mnMenu: TMainMenu;
    mnFile: TMenuItem;
    mnFile_Exit: TMenuItem;
    ActionList: TActionList;
    aExit: TAction;
    PageControl: TPageControl;
    Tab_1: TTabSheet;
    pnlTab_1: TPanel;
    GroupBoxDir: TGroupBox;
    CheckListBoxFolders: TCheckListBox;
    GroupBoxFiles: TGroupBox;
    ListBoxFiles: TListBox;
    pnlIndexLibx: TPanel;
    ComboBoxIndexLibx: TComboBox;
    ToolBarUpDown: TToolBar;
    ImageList: TImageList;
    ToolButtonUpDown: TToolButton;
    ListBoxIndexLibx: TListBox;
    Tab_3: TTabSheet;
    pnlTab_3: TPanel;
    TabControl: TTabControl;
    MemoTextLibx: TMemo;
    lblMemoTextLibx: TLabel;
    Label1: TLabel;
    clbShowLang: TCheckListBox;
    pnlSelFiles: TPanel;
    tmrFiles: TTimer;
    Tab_2: TTabSheet;
    GroupBox1: TGroupBox;
    ToolBarFiles: TToolBar;
    ImageListGRBFileButtonn: TImageList;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    procedure aExitExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ToolButtonUpDownClick(Sender: TObject);
    procedure clbShowLangClickCheck(Sender: TObject);
    procedure ListBoxFilesClick(Sender: TObject);
    procedure tmrFilesTimer(Sender: TObject);
    procedure CheckListBoxFoldersClickCheck(Sender: TObject);
  private
    procedure GetIDX(aFileID: Integer);
    function GetCharset(aLang: string): TFontCharset;
  public
    AddingFiles: Boolean;
  end;

var
  frmLibxEditor: TfrmLibxEditor;
  PathKMR: String;
  ListFilesLibx:Array of TStringList;
  aIDXLF: Integer = 0;
  aIDXOLF: Integer = 0;

implementation

{$R *.dfm}


function TfrmLibxEditor.GetCharset(aLang: string): TFontCharset;
begin
  if Pos(aLang, 'bel,rus,bul,ukr') <> 0 then
    Result := RUSSIAN_CHARSET
  else if Pos(aLang, 'pol,hun,cze,svk,rom') <> 0 then
    Result := EASTEUROPE_CHARSET
  else if Pos(aLang, 'tur') <> 0 then
    Result := TURKISH_CHARSET
  else if Pos(aLang, 'lit,lat') <> 0 then
    Result := BALTIC_CHARSET
  else if Pos(aLang, 'eng,spa,ita,nor,chn,dut,est,ptb,fre,ger,jpn,swe') <> 0 then
    Result := ANSI_CHARSET
  else
    Result := DEFAULT_CHARSET;
end;


procedure TfrmLibxEditor.GetIDX(aFileID: Integer);
begin


end;


procedure TfrmLibxEditor.FormCreate(Sender: TObject);
var I: Integer;
begin
  PathKMR := ExtractFilePath(ParamStr(0)) + '..\..\kam_remake\';

  gResLocales := TKMLocales.Create(PathKMR + 'data\locales.txt', DEFAULT_LOCALE);

  if gResLocales.Count <= 0 then Application.Terminate;

  fTextManager := TTextManager.Create;

  for I := 0 to LENGTH_FOLDERS_LIBX - 1 do
  begin
    CheckListBoxFolders.Items.Add(FOLDERS_LIBX_KMR_TEXT[I]);
    CheckListBoxFolders.Checked[I] := True;
  end;

  clbShowLang.Items.Add('All');

  for I := 0 to gResLocales.Count - 1 do
  begin
    clbShowLang.Items.Add(gResLocales[I].Title + ' (' + gResLocales[I].Code + ')');
    clbShowLang.Checked[I+1]       := True;
    if AnsiLowerCase(gResLocales[I].Code) = 'eng' then
      clbShowLang.ItemEnabled[I+1] := False;
  end;

  frmLibxEditor.clbShowLangClickCheck(nil);

  AddingFiles := False;
end;


procedure TfrmLibxEditor.tmrFilesTimer(Sender: TObject);
begin
  if aIDXLF = 0 then
  begin
    frmLoadFiles.Show;
    inc(aIDXLF);
  end else begin
    case aIDXOLF of
      0:frmLoadFiles.InitFilesLibx;
      1:if ListBoxFiles.ItemIndex >= 0 then
          frmLoadFiles.InitTextsLibx(ListBoxFiles.ItemIndex);
    end;
    tmrFiles.Enabled := False;
  end;
end;


procedure TfrmLibxEditor.ToolButtonUpDownClick(Sender: TObject);
begin
  if pnlIndexLibx.Tag = 0 then
  begin
    pnlIndexLibx.Height         := 258;
    ListBoxIndexLibx.Visible    := True;
    ComboBoxIndexLibx.Visible   := False;
    ToolButtonUpDown.ImageIndex := 1;
    pnlIndexLibx.Tag := 1;
    TabControl.Top := pnlIndexLibx.Top + pnlIndexLibx.Height;
    TabControl.Height := ClientHeight - (pnlIndexLibx.Top + pnlIndexLibx.Height);
    Exit;
  end;

  if pnlIndexLibx.Tag = 1 then
  begin
    pnlIndexLibx.Height         := 58;
    ListBoxIndexLibx.Visible    := False;
    ComboBoxIndexLibx.Visible   := True;
    ToolButtonUpDown.ImageIndex := 0;
    pnlIndexLibx.Tag := 0;
    TabControl.Top := pnlIndexLibx.Top + pnlIndexLibx.Height;
    TabControl.Height := ClientHeight - (pnlIndexLibx.Top + pnlIndexLibx.Height);
    Exit;
  end;

end;


procedure TfrmLibxEditor.ListBoxFilesClick(Sender: TObject);
begin
  pnlSelFiles.Caption := PathKMR + Format(TEXT_SEL_FILE,
    [ListBoxFiles.Items.Strings[ListBoxFiles.ItemIndex]]);

  aIDXLF := 0;
  aIDXOLF := 1;
  tmrFiles.Enabled := True;
end;


procedure TfrmLibxEditor.clbShowLangClickCheck(Sender: TObject);
var I, K: Integer;
  TabSel: String;
begin
  if clbShowLang.Selected[0] then
    if clbShowLang.State[0] = cbChecked then
      for I := 1 to clbShowLang.Count - 1 do
        clbShowLang.Checked[I] := True
    else
    if clbShowLang.State[0] = cbUnchecked then
      for I := 1 to clbShowLang.Count - 1 do
        if clbShowLang.ItemEnabled[I] = True then
          clbShowLang.Checked[I] := False;

  K := 0;
  for I := 1 to clbShowLang.Count - 1 do
  if clbShowLang.Checked[I] then
    Inc(K);

  if K = 0 then
    clbShowLang.State[0] := cbUnchecked
  else
  if K = clbShowLang.Count - 1 then
    clbShowLang.State[0] := cbChecked
  else
    clbShowLang.State[0] := cbGrayed;

  if TabControl.Tabs.Count > 0 then
    TabSel := AnsiLowerCase(TabControl.Tabs.Strings[TabControl.TabIndex]);

  TabControl.Tabs.Clear;

  for I := 1 to clbShowLang.Items.Count - 1 do
    if clbShowLang.Checked[I] = True then
    begin
      TabControl.Tabs.Add(gResLocales[I-1].Title);
    end;

  if TabControl.Tabs.Count <= 0 then Exit;

  TabControl.TabIndex   := TabControl.Tabs.IndexOf(TabSel);
  if TabControl.TabIndex < 0 then
    TabControl.TabIndex := 0;

end;


procedure TfrmLibxEditor.CheckListBoxFoldersClickCheck(Sender: TObject);
begin
  if AddingFiles then Exit;

  aIDXLF := 0;
  aIDXOLF := 0;
  tmrFiles.Enabled := True;
end;


procedure TfrmLibxEditor.aExitExecute(Sender: TObject);
begin
  Close();
end;


end.
