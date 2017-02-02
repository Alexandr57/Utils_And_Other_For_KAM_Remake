unit CKR_Calculation;

interface
type
  TCKR_CTArmy = (taMilitia, taAxeFighter, taSwordFighter, taBowman,
  taCrossbowman, taLanceCarrier, taPikeman, taScout, taKnight);
  TCKR_CTRes = (trWoodenShields, trIronShields, trLeatherArmor, trIronArmor,
  trHandAxes, trSwords, trLances, trPikes, trLongbows, trCrossbows, trHorses,
  Recruit);
  TCKR_Calculation = class
  private
    //ArmyCount
    ArmyCount : Array[0..8] of Integer;
    ResCount : Array[0..11] of Integer;

    procedure Refresh;
  public
    constructor Create;
    destructor Destroy; override;

    procedure SetCountArmy(TypeArmy : TCKR_CTArmy; Count : Integer);
    function GetCountRessource(TypeRes : TCKR_CTRes) : Integer;
  end;
implementation

{ TCKR_Calculation }

constructor TCKR_Calculation.Create;
var I : Integer;
begin
  inherited Create;

  for I := 0 to Length(ArmyCount) - 1 do
    ArmyCount[I] := 0;
  for I := 0 to Length(ResCount) - 1 do
    ResCount[I] := 0;
end;

destructor TCKR_Calculation.Destroy;
var I : Integer;
begin
  for I := 0 to Length(ArmyCount) - 1 do
    ArmyCount[I] := -1;
  for I := 0 to Length(ResCount) - 1 do
    ResCount[I] := -1;

  inherited;
end;

procedure TCKR_Calculation.SetCountArmy(TypeArmy: TCKR_CTArmy;
  Count: Integer);
begin
  ArmyCount[ord(TypeArmy)] := Count;
end;

function TCKR_Calculation.GetCountRessource(TypeRes: TCKR_CTRes): Integer;
begin
  Result := ResCount[ord(TypeRes)];
end;

procedure TCKR_Calculation.Refresh;
begin
  ResCount[ord(trWoodenShields)] := ArmyCount[ord(taAxeFighter)] +
    ArmyCount[ord(taScout)];
  ResCount[ord(trIronShields)] := ArmyCount[ord(taSwordFighter)] +
    ArmyCount[ord(taKnight)];
  ResCount[ord(trLeatherArmor)] := ArmyCount[ord(taAxeFighter)] +
    ArmyCount[ord(taBowman)] + ArmyCount[ord(taLanceCarrier)] +
    ArmyCount[ord(taScout)];
  ResCount[ord(trIronArmor)] := ArmyCount[ord(taSwordFighter)] +
    ArmyCount[ord(taCrossbowman)] + ArmyCount[ord(taPikeman)] +
    ArmyCount[ord(taKnight)];
  ResCount[ord(trHandAxes)] := ArmyCount[ord(taMilitia)] +
    ArmyCount[ord(taAxeFighter)] + ArmyCount[ord(taScout)];
  ResCount[ord(trSwords)] := ArmyCount[ord(taSwordFighter)] +
    ArmyCount[ord(taKnight)];
  ResCount[ord(trLances)] := ArmyCount[ord(taLanceCarrier)];
  ResCount[ord(trPikes)] := ArmyCount[ord(taPikeman)];
  ResCount[ord(trLongbows)] := ArmyCount[ord(taBowman)];
  ResCount[ord(trCrossbows)] := ArmyCount[ord(taCrossbowman)];
  ResCount[ord(trHorses)] := ArmyCount[ord(taScout)] + ArmyCount[ord(taKnight)];
  ResCount[ord(Recruit)] := ArmyCount[ord(taMilitia)] + ArmyCount[ord(taAxeFighter)] +
    ArmyCount[ord(taSwordFighter)] + ArmyCount[ord(taBowman)] +
    ArmyCount[ord(taCrossbowman)] + ArmyCount[ord(taLanceCarrier)] +
    ArmyCount[ord(taPikeman)] + ArmyCount[ord(taScout)] + ArmyCount[ord(taKnight)];
end;

end.
