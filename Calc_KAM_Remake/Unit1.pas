unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Samples.Spin;

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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
implementation

{$R *.dfm}

end.
