library DDCSNursePostpartumMaternity;

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

uses
  Winapi.Windows,
  Vcl.Forms,
  uExtndComBroker,
  frmMain in 'frmMain.pas' {Form1};

{$R *.res}

function Launch(Broker: PCPRSComBroker; out Return: WideString): WordBool; stdcall;
var
  oldHandle: HWND;
begin
  Result := False;
  RPCBrokerV := Broker^;

  oldHandle := Application.Handle;
  Application.Handle := GetActiveWindow;
  Form1 := TForm1.Create(nil);
  try
    RPCBrokerV.DisabledWindow := DisableTaskWindows(0);
    Form1.ShowModal;
    if Form1.DDCSForm1.Validated then
    begin
      Result := True;
      Return := Form1.DDCSForm1.TmpStrList.Text;
    end;
  finally
    Form1.Free;
    Application.Handle := oldHandle;
  end;
end;

exports
  Launch;

begin
end.
