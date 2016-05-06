unit udlgHeadache;

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
  TdlgHeadache = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leChar: TLabeledEdit;
    leLocat: TLabeledEdit;
    Label1: TLabel;
    leDur: TLabeledEdit;
    leAssoc: TLabeledEdit;
    Label2: TLabel;
    leWhat: TLabeledEdit;
    Label3: TLabel;
    cbTreatYes: TCheckBox;
    cbTreatNo: TCheckBox;
    amgrMain: TVA508AccessibilityManager;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbTreatYesClick(Sender: TObject);
  private
  public
  end;

var
  dlgHeadache: TdlgHeadache;

implementation

{$R *.dfm}

procedure TdlgHeadache.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
var
  I : Integer;
begin
  if (leOnset.Text <> '') or (leChar.Text <> '') or (leLocat.Text <> '') or
    (leDur.Text <> '') or (leAssoc.Text <> '') or (cbTreatYes.Checked) or
    (cbTreatNo.Checked) then
  begin
   TmpStrList.Add('Headache:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Time of Onset: ' + leOnset.Text);
   if leChar.Text  <> '' then TmpStrList.Add('  Character: ' + leChar.Text);
   if leLocat.Text  <> '' then TmpStrList.Add('  Localization: ' + leLocat.Text);
   if leDur.Text  <> '' then TmpStrList.Add('  Duration: ' + leDur.Text);
   if leAssoc.Text  <> '' then TmpStrList.Add('  Associated symptoms: ' + leAssoc.Text);
   if cbTreatYes.Checked  then
   begin
     TmpStrList.Add('  Treatments? Yes');
     if leWhat.Text  <> '' then TmpStrList.Add('    What used? Effectiveness? ' + leWhat.Text);
   end
   else if cbTreatNo.Checked  then
     TmpStrList.Add('  Treatments? No');
 end;
end;

procedure TdlgHeadache.cbTreatYesClick(Sender: TObject);
begin
  if ((Sender as TCheckBox).Tag = 1) then
  begin {Yes}
    if ((Sender as TCheckBox).Checked = TRUE) then
    begin
      cbTreatNo.Checked := FALSE;
      cbTreatYes.Checked := TRUE;
      leWhat.Visible := TRUE;
      leWhat.SetFocus;
    end
    else
    begin
      cbTreatYes.Checked := FALSE;
      leWhat.Visible := FALSE;
      leWhat.Clear;
    end;
  end
  else if ((Sender as TCheckBox).Tag = 2) then
  begin  {No}
    cbTreatYes.Checked := FALSE;
    leWhat.Visible := FALSE;
    leWhat.Clear;
  end;
end;

end.
