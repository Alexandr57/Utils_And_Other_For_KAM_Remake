unit CalcResourceKMRUnit;
{$I ..\..\kam_remake\KaM_Remake.inc}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Samples.Spin,
  KM_Defaults, KM_Pics, KM_ResPalettes, KM_ResSpritesEdit,
  Versions, Vcl.Buttons;

type
  TfrmCalcResourceKMR = class(TForm)
    PageControl1: TPageControl;
    tbsHouse: TTabSheet;
    grbStorehouse: TGroupBox;
    scrlbHouse: TScrollBox;
    tbsUnit: TTabSheet;
    scrlbUnit: TScrollBox;
    pnlInfo: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure scrlbHouseMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure scrlbUnitMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private

    lblInfoName:                                           TLabel;
    lblType, lblTypeHint:                                  TLabel;

    fPalettes: TKMResPalettes;
    fSprites: TKMSpritePackEdit;

    pnlStorehouseResource:                                 Array of TPanel;
    lblTypeStorehouseResource, lblCountStorehouseResource: Array of Tlabel;
    imgStorehouseResource:                                 Array of TImage;

    pnlHouse:                                              Array of TPanel;
    lblTypeHouse:                                          Array of TLabel;
    speCountHouse:                                         Array of TSpinEdit;
    imgHouse:                                              Array of TImage;

    pnlUnit_1:                                             Array of TPanel;
    lblTypeUnit_1:                                         Array of TLabel;
    speCountUnit_1:                                        Array of TSpinEdit;
    imgUnit_1:                                             Array of TImage;

    procedure Events_speCountHouse_Change(Sender: TObject);

    procedure Events_speCountUnit_Change(Sender: TObject);

    procedure CreateWindowInfo;

    procedure CreateStorehouseResource;

    procedure CreateHouse;

    procedure CreateUnits;

  public
    { Public declarations }
  end;

const
  COUNT_STOREHOUSE_RESOURCE = 29;
  ID_STOREHOUSE_RESOURCE    = 351;
  HINT_STOREHOUSE_RESOURCE:Array[0..COUNT_STOREHOUSE_RESOURCE - 1] of String =
  (
    'Tree trunk',    //0
    'Stone',         //1
    'Timber',        //2
    'Iron ore',      //3
    'Gold ore',      //4
    'Coal',          //5
    'Iron',          //6
    'Gold',          //7
    'Wine',          //8
    'Corn',          //9
    'Loaves',        //10
    'Flour',         //11
    'Leather',       //12
    'Sausages',      //13
    'Pig',           //14
    'Skin',          //15
    'Wooden Shield', //16
    'Long Shield',   //17
    'Leather Armor', //18
    'Iron Armament', //19
    'Handaxe',       //20
    'Longsword',     //21
    'Lance',         //22
    'Pike',          //23
    'Longbow',       //24
    'Crossbow',      //25
    'Horse',         //26
    'Fish',          //27
    'Recruit'        //28
  );

  COUNT_HOUSE               = 29;
  ID_HOUSE                  = 301;

  COUNT_UNIT_1              = 14;
  COUNT_UNIT_2              = 10;
  COUNT_UNIT_3              = 4;

  ID_UNIT_1                 = 141;
  ID_UNIT_2                 = 61;
  ID_UNIT_3                 = 79;

  SHOW_VER_RELEASE          = True;
  SHOW_VER_BUILD            = True;

  PROJECT_VERSION           = '';

  CLR_DIS_PNL: TColor       = $CCCCCC;

  CLR_DIS_FNT: TColor       = $838383;

var
  frmCalcResourceKMR: TfrmCalcResourceKMR;
  PathKAM: String;
  bmpBase: TBitmap;

  COUNT_ST_RES: Array [0..COUNT_STOREHOUSE_RESOURCE - 1] of Integer;

implementation

{$R *.dfm}

