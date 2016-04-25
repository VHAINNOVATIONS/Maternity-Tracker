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
// File generated on 4/25/2016 4:39:26 PM from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Users\DSSDeveloper\Documents\GitHub\Maternity-Tracker\DDCS\DDCS\2.0\DDCSFormBuilder\DDCSFormBuilder (1)
// LIBID: {46474042-D235-4388-AF75-0BFD7BBC0F2C}
// LCID: 0
// Helpfile:
// HelpString:
// DepndLst:
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
//   (2) v1.0 CPRSChart, (C:\Users\DSSDeveloper\Documents\GitHub\Maternity-Tracker\DDCS\_lib\CPRSChart.exe)
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

  LIBID_DDCSFormBuilder: TGUID = '{46474042-D235-4388-AF75-0BFD7BBC0F2C}';

  IID_IDDCS: TGUID = '{EFE41B95-30BF-47EA-86D3-B6183F167705}';
  CLASS_DDCS: TGUID = '{A5B2B08E-7045-4C77-9233-32B52C6E5B25}';
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
// GUID:      {EFE41B95-30BF-47EA-86D3-B6183F167705}
// *********************************************************************//
  IDDCS = interface(IDispatch)
    ['{EFE41B95-30BF-47EA-86D3-B6183F167705}']
  end;

// *********************************************************************//
// DispIntf:  IDDCSDisp
// Flags:     (4416) Dual OleAutomation Dispatchable
// GUID:      {EFE41B95-30BF-47EA-86D3-B6183F167705}
// *********************************************************************//
  IDDCSDisp = dispinterface
    ['{EFE41B95-30BF-47EA-86D3-B6183F167705}']
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

