program CalcResourceKMR;

uses
  Vcl.Forms,
  CalcResourceKMRUnit in 'CalcResourceKMRUnit.pas' {frmCalcResourceKMR},
  Versions in '..\General\Versions.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCalcResourceKMR, frmCalcResourceKMR);
  Application.Run;
end.
