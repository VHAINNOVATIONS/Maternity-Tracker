DDCS FORMS (Delphi XE10)
========================
To install the DDCSFramework from source load the project DDCSFramework.dproj and then in the project manager you can right click the package name "DDCSFramework.bpl" and select install.

To load from DDCSFramework.bpl you can select the "Component" option "Install Packages" then select ADD and navigate to the .bpl and open.

Be sure to add the DDCSForm directory to your Library. Do this by going to "Tools" "Options" and under "Delphi Options" select "Library". Once here go to "Library path" and add the full path (including DDCSForm) by using the "..." button to the right, then the folder icon to select the path and "Add".

You should now have the cagegory "DDCSForm" in your tool palette with TDDCSForm as an entry.

Quick Start - Your First DDCS (as a CPRS Note Extension) DLL
------------------------------------------------------------
1. In Delphi (XE10) create a New Project - Delphi Projects - Dynamic-link Library.

2. Right click the project name (Project1.dll) from the project manager and select "Add New" - "VCL Form". I changed the name of the form unit to frmMain. The source should now look like this...

	```pascal

	library Project1;

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
	  System.SysUtils,
	  System.Classes,
	  frmMain in 'frmMain.pas' {Form1};

	{$R *.res}

	begin
	end.

	```
	
3. In your VCL Form unit go to your tool pallet and look for TDDCSForm (it's in the DDCSForm cagegory) and add it to your form. Make sure you add at least one page (right click the body of the component and select "New Page") before you add anything else. All components must be placed on a page in order to be picked up by DDCS.

4. Now lets go back to the source and make it look like the following...

	```pascal

	library Project1;

	{$R *.dres}

	uses
	  Winapi.Windows,
	  Vcl.Forms,
	  uExtndComBroker,
	  frmMain in 'frmMain.pas' {Form1};

	{$R *.res}

	function Launch(const CPRSBroker: PCPRSComBroker; out Return: WideString): WordBool; stdcall;
	var
	  oldHandle: HWND;
	begin
	  Result := False;

	  oldHandle := Application.Handle;
	  Application.Handle := GetActiveWindow;

	  RPCBrokerV := CPRSBroker^;
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
		RPCBrokerV := nil;
		Application.Handle := oldHandle;
	  end;
	end;

	exports
	  Launch;

	begin
	end.

	```

5. The rest is up to you. Check out [Documentation](/Documentation) for an advanced guide to developing DDCS forms for CPRS TIU notes. *Will be updated at a later date.*

Adding Themes
-------------
Add the Windows10 theme to your project. This step is optional and at the time of this writting the component's option to change the theme was disabled but if you wish to use it your project will also have to have the appropriate themes added as a resource.

Select the "Project" option and under it select "Resources and Images...". Then select "Add..." and navigate to the theme .vsf file resource you wish to add (mine were located at C:\Users\Public\Documents\Embarcadero\Studio\17.0\Styles\). Once added, set the type to VCLSTYLE and set the identifier to Resource_1 for the first one and just incrememt the number for each addtional entry.

![Image](/Documentation/readme_images/Resource_Theme.png)