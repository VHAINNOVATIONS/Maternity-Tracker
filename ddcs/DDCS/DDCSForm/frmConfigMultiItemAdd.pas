unit frmConfigMultiItemAdd;

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
  Forms, StdCtrls, Buttons, System.Classes, Vcl.Controls;

type
  TAddItem = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    procedure FormShow(Sender: TObject);
  private
  public
  end;

var
  AddItem: TAddItem;

implementation

{$R *.dfm}

procedure TAddItem.FormShow(Sender: TObject);
begin
  Edit1.SetFocus;
end;

end.