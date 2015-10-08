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
  Extctrls, Menus, ComCtrls, StdCtrls, TypInfo, Contnrs, Spin, CheckLst,
  uReportItems, frmVitals, uCommon, uDialog, uExtndComBroker;

const
  U = '^';
  MENU_CONTEXT = 'DSIO DDCS CONTEXT';
  VALID_MESS = 'Some required elements are incomplete and must be completed' + #10#13 +
               'in order to generate the note.';

  { User Windows messages }
  UM_PAGE_CHANGE                = WM_USER + 255;
  UM_PANEL                      = WM_USER + 256;

  WM_SHOW_SPLASH                = WM_USER + 270;
  WM_CONFIG_DEV                 = WM_USER + 280;
  WM_SAVE                       = WM_USER + 290;

type
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

  TPanelOps = (pnCommand, pnSave, pnPreview, pnCancel, pnFinish);

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

  { ToPage }
  ToPage = class(TTabSheet)
  private
    FVstatus: Boolean;
    FVitalComp: TfVitals;
    procedure SetVitalProp(Value: Boolean);
{$IF NOT DEFINED(CLR)}
    procedure CMControlChange(var Message: TCMControlChange); message CM_CONTROLCHANGE;
{$ENDIF}
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property VitalsStatus: Boolean read FVstatus write SetVitalProp;
  end;

  { ToWizardButtonPanel }
  ToWizardButtonPanel = class(TCustomPanel)
  private
    TabSeen: array of Boolean;
  protected
    FCMenu: TPopupMenu;
    CommandButton: TButton;
    SaveButton: TButton;
    PreviewButton: TButton;
    CancelButton: TButton;
    FinishButton: TButton;
    PageIndicator: TPanel;
    PrevButton: TButton;
    NextButton: TButton;
    function CreateButton(Value: string): TButton;
    function PanelMessage(Msg: TPanelOps): TUMPanel;
    procedure DisableButtons;
    procedure Resize; virtual;
    procedure ShowMenu;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function Hidden: Integer;
    function NextIndex(CurrentIndex: Integer): Integer;
    function IsNext(CurrentIndex: Integer): Boolean;
    function PrevIndex(CurrentIndex: Integer): Integer;
    function IsPrev(CurrentIndex: Integer): Boolean;
    function ThisPageIs(CurrentIndex: Integer): Integer;
    procedure ButtonClick(Sender: TObject);
    procedure PageUpdate;
  end;

  TReportList = class(TComponentList)
  private
    FOwner: TComponent;
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    property Owner: TComponent read FOwner write FOwner;
  end;

  TpbFinishEvent = procedure(Sender: TObject; pbFinish: boolean) of object;
  TpbSaveEvent = procedure(Sender: TObject; AutoSave: boolean) of object;
  TpbRestoreEvent = procedure(Sender: TObject) of object;
  TpbFormShow = procedure(Sender: TObject) of object;
  TpbOverrideNote = procedure(Sender: TObject) of object;

 { ToForm }
  ToForm = class(TPageControl)
  private
    FValidated: Boolean;
    FReturnList: TStringList;
    FReportItemList: TReportList;
    FSaveTimer: TTimer;
    FReportCollection: TNoteCollection;
    FDisableSplash: Boolean;
    FVersion: string;
    FOnpbSave: TpbSaveEvent;
    FOnpbRestore: TpbRestoreEvent;
    FOnpbFinish: TpbFinishEvent;
    FOnpbAccept: TpbFinishEvent;
    FOnpbFormShow: TpbFormShow;
    FOnpbOverrideNote: TpbOverrideNote;
    TabCaptions: array of string;
    FMultiInterface: Boolean;
    procedure SetDisableSplash(Value: Boolean);
    procedure SetNoteCollection(const Value: TNoteCollection);
    procedure WMShowSplash(var Message: TMessage); message WM_SHOW_SPLASH;
    procedure WMConfigDev(var Message: TMessage); message WM_CONFIG_DEV;
    procedure WMSave(var Message: TMessage); message WM_SAVE;
  protected
    ControlPanel: ToWizardButtonPanel;
    procedure SetName(const NewName: TComponentName); override;
    procedure Change; override;
    procedure DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure SaveActive;
    procedure AutoSaveActive;
    procedure RestoreActive;
    procedure FinishActive;
    procedure AcceptActive;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMCreate(var Message: TWMCreate); message WM_CREATE;
    procedure UMPageChange(var Message: TUMPageChange); message UM_PAGE_CHANGE;
    procedure UMPanel(var Message: TUMPanel); message UM_PANEL;
    procedure Save(auto: Boolean);
    procedure Finish;
    procedure Cancel;
    procedure ControlExceptions(Sender: TObject; E: Exception);
    procedure BuildValueLine(var Validated: Boolean; var Note: TStringList; Sender: TWinControl);
    function GenerateNote(bFinishBtn: Boolean): Boolean;
    function Preview(Note: TStringList; bFinishBtn: Boolean): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateControlPanel;
    procedure CloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure OnAutoSaveTimer(Sender: TObject);
    procedure ShowAbout(Sender: TObject);
    procedure EditConfiguration(Sender: TObject);
    procedure CreateTab(ACaption: string);
    property Validated: Boolean read FValidated write FValidated;
    property TmpStrList: TStringList read FReturnList write FReturnList;
    property MultiInterface: Boolean read FMultiInterface write FMultiInterface;
    function GetPatientAllergies: TStringList;
    function GetPatientActiveProblems: TStringList;
    function GetPatientActiveMedications: TStringList;
  published
    property DisableSplash: Boolean read FDisableSplash write SetDisableSplash default False;
    property ReportCollection: TNoteCollection read FReportCollection write SetNoteCollection;
    property OnSave: TpbSaveEvent read  FOnpbSave write FOnpbSave;
    property OnRestore: TpbRestoreEvent read  FOnpbRestore write FOnpbRestore;
    property OnpbFinish: TpbFinishEvent read FOnpbFinish write FOnpbFinish;
    property OnpbAccept: TpbFinishEvent read FOnpbAccept write FOnpbAccept;
    property onFormShow: TpbFormShow read FOnpbFormShow write FOnpbFormShow;
    property onOverrideNote: TpbOverrideNote read FOnpbOverrideNote write FOnpbOverrideNote;
    property Version: string read FVersion;
  end;

  { Helpers }
  TWinHelper = class Helper for TWinControl
  private
  public
  //TCheckListbox
    procedure CheckListBoxGetDialogDBClick(Sender: TObject);
  //TListBox
    procedure ListBoxGetDialogDBClick(Sender: TObject);
  //TButton
    procedure ButtonGetDialogClick(Sender: TObject);
  //TComboBox
    procedure cbAutoWidth(Sender: TObject);
  end;

  function ControlVisible(rControl: TWinControl; rForm: TComponent): Boolean;
  function HasSecurityKey(const KeyName: string): Boolean;

  procedure Register;

var
  DialogDLL: THandle;
  DLLDialogList: TStringList;
  First: Boolean = True;
  Tasks: TStringList;    //array of autosave tasks to be canceled onClose of the oCNT

