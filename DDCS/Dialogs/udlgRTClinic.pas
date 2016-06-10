unit udlgRTClinic;

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
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Spin, ORCtrls,
  uDialog, uCommon, uExtndComBroker;

type
  TdlgRTClinic = class(TDDCSDialog)
    bbtnOK: TBitBtn;
    bbtnCancel: TBitBtn;
    edtRTCWeeks: TSpinEdit;
    cbTimeUnit: TComboBox;
    pnlfooter: TPanel;
    lbrtc: TLabel;
    procedure bbtnOKClick(Sender: TObject);
    procedure edtRTCWeeksChange(Sender: TObject);
  private
  public
  end;

var
  dlgRTClinic: TdlgRTClinic;

implementation

{$R *.dfm}

procedure TdlgRTClinic.bbtnOKClick(Sender: TObject);
begin
  if edtRTCWeeks.Value > 0 then
    TmpStrList.add ('Return to clinic in ' + IntToStr(edtRTCWeeks.Value) + ' '+ cbTimeUnit.Text);
end;

procedure TdlgRTClinic.edtRTCWeeksChange(Sender: TObject);
begin
  if (edtRTCWeeks.Value < 0) or (Pos('-', edtRTCWeeks.Text) > 0) then
    edtRTCWeeks.Value := 0;
end;

end.
