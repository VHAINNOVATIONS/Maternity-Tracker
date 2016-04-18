library DDCS_Template;

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

uses
  oCNTBase,
  uExtndComBroker,
  fBase508Form in '..\..\_lib\fBase508Form.pas' {frmBase508Form},
  frmMain in 'frmMain.pas' {Form1};

{$R *.res}

function LaunchoCNT(Broker: PCPRSComBroker): Pointer; stdcall;
begin
  RPCBrokerV := Broker^;             // set the broker first so the create method has access to VistA
  Form1 := TForm1.Create(nil);       // nil - let the ComObject Free it
  Result := @Form1;                  // the component uses caFree on Close of the form so it is freed
end;

exports
  LaunchoCNT;

begin
end.
