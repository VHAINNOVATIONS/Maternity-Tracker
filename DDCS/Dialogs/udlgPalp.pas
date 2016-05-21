unit udlgPalp;

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
  TdlgPalp = class(TDDCSDialog)
    pnlfooter: TPanel;
    bbtnOK: TBitBtn;
    leOnset: TEdit;
    leDur: TEdit;
    leAssoc: TEdit;
    leFreq: TEdit;
    Label1: TLabel;
    lbonset: TLabel;
    lbdur: TLabel;
    lbfrequency: TLabel;
    lbsymptoms: TLabel;
    bbtnCancel: TBitBtn;
    procedure bbtnOKClick(Sender: TObject);
  private
  public
  end;

var
  dlgPalp: TdlgPalp;

implementation

{$R *.dfm}

procedure TdlgPalp.bbtnOKClick(Sender: TObject);
begin
  if leOnset.Text  <> '' then
    TmpStrList.Add('  Onset: ' + leOnset.Text);
  if leDur.Text  <> '' then
    TmpStrList.Add('  Duration: ' + leDur.Text);
  if leFreq.Text  <> '' then
    TmpStrList.Add('  Frequency: ' + leFreq.Text);
  if leAssoc.Text  <> '' then
  begin
    TmpStrList.Add('  Associated Symptoms:');
    TmpStrList.Add('    ' + leAssoc.Text);
  end;

  if TmpStrList.Count > 0 then
    TmpStrList.Insert(0, 'Palpitations:');
end;

end.