implementation

uses
  Consts, frmAbout, frmSplash, frmNoteRvw, frmReportOrder, frmConfiguration;

const
  F_VERSION = '1.0.0.0';

procedure Register;
begin
  RegisterClass(ToCNTDialog);
  RegisterClass(TNoteCollection);
  RegisterClass(TNoteItem);
  RegisterClass(ToPage);
  RegisterClass(TfVitals);
  RegisterComponents('oCNT', [ToForm]);
end;

{$REGION 'Helpers'}

function ControlVisible(rControl: TWinControl; rForm: TComponent): Boolean;
var
  I: Integer;
begin
  Result := True;
  if rForm.ClassType <> ToForm then
    Exit;
  if ToForm(rForm).PageCount = 1 then
    Exit;

  for I := 0 to ToForm(rForm).PageCount - 1 do
  begin
    if ToForm(rForm).Pages[I].ContainsControl(rControl) then
    begin
      Result := ToForm(rForm).Pages[I].TabVisible;
      Break;
    end;
  end;
end;

function HasSecurityKey(const KeyName: string): Boolean;
{ returns true if the currently logged in user has a given security key }
var
  x: string;
begin
  Result := False;
  try
    x := RPCBrokerV.sCallV('ORWU HASKEY', [KeyName]);
    if x = '1' then Result := True;
  except
    on E: Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TWinHelper.CheckListBoxGetDialogDBClick(Sender: TObject);
var
  Note: TNoteItem;
  sl: TStringList;
begin
  inherited;
  if not (Sender is TCheckListBox) then
    Exit;

  if TCheckListBox(Sender).ItemIndex = -1 then
    Exit;

  Note := RCollection^.GetNoteItem(Self);
  if Note = nil then
    Exit;

  sl := TStringList.Create;
  try
    try
      sl.AddStrings(DisplayDialog(@RPCBrokerV, Note.Configuration[TCheckListBox(Sender).ItemIndex], False));
    except
    end;
    TCheckListBox(Sender).Checked[TCheckListBox(Sender).ItemIndex] := True;

    if Note.DialogReturn is TMemo then
      TMemo(Note.DialogReturn).Lines.AddStrings(sl)
    else
      if Note.DialogReturn is TRichEdit then
        TRichEdit(Note.DialogReturn).Lines.AddStrings(sl);
  finally
    sl.Free;
  end;
end;

procedure TWinHelper.ListBoxGetDialogDBClick(Sender: TObject);
var
  Note: TNoteItem;
  sl: TStringList;
begin
  inherited;
  if not (Sender is TListBox) then
    Exit;

  if TListBox(Sender).ItemIndex = -1 then
    Exit;

  Note := RCollection^.GetNoteItem(Self);
  if Note = nil then
    Exit;
  if Note.Configuration.Count < 1 then
    Exit;

  sl := TStringList.Create;
  try
    try
      sl.AddStrings(DisplayDialog(@RPCBrokerV, Note.Configuration[TListBox(Sender).ItemIndex], False));
    except
    end;

    if Note.DialogReturn is TMemo then
      TMemo(Note.DialogReturn).Lines.AddStrings(sl)
    else
      if Note.DialogReturn is TRichEdit then
        TRichEdit(Note.DialogReturn).Lines.AddStrings(sl);
  finally
    sl.Free;
  end;
end;

procedure TWinHelper.ButtonGetDialogClick(Sender: TObject);
var
  Note: TNoteItem;
  sl: TStringList;
begin
  inherited;
  if not (Sender is TButton) then
    Exit;

  Note := RCollection^.GetNoteItem(Self);
  if Note = nil then
    Exit;
  if Note.Configuration.Count < 1 then
    Exit;

  sl := TStringList.Create;
  try
    try
      sl.AddStrings(DisplayDialog(@RPCBrokerV, Note.Configuration[0], False));

      if Note.DialogReturn is TMemo then
        TMemo(Note.DialogReturn).Lines.AddStrings(sl)
      else
        if Note.DialogReturn is TRichEdit then
          TRichEdit(Note.DialogReturn).Lines.AddStrings(sl);
    except
    end;
  finally
    sl.Free;
  end;
end;

procedure TWinHelper.cbAutoWidth(Sender: TObject);
var
  cbLength,I: Integer;
begin
  if not (Sender is TComboBox) then
    Exit;

  cblength := TComboBox(Sender).Width;
  for I := 0 to TComboBox(Sender).Items.Count - 1 do
    if TComboBox(Sender).Canvas.TextWidth(TComboBox(Sender).Items[I]) > cblength then
      cblength := TComboBox(Sender).Canvas.TextWidth(TComboBox(Sender).Items[I]);

  if TComboBox(Sender).Items.Count > TComboBox(Sender).DropDownCount then
    cblength := cblength + GetSystemMetrics(SM_CXVSCROLL);

  SendMessage(TComboBox(Sender).Handle, CB_SETDROPPEDWIDTH, (cblength + 7), 0);
end;

{$ENDREGION}

{$REGION 'ToWizardButtonPanel'}

{ ToWizardButtonPanel }
constructor ToWizardButtonPanel.Create(AOwner: TComponent);
var
  FCItm: TMenuItem;
begin
  inherited Create(AOwner);
  BevelInner := bvNone;
  BevelOuter := bvNone;
  BorderStyle := bsNone;
  BevelWidth := 1;

  if not (csDesigning in ComponentState) then
  begin
    FCMenu := TPopupMenu.Create(Self);
    FCItm := TMenuItem.Create(FCMenu);
    FCItm.Caption := 'Edit Configuration';
    FCItm.OnClick := ToForm(AOwner).EditConfiguration;

    if not HasSecurityKey('DSIO DDCS CONFIG') then
      FCItm.Visible := False;

    FCMenu.Items.Add(FCitm);
    FCItm := TMenuItem.Create(FCMenu);
    FCItm.Caption := 'About';
    FCItm.OnClick := ToForm(AOwner).ShowAbout;
    FCMenu.Items.Add(FCitm);
  end;

  CommandButton := CreateButton('');
  SaveButton := CreateButton('&Save');
  PreviewButton := CreateButton('Pre&view');
  CancelButton := CreateButton('&Cancel');
  FinishButton := CreateButton('&Finish');
  PrevButton := CreateButton('&Prev');

  PageIndicator := TPanel.Create(Self);
  PageIndicator.Parent := Self;
  PageIndicator.Visible := True;
  PageIndicator.Enabled := True;
  PageIndicator.BevelOuter := bvNone;
  PageIndicator.BorderStyle := bsSingle;
  PageIndicator.TabStop := True;
  PageIndicator.Caption := '0 of 0';

  NextButton := CreateButton('&Next');
end;

destructor ToWizardButtonPanel.Destroy;
begin
  if not (csDesigning in ComponentState) then
    SetLength(TabSeen, 0);

  FCMenu.Free;
  inherited Destroy;
end;

function ToWizardButtonPanel.CreateButton(Value: String): TButton;
begin
  Result := TButton.Create(Self);
  Result.Caption := Value;
  Result.OnClick := ButtonClick;
  Result.Visible := True;
  Result.Enabled := True;
  Result.Parent := Self;
