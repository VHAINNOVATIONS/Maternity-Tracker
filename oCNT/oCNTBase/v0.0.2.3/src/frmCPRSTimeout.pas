unit frmCPRSTimeout;

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
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, Dialogs, ExtCtrls;

type
  TCPRSTimeOut = class(TForm)
    OKBtn: TButton;
    CancelBtn: TButton;
    StaticText1: TStaticText;
    Image1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  CPRSTimeOut: TCPRSTimeOut;
  IconIDs: array[TMsgDlgType] of PChar = (IDI_EXCLAMATION, IDI_HAND, IDI_ASTERISK, IDI_QUESTION, nil);

implementation

{$R *.dfm}

procedure TCPRSTimeOut.FormCreate(Sender: TObject);
var
  IconID: PChar;
begin
  IconID := IconIDs[mtWarning];
  Image1.Picture.Icon.Handle := LoadIcon(0, IconID);
end;

end.
