unit udlgRash;

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
  TdlgRash = class(TDDCSDialog)
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leLocat: TEdit;
    lbitching: TLabel;
    cbItchY: TCheckBox;
    cbItchN: TCheckBox;
    lbonset: TLabel;
    lbloc: TLabel;
    pnlfooter: TPanel;
    procedure bbtnOKClick(Sender: TObject);
    procedure checkboxClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  dlgRash: TdlgRash;

implementation

{$R *.dfm}

procedure TdlgRash.FormCreate(Sender: TObject);
begin
  SayOnFocus(cbItchY, 'Itching?');
  SayOnFocus(cbItchN, 'Itching?');
end;

procedure TdlgRash.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
   TmpStrList.Add('  Onset: ' + leOnset.Text);
  if leLocat.Text  <> '' then
   TmpStrList.Add('  Location: ' + leLocat.Text);
  if cbItchY.Checked then
   TmpStrList.Add('  Itching? Yes');
  if cbItchN.Checked then
   TmpStrList.Add('  Itching? No');

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Rash and Itching:');
end;

procedure TdlgRash.checkboxClick(Sender: TObject);
begin
  if ((Sender is TCheckBox) and ((Sender as TCheckBox).Checked)) then
  begin
   if (Sender as TCheckBox).Tag = 1 then
     cbItchN.Checked := False
   else if (Sender as TCheckBox).Tag = 2 then
     cbItchY.Checked := False
  end;
end;

end.
