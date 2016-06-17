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
   VA Contract: TAC-13-06464
}

interface

uses
  Winapi.Windows, System.Classes, System.SysUtils, Vcl.Forms, Vcl.Controls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.Imaging.pngimage, JclFileUtils;

type
  TDDCSSplash = class(TForm)
    pnlBody: TPanel;
    imgVA: TImage;
    lbLoading: TStaticText;
    lbCopyright: TStaticText;
    lbCompany: TStaticText;
    lbApache: TStaticText;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  protected
    procedure CreateParams(var Params: TCreateParams); override;
  public
  end;

var
  DDCSSplash: TDDCSSplash;

implementation

uses
  DateUtils;

{$R *.DFM}

procedure TDDCSSplash.CreateParams(var Params: TCreateParams);
begin
  inherited;

  Params.Style := WS_POPUP;
end;

procedure TDDCSSplash.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, getWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
end;

procedure TDDCSSplash.FormShow(Sender: TObject);
var
  vi: TJclFileVersionInfo;
begin
  lbLoading.SetFocus;

  vi := TJclFileVersionInfo.Create(HInstance);
  try
    lbCopyRight.Caption := 'Copyright ' + Chr(169) + ' 1995 - ' + IntToStr(YearOf(Now));
    lbCompany.Caption := vi.CompanyName;
  finally
    vi.Free;
  end;
end;

end.


