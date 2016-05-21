unit udlgBackPain;

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
  StdCtrls, ExtCtrls, Buttons, ORCtrls, uDialog, uExtndComBroker;

type
  TdlgBackPain = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leChar: TEdit;
    leLocat: TEdit;
    leDur: TEdit;
    leUrin: TEdit;
    lbdysuria: TLabel;
    cbDysY: TCheckBox;
    cbDysN: TCheckBox;
    lbfever: TLabel;
    cbFeverY: TCheckBox;
    cbFeverN: TCheckBox;
    lbchar: TLabel;
    lbloc: TLabel;
    lbdur: TLabel;
    lbonset: TLabel;
    lburinary: TLabel;
    procedure bbtnOKClick(Sender: TObject);
    procedure checkboxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgBackPain: TdlgBackPain;

implementation

{$R *.dfm}

procedure TdlgBackPain.FormCreate(Sender: TObject);
begin
  SayOnFocus(  cbDysY, 'Dysuria?');
  SayOnFocus(  cbDysN, 'Dysuria?');
  SayOnFocus(cbFeverY, 'Fever and or chills?');
  SayOnFocus(cbFeverN, 'Fever and or chills?');
end;

procedure TdlgBackPain.bbtnOKClick(Sender: TObject);
begin
 if leOnset.Text  <> '' then
   TmpStrList.Add('  Onset: ' + leOnset.Text);
 if leDur.Text  <> '' then
   TmpStrList.Add('  Duration: ' + leDur.Text);
 if leLocat.Text  <> '' then
   TmpStrList.Add('  Location: ' + leLocat.Text);
 if leChar.Text  <> '' then
   TmpStrList.Add('  Character: ' + leChar.Text);
 if leUrin.Text  <> '' then
   TmpStrList.Add('  Urinary frequency and or urgency: ' + leUrin.Text);
 if cbDysY.Checked then
   TmpStrList.Add('  Dysuria? Yes');
 if cbDysN.Checked then
   TmpStrList.Add('  Dysuria? No');
 if cbFeverY.Checked then
   TmpStrList.Add('  Fever and or Chills? Yes');
 if cbFeverN.Checked then
   TmpStrList.Add('  Fever and or Chills? No');

 if TmpStrList.Count > 0 then
   TmpStrList.Insert(0, 'Back pain:');
end;

procedure TdlgBackPain.checkboxClick(Sender: TObject);
begin
 if (Sender is TCheckBox) and ((Sender as TCheckBox).Checked) then
 begin
   if (Sender as TCheckBox).Tag = 1 then
     cbDysN.Checked := False
   else if (Sender as TCheckBox).Tag = 2 then
     cbDysY.Checked := False
   else if (Sender as TCheckBox).Tag = 3 then
     cbFeverN.Checked := False
   else if (Sender as TCheckBox).Tag = 4 then
     cbFeverY.Checked := False;
  end;
end;

end.