procedure TfrmCalcResourceKMR.CreateWindowInfo;
begin
  pnlInfo.Caption        := '';

  pnlInfo.Left           := 16;
  pnlInfo.Top            := 16;
  pnlInfo.Width          := ClientWidth - 32;
  pnlInfo.Height         := ClientHeight - 32;
  pnlInfo.Padding.Left   := 8;
  pnlInfo.Padding.Top    := 8;
  pnlInfo.Padding.Right  := 8;
  pnlInfo.Padding.Bottom := 8;
  pnlInfo.Visible        := False;

  lblInfoName            := TLabel.Create(pnlInfo);
  lblInfoName.Parent     := pnlInfo;
  lblInfoName.Font       := Font;
  lblInfoName.Font.Style := [fsBold];
  lblInfoName.Align      := alTop;
  lblInfoName.AutoSize   := False;
  lblInfoName.Alignment  := taCenter;
  lblInfoName.Layout     := tlCenter;
  lblInfoName.Height     := 24;
  lblInfoName.Caption    := 'No Select';

  lblType                := TLabel.Create(pnlInfo);
  lblType.Parent         := pnlInfo;
  lblType.Font           := Font;
  lblType.Font.Style     := [fsBold];
  lblType.AutoSize       := False;
  lblType.Alignment      := taCenter;
  lblType.Layout         := tlCenter;
  lblType.Left           := 8;
  lblType.Top            := lblInfoName.Top + Height + 8;
  //lblType.
end;


procedure TfrmCalcResourceKMR.CreateStorehouseResource;
var
  I, IDTag: Integer;
begin
  SetLength(pnlStorehouseResource     , COUNT_STOREHOUSE_RESOURCE);
  SetLength(lblTypeStorehouseResource , COUNT_STOREHOUSE_RESOURCE);
  SetLength(lblCountStorehouseResource, COUNT_STOREHOUSE_RESOURCE);
  SetLength(imgStorehouseResource     , COUNT_STOREHOUSE_RESOURCE);
  for I := 0 to COUNT_STOREHOUSE_RESOURCE - 1 do
  begin
    COUNT_ST_RES[I]                          := 0;

    if I = (COUNT_STOREHOUSE_RESOURCE - 1) then
      IDTag := 13
    else
      IDTag := I;

    pnlStorehouseResource[I]                 := TPanel.Create(grbStorehouse);
    pnlStorehouseResource[I].Parent           := grbStorehouse;
    pnlStorehouseResource[I].Width            := 64;
    pnlStorehouseResource[I].Height           := 64;
    pnlStorehouseResource[I].Left             := (I mod 5 * pnlStorehouseResource[I].Width) + 8 + ((I mod 5) * 8);
    pnlStorehouseResource[I].Top              := ((I div 5) * pnlStorehouseResource[I].Height) + 28 + ((I div 5) * 8);
    pnlStorehouseResource[I].ParentBackground := False;
    pnlStorehouseResource[I].ParentColor      := False;
    pnlStorehouseResource[I].Tag              := I;

    lblTypeStorehouseResource[I]              := TLabel.Create(pnlStorehouseResource[I]);
    lblTypeStorehouseResource[I].Parent       := pnlStorehouseResource[I];
    lblTypeStorehouseResource[I].Align        := alTop;
    lblTypeStorehouseResource[I].Alignment    := taCenter;
    lblTypeStorehouseResource[I].Layout       := tlCenter;
    lblTypeStorehouseResource[I].Caption      := 'Type: ' + IntToStr(IDTag);
    lblTypeStorehouseResource[I].Tag          := I;

    lblCountStorehouseResource[I]             := TLabel.Create(pnlStorehouseResource[I]);
    lblCountStorehouseResource[I].Parent      := pnlStorehouseResource[I];
    lblCountStorehouseResource[I].Align       := alBottom;
    lblCountStorehouseResource[I].Alignment   := taCenter;
    lblCountStorehouseResource[I].Layout      := tlCenter;
    lblCountStorehouseResource[I].Caption     := '0';
    lblCountStorehouseResource[I].Tag         := I;

    imgStorehouseResource[I]                  := TImage.Create(pnlStorehouseResource[I]);
    imgStorehouseResource[I].Parent           := pnlStorehouseResource[I];
    imgStorehouseResource[I].Align            := alClient;
    imgStorehouseResource[I].Transparent      := True;
    imgStorehouseResource[I].Center           := True;
    imgStorehouseResource[I].ShowHint         := True;
    imgStorehouseResource[I].Hint             := HINT_STOREHOUSE_RESOURCE[I];
    imgStorehouseResource[I].Tag              := I;

    imgStorehouseResource[I].Picture.Bitmap.Canvas.Brush.Color := 0;
    imgStorehouseResource[I].Picture.Bitmap.Canvas.FillRect(imgStorehouseResource[I].Picture.Bitmap.Canvas.ClipRect);
    if I = (COUNT_STOREHOUSE_RESOURCE - 1) then
      fSprites.GetImageToBitmap((ID_UNIT_1 + COUNT_UNIT_1 - 1), bmpBase, nil)
    else
      fSprites.GetImageToBitmap(ID_STOREHOUSE_RESOURCE + I, bmpBase, nil);
    imgStorehouseResource[I].Picture.Assign(bmpBase);
  end;