end;

procedure ToWizardButtonPanel.Resize;
var
  ButtonWidth,ButtonHeight,ButtonLeft: Integer;
  ButtonTop,I: Integer;
begin
  SetBounds(1, 1, Parent.ClientWidth - 2, Font.Size * Font.PixelsPerInch div 72 + 18);
  if ControlCount > 0 then
  begin
    ButtonWidth := ((ClientWidth - (ControlCount - 1)) div (ControlCount - 1)) - 3;
    ButtonHeight := ClientHeight - 2;
    ButtonTop := 1;

    for I := 0 to ControlCount - 1 do
    begin
      if I = 0 then
      begin
        ButtonLeft := 1;
        Controls[I].SetBounds(ButtonLeft, ButtonTop, 20, ButtonHeight);
      end else
      begin
        ButtonLeft := Controls[I - 1].Left + Controls[I - 1].Width + 1;
        Controls[I].SetBounds(ButtonLeft, ButtonTop, ButtonWidth, ButtonHeight);
      end;
    end;
  end;
end;

procedure ToWizardButtonPanel.ShowMenu;
var
  APoint: TPoint;

  function PopupMenuHeight(Popup: TPopupMenu): Integer;
  var
    I,y: integer;
  begin
    y := Round(GetSystemMetrics(SM_CYMENUCHECK) * 1.4);
    Result := 0;
    if Popup.Items.Count > 0 then
    begin
      for I := 0 to Popup.Items.Count - 1 do
      if Popup.Items[I].Visible then
        Inc(Result, y);
    end;
  end;

begin
  APoint := CommandButton.ClientToScreen(Point(0, CommandButton.ClientHeight -
            CommandButton.Height - PopupMenuHeight(FCMenu) - 10));
  FCMenu.Popup(APoint.X, APoint.Y);
end;

function ToWizardButtonPanel.Hidden: Integer;
var
  I: Integer;
begin
  Result := 0;
  for I := 0 to ToForm(Owner).PageCount - 1 do
    if not ToForm(Owner).Pages[I].TabVisible then
      Inc(Result);
end;

