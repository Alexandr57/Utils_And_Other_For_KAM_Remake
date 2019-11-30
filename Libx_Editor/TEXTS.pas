unit TEXTS;
interface
uses System.Classes, System.SysUtils, System.StrUtils, System.Masks, Vcl.Forms,
     Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Dialogs,
     C_TEXTS,
     KM_Defaults, KM_FileIO, KM_ResLocales, KromUtils;

type
  TTextInfo = record
    TextID: Integer;
    ConstName: string; // Name used in KM_TextLibrary.pas
  end;

type
  TTextsArray = array of UnicodeString;

type

  TTextManager = class
  private
    fPaths: TStringList;

    fTextPath: string;
    fConstPath: string; // We use consts only for ingame library, others don't need them

    fTextsTopId: Integer;
    fTexts: Array of TTextsArray;
    fTextsOther: TStringList;
    fConsts: array of TTextInfo;

    //procedure FindFiles(aStartFolder, aSubFolders, aMask: string; aList: TStringList; ScanSubFolders: Boolean = True);
    function GetPath(aIndex: Integer): string;
    function GetCountFiles: Integer;

    procedure LoadConsts(aConstPath: string);
    procedure LoadText(TranslationID: integer; aCodePage: Word);
    procedure AddMissingConsts;
    function GetConst(aIndex: Integer): TTextInfo;

    function GetCount(aLIndex: Integer): Integer;
    function GetText(aIndex, aLIndex: Integer): UnicodeString;
  public
    constructor Create;
    destructor Destroy; override;

    property CountFiles: Integer read GetCountFiles;
    property Paths[aIndex: Integer]: string read GetPath; default;
    procedure ClearFiles;
    procedure AddPath(aBasePath, aSubPath: string; out aAddedFiles: TMemo; aScanSubFolders: Boolean = True);

    function Load(aBasePath: String; aIDFile: Integer; out aAddedFiles: TMemo): Boolean;

    function CheckDataText(aIDFile: Integer): Boolean;
    function CheckCampaignText(aIDFile: Integer): Boolean;

    function ConstCount: Integer;
    property Consts[aIndex: Integer]: TTextInfo read GetConst;

    property Count[aLIndex: Integer]: Integer read GetCount;
    property Text[aIndex, aLIndex: Integer]: UnicodeString read GetText;
    //property Code[aIndex, aLIndex: Integer]: String read GetIDXCode;
  end;

const
  eol: string = #13#10;

var
  fTextManager: TTextManager;

implementation

function Accum(aStr: String; aChar: CHar):Integer;
Var
  I, Count:integer;
begin
  Count:=0;
  for I := 1 to length(aStr) do
    if aStr[I] = aChar then inc(Count);

  Result := Count;
end;

{ TPathManager }


constructor TTextManager.Create;
var I: Integer;
begin
  inherited;
  fPaths := TStringList.Create;

  SetLength(fTexts, gResLocales.Count);

  fTextsOther := TStringList.Create;
end;


destructor TTextManager.Destroy;
var I: Integer;
begin
  fPaths.Free;
  FreeAndNil(fTexts);
  fTextsOther.Free;
  inherited;
end;


function TTextManager.GetCountFiles: Integer;
begin
  Result := fPaths.Count;
end;


function TTextManager.GetPath(aIndex: Integer): string;
begin
  Result :=  fPaths[aIndex];
end;


procedure TTextManager.AddPath(aBasePath, aSubPath: string;
  out aAddedFiles: TMemo; aScanSubFolders: Boolean);
