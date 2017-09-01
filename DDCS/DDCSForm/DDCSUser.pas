unit DDCSUser;

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
}

interface

uses
  System.SysUtils, System.Classes;

  function HasSecurityKey(const KeyName: string): Boolean;

implementation

uses
  DDCSUtils, DDCSCommon, DDCSComBroker;

function HasSecurityKey(const KeyName: string): Boolean;
begin
  Result := False;

  if RPCBrokerV = nil then
    Exit;
  try
    UpdateContext(MENU_CONTEXT);
    Result := (sCallV('ORWU HASKEY', [KeyName]) = '1');
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

end.
