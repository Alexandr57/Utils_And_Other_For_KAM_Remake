unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Samples.Spin, Clipbrd,
  About,
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
    pnlIronShields: TPanel;
    lblIDIronShields: TLabel;
    imgIronShields: TImage;
    lblCountIronShields: TLabel;
    pnlLeatherArmor: TPanel;
    lblIDLeatherArmor: TLabel;
    imgLeatherArmor: TImage;
    lblCountLeatherArmor: TLabel;
    pnlIronArmor: TPanel;
    lblIDIronArmor: TLabel;
    imgIronArmor: TImage;
    lblCountIronArmor: TLabel;
    pnlHandAxes: TPanel;
    lblIDHandAxes: TLabel;
    imgHandAxes: TImage;
    lblCountHandAxes: TLabel;
    pnlSwords: TPanel;
    lblIDSwords: TLabel;
    imgSwords: TImage;
    lblCountSwords: TLabel;
    pnlLances: TPanel;
    lblIDLances: TLabel;
    imgLances: TImage;
    lblCountLances: TLabel;
    pnlPikes: TPanel;
    lblIDPikes: TLabel;
    imgPikes: TImage;
    lblCountPikes: TLabel;
    pnlLongbows: TPanel;
    lblIDLongbows: TLabel;
    imgLongbows: TImage;
    lblCountLongbows: TLabel;
    pnlCrossbows: TPanel;
    lblIDCrossbows: TLabel;
    imgCrossbows: TImage;
    lblCountCrossbows: TLabel;
    pnlHorses: TPanel;
    lblIDHorses: TLabel;
    imgHorses: TImage;
    lblCountHorses: TLabel;
    pnlRecruit: TPanel;
    lblIDRecruit: TLabel;
    imgRecruit: TImage;
    lblCountRecruit: TLabel;
    tmr: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure seResChange(Sender: TObject);
    procedure ClickGetTypeRes(Sender: TObject);
    procedure ClickGetCountRes(Sender: TObject);
    procedure tmrTimer(Sender: TObject);
    procedure Exit1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
  private
    { Private declarations }
    CKR_Calc : TCKR_Calculation;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  lblTmr : TLabel;
  strlblTmrCopied : String;
implementation

{$R *.dfm}

procedure TForm1.About1Click(Sender: TObject);
begin
  Form2.ShowModal;
end;

procedure TForm1.ClickGetCountRes(Sender: TObject);
begin
  lblTmr := TLabel(Sender);
  Clipboard.AsText := lblTmr.Caption;
  strlblTmrCopied := lblTmr.Caption;
  lblTmr.Caption := 'Copied!';
  tmr.Enabled := true;
end;

procedure TForm1.ClickGetTypeRes(Sender: TObject);
begin
  lblTmr := TLabel(Sender);
  Clipboard.AsText := IntToStr(lblTmr.Tag);
  strlblTmrCopied := lblTmr.Caption;
  lblTmr.Caption := 'Copied!';
  tmr.Enabled := true;
end;

procedure TForm1.Exit1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  CKR_Calc := TCKR_Calculation.Create;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  CKR_Calc.Free;
end;

procedure TForm1.seResChange(Sender: TObject);
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

procedure TForm1.tmrTimer(Sender: TObject);
begin
  lblTmr.Caption := strlblTmrCopied;
  tmr.Enabled := false;
end;

end.
