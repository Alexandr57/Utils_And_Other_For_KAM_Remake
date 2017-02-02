unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Samples.Spin,
  CKR_Calculation;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    MainMenu: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    Lunguage1: TMenuItem;
    Rus1: TMenuItem;
    ENG1: TMenuItem;
    About1: TMenuItem;
    ScrollBox1: TScrollBox;
    gbMilitia: TGroupBox;
    seMilitia: TSpinEdit;
    gbAxeFighter: TGroupBox;
    seAxeFighter: TSpinEdit;
    gbSwordFighter: TGroupBox;
    seSwordFighter: TSpinEdit;
    gbBowman: TGroupBox;
    seBowman: TSpinEdit;
    gbCrossbowman: TGroupBox;
    seCrossbowman: TSpinEdit;
    gbLanceCarrier: TGroupBox;
    seLanceCarrier: TSpinEdit;
    gbPikeman: TGroupBox;
    sePikeman: TSpinEdit;
    gbScout: TGroupBox;
    seScout: TSpinEdit;
    gbKnight: TGroupBox;
    seKnight: TSpinEdit;
    GroupBox1: TGroupBox;
    pnlWoodenShields: TPanel;
    lblIDWoodenShields: TLabel;
    imgWoodenShields: TImage;
    lblCountWoodenShields: TLabel;
    imgMilitia: TImage;
    imgAxeFighter: TImage;
    imgSwordFighter: TImage;
    imgBowman: TImage;
    imgCrossbowman: TImage;
    imgLanceCarrier: TImage;
    imgPikeman: TImage;
    imgScout: TImage;
    imgKnight: TImage;
    Panel1: TPanel;
    lblIDIronShields: TLabel;
    imgIronShields: TImage;
    lblCountIronShields: TLabel;
    Panel2: TPanel;
    lblIDLeatherArmor: TLabel;
    imgLeatherArmor: TImage;
    lblCountLeatherArmor: TLabel;
    Panel3: TPanel;
    lblIDIronArmor: TLabel;
    imgIronArmor: TImage;
    lblCountIronArmor: TLabel;
    Panel4: TPanel;
    lblIDHandAxes: TLabel;
    imgHandAxes: TImage;
    lblCountHandAxes: TLabel;
    Panel5: TPanel;
    lblIDSwords: TLabel;
    imgSwords: TImage;
    lblCountSwords: TLabel;
    Panel6: TPanel;
    lblIDLances: TLabel;
    imgLances: TImage;
    lblCountLances: TLabel;
    Panel7: TPanel;
    lblIDPikes: TLabel;
    imgPikes: TImage;
    lblCountPikes: TLabel;
    Panel8: TPanel;
    lblIDLongbows: TLabel;
    imgLongbows: TImage;
    lblCountLongbows: TLabel;
    Panel9: TPanel;
    lblIDCrossbows: TLabel;
    imgCrossbows: TImage;
    lblCountCrossbows: TLabel;
    Panel10: TPanel;
    lblIDHorses: TLabel;
    imgHorses: TImage;
    lblCountHorses: TLabel;
    Panel11: TPanel;
    lblIDRecruit: TLabel;
    imgRecruit: TImage;
    lblCountRecruit: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure seChange(Sender: TObject);
  private
    { Private declarations }
    CKR_Calc : TCKR_Calculation;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  CKR_Calc := TCKR_Calculation.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  CKR_Calc.Free;
end;

procedure TForm1.seChange(Sender: TObject);
var SpinEdit : TSpinEdit;
begin
  SpinEdit := TSpinEdit(Sender);
  CKR_Calc.SetCountArmy(TCKR_CTArmy(ord(SpinEdit.Tag)), SpinEdit.Value);
  lblCountWoodenShields.Caption := IntToStr(CKR_Calc.GetCountRessource(trWoodenShields));
  lblCountIronShields.Caption := IntToStr(CKR_Calc.GetCountRessource(trIronShields));
  lblCountLeatherArmor.Caption := IntToStr(CKR_Calc.GetCountRessource(trLeatherArmor));
  lblCountIronArmor.Caption := IntToStr(CKR_Calc.GetCountRessource(trIronArmor));
  lblCountHandAxes.Caption := IntToStr(CKR_Calc.GetCountRessource(trHandAxes));
  lblCountSwords.Caption := IntToStr(CKR_Calc.GetCountRessource(trSwords));
  lblCountLances.Caption := IntToStr(CKR_Calc.GetCountRessource(trLances));
  lblCountPikes.Caption := IntToStr(CKR_Calc.GetCountRessource(trPikes));
  lblCountLongbows.Caption := IntToStr(CKR_Calc.GetCountRessource(trLongbows));
  lblCountCrossbows.Caption := IntToStr(CKR_Calc.GetCountRessource(trCrossbows));
  lblCountHorses.Caption := IntToStr(CKR_Calc.GetCountRessource(trHorses));
  lblCountRecruit.Caption := IntToStr(CKR_Calc.GetCountRessource(Recruit));
end;

end.