function ToWizardButtonPanel.NextIndex(CurrentIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := CurrentIndex;
  for I := CurrentIndex + 1 to ToForm(Owner).PageCount - 1 do
    if I > -1 then
      if ToForm(Owner).Pages[I].TabVisible then
      begin
        Result := I;
        Break;
      end;
end;

function ToWizardButtonPanel.IsNext(CurrentIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  for I := CurrentIndex to ToForm(Owner).PageCount - 1 do
    if I <> CurrentIndex then
      if ToForm(Owner).Pages[I].TabVisible then
        Result := True;
end;

function ToWizardButtonPanel.PrevIndex(CurrentIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := CurrentIndex;

  if CurrentIndex = -1 then
    Exit;

  for I := (CurrentIndex - 1) downto 0 do
    if ToForm(Owner).Pages[I].TabVisible then
    begin
      Result := I;
      Break;
    end;
end;

function ToWizardButtonPanel.IsPrev(CurrentIndex: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;

  if CurrentIndex = -1 then
    Exit;

  for I := CurrentIndex downto 0 do
    if I <> CurrentIndex then
      if ToForm(Owner).Pages[I].TabVisible then
        Result := True;
end;

function ToWizardButtonPanel.ThisPageIs(CurrentIndex: Integer): Integer;
var
  I: Integer;
begin
  Result := 0;

  if CurrentIndex = -1 then
    Exit;

  for I := CurrentIndex downto 0 do
    if ToForm(Owner).Pages[I].TabVisible then
      Inc(Result);
end;

procedure ToWizardButtonPanel.PageUpdate;
var
  Last: Integer;

  function GetAlternateIndex(CurrentIndex: Integer; Form: ToForm): Integer;
  var
    I: Integer;
  begin
    Result := CurrentIndex;

    for I := 0 to Length(Form.TabCaptions) - 1 do
      if Form.TabCaptions[I] <> '' then
        if StrToInt(Form.TabCaptions[I]) = Form.ActivePageIndex then
        begin
          Result := I;
          Break;
        end;
  end;

begin
  if not (csDesigning in ComponentState) then
  begin
    if ToForm(Owner).ActivePageIndex <> -1 then
     TabSeen[GetAlternateIndex(ToForm(Owner).ActivePageIndex,ToForm(Owner))] := True;
  end;

  Last := ToForm(Owner).PageCount - Hidden;
  if Last < 1 then
    Last := 1;

  PageIndicator.Caption := IntToStr(ThisPageIs(ToForm(Owner).ActivePageIndex)) + ' of ' + IntToStr(Last);
  DisableButtons;
end;

procedure ToWizardButtonPanel.DisableButtons;
begin
  if not (csDesigning in ComponentState) then
  begin
    if IsNext(ToForm(Owner).ActivePageIndex) then
      NextButton.Enabled := True
    else
      NextButton.Enabled := False;

    if IsPrev(ToForm(Owner).ActivePageIndex) then
      PrevButton.Enabled := True
    else
      PrevButton.Enabled := False;
  end;
end;

procedure ToWizardButtonPanel.ButtonClick(Sender: TObject);
begin
  if Sender = CommandButton then
    PanelMessage(pnCommand)
  else if Sender = SaveButton then
    PanelMessage(pnSave)
  else if Sender = PreviewButton then
    PanelMessage(pnPreview)
  else if Sender = CancelButton then
    PanelMessage(pnCancel)
  else if Sender = FinishButton then
    PanelMessage(pnFinish)
  else if Sender = PrevButton then
  begin
    { Perform page changes. }
    ToForm(Owner).ActivePageIndex := PrevIndex(ToForm(Owner).ActivePageIndex);
    PageUpdate;
    ToForm(Owner).Repaint;
  end
  else if Sender = NextButton then
  begin
    { Perform page changes. }
    ToForm(Owner).ActivePageIndex := NextIndex(ToForm(Owner).ActivePageIndex);
    PageUpdate;
    ToForm(Owner).Repaint;
  end;
end;

function ToWizardButtonPanel.PanelMessage(Msg: TPanelOps): TUMPanel;
var
  Message: TUMPanel;
begin
  Message.PanelOp := Word(Msg);
  Message.Result := TWinControl(Owner).Perform(UM_PANEL, Message.wParam, Message.lParam);
  Result := Message;
end;

{$ENDREGION}

{$REGION 'ToPage'}

{ ToPage }
constructor ToPage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := [csAcceptsControls, csCaptureMouse, csClickEvents,
                   csSetCaption, csDoubleClicks, csParentBackground, csPannable, csGestures];
end;

{$IF NOT DEFINED(CLR)}
procedure ToPage.CMControlChange(var Message: TCMControlChange);
begin
  inherited;
  if not (csLoading in ComponentState) then
  if Message.Inserting and (Message.Control.Parent = Self) then
    ToForm(Parent).FReportItemList.Add(Message.Control);
end;
{$ENDIF}

destructor ToPage.Destroy;
begin
  FVitalComp.Free;
  inherited Destroy;
end;

procedure ToPage.SetVitalProp(Value: Boolean);
var
  vPage: ToPage;
  I: Integer;
begin
  if not Value then
  begin
    FVitalComp.Free;
    FVstatus := False;
    Exit;
  end;

  if Parent is ToForm then
  begin
    for I := 0 to ToForm(Parent).PageCount - 1 do
    begin
      vPage := ToPage(ToForm(Parent).Pages[I]);
      if vPage.VitalsStatus then
        vPage.VitalsStatus := False;
    end;

    FVitalComp := frmVitals.CreateInTab(Self, @RPCBrokerV);
    FVstatus := True;
  end;
end;

{$ENDREGION}

{$REGION 'TReportList'}

{ TReportList }
procedure TReportList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Assigned(Owner) then
  begin
    case Action of
      lnAdded: if Ptr <> nil then
                 ToForm(Owner).ReportCollection.AddNoteItem(TWinControl(Ptr));
      lnExtracted,
      lnDeleted: if Ptr <> nil then
                   ToForm(Owner).ReportCollection.DeleteNoteItem(TWinControl(Ptr));
    end;
  end;
  inherited Notify(Ptr, Action);
end;

{$ENDREGION}

{$REGION 'ToForm'}

{ ToForm }

function ToForm.GetPatientAllergies: TStringList;
// Array of patient allergies.  Returned data is delimited by "^" and
// includes: allergen/reactant, reactions/symptoms (multiple symptoms/
// reactions are possible - delimited by ";"), severity, allergy id (record
// number from the Patient Allergies file (#120.8).
// DSSTFF20140715 DSIO ORQQAL LIST created to return formatting
begin
  Result := TStringList.Create;
  try
    RPCBrokerV.SetContext(MENU_CONTEXT);
    RPCBrokerV.tCallV(Result, 'DSIO DDCS ORQQAL LIST', [RPCBrokerV.PatientDFN]);
  except
    on E: Exception do
    begin
      Result.Clear;
      Result.Add(E.Message);
    end;
  end;
end;

function ToForm.GetPatientActiveProblems: TStringList;
// Array of patient problems in the format: problem id^problem name^status
begin
  Result := TStringList.Create;
  try
    RPCBrokerV.SetContext(MENU_CONTEXT);
    RPCBrokerV.tCallV(Result, 'DSIO DDCS ORQQPL LIST', [RPCBrokerV.PatientDFN]);
  except
    on E: Exception do
    begin
      Result.Clear;
      Result.Add(E.Message);
    end;
  end;
end;

function ToForm.GetPatientActiveMedications: TStringList;
// Array medications in the format: medication id^nameform (orderable item)^
// stop date/time^route^schedule/iv rate^refills remaining
begin
  Result := TStringList.Create;
  try
    RPCBrokerV.SetContext(MENU_CONTEXT);
    RPCBrokerV.tCallV(Result, 'DSIO DDCS ORQQPS LIST', [RPCBrokerV.PatientDFN]);
  except
    on E: Exception do
    begin
      Result.Clear;
      Result.Add(E.Message);
    end;
  end;
end;

procedure ToForm.EditConfiguration(Sender: TObject);
begin
  oCNTConfiguration.Show;
end;

procedure ToForm.ShowAbout(Sender: TObject);
begin
  DDCSAbout := TDDCSAbout.Create(Self);
  try
    DDCSAbout.ShowModal;
  finally
    DDCSAbout.Free;
  end;
end;

procedure ToForm.SetName(const NewName: TComponentName);
begin
  inherited SetName('ofrm1');
end;

procedure ToForm.Change;
begin
  inherited Change;
  UpdateControlPanel;
end;

procedure ToForm.CreateTab(ACaption: string);
var
  Tab: ToPage;
begin
  Tab := ToPage.Create(Self);
  Tab.Caption := ACaption;
  Tab.PageControl := Self;
end;

procedure ToForm.DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  ARect,CkRect,TmpRect: TRect;
  I,Tab: Integer;
  cap: string;

  function GetCkRect: TRect;
  begin
    Result.Left   := Rect.Left + 3;
    Result.Top    := Rect.Top + 3;
    Result.Right  := Result.Left + 12;
    Result.Bottom := Result.Top + 12;
  end;

begin
  ARect := Rect;
  Canvas.FillRect(Rect);

  if ((TabIndex <> -1) and (TabIndex <= Length(TabCaptions))) then
    if TabCaptions[TabIndex] <> '' then
      cap := Pages[StrToInt(TabCaptions[TabIndex])].Caption;

  //This needs to happen on starup and only once
  if First then
  begin
    Tab := TabWidth;
    for I := 0 to PageCount - 1 do
    begin
      if Canvas.TextWidth(Pages[I].Caption) > Tab then
        Tab := Canvas.TextWidth(Pages[I].Caption);
    end;
    TabWidth := Tab + 30;
    First := False;
  end;

  CkRect := GetCkRect;
  Canvas.Rectangle(CkRect);
  ARect.Left := CkRect.Right + 3;
  InflateRect(ARect, 0, -3);
  if ((TabIndex <> -1) and (TabIndex <= Length(ControlPanel.TabSeen))) then
  begin
    if ControlPanel.TabSeen[TabIndex] then
      DrawFrameControl(Control.Canvas.Handle, CkRect, DFC_BUTTON, DFCS_CHECKED)
    else
      DrawFrameControl(Control.Canvas.Handle, CkRect, DFC_BUTTON, DFCS_INACTIVE);
  end
  else
    DrawFrameControl(Control.Canvas.Handle, CkRect, DFC_BUTTON, DFCS_INACTIVE);

  Canvas.Brush.Style := bsClear;
  TmpRect := Rect;
  OffsetRect(TmpRect, 1, 1);

  DrawText(Canvas.Handle, PChar(cap), Length(cap), ARect, DT_LEFT or DT_WORDBREAK or DT_CALCRECT);
  DrawText(Canvas.Handle, PChar(cap), Length(cap), ARect, DT_LEFT or DT_WORDBREAK);
end;

procedure ToForm.ControlExceptions(Sender: TObject; E: Exception);
begin
  if Pos('comctl32.dll', E.Message) > 0 then
  //Eat it!
end;

constructor ToForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if AOwner.FindComponent('ofrm1') <> nil then
    raise EInvalidOperation.Create('Only one base form allowed.');

  Name := 'ofrm1';

  if not (csDesigning in ComponentState) then
  begin
    Application.OnException := ControlExceptions;

    if AOwner is TForm then
    begin
      TForm(AOwner).OnCloseQuery := CloseQuery;
      TForm(AOwner).OnClose := FormClose;
      TForm(AOwner).OnShow := FormShow;
      TForm(AOwner).AlphaBlend := True;
      TForm(AOwner).AlphaBlendValue := 0;
    end;

    TabPosition := tpTop;
    Style := tsButtons;
    OwnerDraw := True;
    OnDrawTab := DrawTab;
  end;

  FVersion := F_VERSION;
  FReturnList := TStringList.Create;

  ControlPanel := ToWizardButtonPanel.Create(Self);
  ControlPanel.Parent := Self;
  ControlPanel.Align := alBottom;

  FReportItemList := TReportList.Create(True);
  FReportItemList.Owner := Self;
  FReportCollection := TNoteCollection.Create(Self, TNoteItem);

  Align := alClient;
end;

procedure ToForm.FormShow(Sender: TObject);
var
  sl,dl: TStringList;
  I,ctI: Integer;
  Control: TComponent;
  DDCSConfig,Controlled,vPropertyList,vProp,vValue,iForm: string;
  NItem: TNoteItem;
  wControl: TWinControl;

  procedure SetOnClickAction(var Control: TComponent);
  begin
    if Control is TCheckListBox then
      TCheckListBox(Control).OnDblClick := TCheckListBox(Control).CheckListBoxGetDialogDBClick
    else if Control is TListBox then
      TListBox(Control).OnDblClick := TListBox(Control).ListBoxGetDialogDBClick
    else if Control is TButton then
      TButton(Control).OnClick := TButton(Control).ButtonGetDialogClick
  end;

  procedure loopin(Control: TWinControl);
  var
    I,ctI: Integer;
  begin
    if (Control.ClassType = TPanel) or (Control.ClassType = TGroupBox) then
    begin
      for I := 0 to Control.ControlCount - 1 do
        loopin(TWinControl(Control.Controls[I]));
    end else if Control.ClassType = TPageControl then
    begin
      for I := 0 to TPageControl(Control).PageCount - 1 do
        for ctI := 0 to TPageControl(Control).Pages[I].ControlCount - 1 do
          loopin(TWinControl(TPageControl(Control).Pages[I].Controls[ctI]));
    end else
    begin
      if ((Control is TComboBox) and (not Assigned(TComboBox(Control).OnDragDrop))) then
          TComboBox(Control).OnDropDown := TComboBox(Control).cbAutoWidth;

      NItem := FReportCollection.GetNoteItem(TWinControl(Control));
      if NItem = nil then
        NItem := FReportCollection.AddNoteItem(TWinControl(Control));
    end;
  end;

begin
  TabHeight := 25;

  DLLDialogList := TStringList.Create;
  DialogDLL := LoadDialogs;
  if DialogDLL <> 0 then
  begin
    RegisterDialogs := GetProcAddress(DialogDLL, 'RegisterDialogs');
    DisplayDialog := GetProcAddress(DialogDLL, 'DisplayDialog');
    GetDialogComponents := GetProcAddress(DialogDLL, 'GetDialogComponents');

    DLLDialogList.AddStrings(RegisterDialogs);
  end;

  PostMessage(Handle, WM_SHOW_SPLASH, 0, 0);

  RCollection := @FReportCollection;
  Tasks := TStringList.Create;

  FSaveTimer := TTimer.Create(Self);
  FSaveTimer.Name := 'AutoSaveTimer';
  FSaveTimer.Interval := 60000;
  FSaveTimer.OnTimer := OnAutoSaveTimer;
  FSaveTimer.Enabled := True;

  sl := TStringList.Create; dl := TStringList.Create;
  try
    if RPCBrokerV.DDCSInterfacePages.Count > 0 then
    begin
      dl.AddStrings(RPCBrokerV.DDCSInterfacePages);
      FMultiInterface := True;
    end else
    begin
      dl.Add(RPCBrokerV.DDCSInterface);
      FMultiInterface := False;
    end;

    try
      RPCBrokerV.SetContext(MENU_CONTEXT);
      RPCBrokerV.tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN]);

      if sl.Count > 0 then
      begin
          for I := 0 to sl.Count - 1 do
          begin

            // Interface ------------------------------------------------------
            //           I^TITLE|VALUE
            if Piece(sl[I],U,1)='I' then
            begin
              // Set Properties
              vPropertyList := Piece(sl[I],U,2,99);
              for ctI := 1 to SubCount(vPropertyList,U) + 1 do
              begin
                vProp := Piece(Piece(vPropertyList,U,ctI), '|', 1);
                if IsPublishedProp(TForm(Owner), vProp) then
                begin
                  vValue := Piece(Piece(vPropertyList,U,ctI), '|', 2);
                  if vValue <> '' then
                    SetPropValue(TForm(Owner), vProp, vValue);
                end;
              end;
            end;

            // Page -----------------------------------------------------------
            //      P^NUMBER^CAPTION^HIDE
            if Piece(sl[I],U,1)='P' then
            begin
              if TryStrToInt(Piece(sl[I],U,2),ctI) or (ctI <= PageCount) then
              begin
                if Piece(sl[I],U,3) <> '' then
                  Pages[ctI - 1].Caption := Piece(sl[I],U,3);
                if Piece(sl[I],U,4) <> '' then
                  Pages[ctI - 1].TabVisible := not StrToBool(Piece(sl[I],U,4));
              end;
              iForm := Pages[ctI - 1].Caption;
            end;

            // Control --------------------------------------------------------
            //         CC^NAME^^^PROPERTY|VALUE
            if Piece(sl[I],U,1)='CC' then
            begin
              Control := TForm(Owner).FindComponent(Piece(sl[I],U,2));
              if Control <> nil then
              begin
                NItem := FReportCollection.GetNoteItem(TWinControl(Control));
                if NItem = nil then
                  NItem := FReportCollection.AddNoteItem(TWinControl(Control));

                NItem.Page := iForm;

                // Set Properties
                vPropertyList := Piece(sl[I],U,3,99);

                for ctI := 1 to SubCount(vPropertyList,U) + 1 do
                begin
                  vProp := Piece(Piece(vPropertyList,U,ctI), '|', 1);
                  vValue := Piece(Piece(vPropertyList,U,ctI), '|', 2);

                  if ((vProp = 'ORDER') and (vValue <> '')) then
                    NItem.Order := StrToInt(vValue)
                  else if ((vProp = 'PREFIX') and (vValue <> '')) then
                    NItem.Prefix := vValue
                  else if ((vProp = 'SUFFIX') and (vValue <> '')) then
                    NItem.Suffix := vValue
                  else if ((vProp = 'DO NOT SPACE') and (vValue <> '')) then
                    NItem.DoNotSpace := StrToBool(vValue)
                  else if ((vProp = 'TITLE') and (vValue <> '')) then
                    NItem.Title := vValue
                  else if ((vProp = 'DIALOG RETURN') and (vValue <> '')) then
                    NItem.DialogReturn := TWinControl(TForm(Owner).FindComponent(vValue))
                  else if ((vProp = 'REQUIRED') and (vValue <> '')) then
                    NItem.Required := StrToBool(vValue)
                  else if ((vProp = 'DO NOT SAVE') and (vValue <> '')) then
                    NItem.DoNotSave := StrToBool(vValue)
                  else if ((vProp = 'HIDE FROM NOTE') and (vValue <> '')) then
                    NItem.HideFromNote := StrToBool(vValue);
                end;

                if NItem.DialogReturn <> nil then
                  SetOnClickAction(Control);
              end;
            end;

            // Control Value --------------------------------------------------
            //               CV^NAME^F^(INDEXED^VALUE)
            //               CV^NAME^D^IEN|NAME|CLASS
            if Piece(sl[I],'^',1)='CV' then
            begin
              Control := TForm(Owner).FindComponent(Piece(sl[I],U,2));
              if Control <> nil then
              begin
                NItem := FReportCollection.GetNoteItem(TWinControl(Control));

                if Piece(sl[I],U,3) = 'F' then
                  Fill(Control, Piece(sl[I],U,4), Piece(sl[I],U,5,9999));

                if Piece(sl[I],U,3) = 'D' then
                begin
                  NItem.Configuration.Add(Piece(sl[I],U,4));
                  Fill(Control, '', Piece(Piece(sl[I],U,4),'|',2));

                  if NItem.DialogReturn <> nil then
                    SetOnClickAction(Control);
                end;
              end;
            end;

          end;
      end;

      SetLength(ControlPanel.TabSeen, PageCount);
      SetLength(TabCaptions, PageCount);
      for I := 0 to PageCount - 1 do
      begin
        if Pages[I].TabVisible then
        begin
          for ctI := 0 to PageCount - 1 do
            if TabCaptions[ctI] = '' then
            begin
              TabCaptions[ctI] := IntToStr(I);
              Break;
            end;

          for ctI := 0 to Pages[I].ControlCount - 1 do
            loopin(TWinControl(Pages[I].Controls[ctI]));
        end;
      end;

      ReportCollection.ReIndex;

    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    sl.Free; dl.Free;
  end;

  UpdateControlPanel;
  if PageCount = 1 then
  begin
    for I := 0 to PageCount - 1 do
    begin
      Pages[I].TabVisible := False;
      ActivePageIndex := I;
      Break;
    end;
  end else
  begin
    for I := 0 to PageCount - 1 do
      if Pages[I].TabVisible then
      begin
        ActivePageIndex := I;
        Break;
      end;
  end;

  if Assigned(FOnpbFormShow) then
    FOnpbFormShow(Self);

  PostMessage(Handle, WM_CONFIG_DEV, 0, 0);
end;

procedure ToForm.SetDisableSplash(Value: Boolean);
begin
  FDisableSplash := Value;
end;

procedure ToForm.WMShowSplash(var Message: TMessage);
var
  DDCSConfig: string;
begin
  inherited;

  try
    try
      DDCSConfig := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'SHOW SPLASH']);

      if DDCSConfig <> '' then
        if not StrToBool(DDCSConfig) then
          Exit;

      if ((DDCSConfig <> '') and (StrToBool(DDCSConfig))) or (not FDisableSplash) then
      begin
        DDCSSplash := TDDCSSplash.Create(nil);
        try
          DDCSSplash.Show;
          DDCSSplash.BringToFront;
          DDCSSplash.Update;
          Sleep(2000);
        finally
          DDCSSplash.Free;
        end;
      end;

    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    if Owner is TForm then
      TForm(Owner).AlphaBlend := False;
  end;
