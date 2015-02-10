unit NursePostartum;

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
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, oCNTBase, Vcl.StdCtrls, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ofrm1: ToForm;
    oPage1: ToPage;
    memoDelivery: TMemo;
    ButtonDelivery: TButton;
    Panel1: TPanel;
    ButtonDeliveryClear: TButton;
    btnMaternalInfo: TButton;
    procedure ClearTextClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ClearTextClick(Sender: TObject);
begin
  if not (Sender is TButton) then Exit;

  if MessageDlg('Are you sure you want to clear all the text?', mtWarning, mbYesNo, 0) = mrYes then
  memoDelivery.Clear;
end;

end.
