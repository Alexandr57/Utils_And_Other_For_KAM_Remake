program KMR_OpCodes;

uses
  Vcl.Forms,
  UnitMain in 'UnitMain.pas' {FormMain},
  Versions in '..\General\Versions.pas',
  CONSTS in '..\General\CONSTS.pas',
  ReadScriptsKMR in '..\General\ReadScriptsKMR.pas',
  AL7_CommonUtils in '..\General\AL7_CommonUtils.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormMain, FormMain);
  Application.Run;
end.
