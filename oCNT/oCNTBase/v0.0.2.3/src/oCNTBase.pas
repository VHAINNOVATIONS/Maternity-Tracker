unit oCNTBase;

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

interface

uses
  Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  Extctrls, Buttons, Tabs, Menus, ComCtrls, StdCtrls, TypInfo, Contnrs, Spin,
  JvStringGrid, uReportItems, CPRSChart_TLB, uExtndComBroker;

const
  U = '^';
  MENU_CONTEXT = 'DSIO OCNT CONTEXT';

  { version 3: Renamed resource id from 32761 to 30001 and 32760 to 30000 }
  IDC_RTTCSTORE = PChar(30001);
  IDC_RTTCEDIT = PChar(30000);
  IDC_TABCHECK = PChar(44444);

  { User Windows messages }
  UM_PAGE_CHANGE                = WM_USER + 255;
  UM_PANEL                      = WM_USER + 256;
  UM_PSUD_CHANGE                = WM_USER + 260;
  UM_RTTC_CHANGE                = WM_USER + 261;

  { prompts }
  SaveChangesPrompt = 'Do you want to save changes to the form?';
  OpenChangesPrompt = 'Do you wish to save this  template before opening a saved ?';

type

  { message structures for components. }
  TUMPSUDChange = record
    Msg: Word;
    case Integer of
      0: (
        WParam: Word;
        LParam: Longint;
        Result: Longint);
      1: (
        WParamLo: Byte;
        WParamHi: Byte;
        WPSUDChange: Word;
        LParamHi: Word;
        ResultLo: Word;
        ResultHi: Word);
  end;

  TUMRTTCChange = record
    Msg: Word;
    case Integer of
      0: (
        WParam: Word;
        LParam: Longint;
        Result: Longint);
      1: (
        WParamLo: Byte;
        WParamHi: Byte;
        WPSUDChange: Word;
        LParamHi: Word;
        ResultLo: Word;
        ResultHi: Word);
  end;

  TPageOps = (poNext, poPrev, poAbs);

  TUMPageChange = record
    Msg: Cardinal;       { 32bit.  Type changed from word to Cardinal. }
    case Integer of
      0: (
        WParam: Longint; { 32bit.  Type changed from word to Longint. }
        LParam: Longint;
        Result: Longint);
      1: (
        WParamLo: Word;  { 32bit.  Type changed from byte to word. }
        WParamHi: Word;  { 32bit.  Type changed from word to Longint. }
        PageOp: Word;
        Page: Word;
        ResultLo: Word;
        NewPage: Word);
  end;

  TPanelOps = (pnSave, pnPreview, pnCancel, pnFinish);

  TUMPanel = record
   Msg: Cardinal;       { 32bit.  Type changed from word to Cardinal. }
   case Integer of
     0: (
       WParam: Longint; { 32bit.  Type changed from word to Longint. }
       LParam: Longint;
       Result: Longint);
     1: (
       WParamLo: Word;  { 32bit.  Type changed from byte to word. }
       WParamHi: Word;  { 32bit.  Type changed from byte to word. }
       PanelOp: Word;
       LParamHi: Word;
       ResultLo: Word;
       ResultHi: Word);
  end;

//  TBrowseType = (brTab, brWizard);

  { ToPanel }
  ToPanel = class(TCustomPanel)
    private
    protected
      procedure Paint; override;
    public
  end;

  { ToButtonPanel }
  ToButtonPanel = class(ToPanel)
  private
  protected
//    LayoutButton: TBitBtn;
    SaveButton: TBitBtn;
    PreviewButton: TBitBtn;
    CancelButton: TBitBtn;
    FinishButton: TBitBtn;
    function CreateButton(Value: string): TBitBtn;
    function PanelMessage(Msg: TPanelOps): TUMPanel;
    procedure Resize; virtual;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ButtonClick(Sender: TObject); virtual;
  end;

  { ToControlPanel }
  ToControlPanel = class(TCustomPanel)
  private
    ButtonTabPanel: ToButtonPanel;
    ButtonWizPanel: ToButtonPanel;
  protected
//    BrowseType: TBrowseType;
    procedure Resize; virtual; abstract;
    procedure UMPanel(var Message: TUMPanel); message UM_PANEL;
  public
    constructor Create(AOwner: TComponent); override;
    procedure PagesUpdate(Pages: TObjectList); virtual; abstract;
    procedure SetPageIndex(Page: Integer); virtual; abstract;
  published
  end;

  { ToPageIndicator }
  ToPageIndicator = class(TCustomPanel)
  private
    PageCount: Integer;
    CurrentPage: Integer;
  protected
  public
    constructor Create(AOwner: TComponent); override;
    procedure PagesUpdate(Pages: TObjectList);
    procedure SetPageIndex(PageIndex: Integer);
    function GetCurrentPage: Integer;
    function GetPageCount: Integer;
  published
    property TabStop;
  end;

  { ToWizardButtonPanel }
  ToWizardButtonPanel = class(ToButtonPanel)
  private
  protected
    PageIndicator: ToPageIndicator;
    PrevButton: TBitBtn;
    NextButton: TBitBtn;
    function CreateIndicator: ToPageIndicator;
    procedure DisableButtons;
  public
    constructor Create(AOwner: TComponent); override;
    procedure ButtonClick(Sender: TObject); override;
    procedure PagesUpdate(Pages: TObjectList);
    procedure SetPageIndex(PageIndex: Integer);
  end;

  { ToTabButtonPanel }
  ToTabButtonPanel = class(ToButtonPanel)
    private
    protected
    public
      constructor Create(AOwner: TComponent); override;
  end;

  { ToCombinePanel }
  ToCombinePanel = class(ToControlPanel)
  private
    CheckMark: TImage;
    UITabChange: Boolean;
    { IMPORTANT : If number of tabs - 'TabSet.Tabs' is greater than 20, it will
        cause a problem.  In that case need to increase the size of 'TabSeen'
        array. }
    TabSeen: array[0..20] of Boolean;
  protected
    TabSet: TTabSet;
    procedure Resize; override;
    procedure UMPageChange(var Message: TUMPageChange); message UM_PAGE_CHANGE;
    procedure TabSetDraw(Sender: TObject; TabCanvas: TCanvas; Rect: TRect;
                                            Index: Integer; Selected: Boolean);
    procedure TabSetMeasure(Sender: TObject; Index: Integer; var TabWidth: Integer);
    procedure TabSetClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    procedure PagesUpdate(Pages: TObjectList); override;
    procedure SetPageIndex(Page: Integer); override;
    procedure TabChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
  end;

  { ToWizardPanel }
//  ToWizardPanel = class(ToControlPanel)
//  private
//  protected
//    procedure UMPageChange(var Message: TUMPageChange); message UM_PAGE_CHANGE;
//    procedure Resize; override;
//  public
//    constructor Create(AOwner: TComponent); override;
//    procedure PagesUpdate(Pages: TObjectList); override;
//    procedure SetPageIndex(Page: Integer); override;
//  end;

  { ToTabPanel }