end;


procedure TfrmCalcResourceKMR.CreateHouse;
var
  I, IDTag: Integer;
begin
  SetLength(pnlHouse     , COUNT_HOUSE);
  SetLength(lblTypeHouse , COUNT_HOUSE);
  SetLength(speCountHouse, COUNT_HOUSE);
  SetLength(imgHouse     , COUNT_HOUSE);

  for I := 0 to COUNT_HOUSE- 1 do
  begin
    if I = 26 then
      IDTag := 29
    else
      IDTag := I;

    pnlHouse[I]                := TPanel.Create(scrlbHouse);
    pnlHouse[I].Parent         := scrlbHouse;
    pnlHouse[I].Width          := 64;
    pnlHouse[I].Height         := 96;
    pnlHouse[I].Left           := (I mod 5 * pnlHouse[I].Width) + 8 + ((I mod 5) * 8);
    pnlHouse[I].Top            := ((I div 5) * pnlHouse[I].Height) + 8 + ((I div 5) * 8);
    pnlHouse[I].Tag            := IDTag;

    lblTypeHouse[I]            := TLabel.Create(pnlHouse[I]);
    lblTypeHouse[I].Parent     := pnlHouse[I];
    lblTypeHouse[I].Align      := alTop;
    lblTypeHouse[I].Alignment  := taCenter;
    lblTypeHouse[I].Layout     := tlCenter;
    lblTypeHouse[I].Caption    := 'Type: ' + IntToStr(IDTag);
    lblTypeHouse[I].Tag        := IDTag;

    speCountHouse[I]           := TSpinEdit.Create(pnlHouse[I]);
    speCountHouse[I].Parent    := pnlHouse[I];
    speCountHouse[I].Align     := alBottom;
    speCountHouse[I].Alignment := taCenter;
    speCountHouse[I].Value     := 0;
    speCountHouse[I].Font.Size := 8;
    speCountHouse[I].Tag       := IDTag;
    speCountHouse[I].MinValue  := 0;
    speCountHouse[I].MaxValue  := 100;
    speCountHouse[I].OnChange  := Events_speCountHouse_Change;

    imgHouse[I]                := TImage.Create(pnlHouse[I]);
    imgHouse[I].Parent         := pnlHouse[I];
    imgHouse[I].Align          := alClient;
    imgHouse[I].Transparent    := True;
    imgHouse[I].Center         := True;
    imgHouse[I].Proportional   := True;
    imgHouse[I].Tag            := IDTag;

    imgHouse[I].Picture.Bitmap.Canvas.Brush.Color := 0;
    imgHouse[I].Picture.Bitmap.Canvas.FillRect(imgHouse[I].Picture.Bitmap.Canvas.ClipRect);
    fSprites.GetImageToBitmap(ID_HOUSE + I, bmpBase, nil);
    imgHouse[I].Picture.Assign(bmpBase);
  end;

end;


procedure TfrmCalcResourceKMR.CreateUnits;
var
  I, XS2, YS2: Integer;
