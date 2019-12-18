unit UnitFormSearch;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, System.IOUtils,
  Vcl.Menus;

type
  TFileFoundEvent = procedure(aFileName: string; aFileFixed: Boolean = False) of object;

type
  TProgressEvent = procedure(aProgress: Integer) of object;

type
  TMyThread = class(TThread)
  private
    { Private declarations }
    fListFiles: TStringList;
    fDirsSearch: Array of String;
    fFileName: string;
    fFileFixed: Boolean;
    fProgress: Integer;
    fOnFileFound: TFileFoundEvent;
    fOnProgress: TProgressEvent;
    fLineMemo: String;
    procedure DoCallBack;
    procedure CallBack(aFileName: string; aFileFixed: Boolean = False);
    procedure DoShowProgress;
    procedure ShowProgress(aProgress: Integer);
    procedure AddLineInMemo(aLine: String);
    procedure DoAddLineInMemo;

    procedure EndMyThread;

    function GetProcent(aValue, aMaxValue: Integer): Integer;
  protected
    procedure SearchingFiles(aPath: String);
    procedure Execute; override;
  public
    constructor Create(aDir: Array of String);
    property OnFileFound: TFileFoundEvent read fOnFileFound write fOnFileFound;
    property OnProgress: TProgressEvent read fOnProgress write fOnProgress;
  end;

type
  TFormSearch = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    ProgressBar1: TProgressBar;
    Label3: TLabel;
    MemoLogs: TMemo;
    EditFile: TEdit;
    Button1: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Label4: TLabel;
    Label5: TLabel;
    LabelSearchingFiles: TLabel;
    LabelFixedFiles: TLabel;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }

    SearchingFiles, FixedFiles: Integer;

    procedure OnFileFound(aFileName: string; aFileFixed: Boolean);

    procedure OnProgress(aProgress: Integer);

  public
    fPaths: array of String;
    fListFiles: TStringList;
    { Public declarations }
    procedure StartLFtoCRLF(aPaths: Array of String; out ListFiles: TStringList);
  end;

var
  FormSearch: TFormSearch;

implementation

{$R *.dfm}

{ MyThread }


function TMyThread.GetProcent(aValue, aMaxValue: Integer): Integer;
begin
  Result := Round((aValue / aMaxValue) * 100);
end;


procedure TMyThread.DoShowProgress;
begin
  if Assigned(fOnProgress) then
    fOnProgress(fProgress);
end;


procedure TMyThread.ShowProgress(aProgress: Integer);
begin
  fProgress := aProgress;
  Synchronize(DoShowProgress);
end;


procedure TMyThread.DoCallBack;
begin
  if Assigned(fOnFileFound) then
    fOnFileFound(fFileName, fFileFixed);
end;


procedure TMyThread.CallBack(aFileName: string; aFileFixed: Boolean = False);
begin
  fFileName := aFileName;
  fFileFixed := aFileFixed;
  Synchronize(DoCallBack);
end;


procedure TMyThread.EndMyThread;
begin
  FormSearch.Button1.Enabled := True;
  FormSearch.Button1.Caption := 'Закрыть окно';
  FormSearch.MemoLogs.PopupMenu := FormSearch.PopupMenu1;
end;


procedure TMyThread.DoAddLineInMemo;
begin
  FormSearch.MemoLogs.Lines.Add(fLineMemo);
end;


procedure TMyThread.AddLineInMemo(aLine: String);
begin
  fLineMemo := aLine;
  Synchronize(DoAddLineInMemo);
end;


constructor TMyThread.Create(aDir: Array of String);
var I: Integer;
begin
  inherited Create(false);
  SetLength(fDirsSearch, Length(aDir));
  for I := 0 to Length(aDir) - 1 do
    fDirsSearch[I] := aDir[I];
  fProgress := 0;
  fListFiles := TStringList.Create;
end;


procedure TMyThread.Execute;
var
  I: Integer;
  prc: Integer;
  SLFix: TstringList;
