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
  Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, ExtCtrls,
  JclFileUtils;

type
  TCNTAbout = class(TForm)
    Panel1: TPanel;
    lblAppName: TStaticText;
    lblCopyright: TStaticText;
    lblCompany: TStaticText;
    btnOk: TButton;
    Bevel1: TBevel;
    labelMemory: TStaticText;
    labelOS: TStaticText;
    lblWebAddress: TStaticText;
    Picture1: TImage;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure lblWebAddressClick(Sender: TObject);
  private
   { Private declarations }
  public
   { Public declarations }
  end;

var
  CNTAbout: TCNTAbout;

implementation

uses
  dateutils, shellAPI;

{$R *.DFM}

procedure TCNTAbout.FormShow(Sender: TObject);
var
  Memstat: TMemoryStatus;
  MyVerInfo: TOSVersionInfo;
  OSystem: string;
  I: Integer;
  vi: TJclFileVersionInfo;

  function osver: string;
  begin
    result := 'Unknown (Windows ' + IntToStr(Win32MajorVersion) + '.' + IntToStr(Win32MinorVersion) + ')';
    case Win32MajorVersion of
      4:
        case Win32MinorVersion of
          0: result := 'Windows 95';
          10: result := 'Windows 98';
          90: result := 'Windows ME';
        end;
      5:
        case Win32MinorVersion of
          0: result := 'Windows 2000';
          1: result := 'Windows XP';
        end;
      6:
        case Win32MinorVersion of
          0: result := 'Windows Vista';
          1: result := 'Windows 7';
        end;
    end;
  end;

  function winver: string;
  var
    ver: TOSVersionInfo;
  begin
    ver.dwOSVersionInfoSize := SizeOf(ver);
    if GetVersionEx(ver) then
      with ver do
        result := IntToStr(dwMajorVersion) + '.' + IntToStr(dwMinorVersion) + '.' +
                  IntToStr(dwBuildNumber) + ' (' + szCSDVersion + ')';
  end;

begin
  // OS Version info
  MyVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(MyVerInfo);

  // Memory Info
  Memstat.dwLength := SizeOf(TMemoryStatus);
  GlobalMemoryStatus(MemStat);

  // Text
  vi := TJclFileVersionInfo.Create(HInstance);
  try
    lblCompany.Caption := vi.CompanyName;
    lblAppName.Caption := vi.ProductName + ' ' + vi.ProductVersion;
    lblCopyright.Caption := 'Copyright ' + Chr(169) + ' Document Storage Systems, Inc. 2000 - ' + IntToStr(YearOf(Now));
  finally
    vi.Free;
  end;

  OSystem := osver + ' ' + winver;
  labelOS.Caption := OSystem;
  labelMemory.Caption := 'Memory Available: ' + IntToStr(Round(MemStat.dwTotalPhys / 1024)) + ' KB';
end;

procedure TCNTAbout.lblWebAddressClick(Sender: TObject);
var
  TempString: array[0..79] of Char;
begin
  StrPCopy(TempString, lblWebAddress.Caption);
  ShellExecute(0, nil, TempString, nil, nil, SW_NORMAL);
end;

end.
