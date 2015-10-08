unit frmAbout;

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
  Windows, SysUtils, Forms, StdCtrls, ExtCtrls, JclFileUtils, Vcl.Imaging.pngimage,
  Vcl.Controls, System.Classes;

type
  TDDCSAbout = class(TForm)
    Panel1: TPanel;
    lblAppName: TStaticText;
    btnOk: TButton;
    lblWebAddress: TStaticText;
    Picture1: TImage;
    Image1: TImage;
    Memo1: TMemo;
    Label4: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure lblWebAddressClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
  public
    procedure ShowCompany(Sender: TObject);
  end;

var
  DDCSAbout: TDDCSAbout;

implementation

uses
  dateutils, shellAPI;

{$R *.DFM}

procedure TDDCSAbout.FormCreate(Sender: TObject);
begin
  SetWindowLong(Handle, GWL_EXSTYLE, getWindowLong(Handle, GWL_EXSTYLE) or WS_EX_TOOLWINDOW);
end;

procedure TDDCSAbout.FormShow(Sender: TObject);
var
  vi: TJclFileVersionInfo;
begin
  vi := TJclFileVersionInfo.Create(HInstance);
  try
    lblAppName.Caption := vi.ProductName + ' ' + vi.ProductVersion;
    Label2.Caption := 'Copyright ' + Chr(169) + ' 2000 - ' + IntToStr(YearOf(Now));
  finally
    vi.Free;
  end;
end;

procedure TDDCSAbout.ShowCompany(Sender: TObject);
begin
  FormShow(Sender);
  Image1.Visible := False;
  Picture1.Width := (Width div 2) - (Picture1.Width div 2);
  Label2.Left := (Width div 2) - (Label2.Width div 2);
  Label4.Left := (Width div 2) - (Label4.Width div 2);
  Label3.Left := (Width div 2) - (Label3.Width div 2);
  Show;
end;

procedure TDDCSAbout.lblWebAddressClick(Sender: TObject);
var
  TempString: array[0..79] of Char;
begin
  StrPCopy(TempString, lblWebAddress.Caption);
  ShellExecute(0, nil, TempString, nil, nil, SW_NORMAL);
end;

end.