end;

procedure ToForm.SetNoteCollection(const Value: TNoteCollection);
begin
  FReportCollection.Assign(Value);
end;

procedure ToForm.WMConfigDev(var Message: TMessage);
begin
  inherited;
  oCNTConfiguration := ToCNTConfiguration.Create(Self);
end;

procedure ToForm.UpdateControlPanel;
begin
  ControlPanel.PageUpdate;
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

procedure ToForm.OnAutoSaveTimer(Sender: TObject);
begin
  PostMessage(Handle, WM_SAVE, 0, 0);
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
begin
  inherited;
  UpdateControlPanel;
end;

procedure ToForm.UMPageChange(Var Message: TUMPageChange);
begin
//  case TPageOps(Message.PageOp) of
//    poNext : begin
//               if ActivePageIndex < PageCount - 1 then
//                 ActivePageIndex := ControlPanel.NextIndex(ActivePageIndex);
//               Message.NewPage := Word(ActivePageIndex);
//             end;
//    poPrev : begin
//               if ActivePageIndex > 0 then
//                 ActivePageIndex := ControlPanel.PrevIndex(ActivePageIndex);
//               Message.NewPage := Word(ActivePageIndex);
//             end;
//    poAbs  : ActivePageIndex := Integer(Message.Page);
//  end;
end;

