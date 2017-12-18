unit CalcResourceKMRUnit;
{$I ..\..\kam_remake\KaM_Remake.inc}
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.ExtCtrls,
  KM_Defaults, KM_Pics, KM_ResPalettes, KM_ResSpritesEdit;

type
  TfrmCalcResourceKMR = class(TForm)
    PageControl1: TPageControl;
    tbsHouse: TTabSheet;
    grbStorehouse: TGroupBox;
    procedure FormCreate(Sender: TObject);
  private
    fPalettes: TKMResPalettes;
    fSprites: TKMSpritePackEdit;

    pnlStorehouseResource: Array of TPanel;
    lblTypeStorehouseResource, lblCountStorehouseResource: Array of Tlabel;
    imgStorehouseResource: Array of TImage;

    procedure LoadImgStorehouseResource(aID: Integer);
    procedure CreateStorehouseResource;
  public
    { Public declarations }
  end;

const
  COUNT_STOREHOUSE_RESOURCE = 28;
  ID_STOREHOUSE_RESOURCE = 351;

var
  frmCalcResourceKMR: TfrmCalcResourceKMR;
  PathKAM: String;

implementation

{$R *.dfm}

procedure TfrmCalcResourceKMR.LoadImgStorehouseResource(aID: Integer);
var
  bmpBase: TBitmap;
begin



end;

procedure TfrmCalcResourceKMR.CreateStorehouseResource;
var
  I: Integer;
  bmpBase: TBitmap;
begin
  SetLength(pnlStorehouseResource     , COUNT_STOREHOUSE_RESOURCE);
  SetLength(lblTypeStorehouseResource , COUNT_STOREHOUSE_RESOURCE);
  SetLength(lblCountStorehouseResource, COUNT_STOREHOUSE_RESOURCE);
  SetLength(imgStorehouseResource     , COUNT_STOREHOUSE_RESOURCE);

  bmpBase := TBitmap.Create;

  for I := 0 to COUNT_STOREHOUSE_RESOURCE - 1 do
  begin
    pnlStorehouseResource[I]                := TPanel.Create(grbStorehouse);
    pnlStorehouseResource[I].Parent         := grbStorehouse;
    pnlStorehouseResource[I].Width          := 64;
    pnlStorehouseResource[I].Height         := 64;
    pnlStorehouseResource[I].Left           := (I mod 5 * pnlStorehouseResource[I].Width) + 8 + ((I mod 5) * 8);
    pnlStorehouseResource[I].Top            := ((I div 5) * pnlStorehouseResource[I].Height) + 28 + ((I div 5) * 8);

    lblTypeStorehouseResource[I]            := TLabel.Create(pnlStorehouseResource[I]);
    lblTypeStorehouseResource[I].Parent     := pnlStorehouseResource[I];
    lblTypeStorehouseResource[I].Align      := alTop;
    lblTypeStorehouseResource[I].Alignment  := taCenter;
    lblTypeStorehouseResource[I].Layout     := tlCenter;
    lblTypeStorehouseResource[I].Caption    := 'Type: ' + IntToStr(I);

    lblCountStorehouseResource[I]           := TLabel.Create(pnlStorehouseResource[I]);
    lblCountStorehouseResource[I].Parent    := pnlStorehouseResource[I];
    lblCountStorehouseResource[I].Align     := alBottom;
    lblCountStorehouseResource[I].Alignment := taCenter;
    lblCountStorehouseResource[I].Layout    := tlCenter;
    lblCountStorehouseResource[I].Caption   := '0';

    imgStorehouseResource[I]                := TImage.Create(pnlStorehouseResource[I]);
    imgStorehouseResource[I].Parent         := pnlStorehouseResource[I];
    imgStorehouseResource[I].Align          := alClient;
    imgStorehouseResource[I].Transparent    := True;
    imgStorehouseResource[I].Center         := True;

    imgStorehouseResource[I].Picture.Bitmap.Canvas.Brush.Color := 0;
    imgStorehouseResource[I].Picture.Bitmap.Canvas.FillRect(imgStorehouseResource[I].Picture.Bitmap.Canvas.ClipRect);
    fSprites.GetImageToBitmap(ID_STOREHOUSE_RESOURCE + I, bmpBase, nil);
    imgStorehouseResource[I].Picture.Assign(bmpBase);
  end;

  bmpBase.Free;

end;

procedure TfrmCalcResourceKMR.FormCreate(Sender: TObject);
var
  RT: TRXType;
begin
  PathKAM := ExtractFilePath(ParamStr(0)) + '..\..\kam_remake\';

  Caption := 'Calc Resource KMR (' + GAME_REVISION + ')';

  fPalettes := TKMResPalettes.Create;
  fPalettes.LoadPalettes(PathKAM + 'data\gfx\');

  RT := rxGui;

  fSprites := TKMSpritePackEdit.Create(RT, fPalettes);
  fSprites.LoadFromRXXFile(PathKAM + 'data\Sprites\GUI.rxx');

  CreateStorehouseResource;
end;

end.
