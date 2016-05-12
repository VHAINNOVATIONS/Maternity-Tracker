unit udlgNausea;

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

   v2.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ORCtrls, uDialog, uCommon, uExtndComBroker;

type
  TdlgNausea = class(TDDCSDialog)
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TCaptionEdit;
    leLocal: TCaptionEdit;
    leDur: TCaptionEdit;
    leDur1: TCaptionEdit;
    Label3: TStaticText;
    cbSolidY: TCheckBox;
    cbSolidN: TCheckBox;
    Label4: TStaticText;
    cbLiquidY: TCheckBox;
    cbLiquidN: TCheckBox;
    Label5: TStaticText;
    cbFeverY: TCheckBox;
    cbFeverN: TCheckBox;
    Label6: TStaticText;
    cbAbdomY: TCheckBox;
    cbAbdomN: TCheckBox;
    Label1: TStaticText;
    cbContY: TCheckBox;
    cbContN: TCheckBox;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    lbLocal: TStaticText;
    lbDur1: TStaticText;
    pnlfooter: TPanel;
    procedure bbtnOKClick(Sender: TObject);
    procedure checkboxClick(Sender: TObject);
  private
  public
  end;

var
  dlgNausea: TdlgNausea;

implementation

{$R *.dfm}

procedure TdlgNausea.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
begin
  if (leOnset.Text <> '') or (cbSolidY.Checked) or (cbSolidN.Checked) or
     (cbLiquidY.Checked) or (cbLiquidN.Checked) or (leDur.Text <> '') or
     (cbFeverY.Checked) or (cbFeverN.Checked) or
     (cbAbdomY.Checked) or (cbAbdomN.Checked) or
     (cbContY.Checked) or (cbContN.Checked) then
  begin
   TmpStrList.Add('Nausea, Vomiting, and Diarrhea:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if cbSolidY.Checked then TmpStrList.Add('  Can tolerate solids? Yes')
   else if cbSolidN.Checked then TmpStrList.Add('  Can tolerate solids? No');
   if cbLiquidY.Checked then TmpStrList.Add('  Can tolerate liquids? Yes')
   else if cbLiquidN.Checked then TmpStrList.Add('  Can tolerate liquids? No');
   if leDur.Text  <> '' then TmpStrList.Add('  Duration: ' + leDur.Text);
   if cbFeverY.Checked then TmpStrList.Add('  Fever and or Chills? Yes')
   else if cbFeverN.Checked then TmpStrList.Add('  Fever and or Chills? No');
   if cbContY.Checked then TmpStrList.Add('  Contractions? Yes')
   else if cbContN.Checked then TmpStrList.Add('  Contractions? No');
   if cbAbdomY.Checked then
   begin
     TmpStrList.Add('  Abdominal pain? Yes');
     if leLocal.Text  <> '' then TmpStrList.Add('    Localization: ' + leLocal.Text);
     if leDur1.Text  <> '' then TmpStrList.Add('    Duration: ' + leDur1.Text);
     leLocal.SetFocus;
   end
   else if cbAbdomN.Checked then
   begin
     TmpStrList.Add('  Abdominal pain? No');
     leLocal.Clear;
     leDur1.Clear;
   end;
 end;
end;

procedure TdlgNausea.checkboxClick(Sender: TObject);
begin
  if ((Sender as TCheckBox).Tag = 1) and ((Sender as TCheckBox).Checked = TRUE) then
    cbSolidN.Checked := FALSE
  else  if ((Sender as TCheckBox).Tag = 2) and ((Sender as TCheckBox).Checked = TRUE) then
    cbSolidY.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 3) and ((Sender as TCheckBox).Checked = TRUE) then
    cbLiquidN.Checked := FALSE
  else  if ((Sender as TCheckBox).Tag = 4) and ((Sender as TCheckBox).Checked = TRUE) then
    cbLiquidY.Checked := FALSE
  else if ((Sender as TCheckBox).Tag = 5) and ((Sender as TCheckBox).Checked = TRUE) then
    cbFeverN.Checked := FALSE
  else  if ((Sender as TCheckBox).Tag = 6) and ((Sender as TCheckBox).Checked = TRUE) then
    cbFeverY.Checked := FALSE
  else if (Sender as TCheckBox).Tag = 7 then
  begin {Yes}
    if (Sender as TCheckBox).Checked then
    begin
      cbAbdomN.OnClick := nil;
      cbAbdomN.Checked := False;
      cbAbdomN.OnClick := checkboxClick;

      lbLocal.Visible := True;
      leLocal.Visible := True;
      lbDur1.Visible := True;
      leDur1.Visible := True;
      leLocal.SetFocus;
    end else
    begin
      leLocal.Clear;
      lbLocal.Visible := False;
      leLocal.Visible := False;
      leDur1.Clear;
      lbDur1.Visible := False;
      leDur1.Visible := False;
    end;
  end else if (Sender as TCheckBox).Tag = 8 then
  begin {No}
    cbAbdomY.OnClick := nil;
    cbAbdomY.Checked := False;
    cbAbdomY.OnClick := checkboxClick;

    leLocal.Clear;
    lbLocal.Visible := False;
    leLocal.Visible := False;
    leDur1.Clear;
    lbDur1.Visible := False;
    leDur1.Visible := False;
  end
  else if ((Sender as TCheckBox).Tag = 9) and ((Sender as TCheckBox).Checked = TRUE) then
    cbContN.Checked := FALSE
  else  if ((Sender as TCheckBox).Tag = 10) and ((Sender as TCheckBox).Checked = TRUE) then
    cbContY.Checked := FALSE;
end;

end.