procedure ToForm.UMPanel(var Message: TUMPanel);
begin
  try
    case TPanelOps(Message.PanelOp) of
      pnCommand : ControlPanel.ShowMenu;
         pnSave : Save(False);         // PostMessage(Handle, WM_SAVE, 0, 0);
      pnPreview : GenerateNote(False); // Don't generate note file - just preview }
       pnCancel : Cancel;
       pnFinish : Finish;
    end;
  except
  end;
end;

procedure ToForm.CloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('Are you sure you want to exit?',mtconfirmation,[mbYes,mbNo],0) = mrYes then
    CanClose := True
  else
    CanClose := False;
end;

procedure ToForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    try
      RPCBrokerV.SetContext(MENU_CONTEXT);
      RPCBrokerV.CallV('DSIO DDCS CANCEL AUTOSAVE', [Tasks]);
    except
    end;
  finally
    Save(False);
    Action := caFree;
  end;
end;

procedure ToForm.Cancel;
begin
  TForm(Owner).Close;
end;

procedure ToForm.Finish;
begin
  FinishActive;

  if GenerateNote(True) then
  begin
    AcceptActive;
    TForm(Owner).OnCloseQuery := nil;
    Cancel;
  end;
end;

function ToForm.Preview(Note: TStringList; bFinishBtn: Boolean): Boolean;
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
    end else
      Result := False;
  finally
    ReviewNoteDlg.Free;
  end;
end;

procedure ToForm.BuildValueLine(var Validated: Boolean; var Note: TStringList; Sender: TWinControl);
var
  Item: TNoteItem;
  Title,Before,After: string;
  Space,Hide,Req: Boolean;
  I,ctI: Integer;
  lb: TStringList;
