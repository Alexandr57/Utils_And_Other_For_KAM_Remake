unit About;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    pnlLicense: TPanel;
    Label3: TLabel;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Label3.Caption := 'This program is free and is designed for scripters KAM Remake.'#13#10'Distribution of the program is free for all scripters KAM Remake.';
  Label3.Left := (pnlLicense.Width div 2) - (Label3.Width div 2);
  Label3.Top := (pnlLicense.Height div 2) - (Label3.Height div 2) - (Button1.Height div 2);
end;

end.
