unit TextsUnit;

interface
uses System.Classes, System.SysUtils, System.Generics.Collections;


type TTypeLibxText = (tltMission, tltCampaign, tltData);

type
  TTextInfo = class
  public
    TextID: Integer;
    ConstName: String;

    constructor Create(const aTextID: Integer; aConstName: String);
  end;


type
  TLibxText = Array of TStringList;


type
  TTextManager = class
  private
    fPathKMR: String;
    fCountLocales: Integer;
    fFiles: TStringList;
    fTextInfo: TObjectList<TTextInfo>;
    fTexts: TLibxText;

    function GetFileName(aIndex : Integer): String;

    function GetCountTexts(aIDLang: Integer): Integer;
  public
    constructor Create(aPathKMR: String; aCountLocales: Integer);
    destructor Destroy; override;

    function GetTypeLibxText(aIDFile: Integer) : TTypeLibxText;

    function AddFile(aFile: string): Integer;
    procedure ClearFiles;

    function AddTextInfo(aTextID: Integer; aConstName: String): Integer;
    function AddText(aIDLang: Integer; aText: UnicodeString): Integer;

    procedure ClearTexts;


    property FileName[aIndex: Integer]: String read GetFileName;

    property TextInfo: TObjectList<TTextInfo> read fTextInfo;
    property CountTexts[aIDLang: Integer]: Integer read GetCountTexts;
  end;


implementation
uses CONSTS;


function Accum(aStr: String; aChar: CHar):Integer;
Var
  I, Count:integer;
begin
  Count:=0;
  for I := 1 to length(aStr) do
    if aStr[I] = aChar then inc(Count);

  Result := Count;
end;


{ TTextInfo }


constructor TTextInfo.Create(const aTextID: Integer; aConstName: String);
begin
  TextID := aTextID;
  ConstName := aConstName;
end;


{ TTextManager }


constructor TTextManager.Create(aPathKMR: String; aCountLocales: Integer);
var I: Integer;
begin
  fPathKMR := aPathKMR;
  fCountLocales := aCountLocales;

  fFiles := TStringList.Create;
  fTextInfo := TObjectList<TTextInfo>.Create;
  SetLength(fTexts, aCountLocales);
  for I := 0 to aCountLocales - 1 do
    fTexts[I] := TStringList.Create;

end;


destructor TTextManager.Destroy;
begin
  FreeAndNil(fFiles);
  FreeAndNil(fTextInfo);
  FreeAndNil(fTexts);

  inherited;
end;


function TTextManager.GetTypeLibxText(aIDFile: Integer): TTypeLibxText;
begin
  if SameText(fFiles[aIDFile], PATH_DATA_TEXT) then
    Result := tltData
  else if (Pos(POS_CMPPATH, LowerCase(fFiles[aIDFile])) <> 0) and
  (Pos(POS_CMPFN, LowerCase(fFiles[aIDFile])) <> 0) and
  (Accum(fFiles[aIDFile], '\') = 2) then
    Result := tltCampaign
  else
    Result := tltMission;
end;


function TTextManager.GetFileName(aIndex: Integer): String;
begin
  if aIndex > fFiles.Count - 1 then
    Result := ''
  else
    Result := fFiles[aIndex];
end;


function TTextManager.GetCountTexts(aIDLang: Integer): Integer;
begin
  Result := fTexts[aIDLang].Count;
end;


function TTextManager.AddFile(aFile: string): Integer;
begin
  fFiles.Add(aFile);
  Result := fFiles.Count;
end;


procedure TTextManager.ClearFiles;
var I: Integer;
begin
  fTextInfo.Clear;
  for I := 0 to fCountLocales - 1 do
    fTexts[I].Clear;
  fFiles.Clear;
end;


function TTextManager.AddTextInfo(aTextID: Integer;
  aConstName: String): Integer;
begin
  fTextInfo.Add(TTextInfo.Create(aTextID, aConstName));
  Result := fTextInfo.Count;
end;


function TTextManager.AddText(aIDLang: Integer; aText: UnicodeString): Integer;
begin
  fTexts[aIDLang].Add(aText);
  Result := fTexts[aIDLang].Count;
end;


procedure TTextManager.ClearTexts;
var I: Integer;
begin
  fTextInfo.Clear;
  for I := 0 to fCountLocales - 1 do
    fTexts[I].Clear;
end;


end.
