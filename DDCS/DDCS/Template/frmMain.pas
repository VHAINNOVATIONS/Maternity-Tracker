unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.CheckLst,
  Vcl.ExtCtrls, Vcl.ComCtrls,
  uExtndComBroker, oCNTBase, frmVitals,
  fBase508Form, VA508AccessibilityManager;

type
  TForm1 = class(TfrmBase508Form)
    ofrm1: ToForm;
    oPage1: ToPage;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  VA508AccessibilityRouter;

procedure TForm1.FormCreate(Sender: TObject);
begin
  inherited;
//
end;

end.
