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

   v2.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ORDtTm, ORCtrls, uDialog, uCommon, uExtndComBroker;

type
  TdlgFetalMov = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TCaptionEdit;
    Label3: TStaticText;
    cbFetMovY: TCheckBox;
    cbFetMovN: TCheckBox;
    lbContractions: TStaticText;
    cbContY: TCheckBox;
    cbContN: TCheckBox;
    Label2: TStaticText;
    cbVagBleY: TCheckBox;
    cbVagBleN: TCheckBox;
    Label4: TStaticText;
    cbLeakY: TCheckBox;
    cbLeakN: TCheckBox;
    StaticText1: TStaticText;
    leLastMov: TORDateBox;
    leCharFetal: TCaptionEdit;
    StaticText2: TStaticText;
    StaticText3: TStaticText;
    leFreq: TCaptionEdit;
    leDur: TCaptionEdit;
    leOnset1: TCaptionEdit;
    lbFreq: TStaticText;
    lbDur: TStaticText;
    lbOnset1: TStaticText;
    procedure bbtnOKClick(Sender: TObject);
    procedure checkboxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgFetalMov: TdlgFetalMov;

implementation

{$R *.dfm}

var
  hdiff: Integer;

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
   if leLastMov.Text  <> '' then TmpStrList.Add('  Date and time of last perceived movement: ' + leLastMov.Text);
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

procedure TdlgFetalMov.checkboxClick(Sender: TObject);
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
    if (Sender as TCheckBox).Checked then
    begin
      cbContN.OnClick := nil;
      cbContN.Checked := False;
      cbContN.OnClick := checkboxClick;

      Height := Height + hdiff;

      lbFreq.Visible := True;
      leFreq.Visible := True;
      lbDur.Visible := True;
      leDur.Visible := True;
      lbOnset1.Visible := True;
      leOnset1.Visible := True;

      leFreq.SetFocus;
    end else
    begin
      cbContY.OnClick := nil;
      cbContY.Checked := False;
      cbContY.OnClick := checkboxClick;

      if lbFreq.Visible then
      begin
        lbFreq.Visible := False;
        leFreq.Clear;
        leFreq.Visible := False;
        lbDur.Visible := False;
        leDur.Clear;
        leDur.Visible := False;
        lbOnset1.Visible := False;
        leOnset1.Clear;
        leOnset1.Visible := False;

        Height := Height - hdiff;
      end;
    end;
  end
  else if (Sender as TCheckBox).Tag = 8 then
  begin
    cbContY.OnClick := nil;
    cbContY.Checked := False;
    cbContY.OnClick := checkboxClick;

    if lbFreq.Visible then
    begin
      lbFreq.Visible := False;
      leFreq.Clear;
      leFreq.Visible := False;
      lbDur.Visible := False;
      leDur.Clear;
      leDur.Visible := False;
      lbOnset1.Visible := False;
      leOnset1.Clear;
      leOnset1.Visible := False;

      Height := Height - hdiff;
    end;
  end;
end;

procedure TdlgFetalMov.FormCreate(Sender: TObject);
begin
  hdiff := lbOnset1.Top - lbContractions.Top;
  Height := Height - hdiff;
end;

end.
