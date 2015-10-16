unit DDCSFormBuilder_TLB;

// ************************************************************************ //
// WARNING
// -------
// The types declared in this file were generated from data read from a
// Type Library. If this type library is explicitly or indirectly (via
// another type library referring to this type library) re-imported, or the
// 'Refresh' command of the Type Library Editor activated while editing the
// Type Library, the contents of this file will be regenerated and all
// manual modifications will be lost.
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 10/9/2015 12:13:19 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\DSSDeveloper\Desktop\DDCS\DDCSFormBuilder\DDCSFormBuilder (1)
// LIBID: {CDA57258-06B9-461D-8854-D94A63557EC6}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v1.0 CPRSChart, (C:\Users\DSSDeveloper\Desktop\CPRSChart.exe)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers.
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, CPRSChart_TLB, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;



// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:
//   Type Libraries     : LIBID_xxxx
//   CoClasses          : CLASS_xxxx
//   DISPInterfaces     : DIID_xxxx
//   Non-DISP interfaces: IID_xxxx
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  DDCSFormBuilderMajorVersion = 1;
  DDCSFormBuilderMinorVersion = 0;

  LIBID_DDCSFormBuilder: TGUID = '{CDA57258-06B9-461D-8854-D94A63557EC6}';

  IID_IDDCS: TGUID = '{535EAA9E-EDEF-4F00-A275-B5EF14E6ACA8}';
  CLASS_DDCS: TGUID = '{F4401FE9-4F5C-4633-B409-E7CEC0CE863F}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary
// *********************************************************************//
  IDDCS = interface;
  IDDCSDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library
// (NOTE: Here we map each CoClass to its Default Interface)
// *********************************************************************//
  DDCS = IDDCS;


// *********************************************************************//
// Interface: IDDCS
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {535EAA9E-EDEF-4F00-A275-B5EF14E6ACA8}
// *********************************************************************//
  IDDCS = interface(IDispatch)
    ['{535EAA9E-EDEF-4F00-A275-B5EF14E6ACA8}']
  end;

// *********************************************************************//
// DispIntf:  IDDCSDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {535EAA9E-EDEF-4F00-A275-B5EF14E6ACA8}
// *********************************************************************//
  IDDCSDisp = dispinterface
    ['{535EAA9E-EDEF-4F00-A275-B5EF14E6ACA8}']
  end;

// *********************************************************************//
// The Class CoDDCS provides a Create and CreateRemote method to
// create instances of the default interface IDDCS exposed by
// the CoClass DDCS. The functions are intended to be used by
// clients wishing to automate the CoClass objects exposed by the
// server of this typelibrary.
// *********************************************************************//
  CoDDCS = class
    class function Create: IDDCS;
    class function CreateRemote(const MachineName: string): IDDCS;
  end;

implementation

uses System.Win.ComObj;

class function CoDDCS.Create: IDDCS;
begin
  Result := CreateComObject(CLASS_DDCS) as IDDCS;
end;

class function CoDDCS.CreateRemote(const MachineName: string): IDDCS;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_DDCS) as IDDCS;
end;

end.

