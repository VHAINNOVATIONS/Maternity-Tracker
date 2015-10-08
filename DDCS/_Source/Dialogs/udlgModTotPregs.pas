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
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Buttons, ExtCtrls;

type
  TdlgModTotPregs = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    Bevel1: TBevel;
    StaticText1: TStaticText;
    procedure OKBtnClick(Sender: TObject);
  private
  public
    deletepage: Integer;
  end;

var
  dlgModTotPregs: TdlgModTotPregs;

implementation

uses
  udlgModTotPregsConfirm;

{$R *.dfm}

procedure TdlgModTotPregs.OKBtnClick(Sender: TObject);
begin
  dlgModTotPregsConfirm := TdlgModTotPregsConfirm.Create(Self);
  try
    if dlgModTotPregsConfirm.ShowModal = mrOk then
    begin
      if dlgModTotPregsConfirm.LabeledEdit1.Text <> '' then
        if not TryStrToInt(dlgModTotPregsConfirm.LabeledEdit1.Text,deletepage) then
          ModalResult := mrCancel;
    end else
      ModalResult := mrCancel;
  finally
    dlgModTotPregsConfirm.Free;
  end;
end;

end.