begin
  SetLength(pnlUnit_1     , COUNT_UNIT_1 + COUNT_UNIT_2 + COUNT_UNIT_3);
  SetLength(lblTypeUnit_1 , COUNT_UNIT_1 + COUNT_UNIT_2 + COUNT_UNIT_3);
  SetLength(speCountUnit_1, COUNT_UNIT_1 + COUNT_UNIT_2 + COUNT_UNIT_3);
  SetLength(imgUnit_1     , COUNT_UNIT_1 + COUNT_UNIT_2 + COUNT_UNIT_3);

  for I := 0 to COUNT_UNIT_1 - 1 do
  begin
    pnlUnit_1[I]                := TPanel.Create(scrlbUnit);
    pnlUnit_1[I].Parent         := scrlbUnit;
    pnlUnit_1[I].Width          := 64;
    pnlUnit_1[I].Height         := 96;
    pnlUnit_1[I].Left           := (I mod 5 * pnlUnit_1[I].Width) + 8 + ((I mod 5) * 8);
    pnlUnit_1[I].Top            := ((I div 5) * pnlUnit_1[I].Height) + 8 + ((I div 5) * 8);
    pnlUnit_1[I].Tag            := I;

    lblTypeUnit_1[I]            := TLabel.Create(pnlUnit_1[I]);
    lblTypeUnit_1[I].Parent     := pnlUnit_1[I];
    lblTypeUnit_1[I].Align      := alTop;
    lblTypeUnit_1[I].Alignment  := taCenter;
    lblTypeUnit_1[I].Layout     := tlCenter;
    lblTypeUnit_1[I].Caption    := 'Type: ' + IntToStr(I);
    lblTypeUnit_1[I].Tag        := I;

    speCountUnit_1[I]           := TSpinEdit.Create(pnlUnit_1[I]);
    speCountUnit_1[I].Parent    := pnlUnit_1[I];
    speCountUnit_1[I].Align     := alBottom;
    speCountUnit_1[I].Alignment := taCenter;
    speCountUnit_1[I].Value     := 0;
    speCountUnit_1[I].Font.Size := 8;
    speCountUnit_1[I].Tag       := I;
    speCountUnit_1[I].MinValue  := 0;
    speCountUnit_1[I].MaxValue  := 100;
    speCountUnit_1[I].OnChange  := Events_speCountUnit_Change;

    imgUnit_1[I]                := TImage.Create(pnlUnit_1[I]);
    imgUnit_1[I].Parent         := pnlUnit_1[I];
    imgUnit_1[I].Align          := alClient;
    imgUnit_1[I].Transparent    := True;
    imgUnit_1[I].Center         := True;
    imgUnit_1[I].Proportional   := True;
    imgUnit_1[I].Tag            := I;

    imgUnit_1[I].Picture.Bitmap.Canvas.Brush.Color := 0;
    imgUnit_1[I].Picture.Bitmap.Canvas.FillRect(imgHouse[I].Picture.Bitmap.Canvas.ClipRect);
    fSprites.GetImageToBitmap(ID_UNIT_1 + I, bmpBase, nil);
    imgUnit_1[I].Picture.Assign(bmpBase);
  end;

  for I := COUNT_UNIT_1 to (COUNT_UNIT_2 + COUNT_UNIT_1) - 1 do
  begin

    XS2 := I - COUNT_UNIT_1;
    YS2 := I + 1;

    pnlUnit_1[I]                := TPanel.Create(scrlbUnit);
    pnlUnit_1[I].Parent         := scrlbUnit;
    pnlUnit_1[I].Width          := 64;
    pnlUnit_1[I].Height         := 96;
    pnlUnit_1[I].Left           := (XS2 mod 5 * pnlUnit_1[I].Width) + 8 + ((XS2 mod 5) * 8);
    pnlUnit_1[I].Top            := ((YS2 div 5) * pnlUnit_1[I].Height) + 12 + ((YS2 div 5) * 8);
    pnlUnit_1[I].Tag            := I;

    lblTypeUnit_1[I]            := TLabel.Create(pnlUnit_1[I]);
    lblTypeUnit_1[I].Parent     := pnlUnit_1[I];
    lblTypeUnit_1[I].Align      := alTop;
    lblTypeUnit_1[I].Alignment  := taCenter;
    lblTypeUnit_1[I].Layout     := tlCenter;
    lblTypeUnit_1[I].Caption    := 'Type: ' + IntToStr(I);
    lblTypeUnit_1[I].Tag        := I;

    speCountUnit_1[I]           := TSpinEdit.Create(pnlUnit_1[I]);
    speCountUnit_1[I].Parent    := pnlUnit_1[I];
    speCountUnit_1[I].Align     := alBottom;
    speCountUnit_1[I].Alignment := taCenter;
    speCountUnit_1[I].Value     := 0;
    speCountUnit_1[I].Font.Size := 8;
    speCountUnit_1[I].Tag       := I;
    speCountUnit_1[I].MinValue  := 0;
    speCountUnit_1[I].MaxValue  := 100;
    speCountUnit_1[I].OnChange  := Events_speCountUnit_Change;

    imgUnit_1[I]                := TImage.Create(pnlUnit_1[I]);
    imgUnit_1[I].Parent         := pnlUnit_1[I];
    imgUnit_1[I].Align          := alClient;
    imgUnit_1[I].Transparent    := True;
    imgUnit_1[I].Center         := True;
    imgUnit_1[I].Proportional   := True;
    imgUnit_1[I].Tag            := I;

    imgUnit_1[I].Picture.Bitmap.Canvas.Brush.Color := 0;
    imgUnit_1[I].Picture.Bitmap.Canvas.FillRect(imgHouse[I].Picture.Bitmap.Canvas.ClipRect);
    fSprites.GetImageToBitmap(ID_UNIT_2 + XS2, bmpBase, nil);
    imgUnit_1[I].Picture.Assign(bmpBase);
  end;

  for I := (COUNT_UNIT_1 + COUNT_UNIT_2) to (COUNT_UNIT_3 + (COUNT_UNIT_1 + COUNT_UNIT_2)) - 1 do
  begin

    XS2 := I - (COUNT_UNIT_1 + COUNT_UNIT_2);
    YS2 := (COUNT_UNIT_1 + COUNT_UNIT_2) + 1;

    pnlUnit_1[I]                := TPanel.Create(scrlbUnit);
    pnlUnit_1[I].Parent         := scrlbUnit;
    pnlUnit_1[I].Width          := 64;
    pnlUnit_1[I].Height         := 96;
    pnlUnit_1[I].Left           := (XS2 mod 5 * pnlUnit_1[I].Width) + 8 + ((XS2 mod 5) * 8);
    pnlUnit_1[I].Top            := ((YS2 div 5) * pnlUnit_1[I].Height) + 16 + ((YS2 div 5) * 8);
    pnlUnit_1[I].Tag            := I;

    lblTypeUnit_1[I]            := TLabel.Create(pnlUnit_1[I]);
    lblTypeUnit_1[I].Parent     := pnlUnit_1[I];
    lblTypeUnit_1[I].Align      := alTop;
    lblTypeUnit_1[I].Alignment  := taCenter;
    lblTypeUnit_1[I].Layout     := tlCenter;
    lblTypeUnit_1[I].Caption    := 'Type: ' + IntToStr(I);
    lblTypeUnit_1[I].Tag        := I;

    speCountUnit_1[I]           := TSpinEdit.Create(pnlUnit_1[I]);
    speCountUnit_1[I].Parent    := pnlUnit_1[I];
    speCountUnit_1[I].Align     := alBottom;
    speCountUnit_1[I].Alignment := taCenter;
    speCountUnit_1[I].Value     := 0;
    speCountUnit_1[I].Font.Size := 8;
    speCountUnit_1[I].Tag       := I;
    speCountUnit_1[I].MinValue  := 0;
    speCountUnit_1[I].MaxValue  := 100;
    speCountUnit_1[I].OnChange  := Events_speCountUnit_Change;

    imgUnit_1[I]                := TImage.Create(pnlUnit_1[I]);
    imgUnit_1[I].Parent         := pnlUnit_1[I];
    imgUnit_1[I].Align          := alClient;
    imgUnit_1[I].Transparent    := True;
    imgUnit_1[I].Center         := True;
    imgUnit_1[I].Proportional   := True;
    imgUnit_1[I].Tag            := I;

    imgUnit_1[I].Picture.Bitmap.Canvas.Brush.Color := 0;
    imgUnit_1[I].Picture.Bitmap.Canvas.FillRect(imgHouse[I].Picture.Bitmap.Canvas.ClipRect);
    fSprites.GetImageToBitmap(ID_UNIT_3 + XS2, bmpBase, nil);
    imgUnit_1[I].Picture.Assign(bmpBase);
  end;

