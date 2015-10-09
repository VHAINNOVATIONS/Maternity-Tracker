unit fFamilyAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, udlgFamily;

type
  TfrmFamilyAdd = class(TForm)
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    procedure bbtnOKClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmFamilyAdd: TfrmFamilyAdd;

implementation

{$R *.dfm}

procedure TfrmFamilyAdd.bbtnOKClick(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to TdlgFamily(Owner).lvPersonList.Items.Count - 1 do
    if TdlgFamily(Owner).lvPersonList.Items.Item[I].SubItems[0] = LabeledEdit1.Text then
    begin
      ShowMessage('Associated person already exists.');
      ModalResult := mrCancel;
    end;
end;

end.
