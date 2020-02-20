unit ReadScriptsKMR;

interface

uses
  System.Classes, SysUtils, System.StrUtils, System.Generics.Collections,
  JsonDataObjects, CONSTS;

type
  TVariableType = (vtnNull, vtnByte, vtnShortint, vtnSmallint, vtnWord, vtnInteger,
                       vtnCardinal, vtnSingle, vtnExtended, vtnBoolean,
                       vtnAnsiString, vtnString, vtnArrayOfConst, vtnArrayOfBoolean,
                       vtnArrayOfString, vtnArrayOfAnsiString, vtnArrayOfInteger,
                       vtnArrayOfSingle, vtnArrayOfExtended, vtnTKMHouseType,
                       vtnTKMWareType, vtnTKMFieldType, vtnTKMUnitType, vtnTKMGroupOrder,
                       vtnTKMObjectiveStatus, vtnTKMObjectiveType, vtnTKMArmyType,
                       vtnTKMHouseFace, vtnTKMTerrainTileBrief, vtnTKMMissionDifficulty,
                       vtnTKMMissionDifficultySet,vtnArrayOfTKMTerrainTileBrief,
                       vtnTKMAudioFormat, vtnTKMAIAttackTarget, vtnTKMPoint, vtnSetOfByte);

//Script Const

type
  TObjectScriptConstInfo = class
    Version: AnsiString;
    Name: AnsiString;
    Description: AnsiString;
    ScriptForParam: AnsiString;
    AssignmentScript: AnsiString;
    constructor Create(aVersion, aName, aScriptForParam: AnsiString);
  end;

//Script Event

type
  TObjectScriptEventInfo = class
  public
    Version: AnsiString;
    Name: AnsiString;
    Script: AnsiString;
    constructor Create(aVersion, aName, aScript: AnsiString);
  end;

//Script Actions

type
  TObjectScriptActionsInfo = class
  public
    Version: AnsiString;
    Name: AnsiString;
    Params: Array of AnsiString;
    Returns: AnsiString;
    Script: AnsiString;

    constructor Create(aVersion, aName, aReturns, aScript: AnsiString);
  end;

type
  TScriptsKMR = class
  private
    fJsonObject: TJsonObject;
    fScriptConst: TObjectList<TObjectScriptConstInfo>;
    fScriptEvents: TObjectList<TObjectScriptEventInfo>;
    //fScriptActions, fScriptStates, fScriptUtils: TStringList;

    procedure ParseScript(aTypeScripts: TTypeScripts);

    procedure WriteScriptsInJson(aFileJsonScripts: String);
    procedure ReadScriptsInJson(aFileJsonScripts: String);
  public
    constructor Create(aFileJsonScripts: String; aCreateJson: Boolean = false);
  end;

implementation
uses AL7_CommonUtils;

function TryParseEvents(aSL: TStringList; aIDStartLine: Integer;
  out aIDEndLine: Integer;
  out aOutVer, aOutName, aOutScript : AnsiString): Boolean;
var
  I: Integer;
begin
  if StartsText('//* Version:', aSL[aIDStartLine]) then
  begin
    aOutVer := 'r' + Trim(StrSubstringFromSubstring(aSL[aIDStartLine], '//* Version: '));
    for I := aIDStartLine + 1 to aSL.Count - 1 do
    begin
      if Pos('procedure tkmscriptevents.proc', AnsiLowerCase(aSL[I])) >= 1 then
      begin
        aOutName := 'On' + StrSubstringFromSubstring(aSL[I], 'procedure TKMScriptEvents.Proc', '(');
        aOutScript := '%sprocedure On' + StrSubstringFromSubstring(aSL[I], 'procedure TKMScriptEvents.Proc') + #13#10 + 'begin' + #13#10#9 + '%s' + #13#10 + 'end;';
        aIDEndLine := I;
        Result := True;
        Exit;
      end;
    end;
    Result := False;
  end else
    Result := False;
end;

{ TObjectScriptConst }


constructor TObjectScriptConstInfo.Create(aVersion, aName, aScriptForParam: AnsiString);
begin
  Version := aVersion;
  Name := aName;
  Description := '';
  ScriptForParam := aScriptForParam;
  AssignmentScript := ':= ' + aScriptForParam + ';';
end;


{ TObjectScriptEventInfo }


constructor TObjectScriptEventInfo.Create(aVersion, aName, aScript: AnsiString);
begin
  Version := aVersion;
  Name := aName;
  Script := aScript;
end;


{ TScriptsKMR }


procedure TScriptsKMR.ParseScript(aTypeScripts: TTypeScripts);
var
  ListScripts: TStringList;
  I, J: Integer;
  astr: AnsiString;
  astrVer, astrName, astrDesc, astrScript: AnsiString;
