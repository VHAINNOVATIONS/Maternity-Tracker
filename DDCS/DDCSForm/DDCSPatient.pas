unit DDCSPatient;

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

  procedure GetPatientAllergies(var oText: TStringList);
  procedure GetPatientActiveProblems(var oText: TStringList);
  procedure GetPatientActiveMedications(var oText: TStringList);

implementation

uses
  DDCSUtils, DDCSCommon, DDCSComBroker;

procedure GetPatientAllergies(var oText: TStringList);
// Array of patient allergies.  Returned data is delimited by "^" and
// includes: allergen/reactant, reactions/symptoms (multiple symptoms/
// reactions are possible - delimited by ";"), severity, allergy id (record
// number from the Patient Allergies file (#120.8).
// DSSTFF20140715 DSIO ORQQAL LIST created to return formatting
begin
  oText.Clear;

  if RPCBrokerV = nil then
    Exit;
  try
    UpdateContext(MENU_CONTEXT);
    tCallV(oText, 'DSIO DDCS ORQQAL LIST', [RPCBrokerV.Patient.DFN]);
  except
    on E: Exception do
    begin
      oText.Clear;
      oText.Add(E.Message);
    end;
  end;
end;

procedure GetPatientActiveProblems(var oText: TStringList);
// Array of patient problems in the format: problem id^problem name^status
begin
  oText.Clear;

  if RPCBrokerV = nil then
    Exit;
  try
    UpdateContext(MENU_CONTEXT);
    tCallV(oText, 'DSIO DDCS ORQQPL LIST', [RPCBrokerV.Patient.DFN]);
  except
    on E: Exception do
    begin
      oText.Clear;
      oText.Add(E.Message);
    end;
  end;
end;

procedure GetPatientActiveMedications(var oText: TStringList);
// Array medications in the format: medication id^nameform (orderable item)^
// stop date/time^route^schedule/iv rate^refills remaining
begin
  oText.Clear;

  if RPCBrokerV = nil then
    Exit;
  try
    UpdateContext(MENU_CONTEXT);
    tCallV(oText, 'DSIO DDCS ORQQPS LIST', [RPCBrokerV.Patient.DFN]);
  except
    on E: Exception do
    begin
      oText.Clear;
      oText.Add(E.Message);
    end;
  end;
end;

end.
