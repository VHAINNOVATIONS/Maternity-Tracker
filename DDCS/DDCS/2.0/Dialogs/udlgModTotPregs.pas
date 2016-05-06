unit udlgModTotPregs;

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
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls,
  udlgPregHist, Vcl.Samples.Spin, fBase508Form, VA508AccessibilityManager;

type
  TdlgModTotPregs = class(TfrmBase508Form)
    OKBtn: TBitBtn;
    CancelBtn: TBitBtn;
    Bevel1: TBevel;
    StaticText1: TStaticText;
    Panel1: TPanel;
    Bevel2: TBevel;
    SpinEdit1: TSpinEdit;
    Label1: TLabel;
    amgrMain: TVA508AccessibilityManager;
    procedure OKBtnClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
  private
  public
    deletepage: Integer;
  end;

var
  dlgModTotPregs: TdlgModTotPregs;

implementation

{$R *.dfm}

procedure TdlgModTotPregs.FormShow(Sender: TObject);
begin
  SpinEdit1.MinValue := 0;
  SpinEdit1.MaxValue := TdlgPregHist(Owner).pgcPregnancy.PageCount;
end;

procedure TdlgModTotPregs.SpinEdit1Change(Sender: TObject);
begin
  if SpinEdit1.Value < 0 then
  begin
    SpinEdit1.Value := 0;
    Exit;
  end;
  if SpinEdit1.Value < 1 then
    Exit;

  TdlgPregHist(Owner).pgcPregnancy.ActivePageIndex := SpinEdit1.Value - 1;
end;

procedure TdlgModTotPregs.OKBtnClick(Sender: TObject);
begin
  if SpinEdit1.Value > 0 then
    deletepage := SpinEdit1.Value
  else
    ModalResult := mrCancel;
end;

end.
