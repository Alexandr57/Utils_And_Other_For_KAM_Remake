unit ScanFilesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TfrmScanFiles = class(TForm)
    Label1: TLabel;
  private
    { Private declarations }
  public
    MemoScanFiles: TMemo;
  end;

var
  frmScanFiles: TfrmScanFiles;

implementation

{$R *.dfm}

end.
