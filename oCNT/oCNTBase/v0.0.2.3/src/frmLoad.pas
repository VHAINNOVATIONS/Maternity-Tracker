unit frmLoad;

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
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, ExtCtrls;

type
  TCNTSplash = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Image1: TImage;
    img1: TImage;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CreateParams(var Params: TCreateParams); override;
  public
    { Public declarations }
  end;

var
  CNTSplash: TCNTSplash;

implementation

uses DateUtils;

{$R *.DFM}

procedure TCNTSplash.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do Style := WS_POPUP;
end;

procedure TCNTSplash.FormCreate(Sender: TObject);
begin
  Label2.Caption := 'Copyright © 1995-' + IntToStr(YearOf(Now));
end;

end.


