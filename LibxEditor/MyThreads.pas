unit MyThreads;
interface

uses
  Windows, Classes, System.SysUtils, System.StrUtils, Vcl.CheckLst,
  TextsUnit, CONSTS,
  KM_Defaults;

type
  TThreadProgressEvent = procedure(aProgress: Integer) of object;
  TThreadDoneEvent = procedure(aTextManager: TTextManager) of object;

type
  TThreadFileSearchEvent = procedure(aFileName: string) of object;

type
  TMySearchThread = class(TThread)
  private
    fTextManager: TTextManager;
    fBasePath: String;
    fArraySubDir: TArrayFolders_BOOL;
    fArrayDir: TArrayFolders_String;
    fCheckList: TCheckListBox;

    fFileName: String;
    fProgress: Integer;

    fOnThreadFileSearch: TThreadFileSearchEvent;
    fOnThreadProgressSearch: TThreadProgressEvent;
    fOnThreadSearchDone: TThreadDoneEvent;

    procedure DoThreadFileSearch;
    procedure ThreadFileSearch(aFileName: string);

    procedure DoThreadProgressSearch;
    procedure ThreadProgressSearch(aProgress: Integer);

    procedure DoThreadSearchDone;

  protected
    procedure ScanDir(aBasePath, aSubPath: string; aScanSubFolders: Boolean);
    procedure Execute; override;
  public
    constructor Create(aBasePath: String; aArrayDir: TArrayFolders_String;
      aArraySubDirs: TArrayFolders_BOOL; aCheckList: TCheckListBox;
      aTextManager: TTextManager);

    property OnThreadFileSearch: TThreadFileSearchEvent read fOnThreadFileSearch write fOnThreadFileSearch;
    property OnThreadProgressSearch: TThreadProgressEvent read fOnThreadProgressSearch write fOnThreadProgressSearch;
    property OnThreadSearchDone: TThreadDoneEvent read fOnThreadSearchDone write fOnThreadSearchDone;
  end;

type
  TThreadGetLibxIndexesEvent = procedure(aIndexText: Integer; aConstName: String) of object;

type
  TMySearchLibxIndexesThread = class(TThread)
  private
    fTextManager: TTextManager;
    fBasePath: String;
    fIDSelectFile: Integer;

    fLoadedFile: TStringList;

    fIndexText: Integer;
    fConstName: String;
    fProgress: Integer;

    fOnThreadGetLibxIndexes: TThreadGetLibxIndexesEvent;
    fOnThreadProgressGetLibxIndexes: TThreadProgressEvent;
    fOnThreadGetLibxIndexesDone: TThreadDoneEvent;

    procedure DoThreadGetLibxIndexes;
    procedure ThreadGetLibxIndexes(aIndexText: Integer; aConstName: Integer);

    procedure DoThreadProgressGetLibxIndexes;
    procedure ThreadProgressGetLibxIndexes(aProgress: Integer);

    procedure DoThreadGetLibxIndexesDone;

  protected
    procedure LoadConstDataText;
    procedure GetTextFromLibx(aIDLang: Integer);
    procedure Execute; override;
  public
    constructor Create(aBasePath: String; aIDSelectFile: Integer; aTextManager: TTextManager);

    property OnThreadGetLibxIndexes: TThreadGetLibxIndexesEvent read fOnThreadGetLibxIndexes write fOnThreadGetLibxIndexes;
    property OnThreadProgressGetLibxIndexes: TThreadProgressEvent read fOnThreadProgressGetLibxIndexes write fOnThreadProgressGetLibxIndexes;
    property OnThreadGetLibxIndexesDone: TThreadDoneEvent read fOnThreadGetLibxIndexesDone write fOnThreadGetLibxIndexesDone;
  end;

implementation
uses KM_ResLocales;


function GetProcent(aValue, aMaxValue: Integer): Integer;
begin
  Result := Round((aValue / aMaxValue) * 100);
end;


{ TMySearchThread }


constructor TMySearchThread.Create(aBasePath: String; aArrayDir: TArrayFolders_String;
  aArraySubDirs: TArrayFolders_BOOL; aCheckList: TCheckListBox;
  aTextManager: TTextManager);
begin
  fBasePath := aBasePath;
  fArraySubDir := aArraySubDirs;
  fCheckList := aCheckList;
  fArrayDir := aArrayDir;
  fTextManager := aTextManager;
  inherited Create(false);