end;


procedure TfrmCalcResourceKMR.Events_speCountHouse_Change(Sender: TObject);
var
  I: Integer;
begin
  COUNT_ST_RES[1] := 0;
  COUNT_ST_RES[2] := 0;

  //Sawmill
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[0].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[0].Value * 4);

  //Iron Smithy
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[1].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[1].Value * 4);

  //Weapon Smithy
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[2].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[2].Value * 4);

  //Coal Mine
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[3].Value * 2);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[3].Value * 3);

  //Iron Mine
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[4].Value * 2);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[4].Value * 3);

  //Gold Mine
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[5].Value * 2);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[5].Value * 3);

  //Fisherman's Hut
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[6].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[6].Value * 4);

  //Bakery
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[7].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[7].Value * 4);

  //Farm
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[8].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[8].Value * 4);

  //Woodcutter's
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[9].Value * 2);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[9].Value * 3);

  //Armor Smithy
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[10].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[10].Value * 4);

  //Storehouse
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[11].Value * 5);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[11].Value * 6);

  //Stables
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[12].Value * 5);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[12].Value * 6);

  //School House
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[13].Value * 5);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[13].Value * 6);

  //Quarry
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[14].Value * 2);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[14].Value * 3);

  //Metallurgist's
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[15].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[15].Value * 4);

  //Swine farm
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[16].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[16].Value * 4);

  //Watch Tower
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[17].Value * 2);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[17].Value * 3);

  //Town Hall
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[18].Value * 5);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[18].Value * 6);

  //Weapons Workshop
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[19].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[19].Value * 4);

  //Armory Workshop
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[20].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[20].Value * 4);

  //Barracks
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[21].Value * 6);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[21].Value * 6);

  //Mill
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[22].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[22].Value * 4);

  //Vehicles Workshop
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[23].Value * 0);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[23].Value * 0);

  //Butcher's
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[24].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[24].Value * 4);

  //Tannery
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[25].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[25].Value * 4);

  //Market
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[26].Value * 6);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[26].Value * 5);

  //Inn
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[27].Value * 5);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[27].Value * 6);

  //Vineyard
  COUNT_ST_RES[1] := COUNT_ST_RES[1] + (speCountHouse[28].Value * 3);
  COUNT_ST_RES[2] := COUNT_ST_RES[2] + (speCountHouse[28].Value * 4);

  lblCountStorehouseResource[1].Caption := IntToStr(COUNT_ST_RES[1]);
  lblCountStorehouseResource[2].Caption := IntToStr(COUNT_ST_RES[2]);

