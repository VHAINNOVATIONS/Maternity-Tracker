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
       Company: Document Storage Systems Inc.
   VA Contract: TAC-13-06464

   v1.0.0.0
}

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, oCNTBase, uExtndComBroker;

type
  TdlgRash = class(ToCNTDialog)
    Panel1: TPanel;
    lbltitle: TLabel;
    Panel2: TPanel;
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    leOnset: TLabeledEdit;
    leLocat: TLabeledEdit;
    Label3: TLabel;
    cbItchY: TCheckBox;
    cbItchN: TCheckBox;
    procedure bbtnOKClick(Sender: TObject);
    procedure cbItchYClick(Sender: TObject);
  private                                        { Private declarations }
  public                                         { Public declarations }
  end;

var
  dlgRash: TdlgRash;

implementation

{$R *.dfm}

procedure TdlgRash.bbtnOKClick(Sender: TObject);
{ User pressed OK. }
begin
  if (leOnset.Text <> '') or (leLocat.Text <> '') or
     (cbItchY.Checked) or (cbItchN.Checked) then
  begin
   TmpStrList.Add('Rash/Itching:');
   if leOnset.Text  <> '' then TmpStrList.Add('  Onset: ' + leOnset.Text);
   if leLocat.Text  <> '' then TmpStrList.Add('  Location: ' + leLocat.Text);
   if cbItchY.Checked then TmpStrList.Add('  Itching? Yes');
   if cbItchN.Checked then TmpStrList.Add('  Itching? No');
  end;
end;

procedure TdlgRash.cbItchYClick(Sender: TObject);
begin
  if (Sender as TCheckBox).Checked = TRUE then
    begin
      if (Sender as TCheckBox).Tag = 1 then
        cbItchN.Checked := FALSE
      else
        cbItchY.Checked := FALSE;
    end
end;

end.
