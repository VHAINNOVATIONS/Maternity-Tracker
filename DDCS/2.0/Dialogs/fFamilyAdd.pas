unit fFamilyAdd;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.ExtCtrls, udlgFamily, fBase508Form, VA508AccessibilityManager;

type
  TfrmFamilyAdd = class(TfrmBase508Form)
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    amgrMain: TVA508AccessibilityManager;
    procedure bbtnOKClick(Sender: TObject);
  private
  public
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
