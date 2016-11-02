library DDCSNursePostpartumDelivery;

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

{$R *.dres}

uses
  Winapi.Windows,
  Vcl.Forms,
  uExtndComBroker,
  frmMain in 'frmMain.pas' {Form1},
  frmBaby in 'frmBaby.pas' {fChild: TFrame};

{$R *.res}

function Launch(const CPRSBroker: PCPRSComBroker; var wReturn: WideString): WordBool; stdcall;
var
  oldHandle: Cardinal;
begin
  Result := False;

  RPCBrokerV := CPRSBroker^;
  try
    oldHandle := Application.Handle;
    RPCBrokerV.Host := DisableTaskWindows(oldHandle);
    try
      Application.Handle := GetActiveWindow;
      try
        Form1 := TForm1.Create(nil);
        try
          Form1.ShowModal;
          if Form1.DDCSForm1.Validated then
          begin
            Result := True;
            wReturn := Form1.DDCSForm1.TmpStrList.Text;
          end;
        finally
          Form1.Free;
        end;
      finally
        Application.Handle := oldHandle;
      end;
    finally
      if not RPCBrokerV.HostEnabled then
        EnableTaskWindows(RPCBrokerV.Host);
    end;
  finally
    RPCBrokerV := nil;
  end;
end;
exports
  Launch;

begin
end.