//  ToTabPanel = class(ToControlPanel)
//  private
//    CheckMark: TImage;
//    UITabChange: Boolean;
//    { IMPORTANT : If number of tabs - 'TabSet.Tabs' is greater than 20, it will
//        cause a problem.  In that case need to increase the size of 'TabSeen'
//        array. }
//    TabSeen: array[0..20] of Boolean;
//  protected
//    TabSet: TTabSet;
//    procedure Resize; override;
//    procedure TabSetDraw(Sender: TObject; TabCanvas: TCanvas; Rect: TRect;
//                                            Index: Integer; Selected: Boolean);
//    procedure TabSetMeasure(Sender: TObject; Index: Integer; var TabWidth: Integer);
//    procedure TabSetClick(Sender: TObject);
//  public
//    constructor Create(AOwner: TComponent); override;
//    procedure PagesUpdate(Pages: TObjectList); override;
//    procedure SetPageIndex(Page: Integer); override;
//    procedure TabChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
//  end;

  ToPage = class;

  { ToNotebook }
  ToNotebook = class(TWinControl)
  private
    FPageList: TObjectList;
    FPageIndex: Integer;
    FOnPageChanged: TNotifyEvent;
  protected
    procedure SetPages(Value: TObjectList); virtual;
    procedure SetPageIndex(Value: Integer); virtual;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure ReadState(Reader: TReader); override;
    procedure ShowControl(AControl: TControl); override;
    procedure GetChildren(Proc: TGetChildProc; Root: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function GetPage(Value: Integer): ToPage;
    property Pages: TObjectList read FPageList write FPageList;
  published
    property Align;
    property Color;
    property Ctl3D;
    property DragCursor;
    property DragMode;
    property Font;
    property Enabled;
    property PageIndex: Integer read FPageIndex write SetPageIndex stored False default 0;
    property ParentColor;
    property ParentCtl3D;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
  end;

  { ToPage }
  ToPage = class(TCustomControl)
  private
    FPageControl: ToNotebook;
    procedure WMNCHitTest(var Message: TWMNCHitTest); message WM_NCHITTEST;
    procedure UMPSUDChange(var Message: TUMPSUDChange); message UM_PSUD_CHANGE;
    procedure UMRTTCChange(var Message: TUMRTTCChange); message UM_RTTC_CHANGE;
  protected
    procedure ReadState(Reader: TReader); override;
    procedure Paint; override;
    procedure WMParentNotify(var Message: TWMParentNotify); message WM_PARENTNOTIFY;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property PageControl: ToNotebook read FPageControl write FPageControl;
  published
    property Caption;
    property Height stored False;
    property TabOrder stored False;
    property Visible stored False;
    property Width stored False;
  end;

  type
    TpbFinishEvent = procedure(Sender: TObject; pbFinish: boolean) of Object;
    TpbSaveEvent = procedure(Sender: TObject; AutoSave: boolean) of Object;
    TpbRestoreEvent = procedure(Sender: TObject) of Object;

 { ToForm }
  ToForm = class(ToNotebook)
    procedure FormShow(Sender: TObject);
  private
    FName: TComponentName;    //Make Name ReadOnly
    FCPRSTimeout: TTimer;
    FSaveTimer: TTimer;
    //FBrowseType: TBrowseType;
    FReportOrder: TStringList;
    FReportCollection: TNoteCollection;
    FVersion: string;
    FDisableSplash: Boolean;
    FPopMenu: TPopupMenu;
    FOnpbSave: TpbSaveEvent;
    FOnpbRestore: TpbRestoreEvent;
    FOnpbFinish: TpbFinishEvent;
    FOnpbAccept: TpbFinishEvent;
    procedure SetDisableSplash(Value: Boolean);
    procedure CreateMenu;
//    procedure SetBrowseType(Value: TBrowseType);
    procedure SetNoteCollection(const Value: TNoteCollection);
    procedure WMRButtonDown(var Message: TWMRButtonDown); message WM_RBUTTONDOWN;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    ControlPanel: ToControlPanel;
    procedure SetPages(Value: TObjectList); override;
    procedure SetPageIndex(Value: Integer); override;
    procedure SetupControlPanel;
    procedure SaveActive;
    procedure AutoSaveActive;
    procedure RestoreActive;
    procedure FinishActive;
    procedure AcceptActive;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMCreate(var Message: TWMCreate); message WM_CREATE;
    procedure UMPageChange(var Message: TUMPageChange); message UM_PAGE_CHANGE;
    procedure UMPanel(var Message: TUMPanel); message UM_PANEL;
    procedure Save;
    procedure Finish;
    procedure Cancel;
//    procedure Layout;
    procedure OnResize(Sender: TObject);
    procedure Restore;
    procedure VistASetUp;
    function GenerateNote(bFinishBtn: Boolean): Boolean;
    function Preview(Note: TStringList; bFinishBtn: Boolean): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateControlPanel;
    procedure SyncPageIndex;
    procedure CloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure LockApplication(Sender: TObject);
    procedure OnCPRSTimer(Sender: TObject);
    procedure OnAutoSaveTimer(Sender: TObject);
    procedure ShowAbout(Sender: TObject);
    procedure AddPage;
    procedure DeletePage(Page: ToPage);
    procedure LoadDialogs(Sender: TObject);
  published
    property Name: TComponentName read FName;
    property DisableSplash: Boolean read FDisableSplash write SetDisableSplash default True;
    //property BrowseType: TBrowseType read FBrowseType write SetBrowseType default brTab;
    property ReportOrder: TStringList read FReportOrder write FReportOrder;
    property ReportCollection: TNoteCollection read FReportCollection write SetNoteCollection;
    property OnSave: TpbSaveEvent read  FOnpbSave write FOnpbSave;
    property OnRestore: TpbRestoreEvent read  FOnpbRestore write FOnpbRestore;
    property OnpbFinish: TpbFinishEvent read FOnpbFinish write FOnpbFinish;
    property OnpbAccept: TpbFinishEvent read FOnpbAccept write FOnpbAccept;
    property Version: String read FVersion;
  end;

  { Dialog Custom Form }
  ToCNTDialog = class(TForm)
    private
      FReturnList: TStringList;
      FIEN: string;
    public
      constructor Create(AOwner: TComponent); override;
      destructor Destroy; override;
      procedure Save;
      procedure VistASetUp;
      procedure Show;
      function ShowModal: Integer; override;
      property TmpStrList: TStringList read FReturnList write FReturnList;
      property IEN: string read FIEN write FIEN;
  end;

  TDialogClass = class of ToCNTDialog;

  { Helpers }
  TWinHelper = class Helper for TWinControl
    private
      function GetNote: TNoteItem;
    public
      property NoteItem: TNoteItem read GetNote;
      procedure SetUp;
      procedure DeleteNoteItem;
      //TListbox
      procedure ListBoxGetDialogDBClick(Sender: TObject);
      //TButton
      procedure ButtonGetDialogClick(Sender: TObject);
  end;

  TDisplayDialog = function(Broker: PCPRSComBroker; dlgIEN,dlgName: string): TStringList; stdcall;
  TRegisterDialogs = procedure; stdcall;

  function BuildDiscreetData(AOwner: TComponent; Sender: TObject; Fld: string): TStringList;
  procedure Fill(Sender: TObject; Val,Idx: string; SetUp: Boolean);

  procedure Register;

var
  DialogDLL: THandle;
  DisplayDialog: TDisplayDialog;
  RegisterDialogs: TRegisterDialogs;

implementation

uses
  Consts, frmAbout, frmCPRSTimeout, frmLoad, frmLock, frmNoteRvw, frmReportOrder;

const
  PANEL_BUTTON_HEIGHT_OFFSET = 16;
  F_VERSION = '0.0.2.3';

procedure Register;
begin
  RegisterClass(ToCNTDialog);
  RegisterClass(TNoteCollection);
  RegisterClass(TNoteItem);
  RegisterClasses([ToPage]);
  RegisterComponents('oCNT', [ToForm]);
end;

{------------------------------------------------------------------------------}

{
 ; EXAMPLE ARRAY:
 ; --------------
 ; S^CONTROL^VISTA LABEL 1^SOME VALUE
 ; S^CONTROL^VISTA LABEL 2^SOME OTHER VALUE
 ; M^CONTROL^VISTA LABEL^VALUE 1^INDEX
 ; M^CONTROL^VISTA LABEL^VALUE 2^INDEX
 ; WP^CONTROL^VISTA LABEL^THIS TYPE IS USED MORE FOR A FIELD THAT
 ; WP^CONTROL^VISTA LABEL^CONTAINS A LOT OF TEXT THAT'S MEANT TO BE READ
 ; WP^CONTROL^VISTA LABEL^TOGETHER.
}

// Part of Discreet Saving - Necessary for Restore
function BuildDiscreetData(AOwner: TComponent; Sender: TObject; Fld: string): TStringList;
var
  I,x: Integer;
  Note: TNoteItem;
  sl: TStringList;
begin
  Result := TStringList.Create;
  Result.Clear;

  sl := TStringList.Create;
  try
    if AOwner is ToForm then
    begin
      Note := ToForm(AOwner).FReportCollection.GetItem(TWinControl(Sender));
      if Assigned(Note) then
      sl.AddStrings(Note.VistAConfig);
    end;

    if Sender is TEdit then
    begin
      if ((AOwner is ToForm) and (TEdit(Sender).Text <> sl[0])) then
      Result.Add('S^' + TEdit(Sender).Name + U + Fld + U + TEdit(Sender).Text)
      else Result.Add('S^' + TEdit(Sender).Name + U + Fld + U + TEdit(Sender).Text);
    end
    else if Sender is TLabeledEdit then
    begin
      if ((AOwner is ToForm) and (TLabeledEdit(Sender).Text <> sl[0])) then
      Result.Add('S^' + TLabeledEdit(Sender).Name + U + Fld + U + TLabeledEdit(Sender).Text)
      else Result.Add('S^' + TLabeledEdit(Sender).Name + U + Fld + U + TLabeledEdit(Sender).Text);
    end
    else if Sender is TCheckBox then
    begin
      if TCheckBox(Sender).Checked then
      Result.Add('S^' + TCheckBox(Sender).Name + U + Fld + U + TCheckBox(Sender).Caption)
      else if not TCheckBox(Sender).Checked then
      Result.Add('S^' + TCheckBox(Sender).Name + U + Fld + U);
    end
    else if Sender is TRadioButton then
    begin
      if TRadioButton(Sender).Checked then
      Result.Add('S^' + TRadioButton(Sender).Name + U + Fld + U + TRadioButton(Sender).Caption)
      else if not TRadioButton(Sender).Checked then
      Result.Add('S^' + TRadioButton(Sender).Name + U + Fld + U);
    end
    else if Sender is TRadioGroup then
    begin
      if TRadioGroup(Sender).ItemIndex <> -1 then
      Result.Add('M^' + TRadioGroup(Sender).Name + U + Fld + U + TRadioGroup(Sender).Caption + ' - ' +
                  TRadioGroup(Sender).Items.Strings[TRadioGroup(Sender).ItemIndex] + U + IntToStr(TRadioGroup(Sender).ItemIndex));
    end
    else if Sender is TSpinEdit then
    begin
      if ((AOwner is ToForm) and (TSpinEdit(Sender).Text <> sl[0])) then
      Result.Add('S^' + TSpinEdit(Sender).Name + U + Fld + U + TSpinEdit(Sender).Text)
      else Result.Add('S^' + TSpinEdit(Sender).Name + U + Fld + U + TSpinEdit(Sender).Text);
    end
    else if Sender is TComboBox then
    begin
      if ((AOwner is ToForm) and (TComboBox(Sender).Text <> sl[0])) then
      Result.Add('S^' + TComboBox(Sender).Name + U + Fld + U + TComboBox(Sender).Text)
      else Result.Add('S^' + TComboBox(Sender).Name + U + Fld + U + TComboBox(Sender).Text);
    end
    else if Sender is TListBox then
    begin
      if ((AOwner is ToForm) and (sl.Count = TListBox(Sender).Count)) then
      begin
        for I := 0 to sl.Count - 1 do
        begin
          if Assigned(Note.DialogReturn) then
          begin
            if Piece(sl[I],U,2) <> TListBox(Sender).Items[I] then
            begin
              for x := 0 to TListBox(Sender).Count - 1 do
              Result.Add('M^' + TListBox(Sender).Name + U + Fld + U + TListBox(Sender).Items[x] + U + IntToStr(I));
              Break;
            end;
          end else
          if sl[I] <> TListBox(Sender).Items[I] then
          begin
            for x := 0 to TListBox(Sender).Count - 1 do
            Result.Add('M^' + TListBox(Sender).Name + U + Fld + U + TListBox(Sender).Items[x] + U + IntToStr(I));
            Break;
          end;
        end;
      end else
      begin
        for x := 0 to TListBox(Sender).Count - 1 do
        Result.Add('M^' + TListBox(Sender).Name + U + Fld + U + TListBox(Sender).Items[x] + U + IntToStr(I));
      end;
    end
    else if Sender is TMemo then
    begin
      if ((AOwner is ToForm) and (sl.Count = TMemo(Sender).Lines.Count)) then
      begin
        for I := 0 to sl.Count - 1 do
        if sl[I] <> TMemo(Sender).Lines.Strings[I] then
        begin
          for x := 0 to TMemo(Sender).Lines.Count - 1 do
          Result.Add('WP^' + TMemo(Sender).Name + U + Fld + U + TMemo(Sender).Lines.Strings[x]);
          Break;
        end;
      end else
      begin
        for x := 0 to TMemo(Sender).Lines.Count - 1 do
        Result.Add('WP^' + TMemo(Sender).Name + U + Fld + U + TMemo(Sender).Lines.Strings[x]);
      end;
    end else if Sender is TRichEdit then
    begin
      if ((AOwner is ToForm) and (sl.Count = TRichEdit(Sender).Lines.Count)) then
      begin
        for I := 0 to sl.Count - 1 do
        if sl[I] <> TRichEdit(Sender).Lines.Strings[I] then
        begin
          for x := 0 to TRichEdit(Sender).Lines.Count - 1 do
          Result.Add('WP^' + TRichEdit(Sender).Name + U + Fld + U + TRichEdit(Sender).Lines.Strings[x]);
          Break;
        end;
      end else
      begin
        for x := 0 to TRichEdit(Sender).Lines.Count - 1 do
        Result.Add('WP^' + TRichEdit(Sender).Name + U + Fld + U + TRichEdit(Sender).Lines.Strings[x]);
      end;
    end else if Sender is TJvStringGrid then
    begin
      for I := 0 to TJvStringGrid(Sender).RowCount - 1 do
      for x := 0 to TJvStringGrid(Sender).ColCount - 1 do
      Result.Add('M^' + TJvStringGrid(Sender).Name + U + Fld + U + TJvStringGrid(Sender).Cells[x,I] + U +
                 IntToStr(x) + ',' + IntToStr(I));
    end;
  finally
    sl.Free;
  end;
end;

// Part of Restore and Initial Configuration except TListBox which requires
// some setup to use dialogs
procedure Fill(Sender: TObject; Val,Idx: string; SetUp: Boolean);
begin
  if Val = '' then Exit;

  try
    if Sender is TEdit then
    TEdit(Sender).Text := Val
    else if Sender is TLabeledEdit then
    TLabeledEdit(Sender).Text := Val
    else if Sender is TCheckBox then
    TCheckBox(Sender).Checked := True
    else if Sender is TRadioButton then
    TRadioButton(Sender).Checked := True
    else if Sender is TRadioGroup then
    TRadioGroup(Sender).ItemIndex := StrToInt(Idx)
    else if Sender is TSpinEdit then
    TSpinEdit(Sender).Text := Val
    else if Sender is TComboBox then
    begin
      if SetUp then
      TComboBox(Sender).Items.Add(Val)
      else TComboBox(Sender).Text := Val;
    end
    else if Sender is TListBox then
    TListBox(Sender).Items.Add(Val)
    else if Sender is TMemo then
    TMemo(Sender).Lines.Add(Val)
    else if Sender is TRichEdit then
    TRichEdit(Sender).Lines.Add(Val)
    else if Sender is TJvStringGrid then
    begin
      if StrToInt(Piece(Idx,',',1)) > TJvStringGrid(Sender).ColCount - 1 then
      TJvStringGrid(Sender).InsertCol(StrToInt(Piece(Idx,',',1)));
      if StrToInt(Piece(Idx,',',2)) > TJvStringGrid(Sender).RowCount - 1 then
      TJvStringGrid(Sender).InsertRow(StrToInt(Piece(Idx,',',2)));

      TJvStringGrid(Sender).Cells[StrToInt(Piece(Idx,',',1)), StrToInt(Piece(Idx,',',2))] := Val;
      TJvStringGrid(Sender).AutoSizeCol(StrToInt(Piece(Idx,',',1)), Length(Val), 10);
    end;
  except
  end;
end;

{------------------------------------------------------------------------------}

{$REGION 'ToCNTDialog'}

constructor ToCNTDialog.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FReturnList := TStringList.Create;
end;

destructor ToCNTDialog.Destroy;
begin
  Save;
  FReturnList.Free;
  inherited Destroy;
end;

procedure ToCNTDialog.Save;
var
  Note,Build: TStringList;
  I: Integer;
begin
  if FIEN = '' then
  begin
    try
      RPCBrokerV.SetContext(MENU_CONTEXT);
      FIEN := RPCBrokerV.sCallV('DSIO OCNT DIALOG LOOKUP', [Self.ClassName]);
    except
    end;
  end;

  if ((FIEN <> '') and (FIEN <> '0')) then
  begin
    Note := TStringList.Create;
    for I := 0 to ComponentCount - 1 do
    begin
      Build := TStringList.Create;
      Build := BuildDiscreetData(Self, Components[I], Components[I].Name);
      if Build.Count > 0 then
      Note.AddStrings(Build);

      Build.Free;
    end;

    if Note.Count > 0 then
    begin
      try
        RPCBrokerV.SetContext(MENU_CONTEXT);
        RPCBrokerV.CallV('DSIO OCNT STORE', [RPCBrokerV.TIUNote.IEN, Note, FIEN]);
      except
      end;
    end;
    Note.Free;
  end;
end;

procedure ToCNTDialog.VistASetUp;
var
  sl: TStringList;
  I,x: Integer;
  Control: TComponent;
begin
  if FIEN = '' then
  begin
    //Fine - we'll have an RPC just to lookup the Dialog IEN because some
    //       dialogs use other dialogs and they won't have FIEN set

    RPCBrokerV.SetContext(MENU_CONTEXT);
    FIEN := RPCBrokerV.sCallV('DSIO OCNT DIALOG LOOKUP', [Self.ClassName]);
  end;

  if ((FIEN <> '') and (FIEN <> '0')) then
  begin
    // Populate with Configuration Data
    sl := TStringList.Create;
    try
      for I := 0 to ComponentCount - 1 do
      try
        sl.Clear;

        RPCBrokerV.SetContext(MENU_CONTEXT);
        RPCBrokerV.tCallV(sl, 'DSIO OCNT DIALOG POPULATE', [FIEN, Components[I].Name]);

        if sl.Count > 0 then
        for x := 0 to sl.Count - 1 do
        Fill(Components[I], Piece(sl[x],U,1), Piece(sl[x],U,2), True);

      except
      end;
    finally
      sl.Free;
    end;

    sl := TStringList.Create;
    try
      try
        RPCBrokerV.tCallV(sl, 'DSIO OCNT RESTORE', [RPCBrokerV.TIUNote.IEN, FIEN]);

        if ((sl.Count > 0) and (sl[0] <> '')) then
        if MessageDlg('Values for this dialog exists!' + #10#13 +
                      'If you wish to load them click "Yes."', mtInformation, mbYesNo, 0) = mrYes then
        begin
          for I := 0 to sl.Count - 1 do
          begin
            Control := FindComponent(Piece(sl[I],U,1));
            if Control <> nil then
            Fill(Control, Piece(sl[I],U,2), Piece(sl[I],U,3), False);
          end;
        end;
      except
//        on E: Exception do
//        ShowMessage(E.Message);
      end;
    finally
      sl.Free;
    end;
  end;
end;

procedure ToCNTDialog.Show;
begin
  VistASetUp;
  inherited Show;
end;

function ToCNTDialog.ShowModal: Integer;
begin
  VistASetUp;
  Result := inherited ShowModal;
end;

{$ENDREGION}

{$REGION 'Helpers'}

{ Helper for TWinControl }
procedure TWinHelper.SetUp;
var
  Note: TNoteItem;
begin
  if Self.Parent is ToPage then
  Note := ((Self.Parent as ToPage).Parent as ToForm).ReportCollection.Add(Self);
end;

function TWinHelper.GetNote;
var
  I: Integer;
begin
  Result := nil;
  try
    if RCollection <> nil then
    begin
      for I := 0 to RCollection^.Count - 1 do
      begin
        if RCollection^.Items[I].OwningObject = Self then
        begin
          Result := TNoteItem(RCollection^.Items[I]);
          Break;
        end;
      end;
    end;
  except
  end;
end;

procedure TWinHelper.DeleteNoteItem;
var
  Note: TNoteItem;
begin
  Note := GetNote;
  if Note <> nil then
  if ((csDestroying in ComponentState) and (csDesigning in ComponentState) and
  (csFreeNotification in ComponentState)) then
  Note.Free;
end;

procedure TWinHelper.ListBoxGetDialogDBClick(Sender: TObject);
var
  Note: TNoteItem;
  sl: TStringList;
  Form: ToForm;
  I: Integer;
begin
  inherited;
  if not (Sender is TListBox) then Exit;
  if TListBox(Sender).ItemIndex = -1 then Exit;

  Note := GetNote;
  if Note = nil then Exit;

  if DialogDLL <> 0 then
  begin
    for I := 0 to Note.VistAConfig.Count - 1 do
    if TListBox(Sender).Items[TListBox(Sender).ItemIndex] = Piece(Note.VistAConfig[I],U,2) then
    begin
      sl := TStringList.Create;
      try
        try
          sl.AddStrings(DisplayDialog(@RPCBrokerV, Piece(Note.VistAConfig[I],U,1), Piece(Note.VistAConfig[I],U,3)));
          if Note.DialogReturn is TMemo then
          TMemo(Note.DialogReturn).Lines.AddStrings(sl)
          else
          if Note.DialogReturn is TRichEdit then
          TRichEdit(Note.DialogReturn).Lines.AddStrings(sl);
        except
          on E: Exception do
          ShowMessage(E.Message);
        end;
      finally
        sl.Free;
      end;
      Break;
    end;
  end;
end;

procedure TWinHelper.ButtonGetDialogClick(Sender: TObject);
var
  Note: TNoteItem;
  sl: TStringList;
begin
  inherited;
  if not (Sender is TButton) then Exit;

  Note := GetNote;
  if Note = nil then Exit;

  if DialogDLL <> 0 then
  begin
    sl := TStringList.Create;
    try
      try
        sl.AddStrings(DisplayDialog(@RPCBrokerV, Piece(Note.VistAConfig[0],U,1), Piece(Note.VistAConfig[0],U,3)));
        if Note.DialogReturn is TMemo then
        TMemo(Note.DialogReturn).Lines.AddStrings(sl)
        else
        if Note.DialogReturn is TRichEdit then
        TRichEdit(Note.DialogReturn).Lines.AddStrings(sl);
      except
        on E: Exception do
        ShowMessage(E.Message);
      end;
    finally
      sl.Free;
    end;
  end;
end;

{$ENDREGION}

{$REGION 'ToPanel'}

{ ToPanel }
procedure ToPanel.Paint;
begin
  Caption := '';
  inherited Paint;
end;

{$ENDREGION}

{$REGION 'ToPageIndicator'}

{ ToPageIndicator }
constructor ToPageIndicator.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  BevelOuter := bvNone;
  BorderStyle := bsSingle;
  TabStop := TRUE;
end;

procedure ToPageIndicator.PagesUpdate(Pages: TObjectList);
begin
  PageCount := Pages.Count;
  Caption := IntToStr(CurrentPage) + ' of ' + IntToStr(PageCount);
end;

procedure ToPageIndicator.SetPageIndex(PageIndex: Integer);
begin
  CurrentPage := PageIndex + 1;
  Caption := IntToStr(CurrentPage) + ' of ' + IntToStr(PageCount);
end;

function ToPageIndicator.GetCurrentPage: Integer;
begin
  Result := CurrentPage;
end;

function ToPageIndicator.GetPageCount: Integer;
begin
  Result := PageCount;
end;

{$ENDREGION}

{$REGION 'ToButtonPanel'}

{ ToButtonPanel }
constructor ToButtonPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
//  LayoutButton := CreateButton('&Layout');
  SaveButton := CreateButton('&Save');
  PreviewButton := CreateButton('Pre&view');
  CancelButton := CreateButton('&Cancel');
  FinishButton := CreateButton('&Finish');
  BevelInner := bvNone;
  BorderStyle := bsSingle;
  BevelWidth := 1;
  Align := alClient;
end;

procedure ToButtonPanel.ButtonClick(Sender: TObject);
begin
  {if Sender = LayoutButton then
  PanelMessage(pnLayout)
  else} if Sender = SaveButton then
  PanelMessage(pnSave)
  else if Sender = PreviewButton then
  PanelMessage(pnPreview)
  else if Sender = CancelButton then
  PanelMessage(pnCancel)
  else if Sender = FinishButton then
  PanelMessage(pnFinish);
end;

function ToButtonPanel.PanelMessage(Msg: TPanelOps): TUMPanel;
var
  Message: TUMPanel;
begin
  Message.PanelOp := Word(Msg);
  Message.Result := Parent.Perform(UM_PANEL, Message.wParam, Message.lParam);
  Result := Message;
end;

procedure ToButtonPanel.Resize;
var
  ButtonWidth, ButtonHeight, ButtonLeft: Integer;
  ButtonTop, I: Integer;
begin
  SetBounds(1, 1, Parent.ClientWidth - 2,
            Font.Size * Font.PixelsPerInch div 72 + PANEL_BUTTON_HEIGHT_OFFSET - 2);
  if ControlCount > 0 then
  begin
    ButtonWidth := (ClientWidth - ControlCount) div ControlCount;
    ButtonHeight := ClientHeight - 2;
    ButtonTop := 1;

    for I := 0 to ControlCount - 1 do
    begin
      if I = 0 then
      ButtonLeft := 1
      else
      ButtonLeft := Controls[I - 1].Left + Controls[I - 1].Width + 1;

      if I = ControlCount - 1 then { make up for slack to right }
      ButtonWidth := Parent.ClientWidth - ButtonLeft - 3;

      Controls[I].SetBounds(ButtonLeft, ButtonTop, ButtonWidth, ButtonHeight);
    end;
  end;
end;

function ToButtonPanel.CreateButton(Value: String) : TBitBtn;
begin
  Result := TBitBtn.Create(Self);
  Result.Caption := Value;
  Result.OnClick := ButtonClick;
  Result.Visible := True;
  Result.Enabled := True;
  Result.Parent := Self;
end;

{$ENDREGION}

{$REGION 'ToWizardButtonPanel'}

{ ToWizardButtonPanel }
constructor ToWizardButtonPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  PrevButton := CreateButton('&Prev');
  PageIndicator := CreateIndicator;
  NextButton := CreateButton('&Next');
end;

procedure ToWizardButtonPanel.PagesUpdate(Pages: TObjectList);
begin
  PageIndicator.PagesUpdate(Pages);
  DisableButtons;
end;

procedure ToWizardButtonPanel.SetPageIndex(PageIndex: Integer);
begin
  PageIndicator.SetPageIndex(PageIndex);
  DisableButtons;
end;

{ Disable NextButton if the page is at the last-page and disable PrevButton if
  the page is at the first-page. }
procedure ToWizardButtonPanel.DisableButtons;
begin
  if not (csDesigning in ComponentState) then
  begin
    if (PageIndicator.GetCurrentPage = PageIndicator.GetPageCount) then
    NextButton.Enabled := False
    else
    NextButton.Enabled := True;

    if (PageIndicator.GetCurrentPage = 1) then
    PrevButton.Enabled := False
    else
    PrevButton.Enabled := True;
  end;
end;

procedure ToWizardButtonPanel.ButtonClick(Sender: TObject);
var
  Message: TUMPageChange;
begin
  if Sender = PrevButton then
  begin
    { Perform page changes. }
    Message.PageOp := Word(poPrev);
    Message.Result := Parent.Perform(UM_PAGE_CHANGE, Message.wParam, Message.lParam);
    PageIndicator.SetPageIndex(Message.NewPage);
    DisableButtons;
  end
  else if Sender = NextButton then
  begin
    { Perform page changes. }
    Message.PageOp := Word(poNext);
    Message.Result := Parent.Perform(UM_PAGE_CHANGE, Message.wParam, Message.lParam);
    PageIndicator.SetPageIndex(Message.NewPage);
    DisableButtons;
  end
  else
  inherited ButtonClick(Sender);
end;

function ToWizardButtonPanel.CreateIndicator: ToPageIndicator;
begin
  Result := ToPageIndicator.Create(Self);
  Result.Visible := True;
  Result.Enabled := True;
  Result.Parent := Self;
end;

{$ENDREGION}

{$REGION 'ToControlPanel'}

{ ToControlPanel }
constructor ToControlPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Align := alBottom;
  BevelOuter := bvNone;
end;

procedure ToControlPanel.UMPanel(var Message: TUMPanel);
begin
  Message.Result := Parent.Perform(UM_PANEL, Message.wParam, Message.lParam);
end;

{$ENDREGION}

{$REGION 'ToTabButtonPanel'}

{ ToTabButtonPanel }
constructor ToTabButtonPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

{$ENDREGION}

{$REGION 'ToCombinePanel'}

{ ToCombinePanel }
constructor ToCombinePanel.Create(AOwner: TComponent);
begin
  UITabChange := True;
  inherited Create(AOwner);

  ButtonTabPanel := ToTabButtonPanel.Create(Self);
  ButtonWizPanel := ToWizardButtonPanel.Create(Self);
  ButtonTabPanel.Visible := True;
  ButtonWizPanel.Visible := True;
  ButtonTabPanel.Enabled := True;
  ButtonWizPanel.Enabled := True;
  ButtonTabPanel.Parent := Self;
  ButtonWizPanel.Parent := Self;

  TabSet := TTabSet.Create(Self);
  TabSet.Visible := True;
  TabSet.Enabled := True;
  TabSet.Parent := Self;
  TabSet.Align := alTop;
  TabSet.OnChange := TabChange;
  TabSet.OnClick := TabSetClick;
  TabSet.OnMeasureTab := TabSetMeasure;
  TabSet.OnDrawTab := TabSetDraw;
  TabSet.Style := tsOwnerDraw;

  if (csDesigning in ComponentState) then
  ControlStyle := ControlStyle - [csAcceptsControls];

  CheckMark := TImage.Create(AOwner);
  CheckMark.Autosize := True;
  CheckMark.Visible := True;
  CheckMark.Picture.Create;
  CheckMark.Picture.Bitmap.Create;
  CheckMark.Picture.Bitmap.Handle := LoadBitmap(HInstance, PChar('CHECKBMP'));
end;

procedure ToCombinePanel.TabSetClick(Sender: TObject);
begin
  TabSeen[TabSet.TabIndex] := True;
end;

procedure ToCombinePanel.TabSetDraw(Sender: TObject; TabCanvas: TCanvas; Rect: TRect;
                                            Index: Integer; Selected: Boolean);
var
  Bitmap: TBitmap;
begin
  if Index >= TabSet.Tabs.Count then
  Exit;
  with TabCanvas do	                             { draw on the control canvas, not on the form }
  begin
    FillRect(Rect);	                             { clear the rectangle }

    if not (csDesigning in ComponentState) then
    begin
      if TabSeen[Index] then
      Bitmap := TBitmap(TabSet.Tabs.Objects[Index])
      else
      Bitmap := TBitmap.Create;

      if Bitmap <> nil then
      begin
        BrushCopy(Bounds(Rect.Left + 4, Rect.Top + 4, Bitmap.Width, Bitmap.Height), Bitmap,
            Bounds(0, 0, Bitmap.Width, Bitmap.Height), clRed);	{ render the bitmap }
      end;
    end;

    TextOut(Rect.Left + 5, Rect.Top + 2, TabSet.Tabs.Strings[Index])	{ display the text }
  end;
end;

procedure ToCombinePanel.TabSetMeasure(Sender: TObject; Index: Integer; var TabWidth: Integer);
var
  TempBitmap: TBitmap;
  BitmapWidth: Integer;
begin
  if Index >= TabSet.Tabs.Count then
  Exit;

  TempBitmap := TBitMap.Create;
  TempBitmap := CheckMark.Picture.Bitmap;
  TabSet.Tabs.Objects[Index] := TempBitmap;

  BitmapWidth := TBitmap(TabSet.Tabs.Objects[Index]).Width;
  Inc(TabWidth, 10 + BitmapWidth);
end;

procedure ToCombinePanel.PagesUpdate(Pages: TObjectList);
var
  I: Integer;
begin
  UITabChange := False;

  TabSet.Tabs.Clear;
  for I := 0 to Pages.Count - 1 do
  TabSet.Tabs.Add(ToPage(Pages.Items[I]).Caption);

  UITabChange := True;

  ToWizardButtonPanel(ButtonWizPanel).PagesUpdate(Pages);
end;

procedure ToCombinePanel.SetPageIndex(Page: Integer);
begin
  UITabChange := False;

  if (Page >= 0) and (Page < TabSet.Tabs.Count) then
  TabSet.TabIndex := Page;

  UITabChange := True;

  ToWizardButtonPanel(ButtonWizPanel).SetPageIndex(Page);
end;

procedure ToCombinePanel.TabChange(Sender: TObject; NewTab: Integer; var AllowChange: Boolean);
var
  Message: TUMPageChange;
begin
  AllowChange := True;
  if UITabChange then
  begin
    { Perform page changes. }
    Message.PageOp := Word(poAbs);
    Message.Page := Word(NewTab);
    Parent.Perform(UM_PAGE_CHANGE, Message.wParam, Message.lParam);
  end;
end;

procedure ToCombinePanel.Resize;
begin
  Height := Font.Size * Font.PixelsPerInch div 72 + PANEL_BUTTON_HEIGHT_OFFSET + TabSet.Height;
  ButtonTabPanel.Resize;
  ButtonWizPanel.Resize;
end;

procedure ToCombinePanel.UMPageChange(var Message: TUMPageChange);
begin
  Message.Result := Parent.Perform(UM_PAGE_CHANGE, Message.wParam, Message.lParam);
end;

{ ToWizardPanel }
//constructor ToWizardPanel.Create(AOwner: TComponent);
//begin
//  inherited Create(AOwner);
//  ButtonPanel := ToWizardButtonPanel.Create(Self);
//  ButtonPanel.Visible := True;
//  ButtonPanel.Enabled := True;
//  ButtonPanel.Parent := Self;
//
//  if (csDesigning in ComponentState) then
//  ControlStyle := ControlStyle - [csAcceptsControls];
//end;

//procedure ToWizardPanel.PagesUpdate(Pages: TObjectList);
//begin
//  ToWizardButtonPanel(ButtonPanel).PagesUpdate(Pages);
//end;

//procedure ToWizardPanel.SetPageIndex(Page: Integer);
//begin
//  ToWizardButtonPanel(ButtonPanel).SetPageIndex(Page);
//end;

//procedure ToWizardPanel.Resize;
//begin
//  Height := Font.Size * Font.PixelsPerInch div 72 + PANEL_BUTTON_HEIGHT_OFFSET;
//  ButtonPanel.Resize;
//end;

{$ENDREGION}

{$REGION 'ToPage'}

{ ToPage }
constructor ToPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  ControlStyle := ControlStyle + [csAcceptsControls];
  Visible := False;
  Align := alClient;
end;

destructor ToPage.Destroy;
begin
  if FPageControl = nil then
  begin
    inherited Destroy;
    Exit;
  end;

  ToForm(FPageControl).DeletePage(Self);
end;

procedure ToPage.WMParentNotify(var Message: TWMParentNotify);
var
  NewControl: TWinControl;
begin
  inherited;
  if (csDesigning in ComponentState) and (not (csLoading in ComponentState)) then
  begin
    if Message.Event = WM_CREATE then
    begin
      NewControl := FindControl(Message.ChildWnd);
      if NewControl <> nil then
      NewControl.SetUp;
    end
    else if Message.Event = WM_DESTROY then
    begin
      NewControl := FindControl(Message.ChildWnd);
      if NewControl <> nil then
      NewControl.DeleteNoteItem;
    end;
  end;
end;

procedure ToPage.WndProc(var Message: TMessage);
var
  PNMsg: TWMParentNotify;
begin
  inherited;
  if TWMParentNotify(Message).Msg = WM_PARENTNOTIFY then
  begin
    PNMsg.Msg := Message.Msg;
    PNMsg.Event := Message.WParamLo;
    PNMsg.ChildID := Message.WParamHi;
    PNMsg.ChildWnd := Message.LParam;
    Dispatch(PNMsg);
  end;
end;

procedure ToPage.Paint;
begin
  inherited Paint;
  if csDesigning in ComponentState then
  with Canvas do
  begin
    Pen.Style := psDash;
    Brush.Style := bsClear;
    Rectangle(0, 0, Width, Height);
  end;
end;

procedure ToPage.ReadState(Reader: TReader);
var
  OldOwner: TComponent;
begin
  if Reader.Parent is ToNotebook then
  ToNotebook(Reader.Parent).FPageList.Add(Self);

  OldOwner := Reader.Owner;
  Reader.Owner := Reader.Root;
  try
    inherited ReadState(Reader);
  finally
    Reader.Owner := OldOwner;
  end;
end;

procedure ToPage.WMNCHitTest(var Message: TWMNCHitTest);
begin
  if not (csDesigning in ComponentState) then
  Message.Result := HTTRANSPARENT
  else
  inherited;
end;

procedure ToPage.UMPSUDChange(var Message: TUMPSUDChange);
begin
  if Parent <> nil then
  Parent.Perform(UM_PSUD_CHANGE, 0, 0);
end;

procedure ToPage.UMRTTCChange(var Message: TUMRTTCChange);
begin
  if Parent <> nil then
  Parent.Perform(UM_RTTC_CHANGE, 0, 0);
end;

{$ENDREGION}

{$REGION 'ToNotebook'}

{ ToNotebook }
constructor ToNotebook.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  FPageList := TObjectList.Create;
  FPageList.OwnsObjects := False;
  FPageIndex := -1;

  Classes.RegisterClasses([ToPage]);
end;

destructor ToNotebook.Destroy;
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do
  ToPage(FPageList[I]).FPageControl := nil;

  FPageList.Free;
  inherited Destroy;
end;

procedure ToNotebook.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  with Params do
  Style := Style or WS_CLIPCHILDREN;
end;

procedure ToNotebook.ReadState(Reader: TReader);
var
  OldOwner: TComponent;
begin
  OldOwner := Reader.Owner;
  Reader.Owner := Self;
  try
    inherited ReadState(Reader);
  finally
    Reader.Owner := OldOwner;
  end;
  if FPageList.Count > 0 then
  begin
    with ToPage(FPageList[0]) do
    begin
      BringToFront;
      Visible := True;
      Align := alClient;
    end;
  end else FPageIndex := -1;
end;

procedure ToNotebook.ShowControl(AControl: TControl);
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do
  if FPageList.Items[I] = AControl then
  begin
    SetPageIndex(I);
    Exit;
  end;
  inherited ShowControl(AControl);
end;

procedure ToNotebook.GetChildren(Proc: TGetChildProc; Root: TComponent);
var
  I: Integer;
begin
  for I := 0 to FPageList.Count - 1 do
  Proc(TControl(FPageList[I]));
end;

procedure ToNotebook.SetPages(Value: TObjectList);
begin
  FPageList.Assign(Value);
end;

procedure ToNotebook.SetPageIndex(Value: Integer);
var
  ParentForm: TCustomForm;
begin
  if csLoading in ComponentState then
  begin
    FPageIndex := Value;
    Exit;
  end;
  if (Value <> FPageIndex) and (Value >= 0) and (Value < FPageList.Count) then
  begin
    ParentForm := GetParentForm(Self);

    if ParentForm <> nil then
    begin
      if ContainsControl(ParentForm.ActiveControl) then
      ParentForm.ActiveControl := Self;
    end;

    with ToPage(FPageList[Value]) do
    begin
      BringToFront;
      Visible := True;
      Align := alClient;
    end;

    if (FPageIndex >= 0) and (FPageIndex < FPageList.Count) then
    ToPage(FPageList[FPageIndex]).Visible := False;

    FPageIndex := Value;
    if ParentForm <> nil then
    begin
      if ParentForm.ActiveControl = Self then
      SelectFirst;
    end;

    if Assigned(FOnPageChanged) then
    FOnPageChanged(Self);
  end;
end;

function ToNotebook.GetPage(Value: Integer): ToPage;
begin
  Result := ToPage(FPageList.Items[Value]);
end;

{$ENDREGION}

{$REGION 'ToForm'}

{ ToForm }
procedure ToForm.ShowAbout(Sender: TObject);
begin
  CNTAbout.ShowModal;
end;

procedure ToForm.AddPage;
var
  Page: ToPage;
  Form: TCustomForm;
begin
  Page := ToPage.Create(Self);

  with Page do
  begin
    Name := 'Page' + IntToStr(FPageList.Count + 1);
    Parent := Self;
    FPageControl := Self;
  end;

  FPageList.Add(Page);
  PageIndex := FPageList.IndexOf(Page);

  UpdateControlPanel;

  if csDesigning in ComponentState then
  begin
    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.Designer <> nil) then
    Form.Designer.Modified;
  end;

  if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
  begin
    keybd_event(VK_MENU, 0, 0 ,0);
    keybd_event(VK_F12, 0, 0 ,0);
    keybd_event(VK_F12, 0, KEYEVENTF_KEYUP,0);
    keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP,0);

    keybd_event(VK_MENU, 0, 0 ,0);
    keybd_event(VK_F12, 0, 0 ,0);
    keybd_event(VK_F12, 0, KEYEVENTF_KEYUP,0);
    keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP,0);
  end;