begin
  if not ControlVisible(Sender,Self) then
    Exit;
  if not Validated then
    Exit;

  if (Sender.ClassType = TPanel) or (Sender.ClassType = TGroupBox) then
  begin
    for I := 0 to Sender.ControlCount - 1 do
      if Validated then
        BuildValueLine(Validated, Note, TWinControl(Sender.Controls[I]))
      else
        begin
          Break;
          Exit;
        end;
  end else if Sender.ClassType = TPageControl then
  begin
    for I := 0 to TPageControl(Sender).PageCount - 1 do
      for ctI := 0 to TPageControl(Sender).Pages[I].ControlCount - 1 do
        if Validated then
          BuildValueLine(Validated, Note, TWinControl(TPageControl(Sender).Pages[I].Controls[ctI]))
        else
          begin
            Break;
            Exit;
          end;
  end;

  Item := ReportCollection.GetNoteItem(Sender);
  if Item <> nil then
  begin
    Title := Item.Title;
    Before := Item.Prefix;
    After := Item.Suffix;
    Space := Item.DoNotSpace;
    Hide := Item.HideFromNote;
    Req := Item.Required;
  end else
  begin
    Title := '';
    Before := '';
    After := '';
    Space := False;
    Hide := False;
    Req := False;
  end;

  try
    if Sender.ClassType = TLabel then
    begin
      if not Hide then
      begin
        if Title <> '' then
          Note.Add(Title);

        Note.Add(Before + TLabel(Sender).Caption + After);

        if not Space then
          Note.Add('');
      end;
    end else if Sender.ClassType = TDateTimePicker then
    begin
      if not Hide then
      begin
        if Title <> '' then
          Note.Add(Title);

        Note.Add(Before + DateToStr(TDateTimePicker(Sender).DateTime) + After);

        if not Space then
          Note.Add('');
      end
      else if Req then
      begin
        ShowMessage(VALID_MESS);
        TDateTimePicker(Sender).SetFocus;
        Validated := False;
      end;
    end
    else if Sender.ClassType = TEdit then
    begin
      if Trim(TEdit(Sender).Text) <> '' then
      begin
        if not Hide then
        begin
          if Title <> '' then
            Note.Add(Title);

          Note.Add(Before + TEdit(Sender).Text + After);

          if not Space then
            Note.Add('');
        end;
      end
      else if Req then
      begin
        ShowMessage(VALID_MESS);
        TEdit(Sender).SetFocus;
        Validated := False;
      end;
    end
    else if Sender.ClassType = TLabeledEdit then
    begin
      if Trim(TLabeledEdit(Sender).Text) <> '' then
      begin
        if not Hide then
        begin
          if Title <> '' then
            Note.Add(Title);

          Note.Add(Before + TLabeledEdit(Sender).Text + After);

          if not Space then
            Note.Add('');
        end;
      end
      else if Req then
      begin
        ShowMessage(VALID_MESS);
        TLabeledEdit(Sender).SetFocus;
        Validated := False;
      end;
    end
    else if Sender.ClassType = TCheckBox then
    begin
      if TCheckBox(Sender).Checked then
      if not Hide then
      begin
        if Title <> '' then
          Note.Add(Title);

        Note.Add(Before + TCheckBox(Sender).Caption + After);

        if not Space then
          Note.Add('');
      end;
    end
    else if Sender.ClassType = TCheckListBox then
    begin
      if not Hide then
      begin
        if Title <> '' then
          Note.Add(Title);

        for I := 0 to TCheckListBox(Sender).Count - 1 do
          if TCheckListBox(Sender).Selected[I] then
            Note.Add(Before + TCheckListBox(Sender).Items[I] + After);

        if not Space then
          Note.Add('');
      end;
    end
    else if Sender.ClassType = TRadioButton then
    begin
      if TRadioButton(Sender).Checked then
      if not Hide then
      begin
        if Title <> '' then
          Note.Add(Title);

        Note.Add(Before + TRadioButton(Sender).Caption + After);

        if not Space then
          Note.Add('');
      end;
    end
    else if Sender.ClassType = TRadioGroup then
    begin
      if TRadioGroup(Sender).ItemIndex <> -1 then
      if not Hide then
      begin
        if Title <> '' then
          Note.Add(Title);

        Note.Add(TRadioGroup(Sender).Caption);
        Note.Add(Before + TRadioGroup(Sender).Items.Strings[TRadioGroup(Sender).ItemIndex] + After);

        if not Space then
          Note.Add('');
      end;
    end
    else if Sender.ClassType = TSpinEdit then
    begin
      if not Hide then
      begin
        if Title <> '' then
          Note.Add(Title);

        Note.Add(Before + TSpinEdit(Sender).Text + After);

        if not Space then
          Note.Add('');
      end;
    end
    else if Sender.ClassType = TComboBox then
    begin
      if Trim(TComboBox(Sender).Text) <> '' then
      begin
        if not Hide then
        begin
          if Title <> '' then
            Note.Add(Title);

          Note.Add(Before + TComboBox(Sender).Text + After);

          if not Space then
            Note.Add('');
        end;
      end
      else if Req then
      begin
        ShowMessage(VALID_MESS);
        TComboBox(Sender).SetFocus;
        Validated := False;
      end;
    end
    else if Sender.ClassType = TListBox then
    begin
      if not Hide then
      begin
        lb := TStringList.Create;
        try
          for I := 0 to TListBox(Sender).Count - 1 do
            lb.Add(TListBox(Sender).Items[I]);

          if lb.Count > 0 then
          begin
            if Title <> '' then
              Note.Add(Title);

            for I := 0 to lb.Count - 1 do
            begin
              if Trim(lb[I]) <> '' then
              Note.Add(Before + lb[I] + After);
            end;

            if not Space then
              Note.Add('');
          end
          else if Req then
          begin
            ShowMessage(VALID_MESS);
            TListBox(Sender).SetFocus;
            Validated := False;
          end;
        finally
          lb.Free;
        end;
      end;
    end
    else if Sender.ClassType = TMemo then
    begin
      if not Hide then
      begin
        if TMemo(Sender).Lines.Count > 0 then
        begin
          if Title <> '' then
            Note.Add(Title);

          for I := 0 to TMemo(Sender).Lines.Count - 1 do
            Note.Add(Before + TMemo(Sender).Lines.Strings[I] + After);

          if not Space then
            Note.Add('');
        end else if Req then
        begin
          ShowMessage(VALID_MESS);
          TMemo(Sender).SetFocus;
          Validated := False;
        end;
      end;
    end
    else if Sender.ClassType = TRichEdit then
    begin
      if not Hide then
      begin
        if TRichEdit(Sender).Lines.Count > 0 then
        begin
          if Title <> '' then
            Note.Add(Title);

          for I := 0 to TRichEdit(Sender).Lines.Count - 1 do
            Note.Add(Before + TRichEdit(Sender).Lines.Strings[I] + After);

          if not Space then
            Note.Add('');
        end else if Req then
        begin
          ShowMessage(VALID_MESS);
          TRichEdit(Sender).SetFocus;
          Validated := False;
        end;
      end;
    end
    else if Sender.ClassType = TfVitals then
    begin
      if not Hide then
        Note.AddStrings(TfVitals(Sender).GetCompleteNote);

      if not Space then
        Note.Add('');
    end

//    else if ClassRef = 'TGroupBox' then
//    begin
//      if not Hide then
//      begin
//        lb := TStringList.Create;
//        try
//          lb.Add(TGroupBox(Sender).Caption);
//
//          if Title <> '' then
//            lb.Add(Title);
//
//          for I := 0 to TGroupBox(Sender).ControlCount - 1 do
//          begin
//            if TGroupBox(Sender).Controls[I] is TLabel then
//              lb.Add(Before + TLabel(TGroupBox(Sender).Controls[I]).Caption + After)
//            else if TGroupBox(Sender).Controls[I] is TMemo then
//            begin
//              for ctI := 0 to TMemo(TGroupBox(Sender).Controls[I]).Lines.Count - 1 do
//                lb.Add(Before + TMemo(TGroupBox(Sender).Controls[I]).Lines.Strings[ctI] + After);
//            end else if TGroupBox(Sender).Controls[I] is TRichEdit then
//            begin
//              for ctI := 0 to TRichEdit(TGroupBox(Sender).Controls[I]).Lines.Count - 1 do
//                lb.Add(Before + TRichEdit(TGroupBox(Sender).Controls[I]).Lines.Strings[ctI] + After);
//            end;
//          end;
//
//          if ((Title <> '') and (lb.Count > 1)) or ((Title = '') and (lb.Count > 0)) then
//          begin
//            Note.AddStrings(lb);
//
//            if not Space then
//              Note.Add('');
//          end;
//        finally
//          lb.Free;
//        end;
//      end;
//    end

  except
  end;
