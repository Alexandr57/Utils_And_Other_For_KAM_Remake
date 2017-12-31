unit TEXTS;
interface
uses System.Classes, System.SysUtils, System.StrUtils, System.Masks, Vcl.Forms,
     C_TEXTS,
     KM_Defaults, KM_FileIO, KM_ResLocales;

type

  TTextManager = class
  private
    fPaths: TStringList;
    fTexts: Array of Array of TStringList;
    fTextsOther: TStringList;

    //procedure FindFiles(aStartFolder, aSubFolders, aMask: string; aList: TStringList; ScanSubFolders: Boolean = True);
    function GetPath(aIndex: Integer): string;
    function GetCountFiles: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    property CountFiles: Integer read GetCountFiles;
    property Paths[aIndex: Integer]: string read GetPath; default;
    procedure Clear;
    procedure AddPath(aBasePath, aSubPath: string; out aAddedFiles: String; aScanSubFolders: Boolean = True);

    procedure LoadFiles(out aProgress: Integer);
  end;

implementation

{ TPathManager }


constructor TTextManager.Create;
begin
  inherited;
  fPaths := TStringList.Create;
  fTextsOther := TStringList.Create;
end;


destructor TTextManager.Destroy;
begin
  fPaths.Free;
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
  out aAddedFiles: String; aScanSubFolders: Boolean);
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
          fPaths.Add(ExtractRelativePath(aBasePath, SubFolders) + addFileMask);
          aAddedFiles := aBasePath + aSubPath + addFileMask;
        end;
      end;
      Application.ProcessMessages;
      FindResult := FindNext(SearchRec);
    end;
  finally
    FindClose(SearchRec);
  end;

end;

procedure TTextManager.Clear;
begin
  fPaths.Clear;
end;


procedure TTextManager.LoadFiles;
begin

end;


end.
