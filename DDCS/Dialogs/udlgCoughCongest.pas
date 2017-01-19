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
   VA Contract: TAC-13-06464

   v2.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, ORCtrls, uDialog, uCommon,
  DDCSUtils, DDCSComBroker;

type
  TdlgCoughCongest = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leColor: TEdit;
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
    lbColor: TLabel;
    lbonset: TLabel;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbProdCYClick(Sender: TObject);
    procedure cbBloodYClick(Sender: TObject);
    procedure cbNasalYClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgCoughCongest: TdlgCoughCongest;

implementation

{$R *.dfm}

procedure TdlgCoughCongest.FormCreate(Sender: TObject);
begin
  SayOnFocus(cbProdCY, 'Productive Cough?');
  SayOnFocus(cbProdCN, 'Productive Cough?');
  SayOnFocus(cbBloodY, 'Blood?');
  SayOnFocus(cbBloodN, 'Blood?');
  SayOnFocus(cbNasalY, 'Post Nasal Drip?');
  SayOnFocus(cbNasalN, 'Post Nasal Drip?');
  SayOnFocus(cbSinusY, 'Sinus Pain?');
  SayOnFocus(cbSinusN, 'Sinus Pain?');
  SayOnFocus( cbRhinY, 'Rhinorrhea?');
  SayOnFocus( cbRhinN, 'Rhinorrhea?');
  SayOnFocus(cbFeverY, 'Fever and or chills?');
  SayOnFocus(cbFeverN, 'Fever and or chills?');
  SayOnFocus(  cbSOBY, 'Shortness of Breath?');
  SayOnFocus(  cbSOBN, 'Shortness of Breath?');
end;

procedure TdlgCoughCongest.bbtnOKClick(Sender: TObject);
begin
 if leOnset.Text  <> '' then
   TmpStrList.Add('  Onset: ' + leOnset.Text);
 if cbProdCY.Checked then
 begin
   TmpStrList.Add('  Productive Cough? Yes');
   if leColor.Text  <> '' then
     TmpStrList.Add('    Color: ' + leColor.Text);
   if cbBloodY.Checked then
     TmpStrList.Add('    Blood? Yes')
   else if cbBloodN.Checked then
     TmpStrList.Add('    Blood? No');
 end
 else if cbProdCN.Checked then
   TmpStrList.Add('  Productive cough? No');

 if cbNasalY.Checked then
   TmpStrList.Add('  Post-Nasal Drip? Yes')
 else if cbNasalN.Checked then
   TmpStrList.Add('  Post-Nasal Drip? No');
 if cbSinusY.Checked then
   TmpStrList.Add('  Sinus Pain? Yes')
 else if cbSinusN.Checked then
   TmpStrList.Add('  Sinus Pain? No');
 if cbRhinY.Checked then
   TmpStrList.Add('  Rhinorrhea? Yes')
 else if cbRhinN.Checked then
   TmpStrList.Add('  Rhinorrhea? No');
 if cbFeverY.Checked then
   TmpStrList.Add('  Fever and or Chills? Yes')
 else if cbFeverN.Checked then
   TmpStrList.Add('  Fever and or Chills? No');
 if cbSOBY.Checked then
   TmpStrList.Add('  Shortness of Breath? Yes')
 else if cbSOBN.Checked then
   TmpStrList.Add('  Shortness of Breath? No');

 if TmpStrList.Count > 0 then
   TmpStrList.Insert(0, 'Cough and Congestion:');
end;

procedure TdlgCoughCongest.cbProdCYClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Tag = 1 then
  begin
    if (Sender as TCheckBox).Checked then
    begin
      cbProdCN.Checked := False;

      lbColor.Visible := True;
      leColor.Visible := True;
      lbBlood.Visible := True;
      cbBloodY.Visible := True;
      cbBloodN.Visible := True;
    end
    else if not (Sender as TCheckBox).Checked then
    begin
      leColor.Clear;
      lbColor.Visible := False;
      leColor.Visible := False;
      lbBlood.Visible := False;
      cbBloodY.Visible := False;
      cbBloodN.Visible := False;
    end;
  end
  else if (((Sender as TCheckBox).Tag = 2) and ((Sender as TCheckBox).Checked)) then
    begin
      cbProdCY.Checked := False;

      leColor.Clear;
      lbColor.Visible := False;
      leColor.Visible := False;
      lbBlood.Visible := False;
      cbBloodY.Visible := False;
      cbBloodN.Visible := False;
    end;
end;

procedure TdlgCoughCongest.cbBloodYClick(Sender: TObject);
begin
  if ((Sender is TCheckBox) and ((Sender as TCheckBox).Checked)) then
  begin
    if (Sender as TCheckBox).Tag = 1 then
      cbBloodN.Checked := False
    else if (Sender as TCheckBox).Tag = 2 then
      cbBloodY.Checked := False;
  end;
end;

procedure TdlgCoughCongest.cbNasalYClick(Sender: TObject);
begin
  if ((Sender is TCheckBox) and ((Sender as TCheckBox).Checked)) then
  begin
    if (Sender as TCheckBox).Tag = 1 then
      cbNasalN.Checked := False
    else if (Sender as TCheckBox).Tag = 2 then
      cbNasalY.Checked := False
    else if (Sender as TCheckBox).Tag = 3 then
      cbSinusN.Checked := False
    else if (Sender as TCheckBox).Tag = 4 then
      cbSinusY.Checked := False
    else if (Sender as TCheckBox).Tag = 5 then
      cbRhinN.Checked := False
    else if (Sender as TCheckBox).Tag = 6 then
      cbRhinY.Checked := False
    else if (Sender as TCheckBox).Tag = 7 then
      cbFeverN.Checked := False
    else if (Sender as TCheckBox).Tag = 8 then
      cbFeverY.Checked := False
    else if (Sender as TCheckBox).Tag = 9 then
      cbSOBN.Checked := False
    else if (Sender as TCheckBox).Tag = 10 then
      cbSOBY.Checked := False;
  end;    
end;

end.