end;


procedure TfrmCalcResourceKMR.Events_speCountUnit_Change(Sender: TObject);
begin
  COUNT_ST_RES[7]  := 0;
  COUNT_ST_RES[16] := 0;
  COUNT_ST_RES[17] := 0;
  COUNT_ST_RES[18] := 0;
  COUNT_ST_RES[19] := 0;
  COUNT_ST_RES[20] := 0;
  COUNT_ST_RES[21] := 0;
  COUNT_ST_RES[22] := 0;
  COUNT_ST_RES[23] := 0;
  COUNT_ST_RES[24] := 0;
  COUNT_ST_RES[25] := 0;
  COUNT_ST_RES[26] := 0;
  COUNT_ST_RES[28] := 0;


  //Serf
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[0].Value;

  //Woodcutter
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[1].Value;

  //Miner
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[2].Value;

  //Animal Breeder
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[3].Value;

  //Farmer
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[4].Value;

  //Carpenter
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[5].Value;

  //Baker
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[6].Value;

  //Butcher
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[7].Value;

  //Fisherman
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[8].Value;

  //Laborer
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[9].Value;

  //Stone Mason
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[10].Value;

  //Blacksmith
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[11].Value;

  //Metallurgist
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[12].Value;

  //Recruit
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[13].Value;


  //Militia
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[14].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[14].Value;
  COUNT_ST_RES[20] := COUNT_ST_RES[20] + speCountUnit_1[14].Value;

  //Axe Fighter
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[15].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[15].Value;
  COUNT_ST_RES[20] := COUNT_ST_RES[20] + speCountUnit_1[15].Value;
  COUNT_ST_RES[16] := COUNT_ST_RES[16] + speCountUnit_1[15].Value;
  COUNT_ST_RES[18] := COUNT_ST_RES[18] + speCountUnit_1[15].Value;

  //Sword Fighter
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[16].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[16].Value;
  COUNT_ST_RES[21] := COUNT_ST_RES[21] + speCountUnit_1[16].Value;
  COUNT_ST_RES[17] := COUNT_ST_RES[17] + speCountUnit_1[16].Value;
  COUNT_ST_RES[19] := COUNT_ST_RES[19] + speCountUnit_1[16].Value;

  //Bowman
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[17].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[17].Value;
  COUNT_ST_RES[24] := COUNT_ST_RES[24] + speCountUnit_1[17].Value;
  COUNT_ST_RES[18] := COUNT_ST_RES[18] + speCountUnit_1[17].Value;

  //Crossbowman
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[18].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[18].Value;
  COUNT_ST_RES[25] := COUNT_ST_RES[25] + speCountUnit_1[18].Value;
  COUNT_ST_RES[19] := COUNT_ST_RES[19] + speCountUnit_1[18].Value;

  //Lance Carrier
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[19].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[19].Value;
  COUNT_ST_RES[22] := COUNT_ST_RES[22] + speCountUnit_1[19].Value;
  COUNT_ST_RES[18] := COUNT_ST_RES[18] + speCountUnit_1[19].Value;

  //Pikeman
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[20].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[20].Value;
  COUNT_ST_RES[23] := COUNT_ST_RES[23] + speCountUnit_1[20].Value;
  COUNT_ST_RES[19] := COUNT_ST_RES[19] + speCountUnit_1[20].Value;

  //Scout
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[21].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[21].Value;
  COUNT_ST_RES[26] := COUNT_ST_RES[26] + speCountUnit_1[21].Value;
  COUNT_ST_RES[20] := COUNT_ST_RES[20] + speCountUnit_1[21].Value;
  COUNT_ST_RES[16] := COUNT_ST_RES[16] + speCountUnit_1[21].Value;
  COUNT_ST_RES[18] := COUNT_ST_RES[18] + speCountUnit_1[21].Value;

  //Knight
  COUNT_ST_RES[28] := COUNT_ST_RES[28] + speCountUnit_1[22].Value;
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + speCountUnit_1[22].Value;
  COUNT_ST_RES[26] := COUNT_ST_RES[26] + speCountUnit_1[22].Value;
  COUNT_ST_RES[21] := COUNT_ST_RES[21] + speCountUnit_1[22].Value;
  COUNT_ST_RES[17] := COUNT_ST_RES[17] + speCountUnit_1[22].Value;
  COUNT_ST_RES[19] := COUNT_ST_RES[19] + speCountUnit_1[22].Value;

  //Barbarian
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + (speCountUnit_1[23].Value * 6);

  //Rebel
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + (speCountUnit_1[24].Value * 2);

  //Rogue
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + (speCountUnit_1[25].Value * 2);

  //Warrior
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + (speCountUnit_1[26].Value * 6);

  //Vagabond
  COUNT_ST_RES[7] := COUNT_ST_RES[7] + (speCountUnit_1[27].Value * 4);

  lblCountStorehouseResource[7].Caption  := IntToStr(COUNT_ST_RES[7]);
  lblCountStorehouseResource[16].Caption := IntToStr(COUNT_ST_RES[16]);
  lblCountStorehouseResource[17].Caption := IntToStr(COUNT_ST_RES[17]);
  lblCountStorehouseResource[18].Caption := IntToStr(COUNT_ST_RES[18]);
  lblCountStorehouseResource[19].Caption := IntToStr(COUNT_ST_RES[19]);
  lblCountStorehouseResource[20].Caption := IntToStr(COUNT_ST_RES[20]);
  lblCountStorehouseResource[21].Caption := IntToStr(COUNT_ST_RES[21]);
  lblCountStorehouseResource[22].Caption := IntToStr(COUNT_ST_RES[22]);
  lblCountStorehouseResource[23].Caption := IntToStr(COUNT_ST_RES[23]);
  lblCountStorehouseResource[24].Caption := IntToStr(COUNT_ST_RES[24]);
  lblCountStorehouseResource[25].Caption := IntToStr(COUNT_ST_RES[25]);
  lblCountStorehouseResource[26].Caption := IntToStr(COUNT_ST_RES[26]);
  lblCountStorehouseResource[28].Caption := IntToStr(COUNT_ST_RES[28]);
