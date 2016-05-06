unit frmMain;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.CheckLst, Vcl.ExtCtrls, Vcl.ComCtrls, ORCtrls, uBase,
  uExtndComBroker;

type
  TForm1 = class(TForm)
    DDCSForm1: TDDCSForm;
    TabSheet1: TTabSheet;
    lbFeedingMethod: TStaticText;
    lbOngoingChronic: TStaticText;
    lbMaternalComplications: TStaticText;
    lbContraceptiveMethod: TStaticText;
    lbComments: TStaticText;
    ckBreastMilk: TCheckBox;
    cbContraceptiveMethod: TCaptionComboBox;
    ckPreEclampsia: TCheckBox;
    ckInfection: TCheckBox;
    ckNone: TCheckBox;
    ledMaternalComplicationsOther: TCaptionEdit;
    ledOngoingChronicOther: TCaptionEdit;
    ckAsthma: TCheckBox;
    ledContraceptiveMethodOther: TCaptionEdit;
    ckBottle: TCheckBox;
    ckFormula: TCheckBox;
    ckDiabetes: TCheckBox;
    ckHypertension: TCheckBox;
    ckPostpartumHemorrhage: TCheckBox;
    meComments: TCaptionMemo;
    lbOngoingOther: TStaticText;
    lbMaternalOther: TStaticText;
    lbContraceptiveOther: TStaticText;
    procedure MaternalComplicationsUpdate(Sender: TObject);
  private
    FCheck: Boolean;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.MaternalComplicationsUpdate(Sender: TObject);
begin
  if FCheck then
    Exit;

  FCheck := True;
  try
    if ckNone.Checked then
    begin
      ckPostpartumHemorrhage.Visible := False;
      ckPreEclampsia.Visible := False;
      ckInfection.Visible := False;
      ledMaternalComplicationsOther.Visible := False;
    end else
    begin
      ckPostpartumHemorrhage.Visible := True;
      ckPreEclampsia.Visible := True;
      ckInfection.Visible := True;
      ledMaternalComplicationsOther.Visible := True;

      if ckPostpartumHemorrhage.Checked or ckInfection.Checked or
         ckPreEclampsia.Checked or (Trim(ledMaternalComplicationsOther.Text) <> '') then
        ckNone.Visible := False
      else
        ckNone.Visible := True;
    end;
  finally
    FCheck := False;
  end;
end;

end.