begin
  //Поиск файлов

  AddLineInMemo('-------------');
  AddLineInMemo('::Поск файлов');
  AddLineInMemo('-------------');

  for I := 0 to Length(fDirsSearch) - 1 do
  begin
    SearchingFiles(fDirsSearch[I]);
    prc := GetProcent(I + 1, Length(fDirsSearch));
    ShowProgress(prc);
  end;

  //Перевод файлов из LF в CRLF

  if fListFiles.Count <= 0 then
  begin
    AddLineInMemo('------------------');
    AddLineInMemo('::Файлы не найдены');
    AddLineInMemo('------------------');
    fListFiles.Free;
    Exit;
  end else begin
    SLFix := TStringList.Create;

    AddLineInMemo('--------------------');
    AddLineInMemo('::Исправление файлов');
    AddLineInMemo('--------------------');

    for I := 0 to fListFiles.Count - 1 do
    begin
      try
        SLFix.LoadFromFile(fListFiles[I]);
        SLFix.SaveToFile(fListFiles[I]);
        CallBack(fListFiles[I], True);
        prc := GetProcent(I + 1, fListFiles.Count);
        ShowProgress(prc);
      except
        Continue;
      end;
    end;

    SLFix.Free;

    fListFiles.Free;

    AddLineInMemo('-------');
    AddLineInMemo('::Конец');
    AddLineInMemo('-------');

  end;

  Synchronize(EndMyThread);

end;


procedure TMyThread.SearchingFiles(aPath: String);
var
  SearchRec: TSearchRec;
  FindResult: Integer;
  apr:String;
begin
  aPath := IncludeTrailingBackslash(aPath);
  FindResult := FindFirst(aPath + '*', faAnyFile, SearchRec);
  try
    while FindResult = 0 do
    begin
      if (SearchRec.Attr and faDirectory) <> 0 then
      begin
        if (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          SearchingFiles(aPath + SearchRec.Name + '\');
      end
      else
      begin
        apr := SearchRec.Name;
        apr := LowerCase(apr);
        if ExtractFileExt(apr) = '.pas' then
        begin
          fListFiles.Add(aPath + SearchRec.Name);
          CallBack(aPath + SearchRec.Name);
        end;
      end;
      FindResult := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;
end;

{ TFormSearch }


procedure TFormSearch.Button1Click(Sender: TObject);
begin
  FormSearch.ModalResult := mrOk;
end;


procedure TFormSearch.FormShow(Sender: TObject);
begin
  MemoLogs.PopupMenu := nil;
  Button1.Caption := 'Идет процесс';
  Button1.Enabled := False;
  EditFile.Clear;
  MemoLogs.Clear;
  fListFiles := TStringList.Create;
  fListFiles.Clear;

  with TMyThread.Create(fPaths) do begin
    OnFileFound := FormSearch.OnFileFound;
    OnProgress := FormSearch.OnProgress;
    FreeOnTerminate := true;
  end;

end;


procedure TFormSearch.N1Click(Sender: TObject);
begin
  MemoLogs.CopyToClipboard;
end;


procedure TFormSearch.N2Click(Sender: TObject);
begin
  MemoLogs.Lines.SaveToFile('Information LF to CRLF.log');
end;


procedure TFormSearch.OnFileFound(aFileName: string; aFileFixed: Boolean);
begin

  EditFile.Text := aFileName;
  MemoLogs.Lines.Add(aFileName);
  if aFileFixed = True then
  begin
    fListFiles.Add(aFileName);
    FixedFiles := FixedFiles + 1;
  end else
    SearchingFiles := SearchingFiles + 1;

  LabelSearchingFiles.Caption := IntToStr(SearchingFiles);
  LabelFixedFiles.Caption := IntToStr(FixedFiles);
end;


procedure TFormSearch.OnProgress(aProgress: Integer);
begin
  ProgressBar1.Position := aProgress;
end;


procedure TFormSearch.StartLFtoCRLF(aPaths: array of String;
  out ListFiles: TStringList);
var I: Integer;
begin
  SearchingFiles := 0;
  FixedFiles := 0;

  SetLength(fPaths, Length(aPaths));
  for I := 0 to Length(aPaths) - 1 do
    fPaths[I] := aPaths[I];

  if FormSearch.ShowModal = mrOk then
    ListFiles := fListFiles;
end;


end.