end;

procedure TfrmCalcResourceKMR.FormCreate(Sender: TObject);
var
  RT: TRXType;
  TextVersion: String;
begin
  PathKAM := ExtractFilePath(ParamStr(0)) + '..\..\kam_remake\';

  Caption := 'Calc Resource KMR (' + GAME_REVISION + ')' + ' ' + PROJECT_VERSION + ' ' + GetMyVersion(SHOW_VER_RELEASE, SHOW_VER_BUILD);

  fPalettes := TKMResPalettes.Create;
  fPalettes.LoadPalettes(PathKAM + 'data\gfx\');

  RT := rxGui;

  fSprites := TKMSpritePackEdit.Create(RT, fPalettes);
  fSprites.LoadFromRXXFile(PathKAM + 'data\Sprites\GUI.rxx');

  CreateWindowInfo;

  bmpBase := TBitmap.Create;

  CreateStorehouseResource;

  CreateHouse;

  CreateUnits;

  bmpBase.Free;

  PageControl1Change(nil);

end;


procedure TfrmCalcResourceKMR.PageControl1Change(Sender: TObject);
var I: Integer;
begin
  case PageControl1.TabIndex of
    0:
    begin
      pnlStorehouseResource[0].Enabled            := False;
      pnlStorehouseResource[0].Color              := CLR_DIS_PNL;
      lblTypeStorehouseResource[0].Font.Color     := CLR_DIS_FNT;
      lblCountStorehouseResource[0].Font.Color    := CLR_DIS_FNT;
      pnlStorehouseResource[1].Enabled            := True;
      pnlStorehouseResource[1].Color              := Color;
      lblTypeStorehouseResource[1].Font.Color     := Font.Color;
      lblCountStorehouseResource[1].Font.Color    := Font.Color;
      pnlStorehouseResource[2].Enabled            := True;
      pnlStorehouseResource[2].Color              := Color;
      lblTypeStorehouseResource[2].Font.Color     := Font.Color;
      lblCountStorehouseResource[2].Font.Color    := Font.Color;

      for I := 3 to 28 do
      begin
        pnlStorehouseResource[I].Enabled          := False;
        pnlStorehouseResource[I].Color            := CLR_DIS_PNL;
        lblTypeStorehouseResource[I].Font.Color   := CLR_DIS_FNT;
        lblCountStorehouseResource[I].Font.Color  := CLR_DIS_FNT;
      end;

    end;
    1:
    Begin
      for I := 0 to 15 do
      begin
        pnlStorehouseResource[I].Enabled          := False;
        pnlStorehouseResource[I].Color            := CLR_DIS_PNL;
        lblTypeStorehouseResource[I].Font.Color   := CLR_DIS_FNT;
        lblCountStorehouseResource[I].Font.Color  := CLR_DIS_FNT;
      end;

      for I := 16 to 28 do
      begin
        pnlStorehouseResource[I].Enabled          := True;
        pnlStorehouseResource[I].Color            := Color;
        lblTypeStorehouseResource[I].Font.Color   := Font.Color;
        lblCountStorehouseResource[I].Font.Color  := Font.Color;
      end;

      pnlStorehouseResource[7].Enabled          := True;
      pnlStorehouseResource[7].Color            := Color;
      lblTypeStorehouseResource[7].Font.Color   := Font.Color;
      lblCountStorehouseResource[7].Font.Color  := Font.Color;

      pnlStorehouseResource[27].Enabled           := False;
      pnlStorehouseResource[27].Color             := CLR_DIS_PNL;
      lblTypeStorehouseResource[27].Font.Color    := CLR_DIS_FNT;
      lblCountStorehouseResource[27].Font.Color   := CLR_DIS_FNT;

    End;
  end;

end;

procedure TfrmCalcResourceKMR.scrlbHouseMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  scrlbHouse.VertScrollBar.Position :=
   scrlbHouse.VertScrollBar.Position - WheelDelta;
end;

procedure TfrmCalcResourceKMR.scrlbUnitMouseWheel(Sender: TObject;
  Shift: TShiftState; WheelDelta: Integer; MousePos: TPoint;
  var Handled: Boolean);
begin
  scrlbUnit.VertScrollBar.Position :=
   scrlbUnit.VertScrollBar.Position - WheelDelta;
end;

end.
