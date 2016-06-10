unit udlgLegPain;

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
  TdlgLegPain = class(TDDCSDialog)
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TEdit;
    leDur: TEdit;
    pnlfooter: TPanel;
    lbonset: TLabel;
    lbdur: TLabel;
    procedure bbtnOKClick(Sender: TObject);
  private
  public
  end;

var
  dlgLegPain: TdlgLegPain;

implementation

{$R *.dfm}

procedure TdlgLegPain.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
    TmpStrList.Add('  Onset: ' + leOnset.Text);
  if leDur.Text  <> '' then
    TmpStrList.Add('  Duration: ' + leDur.Text);

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Leg Pain and Swelling:');
end;

end.
