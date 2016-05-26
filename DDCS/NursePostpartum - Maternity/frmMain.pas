unit frmMain;

{
   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.

     Developer: Theodore Fontana
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464
}

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
    ledMaternalComplicationsOther: TEdit;
    ledOngoingChronicOther: TEdit;
    ckAsthma: TCheckBox;
    ledContraceptiveMethodOther: TEdit;
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
      lbMaternalOther.Visible := False;
      ledMaternalComplicationsOther.Visible := False;
    end else
    begin
      ckPostpartumHemorrhage.Visible := True;
      ckPreEclampsia.Visible := True;
      ckInfection.Visible := True;
      lbMaternalOther.Visible := True;
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
