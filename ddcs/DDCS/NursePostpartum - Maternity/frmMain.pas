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
    LB_FEEDING_METHOD: TLabel;
    LB_ONGOING_CHRONIC_MEDICAL_CONDITIONS: TLabel;
    LB_MATERNAL_COMPLICATIONS: TLabel;
    LB_CONTRACEPTIVE_METHOD: TLabel;
    LB_COMMENTS: TLabel;
    CK_BREAST_MILK: TCheckBox;
    CB_CONTRACEPTIVE_METHOD: TComboBox;
    CK_PRE_ECLAMPSIA: TCheckBox;
    CK_INFECTION: TCheckBox;
    CK_NONE: TCheckBox;
    ED_MATERNAL_OTHER: TLabeledEdit;
    ED_ONGOING_OTHER: TLabeledEdit;
    CK_ASTHMA: TCheckBox;
    ED_CONTRACEPTIVE_OTHER: TLabeledEdit;
    CK_BOTTLE: TCheckBox;
    CK_FORMULA: TCheckBox;
    CK_DIABETES: TCheckBox;
    CK_HYPERTENSION: TCheckBox;
    CK_POSTPARTUM_HEMORRHAGE: TCheckBox;
    MO_NARRATIVE: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure CK_POSTPARTUM_HEMORRHAGEClick(Sender: TObject);
    procedure CK_NONEClick(Sender: TObject);
  private
    fRecursiveChecking: boolean;
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
  fRecursiveChecking := False;
end;

procedure TForm1.CK_POSTPARTUM_HEMORRHAGEClick(Sender: TObject);
begin
  if fRecursiveChecking then
    Exit;

  fRecursiveChecking := True;
  if CK_POSTPARTUM_HEMORRHAGE.Checked or CK_INFECTION.Checked or
    CK_HYPERTENSION.Checked or (Trim(ED_MATERNAL_OTHER.text) <> '') then
  begin
    CK_NONE.Checked := False;
    CK_NONE.Visible := False;
  end else
    CK_NONE.Visible := True;

  fRecursiveChecking := False;
end;

procedure TForm1.CK_NONEClick(Sender: TObject);
begin
  if fRecursiveChecking then
    Exit;

  fRecursiveChecking := True;
  if CK_NONE.Checked then
  begin
    CK_POSTPARTUM_HEMORRHAGE.Checked := False;
    CK_PRE_ECLAMPSIA.Checked := False;
    CK_INFECTION.Checked := False;
    ED_MATERNAL_OTHER.Text := '';
  end;

  CK_POSTPARTUM_HEMORRHAGE.Visible := not CK_NONE.Checked;
  CK_PRE_ECLAMPSIA.Visible := not CK_NONE.Checked;
  CK_INFECTION.Visible := not CK_NONE.Checked;
  ED_MATERNAL_OTHER.Visible := not CK_NONE.Checked;
  fRecursiveChecking := False;
end;

end.