var
  SearchRec: TSearchRec;
  FindResult: Integer;
  addFileMask : String;
  SubFolders: String;
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
          AddPath(aBasePath, aSubPath + SearchRec.Name + '\', aAddedFiles, aScanSubFolders);
      end
      else
      begin
        apr := SearchRec.Name;
        if Pos('.' + DEFAULT_LOCALE + EXT_FILE_LIBX_DOT, apr) <> 0 then
        begin
          addFileMask := LeftStr( SearchRec.Name, Length(SearchRec.Name) - ( Length(EXT_FILE_LIBX_DOT) + Length(DEFAULT_LOCALE) ) ) +'%s' + EXT_FILE_LIBX_DOT;
          SubFolders  := aBasePath + aSubPath;
          fPaths.Add(ExtractRelativePath(aBasePath, SubFolders + addFileMask));
          aAddedFiles.Text := aBasePath + aSubPath + addFileMask;
          aAddedFiles.Repaint;
        end;
      end;
      FindResult := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;

end;


procedure TTextManager.ClearFiles;
begin
  fPaths.Clear;
end;


function TTextManager.ConstCount: Integer;
begin
  Result := Length(fConsts);
end;


function TTextManager.GetConst(aIndex: Integer): TTextInfo;
begin
  Result := fConsts[aIndex];
end;


{function TTextManager.GetText(aIndex: Integer): TStringList;
begin

end;}


function TTextManager.CheckDataText(aIDFile: Integer): Boolean;
begin
  Result := SameText(Paths[aIDFile], PATH_TEXT);
end;


function TTextManager.CheckCampaignText(aIDFile: Integer): Boolean;
begin
  Result := (Pos(CMPPATH_1, LowerCase(Paths[aIDFile])) <> 0) and
            (Pos(CMPPATH_2, LowerCase(Paths[aIDFile])) <> 0) and
            (Accum(Paths[aIDFile], '\') = 2)
end;


procedure TTextManager.AddMissingConsts;
  function TextEmpty(aIndex: Integer): Boolean;
  var I: Integer;
  begin
    Result := True;
    for I := 0 to gResLocales.Count - 1 do
      Result := Result and (Trim(fTexts[I][aIndex]) = '');
  end;
  function TextUnused(aIndex: Integer): Boolean;
  var I: Integer;
  begin
    Result := True;
    for I := 0 to High(fConsts) do
    if fConsts[I].TextID = aIndex then
    begin
      Result := False;
      Break;
    end;
  end;
var
  I: Integer;
  s: string;
begin
  for I := 0 to fTextsTopId do
    if not TextEmpty(I) and TextUnused(I) then
    begin
      s := StringReplace(fTexts[gResLocales.IndexByCode(DEFAULT_LOCALE)][I], ' ', '', [rfReplaceAll]);
      s := UpperCase(LeftStr(s, 16));

      SetLength(fConsts, Length(fConsts) + 1);
      fConsts[High(fConsts)].TextID := I;

      fConsts[High(fConsts)].ConstName := Format('TX_UNUSED_%d_%s', [I, s]);
    end;
end;


procedure TTextManager.LoadConsts(aConstPath: string);
var
  SL: TStringList;
  Line: string;
  I, K, CenterPos, CommentPos: Integer;
begin
  SL := TStringList.Create;
  SL.LoadFromFile(aConstPath);

  SetLength(fConsts, SL.Count);

  for I := 0 to SL.Count - 1 do
  begin
    Line := Trim(SL[I]);

    CenterPos := Pos(' = ', Line);
    //Separator (line without ' = ')
    if CenterPos = 0 then
    begin
      fConsts[I].TextID := -1;
      fConsts[I].ConstName := '';
    end
    else
    begin
      CommentPos := Pos('; //', Line);
      if CommentPos = 0 then
        fConsts[I].TextID := StrToInt(Copy(Line, CenterPos + 3, Length(Line) - CenterPos - 3))
      else
        fConsts[I].TextID := StrToInt(Copy(Line, CenterPos + 3, CommentPos - CenterPos - 3));
      fConsts[I].ConstName := Copy(Line, 1, CenterPos - 1);
    end;
  end;

  //Ensure there are no duplicates, because that's a very bad situation
  for I := 0 to SL.Count - 1 do
    for K := I+1 to SL.Count - 1 do
      if (fConsts[I].TextID <> -1) and (fConsts[I].TextID = fConsts[K].TextID) then
        ShowMessage('Error: Two constants have the same ID!: '+fConsts[I].ConstName+' & '+fConsts[K].ConstName+' = '+IntToStr(fConsts[I].TextID));

  SL.Free;
end;


procedure TTextManager.LoadText(TranslationID: integer; aCodePage: Word);
begin

end;


function TTextManager.Load(aBasePath: String; aIDFile: Integer; out aAddedFiles: TMemo): Boolean;
begin

end;


function TTextManager.GetCount(aLIndex: Integer): Integer;
begin
  try
    Result := Length(fTexts[aLIndex]);
  except
    Result := 0;
  end;
end;


function TTextManager.GetText(aIndex, aLIndex: Integer): UnicodeString;
begin
  Result := fTexts[aLIndex][aIndex];
end;


end.
