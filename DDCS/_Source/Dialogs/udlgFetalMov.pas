unit udlgFetalMov;

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

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, uDialog, uExtndComBroker;

type
  TdlgFetalMov = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leCharFetal: TLabeledEdit;
    leLastMov: TLabeledEdit;
    leFreq: TLabeledEdit;
    leOnset1: TLabeledEdit;
    Label3: TLabel;
    cbFetMovY: TCheckBox;
    cbFetMovN: TCheckBox;
    Label1: TLabel;
    cbContY: TCheckBox;
    cbContN: TCheckBox;
    Label2: TLabel;
    cbVagBleY: TCheckBox;
    cbVagBleN: TCheckBox;
    Label4: TLabel;
    cbLeakY: TCheckBox;
    cbLeakN: TCheckBox;
    leDur: TLabeledEdit;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbFetMovYClick(Sender: TObject);
  private                                        { Private declarations }
  public                                         { Public declarations }
  end;

var
  dlgFetalMov: TdlgFetalMov;

implementation

{$R *.dfm}

procedure TdlgFetalMov.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
begin
  if (leLastMov.Text <> '') or (leCharFetal.Text <> '') or (leOnset.Text <> '') or
      (cbFetMovY.Checked) or (cbFetMovN.Checked) or
      (cbVagBleY.Checked) or (cbVagBleN.Checked) or
      (cbLeakY.Checked) or (cbLeakN.Checked) or
      (cbContY.Checked) or (cbContN.Checked) then
  begin
   TmpStrList.Add('Change in fetal movement:');
   if cbFetMovY.Checked then TmpStrList.Add('  Fetal movement present? Yes');
   if cbFetMovN.Checked then TmpStrList.Add('  Fetal movement present? No');
   if leLastMov.Text  <> '' then TmpStrList.Add('  Date/time of last perceived movement: ' + leLastMov.Text);
   if leCharFetal.Text  <> '' then TmpStrList.Add('  Character of fetal movements: ' + leCharFetal.Text);
   if cbVagBleY.Checked then TmpStrList.Add('  Vaginal bleeding? Yes');
   if cbVagBleN.Checked then TmpStrList.Add('  Vaginal bleeding? No');
   if cbLeakY.Checked then TmpStrList.Add('  Leakage of fluid? Yes');
   if cbLeakN.Checked then TmpStrList.Add('  Leakage of fluid? No');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if cbContY.Checked then
   begin
     TmpStrList.Add('  Contractions? Yes');
     if leFreq.Text  <> '' then TmpStrList.Add('    Frequency: ' + leFreq.Text);
     if leDur.Text  <> '' then TmpStrList.Add('    Duration: ' + leDur.Text);
     if leOnset1.Text  <> '' then TmpStrList.Add('    Onset: ' + leOnset1.Text);
   end
   else if cbContN.Checked then
    TmpStrList.Add('  Contractions? No');
  end;
end;

procedure TdlgFetalMov.cbFetMovYClick(Sender: TObject);
begin
  if ((Sender as TCheckBox).Tag = 1) and ((Sender as TCheckBox).Checked = TRUE) then
    cbFetMovN.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 2) and ((Sender as TCheckBox).Checked = TRUE) then
    cbFetMovY.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 3) and ((Sender as TCheckBox).Checked = TRUE) then
    cbVagBleN.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 4) and ((Sender as TCheckBox).Checked = TRUE) then
    cbVagBleY.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 5) and ((Sender as TCheckBox).Checked = TRUE) then
    cbLeakN.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 6) and ((Sender as TCheckBox).Checked = TRUE) then
    cbLeakY.Checked := FALSE
  else if (Sender as TCheckBox).Tag = 7 then
  begin
    if (Sender as TCheckBox).Checked = TRUE then
    begin
      cbContN.Checked := FALSE;
      cbContY.Checked := TRUE;
      leFreq.Visible := TRUE;
      leDur.Visible := TRUE;
      leOnset1.Visible := TRUE;
      leFreq.SetFocus;
    end
    else
    begin
      cbContY.Checked := FALSE;
      leFreq.Visible := FALSE;
      leDur.Visible := FALSE;
      leOnset1.Visible := FALSE;
      leFreq.Clear;
      leDur.Clear;
      leOnset1.Clear;
    end;
  end
  else if (Sender as TCheckBox).Tag = 8 then
  begin
    cbContY.Checked := FALSE;
    leFreq.Visible := FALSE;
    leDur.Visible := FALSE;
    leOnset1.Visible := FALSE;
    leFreq.Clear;
    leDur.Clear;
    leOnset1.Clear;
  end;
end;

end.
