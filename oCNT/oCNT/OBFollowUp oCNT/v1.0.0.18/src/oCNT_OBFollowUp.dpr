library oCNT_OBFollowUp;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }



uses
  ShareMem,
  SysUtils,
  Classes,
  Forms,
  oCNTBase,
  uExtndComBroker,
  OBFollowUp in 'OBFollowUp.pas' {Form1},
  CPRSChart_TLB in '..\..\..\Documents\RAD Studio\11.0\Imports\CPRSChart_TLB.pas';

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
