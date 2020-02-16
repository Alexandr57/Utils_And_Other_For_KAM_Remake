unit ReadScriptsKMR;

interface

uses
  System.Classes, SysUtils, System.StrUtils, System.Generics.Collections,
  JsonDataObjects, CONSTS;

type
  TObjectScriptEventInfo = class
  public
    Version: AnsiString;
    Name: AnsiString;
    Description: AnsiString;
    Script: AnsiString;

    constructor Create(aVersion, aName, aDescription, aScript: AnsiString);
  end;

type
  TVariableTypeName = (vtnByte, vtnShortint, vtnSmallint, vtnWord, vtnInteger,
                       vtnCardinal, vtnSingle, vtnExtended, vtnBoolean,
                       vtnAnsiString, vtnString, vtnArrayOfConst, vtnArrayOfBoolean,
                       vtnArrayOfString, vtnArrayOfAnsiString, vtnArrayOfInteger,
                       vtnArrayOfSingle, vtnArrayOfExtended, vtnTKMHouseType,
                       vtnTKMWareType, vtnTKMFieldType, vtnTKMUnitType, vtnTKMGroupOrder,
                       vtnTKMObjectiveStatus, vtnTKMObjectiveType, vtnTKMArmyType,
                       vtnTKMHouseFace, vtnTKMTerrainTileBrief, vtnTKMMissionDifficulty,
                       vtnTKMMissionDifficultySet,vtnArrayOfTKMTerrainTileBrief,
                       vtnTKMAudioFormat, vtnTKMAIAttackTarget, vtnTKMPoint, vtnSetOfByte);

type
  TObjectScriptActionsInfo = class
  public
    Version: AnsiString;
    Name: AnsiString;
    Description: AnsiString;
    Script: AnsiString;

    constructor Create(aVersion, aName, aDescription, aScript: AnsiString);
  end;

type
  TScriptsKMR = class
  private
    fJsonObject: TJsonObject;
    //fScriptConst
    fScriptEvents: TObjectList<TObjectScriptEventInfo>;
    fScriptActions, fScriptStates, fScriptUtils: TStringList;

    procedure ParseScript(aTypeScripts: TTypeScripts);

    procedure WriteScriptsInJson(aFileJsonScripts: String);
    procedure ReadScriptsInJson(aFileJsonScripts: String);
  public
    constructor Create(aFileJsonScripts: String; aCreateJson: Boolean = false);
  end;

implementation
uses AL7_CommonUtils;

{ TObjectScriptEventInfo }


constructor TObjectScriptEventInfo.Create(aVersion, aName, aDescription, aScript: AnsiString);
begin
  Version := aVersion;
  Name := aName;
  Description := aDescription;
  Script := aScript;
end;


{ TScriptsKMR }


procedure TScriptsKMR.ParseScript(aTypeScripts: TTypeScripts);
var
  ListScripts: TStringList;
  I, J: Integer;
  astrVer, astrName, astrDesc, astrScript: AnsiString;
begin
  ListScripts := TStringList.Create;
  astrDesc := '';
  astrVer := '';
  astrName := '';
  astrScript := '';
  case aTypeScripts of
    toEvents:
    begin
      ListScripts.LoadFromFile(ExtractFilePath(ParamStr(0)) + FN_KMR_SCRIPT_EV);

      for I := 0 to ListScripts.Count-1 do
      begin
        if StartsText('//* Version:', ListScripts[I]) then
          astrVer := 'r' + Trim(StrSubstringFromSubstring(ListScripts[i], '//* Version: '));
        if (StartsText('//* ', ListScripts[I])) and (Pos('version:', AnsiLowerCase(ListScripts[i])) < 1) then
          if Length(astrDesc) > 0 then
            astrDesc := astrDesc + #13#10 + '//' + StrSubstringFromSubstring(ListScripts[i], '//* ')
          else
            astrDesc := astrDesc + '//' + StrSubstringFromSubstring(ListScripts[i], '//* ');

        if Pos('procedure tkmscriptevents.proc', AnsiLowerCase(ListScripts[i])) >= 1 then
        begin
          astrName := 'On' + StrSubstringFromSubstring(ListScripts[i], 'procedure TKMScriptEvents.Proc', '(');
          astrScript := '%sprocedure On' + StrSubstringFromSubstring(ListScripts[i], 'procedure TKMScriptEvents.Proc') + #13#10 + 'begin' + #13#10#9 + '%s' + #13#10 + 'end;';
          for J := 0 to High(VAR_TYPE_NAME) do
            astrScript := StringReplace(astrScript, VAR_TYPE_NAME[J], VAR_TYPE_ALIAS[J], [rfReplaceAll, rfIgnoreCase]);
        end;
        if (Length(astrVer) > 0) and
          (Length(astrName) > 0) and
          (Length(astrDesc) > 0) and
          (Length(astrScript) > 0) then
        begin
          fScriptEvents.Add(TObjectScriptEventInfo.Create(astrVer, astrName, astrDesc, astrScript));
          astrDesc := '';
          astrVer := '';
          astrName := '';
          astrScript := '';
        end;
      end;
    end;
    toActions: begin end;
    toStates: begin end;
    toUtils: begin end;
  end;
end;


procedure TScriptsKMR.WriteScriptsInJson(aFileJsonScripts: String);
var
  Item: TObjectScriptEventInfo;
  childJsonObj1, childJsonObj2: TJsonObject;
  eventsArray: TJSONArray;
begin
  childJsonObj1 := fJsonObject.O['KMR_Scripts'];
  eventsArray := TJSONArray.Create;
  for Item in fScriptEvents do
  begin
    childJsonObj2 := TJsonObject.Create;
    childJsonObj2.S['Version'] := Item.Version;
    childJsonObj2.S['Name'] := Item.Name;
    childJsonObj2.S['Description'] := Item.Description;
    childJsonObj2.S['Script'] := Item.Script;
    EventsArray.Add(childJsonObj2);
  end;
  childJsonObj1.A['Events'] := EventsArray;
  fJsonObject.SaveToFile(aFileJsonScripts, False);
end;


procedure TScriptsKMR.ReadScriptsInJson(aFileJsonScripts: String);
var
  obj: TJsonObject;
begin
  fJsonObject := TJsonObject.ParseFromFile(aFileJsonScripts) as TJsonObject;
  for obj in fJsonObject.O['KMR_Scripts'].A['Events'] do
  begin
    fScriptEvents.Add(TObjectScriptEventInfo.Create(
      obj.S['Version'],
      obj.S['Name'],
      obj.S['Description'],
      obj.S['Script']));
  end;
end;


constructor TScriptsKMR.Create(aFileJsonScripts: String; aCreateJson: Boolean = false);
begin
  fJsonObject := TJsonObject.Create;

  fScriptEvents := TObjectList<TObjectScriptEventInfo>.Create();

  if aCreateJson or not FileExists(aFileJsonScripts) then
  begin
    ParseScript(toEvents);
    WriteScriptsInJson(aFileJsonScripts);
  end else begin
    ReadScriptsInJson(aFileJsonScripts);
  end;

end;


end.