end;

function ToForm.GenerateNote(bFinishBtn: Boolean): Boolean;
var
  I,ctI: Integer;
  Note,ml: TStringList;
  Validated: Boolean;
  ccSort: array of TNoteItem;
  Item: TNoteItem;
  Sender: TObject;

  procedure GetItemOrder(var ccSort: array of TNoteItem; cc: TControl);
  var
    I,ctI: Integer;
    Item: TNoteItem;
  begin
    if cc is TPanel then
    begin
      for I := 0 to TPanel(cc).ControlCount - 1 do
        GetItemOrder(ccSort, TPanel(cc).Controls[I]);
    end else if cc is TGroupBox then
    begin
      for I := 0 to TGroupBox(cc).ControlCount - 1 do
        GetItemOrder(ccSort, TGroupBox(cc).Controls[I]);
    end else if cc is TPageControl then
    begin
      for I := 0 to TPageControl(cc).PageCount - 1 do
        for ctI := 0 to TPageControl(cc).Pages[I].ControlCount - 1 do
          GetItemOrder(ccSort, TPageControl(cc).Pages[I].Controls[ctI]);
    end else
    begin
      Item := ReportCollection.GetNoteItem(TWinControl(cc));

      if Item <> nil then
        if Item.Order > 0 then
          ccSort[Item.Order] := Item;
    end;
  end;

begin
  Validated := True;
  Result := False;
  FValidated := False;
  FReturnList.Clear;

  if Assigned(FOnpbOverrideNote) then
  begin
    onOverrideNote(Sender);
    Result := FValidated;

    if not FValidated then
      Exit;

    if bFinishBtn then
    begin
      Result := Preview(TmpStrList, bFinishBtn);
      if Result then
        Save(False);
    end else
      Preview(TmpStrList, bFinishBtn);
  end else
  begin
    Note := TStringList.Create;
    try
      //To use the configured order we have to loop on ReportItems
      //but VistA Configuration will allow this to be changed from
      //the first configured values
      if FMultiInterface then
      begin
        SetLength(ccSort, TForm(Owner).ComponentCount);
        ml := TStringList.Create;
        try
          for I := 0 to PageCount - 1 do
            if Pages[I].TabVisible then
              for ctI := 0 to Pages[I].ControlCount - 1 do
                GetItemOrder(ccSort, Pages[I].Controls[ctI]);

          for I := 0 to Length(ccSort) - 1 do
            if ccSort[I] <> nil then
              if Validated then
              begin
                if ml.IndexOf(ccSort[I].Page) < 0 then
                begin
                  Note.Add('-------------------------------------------------------------------------------');
                  Note.Add(ccSort[I].Page);
                  Note.Add('-------------------------------------------------------------------------------');
                  ml.Add(ccSort[I].Page);
                end;

                BuildValueLine(Validated, Note, ccSort[I].OwningObject)
              end else begin
                Break;
                Exit;
              end;
        finally
          ml.Free;
          SetLength(ccSort,0);
        end;
      end else
      begin
        for I := 0 to ReportCollection.Count - 1 do
          if ReportCollection.Items[I].OwningObject <> nil then
          begin
            if Validated then
              BuildValueLine(Validated, Note, ReportCollection.Items[I].OwningObject)
            else begin
              Break;
              Exit;
            end;
          end;
      end;

      if bFinishBtn then
      begin
        Result := Preview(Note, bFinishBtn);
        if Result then
          Save(False);
      end else 
        Preview(Note, bFinishBtn);
    finally
      Note.Free;
    end;
  end;
end;

procedure ToForm.WMSave(var Message: TMessage);
begin
  inherited;
  Save(True);
end;

procedure ToForm.Save(auto: Boolean);
var
  Build,Note: TStringList;
  I,ctI,ntI: Integer;
  Item: TNoteItem;

  procedure Submit(iForm: string);
  var
    I: Integer;
  begin
    try
      RPCBrokerV.SetContext(MENU_CONTEXT);
      if auto then
        Tasks.Add(RPCBrokerV.sCallV('DSIO DDCS STORE', [RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN, iForm, Note, 1]))
      else
        RPCBrokerV.CallV('DSIO DDCS STORE', [RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN, iForm, Note]);

      for I := 0 to PageCount - 1 do
        if ((ToPage(Pages[I]).TabVisible) and (ToPage(Pages[I]).FVitalComp <> nil)) then
        begin
          ToPage(Pages[I]).FVitalComp.Save;
          Break;
        end;
    except
    end;
  end;

begin
  if not ControlPanel.SaveButton.Enabled then
    Exit;

  ControlPanel.SaveButton.Enabled := False;

  Build := TStringList.Create; Note := TStringList.Create;
  try
    if FMultiInterface then
    begin
      for I := 0 to RPCBrokerV.DDCSInterfacePages.Count - 1 do
      begin
        Note.Clear;

        for ctI := 0 to ReportCollection.Count - 1 do
        begin
          Item := ReportCollection.Items[ctI];
          if Item.Page = RPCBrokerV.DDCSInterfacePages[I] then
          begin
            if not Item.DoNotSave then
            begin
              Build.Clear;
              try
                Build := BuildDiscreetData(Item.OwningObject);
                if Build.Count > 0 then
                  Note.AddStrings(Build);
              except
              end;
            end;
          end;
        end;

        if Note.Count > 0 then
          Submit(RPCBrokerV.DDCSInterfacePages[I]);
      end;
    end else
    begin
      for I := 0 to ReportCollection.Count - 1 do
      begin
        Item := ReportCollection.Items[I];

        if not Item.DoNotSave then
        begin
          Build.Clear;
          try
            Build := BuildDiscreetData(Item.OwningObject);
            if Build.Count > 0 then
              Note.AddStrings(Build);
          except
          end;
        end;
      end;

      if Note.Count > 0 then
        Submit(RPCBrokerV.DDCSInterface);
    end;

  finally
    Build.Free;
    Note.Free;
    ControlPanel.SaveButton.Enabled := True;
  end;
end;

destructor ToForm.Destroy;
begin
  if RCollection <> nil then
    RCollection := nil;

  FReturnList.Free;
  FReportItemList.Free;

  if not (csDesigning in ComponentState) then
  begin
    SetLength(TabCaptions, 0);
    Tasks.Free;
    DLLDialogList.Free;
    FreeLibrary(DialogDLL);
  end;

  inherited Destroy;
end;

{$ENDREGION}

initialization
  RegisterClass(ToCNTDialog);
  RegisterClass(ToPage);
  RegisterClass(ToForm);
  RegisterClass(TfVitals);

end.
