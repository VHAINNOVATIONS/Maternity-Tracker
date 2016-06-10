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
    leOnset: TEdit;
    leLocal: TEdit;
    leDur: TEdit;
    leDur1: TEdit;
    lbtoleratesolids: TLabel;
    cbSolidY: TCheckBox;
    cbSolidN: TCheckBox;
    lbtolerateliquids: TLabel;
    cbLiquidY: TCheckBox;
    cbLiquidN: TCheckBox;
    lbfever: TLabel;
    cbFeverY: TCheckBox;
    cbFeverN: TCheckBox;
    lbabdominalpain: TLabel;
    cbAbdomY: TCheckBox;
    cbAbdomN: TCheckBox;
    lbcontractions: TLabel;
    cbContY: TCheckBox;
    cbContN: TCheckBox;
    lbonset: TLabel;
    lbdur: TLabel;
    lbLocal1: TLabel;
    lbDur1: TLabel;
    pnlfooter: TPanel;
    procedure bbtnOKClick(Sender: TObject);
    procedure checkboxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgNausea: TdlgNausea;

implementation

{$R *.dfm}

procedure TdlgNausea.FormCreate(Sender: TObject);
begin
  SayOnFocus( cbSolidY, 'Can tolerate solids?');
  SayOnFocus( cbSolidN, 'Can tolerate solids?');
  SayOnFocus(cbLiquidY, 'Can tolerate liquids?');
  SayOnFocus(cbLiquidN, 'Can tolerate liquids?');
  SayOnFocus( cbFeverY, 'Fever and or Chills?');
  SayOnFocus( cbFeverN, 'Fever and or Chills?');
  SayOnFocus(  cbContY, 'Contractions?');
  SayOnFocus(  cbContN, 'Contractions?');
  SayOnFocus( cbAbdomY, 'Abdominal pain?');
  SayOnFocus( cbAbdomN, 'Abdominal pain?');
end;

procedure TdlgNausea.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
    TmpStrList.Add('  Onset: ' + leOnset.Text);
  if cbSolidY.Checked then
    TmpStrList.Add('  Can tolerate solids? Yes')
  else if cbSolidN.Checked then
    TmpStrList.Add('  Can tolerate solids? No');
  if cbLiquidY.Checked then
    TmpStrList.Add('  Can tolerate liquids? Yes')
  else if cbLiquidN.Checked then
    TmpStrList.Add('  Can tolerate liquids? No');
  if leDur.Text  <> '' then
    TmpStrList.Add('  Duration: ' + leDur.Text);
  if cbFeverY.Checked then
    TmpStrList.Add('  Fever and or Chills? Yes')
  else if cbFeverN.Checked then
    TmpStrList.Add('  Fever and or Chills? No');
  if cbContY.Checked then
    TmpStrList.Add('  Contractions? Yes')
  else if cbContN.Checked then
    TmpStrList.Add('  Contractions? No');
  if cbAbdomY.Checked then
  begin
    TmpStrList.Add('  Abdominal pain? Yes');
    if leLocal.Text  <> '' then
      TmpStrList.Add('    Localization: ' + leLocal.Text);
    if leDur1.Text  <> '' then
      TmpStrList.Add('    Duration: ' + leDur1.Text);
  end
  else if cbAbdomN.Checked then
  begin
    TmpStrList.Add('  Abdominal pain? No');
    leLocal.Clear;
    leDur1.Clear;
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Nausea, Vomiting, and Diarrhea:');
end;

procedure TdlgNausea.checkboxClick(Sender: TObject);
begin
  if (((Sender as TCheckBox).Tag = 1) and ((Sender as TCheckBox).Checked)) then
    cbSolidN.Checked := False
  else  if (((Sender as TCheckBox).Tag = 2) and ((Sender as TCheckBox).Checked)) then
    cbSolidY.Checked := False
  else if (((Sender as TCheckBox).Tag = 3) and ((Sender as TCheckBox).Checked)) then
    cbLiquidN.Checked := False
  else  if (((Sender as TCheckBox).Tag = 4) and ((Sender as TCheckBox).Checked)) then
    cbLiquidY.Checked := False
  else if (((Sender as TCheckBox).Tag = 5) and ((Sender as TCheckBox).Checked)) then
    cbFeverN.Checked := False
  else  if (((Sender as TCheckBox).Tag = 6) and ((Sender as TCheckBox).Checked)) then
    cbFeverY.Checked := False
  else if (Sender as TCheckBox).Tag = 7 then
  begin
    if (Sender as TCheckBox).Checked then
    begin
      cbAbdomN.OnClick := nil;
      cbAbdomN.Checked := False;
      cbAbdomN.OnClick := checkboxClick;

      lbLocal1.Visible := True;
      leLocal.Visible := True;
      lbDur1.Visible := True;
      leDur1.Visible := True;
    end else
    begin
      leLocal.Clear;
      lbLocal1.Visible := False;
      leLocal.Visible := False;
      leDur1.Clear;
      lbDur1.Visible := False;
      leDur1.Visible := False;
    end;
  end else if (Sender as TCheckBox).Tag = 8 then
  begin
    cbAbdomY.OnClick := nil;
    cbAbdomY.Checked := False;
    cbAbdomY.OnClick := checkboxClick;

    leLocal.Clear;
    lbLocal1.Visible := False;
    leLocal.Visible := False;
    leDur1.Clear;
    lbDur1.Visible := False;
    leDur1.Visible := False;
  end
  else if (((Sender as TCheckBox).Tag = 9) and ((Sender as TCheckBox).Checked)) then
    cbContN.Checked := False
  else  if (((Sender as TCheckBox).Tag = 10) and ((Sender as TCheckBox).Checked)) then
    cbContY.Checked := False;
end;

end.