end;


procedure TMySearchThread.DoThreadFileSearch;
begin
  if Assigned(fOnThreadFileSearch) then
    fOnThreadFileSearch(fFileName);
end;


procedure TMySearchThread.ThreadFileSearch(aFileName: string);
begin
  fFileName := aFileName;
  Synchronize(DoThreadFileSearch);
end;


procedure TMySearchThread.DoThreadProgressSearch;
begin
  if Assigned(fOnThreadProgressSearch) then
    fOnThreadProgressSearch(fProgress);
end;


procedure TMySearchThread.ThreadProgressSearch(aProgress: Integer);
begin
  fProgress := aProgress;
  Synchronize(DoThreadProgressSearch);
end;


procedure TMySearchThread.DoThreadSearchDone;
begin
  if Assigned(fOnThreadSearchDone) then
    fOnThreadSearchDone(fTextManager);
end;


procedure TMySearchThread.ScanDir(aBasePath, aSubPath: string; aScanSubFolders: Boolean);
var
  SearchRec: TSearchRec;
  FindResult: Integer;
  addFileMask : String;
  apr:String;
begin
  aBasePath := IncludeTrailingBackslash(aBasePath);
  aSubPath := IncludeTrailingBackslash(aSubPath);
  FindResult := FindFirst(aBasePath + aSubPath + '*.*', faAnyFile, SearchRec);
  try
    while FindResult = 0 do
    begin
      if (SearchRec.Attr and faDirectory) <> 0 then
      begin
        if aScanSubFolders and (SearchRec.Name <> '.') and (SearchRec.Name <> '..') then
          ScanDir(aBasePath, aSubPath + SearchRec.Name + '\', aScanSubFolders);
      end else begin
        apr := SearchRec.Name;
        if Pos(AnsiLowerCase('.' + DEFAULT_LOCALE + EXT_FILE_LIBX_DOT), AnsiLowerCase(SearchRec.Name)) >= 1 then
        begin
          addFileMask := LeftStr(SearchRec.Name, Length(SearchRec.Name) - Length(DEFAULT_LOCALE + EXT_FILE_LIBX_DOT)) +'%s' + EXT_FILE_LIBX_DOT;
          fTextManager.AddFile(aBasePath + aSubPath + addFileMask);
          ThreadFileSearch(aSubPath + addFileMask);
        end;
      end;
      FindResult := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;
end;


procedure TMySearchThread.Execute;
var I: Integer;
begin
  ThreadProgressSearch(0);

  for I := 0 to Length(fArraySubDir) - 1 do
  begin
    if fCheckList.Checked[I] = true then
      ScanDir(fBasePath, fArrayDir[I], fArraySubDir[I]);
    ThreadProgressSearch(GetProcent((I + 1), Length(fArraySubDir)));
  end;

  ThreadProgressSearch(100);

  Synchronize(DoThreadSearchDone);
end;


{ TMySearchLibxIndexesThread }


constructor TMySearchLibxIndexesThread.Create(aBasePath: String; aIDSelectFile: Integer; aTextManager: TTextManager);
begin
  fBasePath := aBasePath;
  fIDSelectFile := aIDSelectFile;
  fTextManager := aTextManager;
  inherited Create(false);
end;


procedure TMySearchLibxIndexesThread.DoThreadGetLibxIndexes;
begin

end;


procedure TMySearchLibxIndexesThread.ThreadGetLibxIndexes(aIndexText,
  aConstName: Integer);
begin

end;


procedure TMySearchLibxIndexesThread.DoThreadProgressGetLibxIndexes;
begin
  if Assigned(fOnThreadProgressGetLibxIndexes) then
    fOnThreadProgressGetLibxIndexes(fProgress);
end;


procedure TMySearchLibxIndexesThread.ThreadProgressGetLibxIndexes(
  aProgress: Integer);
begin
  fProgress := aProgress;
  Synchronize(DoThreadProgressGetLibxIndexes);
end;


procedure TMySearchLibxIndexesThread.DoThreadGetLibxIndexesDone;
begin
  if Assigned(fOnThreadGetLibxIndexesDone) then
    fOnThreadGetLibxIndexesDone(fTextManager);
end;


procedure TMySearchLibxIndexesThread.LoadConstDataText;
var
  FNConst: String;
  SL: TstringList;
  Line: string;
  I: Integer;
  PosID_StartConstName, PosID_EndConstName, PosID_StartConstID, PosID_EndConstID: Integer;
  CopyConstName: string;
  CopyConstID: Integer;
begin
  FNConst := IncludeTrailingBackslash(fBasePath) + PATH_CONST;
  SL := TStringList.Create;
  SL.LoadFromFile(FNConst);
  SL.Text := AnsiUpperCase(SL.Text);
  SL.Text := StringReplace(SL.Text, ' ', '', [rfReplaceAll]);
  SL.Text := StringReplace(SL.Text, #9 , '', [rfReplaceAll]);

  for I := 0 to SL.Count - 1 do
  begin
    if (Pos('TX_', SL.Strings[I]) <= 0) or (Pos('=', SL.Strings[I]) <= 0) then Continue;

    Line := SL.Strings[I];

    PosID_StartConstName := Pos('TX_', Line);
    PosID_EndConstName := Pos('=', Line);

    PosID_StartConstID := Pos('=', Line) + 1;
    PosID_EndConstID := Pos(';//', Line);

    CopyConstName := Copy(Line, PosID_StartConstName, PosID_EndConstName - PosID_StartConstName);
    CopyConstID := StrToInt(Copy(Line, PosID_StartConstID, PosID_EndConstID - PosID_StartConstID));

    ThreadGetLibxIndexes(CopyConstID, CopyConstName);
    fTextManager.AddTextInfo(CopyConstID, CopyConstName);
  end;

  FreeAndNil(SL);
end;


procedure TMySearchLibxIndexesThread.GetTextFromLibx(aIDLang: Integer);
var
  FN: String;
  firstDelimiter, topId, IDStartText: Integer;
  isAddConst: Boolean;
  I, J: Integer;
begin
  FN := Format(fTextManager.FileName[fIDSelectFile], [gResLocales.Locales[aIDLang].Code]);
  if FileExists(FN) = false then Exit;

  fLoadedFile.Clear;

  fLoadedFile.LoadFromFile(FN);

  isAddConst := AnsiLowerCase(gResLocales.Locales[aIDLang].Code) = DEFAULT_LOCALE;

  for I := 0 to fLoadedFile.Count - 1 do
  begin
    firstDelimiter := Pos(':', fLoadedFile[I]);
    if firstDelimiter = 0 then Continue;

    if TryStrToInt(LeftStr(fLoadedFile[I], firstDelimiter - 1), topId) = false then
      Continue;

    if fTextManager.GetTypeLibxText(fIDSelectFile) = tltData then
    begin
      for J := 0 to fTextManager.TextInfo.Count - 1 do
        if fTextManager.TextInfo[J].TextID = topId then
        begin
          fTextManager.AddText(aIDLang, Copy(fLoadedFile[I], firstDelimiter, Length(fLoadedFile[I])));
          Break;
        end;
    end else if fTextManager.GetTypeLibxText(fIDSelectFile) = tltCampaign then
    begin
      fTextManager.AddText(aIDLang, Copy(fLoadedFile[I], firstDelimiter, Length(fLoadedFile[I])));


    end;

  end;


  if AnsiLowerCase(gResLocales.Locales[aIDLang].Code) = DEFAULT_LOCALE then
  begin

    LoadConstDataText;
  end;


  if fTextManager.GetTypeLibxText(fIDSelectFile) = tltData then
  begin

  end else if fTextManager.GetTypeLibxText(fIDSelectFile) = tltCampaign then
  begin

  end else if fTextManager.GetTypeLibxText(fIDSelectFile) = tltMission then
  begin

  end;

end;


procedure TMySearchLibxIndexesThread.Execute;
var I: Integer;
begin
  ThreadProgressGetLibxIndexes(0);

  fLoadedFile := TStringList.Create;

  fTextManager.ClearTexts;

  if fTextManager.GetTypeLibxText(fIDSelectFile) = tltData then
    LoadConstDataText;

  for I := 0 to gResLocales.Count - 1 do
  begin
    GetTextFromLibx(I);
    ThreadProgressGetLibxIndexes(GetProcent((I + 1), gResLocales.Count));
  end;

  fLoadedFile.Free;

end;


end.
