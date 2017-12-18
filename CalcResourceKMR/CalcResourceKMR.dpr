program CalcResourceKMR;

uses
  Vcl.Forms,
  CalcResourceKMRUnit in 'CalcResourceKMRUnit.pas' {frmCalcResourceKMR};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmCalcResourceKMR, frmCalcResourceKMR);
  Application.Run;
end.