end;

procedure ToForm.DeletePage(Page: ToPage);
var
  Form: TCustomForm;
begin
  FPageList.Delete(FPageList.IndexOf(Page));
  PageIndex := 0;

  Page.FPageControl := nil;
  Page.Free;

  UpdateControlPanel;

  if csDesigning in ComponentState then
  begin
    Form := GetParentForm(Self);
    if (Form <> nil) and (Form.Designer <> nil) then
    Form.Designer.Modified;
  end;

  if (csDesigning in ComponentState) and not (csLoading in ComponentState) then
  begin
    keybd_event(VK_MENU, 0, 0 ,0);
    keybd_event(VK_F12, 0, 0 ,0);
    keybd_event(VK_F12, 0, KEYEVENTF_KEYUP,0);
    keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP,0);

    keybd_event(VK_MENU, 0, 0 ,0);
    keybd_event(VK_F12, 0, 0 ,0);
    keybd_event(VK_F12, 0, KEYEVENTF_KEYUP,0);
    keybd_event(VK_MENU, 0, KEYEVENTF_KEYUP,0);
  end;
end;

procedure ToForm.LoadDialogs(Sender: TObject);
var
  Path: string;
  PathLen,I: Integer;
begin
  if not (csDesigning in ComponentState) then
  begin
    Path := ExtractFilePath(GetModuleName(HInstance));

    if FileExists(Path + 'oCNTDialogs.dll') then
    Path := Path + 'oCNTDialogs.dll'
    else if DirectoryExists(Path + 'Extensions\') then
    Path := Path + 'Extensions\oCNTDialogs.dll'
    else
    begin
      Path := ExtractFileDir(GetModuleName(HInstance));
      PathLen := Length(Path);
      for I := PathLen downto 1 do
      begin
        if ((Path[I] = ':') or (Path[I] = '\')) then
        Break
        else
        Delete(Path,I,Length(Path));
      end;
      Path := Path + 'Extensions\oCNTDialogs.dll';
    end;

    if DialogDLL <> 0 then
    begin
      try
        FreeLibrary(DialogDLL);
      except
      end;
    end;

    try
      DialogDLL := SafeLoadLibrary(Path);
    except
    end;

    if DialogDLL <> 0 then
    begin
      RegisterDialogs := GetProcAddress(DialogDLL, 'RegisterDialogs');
      RegisterDialogs;
      DisplayDialog := GetProcAddress(DialogDLL, 'DisplayDialog');
    end
    else ShowMessage('Unable to load oCNTDialogs.dll.');
  end;
end;

constructor ToForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  CreateMenu;
  SetupControlPanel;
  FReportCollection := TNoteCollection.Create(Self, TNoteItem);
  RCollection := @FReportCollection;

  if Owner is TForm then
  begin
    TForm(Owner).OnCloseQuery := CloseQuery;
    TForm(Owner).OnResize := OnResize;
    TForm(Owner).OnShow := FormShow;
  end;

  FVersion := F_VERSION;
  Align := alClient;
  FDisableSplash := False;
  Font.Name := 'MS Sans Serif';

//  FCPRSTimeout := TTimer.Create(Self);
//  FCPRSTimeout.Name := 'CPRSTimer';
//  FCPRSTimeout.Interval := 15000;
//  FCPRSTimeout.OnTimer := OnCPRSTimer;

  FSaveTimer := TTimer.Create(Self);
  FSaveTimer.Name := 'AutoSaveTimer';
  FSaveTimer.Interval := 60000;
  FSaveTimer.OnTimer := OnAutoSaveTimer;

  CNTAbout := TCNTAbout.Create(Self);
  CNTLock := TCNTLock.Create(Self);

  if not (csDesigning in ComponentState) then
  begin
//    FCPRSTimeout.Enabled := True;
    FSaveTimer.Enabled := False;
  end;
end;

procedure ToForm.FormShow(Sender: TObject);
begin
  if not (csDesigning in ComponentState) then
  begin
//    try
//      RPCBrokerV.SetContext(MENU_CONTEXT);
//      SetBrowseType(TBrowseType(GetEnumValue(TypeInfo(TBrowseType), 'br' +
//                    RPCBrokerV.sCallV('DSIO GET PARAMETER VALUE', ['DSIO OCNT TAB TYPE']))));
//    except
//      SetBrowseType(brTab);
//    end;

    if ((PageIndex < 0) and (FPageList.Count > 0)) then
    FPageIndex := 0;

    ControlPanel.PagesUpdate(FPageList);
    ControlPanel.SetPageIndex(FPageIndex);

    LoadDialogs(Self);   //load the oCNTDialogs.dll

    //Populate From VistA from DSIO OCNT CONFIGURATION
    VistASetUp;

    Restore;
  end;
end;

procedure ToForm.VistASetUp;
var
  I: Integer;

  procedure Pop(AComponent: TComponent);
  var
    sl: TStringList;
    I: Integer;
    NItem: TNoteItem;
  begin
    sl := TStringList.Create;
    try
      try
        sl.Clear;

        RPCBrokerV.SetContext(MENU_CONTEXT);
        RPCBrokerV.tCallV(sl, 'DSIO OCNT POPULATE', [RPCBrokerV.TIUNote.IEN, AComponent.Name]);

        if sl.Count > 0 then
        begin
          NItem := FReportCollection.GetItem(AComponent.Name);
          if Assigned(NItem) then
          begin
            NItem.VistAConfig.AddStrings(sl);

            if NItem.DialogReturn <> nil then
            begin
              if AComponent is TListBox then
              begin
                TListBox(AComponent).Clear;
                TListBox(AComponent).OnDblClick := TListBox(AComponent).ListBoxGetDialogDBClick;

                for I := 0 to sl.Count - 1 do
                TListBox(AComponent).Items.Add(Piece(sl[I],U,2));
              end
              else if AComponent is TButton then
              TButton(AComponent).OnClick := TButton(AComponent).ButtonGetDialogClick
              else
              begin
                for I := 0 to sl.Count - 1 do
                Fill(AComponent, Piece(sl[I],U,1), Piece(sl[I],U,2), True);
              end;
            end else
            begin
              for I := 0 to sl.Count - 1 do
              Fill(AComponent, Piece(sl[I],U,1), Piece(sl[I],U,2), True);
            end;
          end;
        end;
      except
//        on E: Exception do
//        ShowMessage('Unable to populate the Control: ' + AComponent.Name);
      end;
    finally
      sl.Free;
    end;
  end;

begin
  if not (csDesigning in ComponentState) then
  begin
    if Owner is TForm then
    begin
      for I := 0 to TForm(Owner).ComponentCount - 1 do
      Pop(TForm(Owner).Components[I]);
    end;
  end;
end;

procedure ToForm.SetupControlPanel;
begin
//  case FBrowseType of
//    brWizard : ControlPanel := ToWizardPanel.Create(Self);
//    brTab : ControlPanel := ToTabPanel.Create(Self);
//  end;
  ControlPanel := ToCombinePanel.Create(Self);
  ControlPanel.Visible := True;
  ControlPanel.Enabled := True;
  ControlPanel.Parent := Self;
end;

//procedure ToForm.SetBrowseType(Value: TBrowseType);
//begin
//  if (Value <> FBrowseType) then
//  begin
//    FBrowseType := Value;
//    ControlPanel.Free;
//    SetupControlPanel;
//    ControlPanel.Resize;
//    ControlPanel.PagesUpdate(Pages);
//    ControlPanel.SetPageIndex(PageIndex);
//  end;
//end;

procedure ToForm.CMTextChanged(var Message: TMessage);
begin
  inherited;
  // FName is just to make the name property readonly and show the name
  // SetName is what really changes the component's name
  // We need to force the name to this so that the COMObject can control the
  // component and handle the broker.
  // This also ensures that only one ToForm exists on a form.
  FName := 'ofrm1';
  SetName('ofrm1');
end;

//procedure ToForm.Layout;
//begin
//  if ((PageIndex < 0) and (FPageList.Count > 0)) then
//  FPageIndex := 0;
//
//  if BrowseType = brTab then
//  begin
//    BrowseType := brWizard;
//
//    ToWizardButtonPanel(ControlPanel.ButtonPanel).PageIndicator.SetPageIndex(FPageIndex);
//    ToWizardButtonPanel(ControlPanel.ButtonPanel).DisableButtons;
//  end
//  else
//  BrowseType := brTab;
//
//  ControlPanel.PagesUpdate(FPageList);
//  ControlPanel.SetPageIndex(FPageIndex);
//
//  try
//    RPCBrokerV.SetContext(MENU_CONTEXT);
//    RPCBrokerV.CallV('DSIO GET PARAMETER VALUE', ['DSIO OCNT TAB TYPE',
//                     GetEnumName(TypeInfo(TBrowseType),Integer(BrowseType))]);
//  except
//  end;
//end;

procedure ToForm.OnResize(Sender: TObject);
begin
  ControlPanel.Resize;
end;

procedure ToForm.SetNoteCollection(const Value: TNoteCollection);
begin
  FReportCollection.Assign(Value);
end;

procedure ToForm.WMRButtonDown(var Message: TWMRButtonDown);
var
  ScreenPoint: TPoint;
begin
  if Windows.GetCursorPos(ScreenPoint) then
  FPopMenu.Popup(ScreenPoint.X, ScreenPoint.Y);

  inherited;
end;

procedure ToForm.SetDisableSplash(Value: Boolean);
begin
  FDisableSplash := Value;

  if Value = False then
  if not (csDesigning in ComponentState) then
  begin
    { Before form is visible, show load logo. }
    if FDisableSplash = False then
    begin
      CNTSplash := TCNTSplash.Create(Application);
      CNTSplash.Show;
      CNTSplash.Update;
      Sleep(1000);
      CNTSplash.Free;
    end;
  end;
end;

procedure ToForm.CreateMenu;
var
  MenuItem: TMenuItem;
begin
  FPopMenu := TPopupMenu.Create(Self);
  FPopMenu.AutoPopup := False;
  try
    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := 'Load Dialog DLL';
    MenuItem.OnClick := Self.LoadDialogs;
    FPopMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := '-';
    FPopMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := 'Lock VISTA Application';
    MenuItem.OnClick := LockApplication;
    FPopMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := '-';
    FPopMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := 'About';
    MenuItem.OnClick := Self.ShowAbout;
    FPopMenu.Items.Add(MenuItem);

    MenuItem := TMenuItem.Create(Self);
    MenuItem.Caption := '';
    FPopMenu.Items.Add(MenuItem);
  finally
    MenuItem.Free;
  end;
end;

procedure ToForm.LockApplication(Sender: TObject);
var
  this: HWND;
begin
  TForm(Owner).WindowState := wsMinimized;
  if RPCBrokerV.CPRSHandle <> 0 then
  begin
    this := Application.Handle;
    Application.Handle := RPCBrokerV.CPRSHandle;
    Application.Minimize;
    Application.Handle := this;
  end;
  try
    CNTLock.ShowModal;
  finally
    if RPCBrokerV.CPRSHandle <> 0 then
    begin
      this := Application.Handle;
      Application.Handle := RPCBrokerV.CPRSHandle;
      Application.Restore;
      Application.Handle := this;
    end;
    TForm(Owner).WindowState := wsNormal;
    TForm(Owner).BringToFront;
  end;
end;

procedure ToForm.SetPages(Value: TObjectList);
begin
  inherited SetPages(Value);
  UpdateControlPanel;
end;

procedure ToForm.UpdateControlPanel;
begin
  ControlPanel.PagesUpdate(Pages);
  ControlPanel.SetPageIndex(PageIndex);
end;

procedure ToForm.SyncPageIndex;
begin
  ControlPanel.SetPageIndex(PageIndex);
end;

procedure ToForm.SetPageIndex(Value: Integer);
begin
  inherited SetPageIndex(Value);
  if (ControlPanel <> nil) then
  ControlPanel.SetPageIndex(PageIndex);
end;

procedure ToForm.SaveActive;
begin
  if Assigned(FOnpbSave) then
  FOnpbSave(Self, False);
end;

procedure ToForm.AutoSaveActive;
begin
  if Assigned(FOnpbSave) then
  FOnpbSave(Self, True);
end;

procedure ToForm.OnCPRSTimer(Sender: TObject);
{ Checks to see if the CPRS timeout window is available, if so inform the user }
var
  wnd: HWND;
  CPRSTimeOut: TCPRSTimeOut;
begin
  FCPRSTimeout.Enabled := False;
  wnd := FindWindow( nil, pchar('CPRS Timeout'));
  if wnd <> 0 then
  begin
    CPRSTimeOut := TCPRSTimeOut.Create(nil);

    if CPRSTimeOut.ShowModal = mrOK then
    begin
      CPRSTimeOut.Free;
      PostQuitMessage(0);
    end;
    CPRSTimeOut.Free;
  end;
  FCPRSTimeout.Enabled := True;
end;

procedure ToForm.OnAutoSaveTimer(Sender: TObject);
begin
//  Save;
end;

procedure ToForm.RestoreActive;
begin
  if Assigned(FOnpbRestore) then
  FOnpbRestore(Self);
end;

procedure ToForm.FinishActive;
var
  pbFinish: boolean;
begin
  if Assigned(FOnpbFinish) then
  FOnpbFinish(Self, pbFinish);
end;

procedure ToForm.AcceptActive;
var
  pbAccept: boolean;
begin
  if Assigned(FOnpbAccept) then
  FOnpbAccept(Self, pbAccept);
end;

procedure ToForm.WMSize(var Message: TWMSize);
begin
  inherited;
  ControlPanel.Resize;
end;

procedure ToForm.WMCreate(var Message: TWMCreate);
var
  FillRect: TRect;
begin
  if (csDesigning in ComponentState) and (not (csReading in ComponentState)) then
  begin
    FillRect := Parent.ClientRect;
    SetBounds(0, 0, FillRect.Right, FillRect.Bottom);
  end;
  inherited;
  ControlPanel.PagesUpdate(Pages);
  ControlPanel.SetPageIndex(PageIndex);
end;

procedure ToForm.UMPageChange(Var Message: TUMPageChange);
begin
  case TPageOps(Message.PageOp) of
    poNext : begin
               if PageIndex < Pages.Count - 1 then
               PageIndex := PageIndex + 1;
               Message.NewPage := Word(PageIndex);
             end;
    poPrev : begin
               if PageIndex > 0 then
               PageIndex := PageIndex - 1;
               Message.NewPage := Word(PageIndex);
             end;
    poAbs  : begin
               PageIndex := Integer(Message.Page);
             end;
  end;
end;

procedure ToForm.UMPanel(var Message: TUMPanel);
begin
  try
    case TPanelOps(Message.PanelOp) of
//      pnLayout : Layout;
      pnSave : Save;
      pnPreview : GenerateNote(False); { Don't generate note file - just preview }
      pnCancel : Cancel;
      pnFinish : Finish;
    end;
  except
  end;
end;

procedure ToForm.CloseQuery(Sender: TObject; var CanClose: Boolean);
var
  sBxMsg: string;
begin
  sBxMsg := 'Are you sure you want to exit?';
  if MessageDlg(sBxMsg,mtconfirmation,[mbYes,mbNo],0) = mrYes then
  begin
    Save;
    CanClose := True;
  end else CanClose := False;
end;

procedure ToForm.Cancel;
begin
  TForm(Owner).Close;
end;

procedure ToForm.Finish;
var
  CloseEvent: TCloseQueryEvent;
begin
  FinishActive;

  if GenerateNote(True) then
  begin
    AcceptActive;
    TForm(Owner).OnCloseQuery := nil;
    Cancel;
    TForm(Owner).OnCloseQuery := CloseQuery;
  end;
end;

procedure ToForm.Restore;
var
  sl: TStringList;
  I: Integer;
  Control: TComponent;
begin
  sl := TStringList.Create;
  try
    try
      RPCBrokerV.tCallV(sl, 'DSIO OCNT RESTORE', [RPCBrokerV.TIUNote.IEN]);

      if ((sl.Count > 0) and (sl[0] <> '')) then
      if MessageDlg('A backup note for this OCNT exists!' + #10#13 +
                    'If you wish to load it click "Yes."', mtInformation, mbYesNo, 0) = mrYes then
      begin
        for I := 0 to sl.Count - 1 do
        begin
          if Owner is TForm then
          begin
            Control := TForm(Owner).FindComponent(Piece(sl[I],U,1));
            if Control <> nil then
            Fill(Control, Piece(sl[I],U,2), Piece(sl[I],U,3), False);
          end;
        end;
      end;
    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    sl.Free;
  end;
end;

function ToForm.Preview(Note: TStringList; bFinishBtn: Boolean): Boolean;
var
  I,J: Integer;
  S: string;
begin
  ReviewNoteDlg := TReviewNoteDlg.Create(Application);
  try
    ReviewNoteDlg.SetNote(Note);
    ReviewNoteDlg.OKBtn.Enabled := bFinishBtn;

    { Finish button. }
    if bFinishBtn = True then
    Result := False
    else
    { Preview Note. }
    begin
      { Note background for 'Preview'.  To enable uncomment.}
      ReviewNoteDlg.NoteMemo.Font.Color := clGray	;
      ReviewNoteDlg.NoteMemo.ReadOnly := True;
    end;

    ReviewNoteDlg.ShowModal;
    if ReviewNoteDlg.ModalResult = mrOK then
      begin
        Result := True;
        Note.SetText(ReviewNoteDlg.DialogResult.GetText);
      end
    else
    Result := False;
  finally
    ReviewNoteDlg.Free;
  end;
end;

function ToForm.GenerateNote(bFinishBtn: Boolean): Boolean;
var
  Note,Build: TStringList;
  I: Integer;
  Item: TNoteItem;
  Value: string;
  Validated: Boolean;

  const
    VALID_MESS = 'Some required elements are incomplete and must be completed' + #10#13 +
                 'in order to generate the note.';

  function BuildValueLine(Sender: TWinControl; Item: TNoteItem): TStringList;
  var
    Before, After: string;
    I: Integer;
    lb: TStringList;
  begin
    Result := TStringList.Create;
    Result.Clear;

    try
      // Write the prefix value
      if Item.BeforeValue <> '' then
      Before := Item.BeforeValue
      else Before := '';

      // Write the suffix
      if Item.AfterValue <> '' then
      After := Item.AfterValue
      else After := '';

      if Sender is TEdit then
      begin
        if Trim(TEdit(Sender).Text) <> '' then
        Result.Add(Before + TEdit(Sender).Text + After)
        else if Item.Required then
        begin
          ShowMessage(VALID_MESS);
          TEdit(Sender).SetFocus;
          Validated := False;
        end;
      end
      else if Sender is TLabeledEdit then
      begin
        if Trim(TLabeledEdit(Sender).Text) <> '' then
        Result.Add(Before + TLabeledEdit(Sender).Text + After)
        else if Item.Required then
        begin
          ShowMessage(VALID_MESS);
          TLabeledEdit(Sender).SetFocus;
          Validated := False;
        end;
      end
      else if Sender is TCheckBox then
      begin
        if TCheckBox(Sender).Checked then
        Result.Add(Before + TCheckBox(Sender).Caption + After);
      end
      else if Sender is TRadioButton then
      begin
        if TRadioButton(Sender).Checked then
        Result.Add(Before + TRadioButton(Sender).Caption + After);
      end
      else if Sender is TRadioGroup then
      begin
        if TRadioGroup(Sender).ItemIndex <> -1 then
        begin
          Result.Add(TRadioGroup(Sender).Caption);
          Result.Add(Before + TRadioGroup(Sender).Items.Strings[TRadioGroup(Sender).ItemIndex] + After);
        end;
      end
      else if Sender is TSpinEdit then
      Result.Add(Before + TSpinEdit(Sender).Text + After)
      else if Sender is TComboBox then
      begin
        if Trim(TComboBox(Sender).Text) <> '' then
        Result.Add(Before + TComboBox(Sender).Text + After)
        else if Item.Required then
        begin
          ShowMessage(VALID_MESS);
          TComboBox(Sender).SetFocus;
          Validated := False;
        end;
      end
      else if Sender is TListBox then
      begin
        if Item.DialogReturn <> nil then Exit;

        lb := TStringList.Create;
        try
          for I := 0 to TListBox(Sender).Count - 1 do
          lb.Add(TListBox(Sender).Items[I]);

          if lb.Count > 0 then
          begin
            for I := 0 to lb.Count - 1 do
            begin
              if Trim(lb[I]) <> '' then
              Result.Add(Before + lb[I] + After);
            end;
          end
          else if Item.Required then
          begin
            ShowMessage(VALID_MESS);
            TListBox(Sender).SetFocus;
            Validated := False;
          end;
        finally
          lb.Free;
        end;
      end
      else if Sender is TMemo then
      begin
        if TMemo(Sender).Lines.Count > 0 then
        begin
          for I := 0 to TMemo(Sender).Lines.Count - 1 do
          Result.Add(Before + TMemo(Sender).Lines.Strings[I] + After);
        end else if Item.Required then
        begin
          ShowMessage(VALID_MESS);
          TMemo(Sender).SetFocus;
          Validated := False;
        end;
      end
      else if Sender is TRichEdit then
      begin
        if TRichEdit(Sender).Lines.Count > 0 then
        begin
          for I := 0 to TRichEdit(Sender).Lines.Count - 1 do
          Result.Add(Before + TRichEdit(Sender).Lines.Strings[I] + After);
        end else if Item.Required then
        begin
          ShowMessage(VALID_MESS);
          TRichEdit(Sender).SetFocus;
          Validated := False;
        end;
      end;
    except
    end;
  end;

begin
  Validated := True;
  Result := False;

  Note := TStringList.Create;
  try
    for I := 0 to ReportCollection.Count - 1 do
    begin
      Item := ReportCollection.Items[I];

      if not ReportCollection.Items[I].HideFromNote then
      begin
        // Setup Control Values and add to Note
        Build := TStringList.Create;
        try
          Build := BuildValueLine(Item.OwningObject, Item);
          if Build.Count > 0 then
          begin
            // Write the Title for the Item
            if Item.Title <> '' then
            Note.Add(Item.Title);

            Note.AddStrings(Build);
            Note.Add('');
          end;
        finally
          Build.Free;
        end;
      end;
    end;

    if not Validated then Exit;

    if bFinishBtn then
    begin
      Result := Preview(Note, bFinishBtn);
      if Result then
      Save;
    end
    else Preview(Note, bFinishBtn);
  finally
    Note.Free;
  end;
end;

procedure ToForm.Save;
var
  Note,Build: TStringList;
  I: Integer;
  Item: TNoteItem;
  Fld: string;
begin
  Note := TStringList.Create;
  try
    for I := 0 to ReportCollection.Count - 1 do
    begin
      Item := ReportCollection.Items[I];

      if not Item.DoNotSave then
      begin
        Fld := Item.VistALabel;
        if Fld = '' then Fld := Item.DisplayName;

        Build := TStringList.Create;
        try
          try
            Build := BuildDiscreetData(Self, Item.OwningObject, Fld);
            if Build.Count > 0 then
            Note.AddStrings(Build);
          except
          end;
        finally
          Build.Free;
        end;
      end;
    end;

    if Note.Count > 0 then
    begin
      try
        RPCBrokerV.SetContext(MENU_CONTEXT);
        RPCBrokerV.CallV('DSIO OCNT STORE', [RPCBrokerV.TIUNote.IEN, Note]);
      except
      end;
    end;
  finally
    Note.Free;
  end;
end;

destructor ToForm.Destroy;
begin
  CNTAbout.Free;
  CNTLock.Free;
  FReportCollection.Free;
  if DialogDLL <> 0 then FreeLibrary(DialogDLL);

  inherited Destroy;
end;

{$ENDREGION}

end.

