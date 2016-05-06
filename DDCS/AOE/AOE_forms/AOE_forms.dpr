library AOE_forms;

uses
  oCNTBase,
  uExtndComBroker,
  System.SysUtils,
  System.Classes,
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
