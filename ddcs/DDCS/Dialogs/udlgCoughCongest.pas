unit udlgCoughCongest;

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
  StdCtrls, ExtCtrls, Buttons, uDialog, uExtndComBroker,
  VA508AccessibilityManager;

type
  TdlgCoughCongest = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leColor: TLabeledEdit;
    Label3: TLabel;
    cbProdCY: TCheckBox;
    cbProdCN: TCheckBox;
    lbBlood: TLabel;
    cbBloodY: TCheckBox;
    cbBloodN: TCheckBox;
    Label5: TLabel;
    cbNasalY: TCheckBox;
    cbNasalN: TCheckBox;
    Label1: TLabel;
    cbSinusY: TCheckBox;
    cbSinusN: TCheckBox;
    Label2: TLabel;
    cbRhinY: TCheckBox;
    cbRhinN: TCheckBox;
    Label6: TLabel;
    cbFeverY: TCheckBox;
    cbFeverN: TCheckBox;
    Label7: TLabel;
    cbSOBY: TCheckBox;
    cbSOBN: TCheckBox;
    amgrMain: TVA508AccessibilityManager;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbProdCYClick(Sender: TObject);
    procedure cbBloodYClick(Sender: TObject);
    procedure cbNasalYClick(Sender: TObject);
  private
  public
  end;

var
  dlgCoughCongest: TdlgCoughCongest;

implementation

{$R *.dfm}

procedure TdlgCoughCongest.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  I : Integer;
begin
  if (leOnset.Text <> '') or (cbProdCY.Checked) or (cbProdCN.Checked) or
     (leColor.Text <> '') or (cbBloodY.Checked) or (cbBloodN.Checked) or
     (cbNasalY.Checked) or (cbNasalN.Checked) or (cbSinusY.Checked) or
     (cbSinusN.Checked) or (cbRhinY.Checked) or (cbRhinN.Checked) or
     (cbFeverY.Checked) or (cbFeverN.Checked) or (cbSOBY.Checked) or
     (cbSOBN.Checked) then
  begin
   TmpStrList.Add('Cough/Congestion:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if cbProdCY.Checked then
   begin
     TmpStrList.Add('  Productive Cough? Yes');
     if leColor.Text  <> '' then TmpStrList.Add('    Color: ' + leColor.Text);
     if cbBloodY.Checked then TmpStrList.Add('    Blood? Yes')
     else if cbBloodN.Checked then TmpStrList.Add('    Blood? No');
   end
   else if cbProdCN.Checked then
   begin
     TmpStrList.Add('  Productive cough? No');
   end;
   if cbNasalY.Checked then TmpStrList.Add('  Post-Nasal Drip? Yes')
   else if cbNasalN.Checked then TmpStrList.Add('  Post-Nasal Drip? No');
   if cbSinusY.Checked then TmpStrList.Add('  Sinus Pain? Yes')
   else if cbSinusN.Checked then TmpStrList.Add('  Sinus Pain? No');
   if cbRhinY.Checked then TmpStrList.Add('  Rhinorrhea? Yes')
   else if cbRhinN.Checked then TmpStrList.Add('  Rhinorrhea? No');
   if cbFeverY.Checked then TmpStrList.Add('  Fever/Chills? Yes')
   else if cbFeverN.Checked then TmpStrList.Add('  Fever/Chills? No');
   if cbSOBY.Checked then TmpStrList.Add('  Shortness of Breath? Yes')
   else if cbSOBN.Checked then TmpStrList.Add('  Shortness of Breath? No');
 end;
end;

procedure TdlgCoughCongest.cbProdCYClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 1 then
  begin
    if ((Sender as TCheckBox).Checked = TRUE) then
    begin {Yes}
      cbProdCY.Checked := TRUE;
      cbProdCN.Checked := FALSE;
      leColor.Visible := TRUE;
      lbBlood.Visible := TRUE;
      cbBloodY.Visible := TRUE;
      cbBloodN.Visible := TRUE;
      leColor.SetFocus;
    end
    else if ((Sender as TCheckBox).Checked = FALSE) then
    begin {Yes - unchecked}
      //cbProdCY.Checked := FALSE;
      leColor.Visible := FALSE;
      lbBlood.Visible := FALSE;
      cbBloodY.Visible := FALSE;
      cbBloodN.Visible := FALSE;
      cbBloodY.Checked := FALSE;
      cbBloodN.Checked := FALSE;
      leColor.Clear;
    end;
  end
  else if ((Sender as TCheckBox).Tag = 2) and ((Sender as TCheckBox).Checked = TRUE) then
    begin
      cbProdCY.Checked := FALSE;
      leColor.Visible := FALSE;
      lbBlood.Visible := FALSE;
      cbBloodY.Visible := FALSE;
      cbBloodN.Visible := FALSE;
      cbBloodY.Checked := FALSE;
      cbBloodN.Checked := FALSE;
      leColor.Clear;
    end;
end;

procedure TdlgCoughCongest.cbBloodYClick(Sender: TObject);
begin
  if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked = TRUE) then
  begin   {cb6-9 - toggle 4 checkboxes}
    if (Sender as TCheckBox).Tag = 1 then
      cbBloodN.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 2 then
      cbBloodY.Checked := FALSE;
  end;
end;

procedure TdlgCoughCongest.cbNasalYClick(Sender: TObject);
begin
  if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked = TRUE) then
  begin   {cb6-9 - toggle 4 checkboxes}
    if (Sender as TCheckBox).Tag = 1 then
      cbNasalN.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 2 then
      cbNasalY.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 3 then
      cbSinusN.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 4 then
      cbSinusY.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 5 then
      cbRhinN.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 6 then
      cbRhinY.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 7 then
      cbFeverN.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 8 then
      cbFeverY.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 9 then
      cbSOBN.Checked := FALSE
    else if (Sender as TCheckBox).Tag = 10 then
      cbSOBY.Checked := FALSE;
  end;    
end;

end.