begin
  ListScripts := TStringList.Create;
  astrDesc := '';
  astrVer := '';
  astrName := '';
  astrScript := '';
  case aTypeScripts of
    toConsts:
    begin
      ListScripts.LoadFromFile(ExtractFilePath(ParamStr(0)) + FN_KMR_SCRIPT_CONST);

      for I := 0 to ListScripts.Count-1 do
      begin
        astrVer := 'r6720+';
        if (Pos('=', ListScripts[i]) > 0) and (Pos(';', ListScripts[i]) > 0) then
        begin
          astr := ListScripts[i];
          astr := StringReplace(astr, ' ', '', [rfReplaceAll]);
          astr := StringReplace(astr, #9, '', [rfReplaceAll]);
          astrName := StrSubstring(astr, 1, '=');
          astrScript := astrName;
          fScriptConst.Add(TObjectScriptConstInfo.Create(astrVer, astrName, astrScript));
        end;
      end;
    end;
    toEvents:
    begin
      ListScripts.LoadFromFile(ExtractFilePath(ParamStr(0)) + FN_KMR_SCRIPT_EV);
      I := 0;
      while I < ListScripts.Count do
      begin
        if TryParseEvents(ListScripts, I, I, astrVer, astrName, astrScript) then
        begin
          for J := 0 to High(VAR_TYPE_NAME) do
            astrScript := StringReplace(astrScript, VAR_TYPE_NAME[J], VAR_TYPE_ALIAS[J], [rfReplaceAll, rfIgnoreCase]);
          fScriptEvents.Add(TObjectScriptEventInfo.Create(astrVer, astrName, astrScript));
          astrVer := '';
          astrName := '';
          astrScript := '';
        end else
          Inc(I);
      end;
    end;
    toActions:
    begin
      ListScripts.LoadFromFile(ExtractFilePath(ParamStr(0)) + FN_KMR_SCRIPT_A);

    end;
    toStates: begin end;
    toUtils: begin end;
  end;
end;


procedure TScriptsKMR.WriteScriptsInJson(aFileJsonScripts: String);
var
  ItemConst: TObjectScriptConstInfo;
  ItemEvent: TObjectScriptEventInfo;
  childJsonObj1, childJsonObj2: TJsonObject;
  objArray: TJSONArray;
begin
  childJsonObj1 := fJsonObject.O['KMR_Scripts'];
  objArray := TJSONArray.Create;
  for ItemConst in fScriptConst do
  begin
    childJsonObj2 := TJsonObject.Create;
    childJsonObj2.S['Version'] := ItemConst.Version;
    childJsonObj2.S['Name'] := ItemConst.Name;
    childJsonObj2.S['Description'] := ItemConst.Description;
    childJsonObj2.S['ScriptForParam'] := ItemConst.ScriptForParam;
    objArray.Add(childJsonObj2);
  end;
  childJsonObj1.A['CONST'] := objArray;
  objArray := TJSONArray.Create;
  for ItemEvent in fScriptEvents do
  begin
    childJsonObj2 := TJsonObject.Create;
    childJsonObj2.S['Version'] := ItemEvent.Version;
    childJsonObj2.S['Name'] := ItemEvent.Name;
    childJsonObj2.S['Script'] := ItemEvent.Script;
    objArray.Add(childJsonObj2);
  end;
  childJsonObj1.A['Events'] := objArray;
  fJsonObject.SaveToFile(aFileJsonScripts, False);
end;


procedure TScriptsKMR.ReadScriptsInJson(aFileJsonScripts: String);
var
  obj: TJsonObject;
begin
  fJsonObject := TJsonObject.ParseFromFile(aFileJsonScripts) as TJsonObject;
  for obj in fJsonObject.O['KMR_Scripts'].A['CONST'] do
  begin
    fScriptConst.Add(TObjectScriptConstInfo.Create(
      obj.S['Version'],
      obj.S['Name'],
      obj.S['ScriptForParam']));
  end;
  for obj in fJsonObject.O['KMR_Scripts'].A['Events'] do
  begin
    fScriptEvents.Add(TObjectScriptEventInfo.Create(
      obj.S['Version'],
      obj.S['Name'],
      obj.S['Script']));
  end;
end;


constructor TScriptsKMR.Create(aFileJsonScripts: String; aCreateJson: Boolean = false);
begin
  fJsonObject := TJsonObject.Create;

  fScriptConst := TObjectList<TObjectScriptConstInfo>.Create();
  fScriptEvents := TObjectList<TObjectScriptEventInfo>.Create();

  if aCreateJson or not FileExists(aFileJsonScripts) then
  begin
    ParseScript(toConsts);
    ParseScript(toEvents);
    WriteScriptsInJson(aFileJsonScripts);
  end else begin
    ReadScriptsInJson(aFileJsonScripts);
  end;

end;


end.
