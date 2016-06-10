unit udlgVagDischarge;

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
  TdlgVagDischarge = class(TDDCSDialog)
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leColor: TEdit;
    lbodor: TLabel;
    ckOdorY: TCheckBox;
    ckOdorN: TCheckBox;
    lbitching: TLabel;
    ckItchingY: TCheckBox;
    ckItchingN: TCheckBox;
    lbonset: TLabel;
    lbcolor: TLabel;
    pnlfooter: TPanel;
    procedure bbtnOKClick(Sender: TObject);
    procedure CheckBoxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgVagDischarge: TdlgVagDischarge;

implementation

{$R *.dfm}

procedure TdlgVagDischarge.FormCreate(Sender: TObject);
begin
  SayOnFocus(   ckOdorY, 'Odor?');
  SayOnFocus(   ckOdorN, 'Odor?');
  SayOnFocus(ckItchingY, 'Itching?');
  SayOnFocus(ckItchingN, 'Itching?');
end;

procedure TdlgVagDischarge.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
    TmpStrList.Add('  Onset: ' + leOnset.Text);
  if leColor.Text  <> '' then
    TmpStrList.Add('  Color: ' + leColor.Text);
  if ckOdorY.Checked then
    TmpStrList.Add('  Odor? Yes');
  if ckOdorN.Checked then
    TmpStrList.Add('  Odor? No');
  if ckItchingY.Checked then
    TmpStrList.Add('  Itching? Yes');
  if ckItchingN.Checked then
    TmpStrList.Add('  Itching? No');

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Vaginal Discharge:');
end;

procedure TdlgVagDischarge.CheckBoxClick(Sender: TObject);
begin
 if ((Sender is TCheckBox) and ((Sender as TCheckBox).Checked)) then
 begin
   if (Sender as TCheckBox).Tag = 1 then
     ckOdorN.Checked := False
   else if (Sender as TCheckBox).Tag = 2 then
     ckOdorY.Checked := False
   else if (Sender as TCheckBox).Tag = 3 then
     ckItchingN.Checked := False
   else if (Sender as TCheckBox).Tag = 4 then
     ckItchingY.Checked := False;
  end;
end;

end.
