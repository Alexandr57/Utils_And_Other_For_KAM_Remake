program LFtoCRLF;

uses
  Vcl.Forms,
  MainUnit in 'MainUnit.pas' {Form1},
  UnitFormSearch in 'UnitFormSearch.pas' {FormSearch};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TFormSearch, FormSearch);
  Application.Run;
end.
