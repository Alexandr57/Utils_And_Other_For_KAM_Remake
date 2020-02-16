unit UnitMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.CheckLst, IniFiles,
  Versions, ReadScriptsKMR, CONSTS;


type
  TFormMain = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    BitBtn2: TBitBtn;
    Memo1: TMemo;
    PageControlMain: TPageControl;
    TabSheetMainOpCodes: TTabSheet;
    TabSheetMainSettings: TTabSheet;
    Splitter1: TSplitter;
    PageControlOpCodes: TPageControl;
    TabSheetConsts: TTabSheet;
    TabSheetEvents: TTabSheet;
    TabSheetActions: TTabSheet;
    TabSheetStates: TTabSheet;
    TabSheetUtils: TTabSheet;
    CheckListConsts: TCheckListBox;
    CheckListEvents: TCheckListBox;
    CheckListActions: TCheckListBox;
    CheckListStates: TCheckListBox;
    CheckListUtils: TCheckListBox;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    fScriptsKMR: TScriptsKMR;
  public
    { Public declarations }
  end;
const
  NEW_LINE_3 = #13#10 + #13#10 + #13#10;

var
  FormMain: TFormMain;
  fAddOpcodes: AnsiString = '%S';
implementation

{$R *.dfm}


procedure TFormMain.FormCreate(Sender: TObject);
begin
  fScriptsKMR := TScriptsKMR.Create('KMRScripts.Json');
end;

end.
