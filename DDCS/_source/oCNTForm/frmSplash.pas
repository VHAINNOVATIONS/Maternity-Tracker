unit frmSplash;

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
  Windows, SysUtils, Forms, Controls, StdCtrls, ExtCtrls, Vcl.Imaging.pngimage,
  System.Classes;

type
  TDDCSSplash = class(TForm)
    Panel1: TPanel;
    Image1: TImage;
    img1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure FormCreate(Sender: TObject);
  private
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure ShowCompany;
  end;

var
  DDCSSplash: TDDCSSplash;

implementation

uses
  DateUtils;

{$R *.DFM}

procedure TDDCSSplash.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do Style := WS_POPUP;
end;

procedure TDDCSSplash.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, getWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
  Label2.Caption := 'Copyright © 1995-' + IntToStr(YearOf(Now));
end;

procedure TDDCSSplash.ShowCompany;
begin
  img1.Visible := False;
  Width := Width div 2;
  Image1.Left := (Width div 2) - (Image1.Width div 2);
  Label2.Left := (Width div 2) - (Label2.Width div 2);
  Label4.Left := (Width div 2) - (Label4.Width div 2);
  Label3.Left := (Width div 2) - (Label3.Width div 2);
  Show;
end;

end.


