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
  ShareMem, Windows, SysUtils, Messages, Classes, Graphics, Controls, Forms, Dialogs,
  Extctrls, Buttons, Tabs, Menus, ComCtrls, StdCtrls, TypInfo, Contnrs, Spin,
  CheckLst, JvStringGrid, Jvspin,
  CPRSChart_TLB, uReportItems, frmVitals, uExtndComBroker;

const
  U = '^';
  MENU_CONTEXT = 'DSIO OCNT CONTEXT';
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

  TGetTmpStrList = function: TStringList of object;

  { Dialog Custom Form }
  ToCNTDialog = class(TForm)
  private
    FReturnList: TStringList;
    FDebugMode: Boolean;
    FAction: string;
    FShare: Boolean;
    FRestore: Boolean;
    FIEN: string;
    FEmbedded: Boolean;
    FConfiguration: TStringList;
    FOnGetTmpStrList: TGetTmpStrList;
  protected
  public
    constructor Create(AOwner: TComponent; Broker: PCPRSComBroker; DebugMode: Boolean; iIEN: string); overload;
    destructor Destroy; override;
    procedure Save;
    procedure VistASetUp;
    procedure DialogClose(Sender: TObject; var Action: TCloseAction);
    function GetConfigDataButtonDClass(Button: string): string;
    function BuildDiscreetData(Sender: TObject; Fld: string): TStringList;
    property TmpStrList: TStringList read FReturnList write FReturnList;
    property DebugMode: Boolean read FDebugMode write FDebugMode;
    property IEN: string read FIEN write FIEN;
    property Share: Boolean read FShare write FShare;
    property Action: string read FAction write FAction;
    property Configuration: TStringList read FConfiguration write FConfiguration;
    property Embedded: Boolean read FEmbedded write FEmbedded;
    property Restored: Boolean read FRestore write FRestore;
  published
    property OnGetTmpStrList: TGetTmpStrList read FOnGetTmpStrList write FOnGetTmpStrList;
  end;
  TPoCNTDialog = ^ToCNTDialog;

  TDialogClass = class of ToCNTDialog;

  { ToPage }
  ToPage = class(TTabSheet)
  private
    FVstatus: Boolean;
    FVitalComp: TfVitals;
    FEmbedForm: ToCNTDialog;
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

  TpbFinishEvent = procedure(Sender: TObject; pbFinish: boolean) of Object;
  TpbSaveEvent = procedure(Sender: TObject; AutoSave: boolean) of Object;
  TpbRestoreEvent = procedure(Sender: TObject) of Object;
  TpbFormShow = procedure(Sender: TObject) of object;

 { ToForm }
  ToForm = class(TPageControl)
  private
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
//    procedure Restore;
    procedure VistASetUp;
    procedure ControlExceptions(Sender: TObject; E: Exception);
    function BuildValueLine(var Validated: Boolean; Sender: TWinControl): TStringList;
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
    function BuildDiscreetData(Sender: TObject; Fld: string): TStringList;
  published
    property DisableSplash: Boolean read FDisableSplash write SetDisableSplash default False;
    property ReportCollection: TNoteCollection read FReportCollection write SetNoteCollection;
    property OnSave: TpbSaveEvent read  FOnpbSave write FOnpbSave;
    property OnRestore: TpbRestoreEvent read  FOnpbRestore write FOnpbRestore;
    property OnpbFinish: TpbFinishEvent read FOnpbFinish write FOnpbFinish;
    property OnpbAccept: TpbFinishEvent read FOnpbAccept write FOnpbAccept;
    property onFormShow: TpbFormShow read FOnpbFormShow write FOnpbFormShow;
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

  TDisplayDialog = function(Broker: PCPRSComBroker; dlgName: string; DebugMode: Boolean): TStringList; stdcall;
  TRegisterDialogs = function: TStringList; stdcall;
  TGetDialogComponents = function(dlgName: string): TStringList; stdcall;
  TEmbedDialog = function(AOwner: Pointer; Broker: PCPRSComBroker; dlgName: string; DebugMode: Boolean): TPoCNTDialog; stdcall;

  procedure Fill(Sender: TObject; Val,Indx: string; SetUp: Boolean; var WPDelete: TList);
  function LoadDialogs: THandle;

  procedure Register;

var
  DialogDLL: THandle;
  DisplayDialog: TDisplayDialog;
  RegisterDialogs: TRegisterDialogs;
  GetDialogComponents: TGetDialogComponents;
  EmbedDialog: TEmbedDialog;
  DLLDialogList: TStringList;
  DLLDialogList2: TStringList;
  First: Boolean = True;
  Tasks: TStringList;    //array of autosave tasks to be canceled onClose of the oCNT
  oCNT: string;

implementation

uses
  Consts, frmAbout, frmSplash, frmNoteRvw, frmReportOrder, frmConfiguration;

const
  F_VERSION = '0.0.3.16';

procedure Register;
begin
  RegisterClass(ToCNTDialog);
  RegisterClass(TNoteCollection);
  RegisterClass(TNoteItem);
  RegisterClass(ToPage);
  RegisterClass(TfVitals);
  RegisterComponents('oCNT', [ToForm]);
end;

{------------------------------------------------------------------------------}

function LoadDialogs: THandle;
var
  Path: string;
  PathLen,I: Integer;

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

  try
    Result := SafeLoadLibrary(Path);

    if Result = 0 then
    ShowMessage('Unable to load DialogDLL at:' + #13#13 + Path);
  except
    on E: Exception do
    ShowMessage(E.Message);
  end;
end;

// Part of Restore and Initial Configuration except TCheckListBox which requires
// some setup to use dialogs
procedure Fill(Sender: TObject; Val,Indx: string; SetUp: Boolean; var WPDelete: TList);
var
  I: Integer;
  ClassRef: string;
  sl: TStringList;
  lvitem: TListItem;
  lvcolumn: TListColumn;
  emControl: TWinControl;
  new: Boolean;

  function ListViewCaption(lv: TListView; str: string): Integer;
  var
    I: Integer;
  begin
    Result := -1;
    for I := 0 to lv.Items.Count - 1 do
    if lv.Items[I].Caption = str then
    begin
      Result := I;
      Break;
    end;
  end;

begin
  if Val = '' then Exit;
  ClassRef := Sender.ClassName;

  try
    if ClassRef = 'ToPage' then
    begin
      if DialogDLL <> 0 then
      begin
        ToPage(Sender).FEmbedForm := EmbedDialog(Pointer(ToPage(Sender)), @RPCBrokerV, Val, False)^;
        ToPage(Sender).Owner.InsertComponent(ToPage(Sender).FEmbedForm);
      end
      else ToPage(Sender).Visible := False;
    end
    else if ClassRef = 'TDateTimePicker' then
    TDateTimePicker(Sender).DateTime := StrToDate(Val)
    else if ClassRef = 'TEdit' then
    TEdit(Sender).Text := Val
    else if ClassRef = 'TLabeledEdit' then
    TLabeledEdit(Sender).Text := Val
    else if ClassRef = 'TCheckBox' then
    TCheckBox(Sender).Checked := True
    else if ClassRef = 'TRadioButton' then
    TRadioButton(Sender).Checked := True
    else if ClassRef = 'TRadioGroup' then
    TRadioGroup(Sender).ItemIndex := StrToInt(Indx)
    else if ClassRef = 'TSpinEdit' then
    TSpinEdit(Sender).Text := Val
    else if ClassRef = 'TJvSpinEdit' then
    TJvSpinEdit(Sender).Text := Val
    else if ClassRef = 'TComboBox' then
    begin
      if SetUp then
      TComboBox(Sender).Items.Add(Val)
      else
      begin
        for I := 0 to TComboBox(Sender).Items.Count do
        if TComboBox(Sender).Items[I] = Val then
        begin
          TComboBox(Sender).ItemIndex := I;
          break;
        end;
      end;
    end
    else if ClassRef = 'TListBox' then
    TListBox(Sender).Items.Add(Val)
    else if ClassRef = 'TCheckListBox' then
    begin
      if TCheckListBox(Sender).Items.IndexOf(Val) = -1 then
      TCheckListBox(Sender).Items.Add(Val);

      if indx = 'TRUE' then
      TCheckListBox(Sender).Checked[TCheckListBox(Sender).Items.IndexOf(Val)] := True;
    end else if ClassRef = 'TListView' then
    begin
      sl := TStringList.Create;
      try
        sl.Delimiter := '^'; sl.StrictDelimiter := True;
        sl.DelimitedText := Val;
        if Indx = '0' then
        begin
          for I := 0 to sl.Count - 1 do
          begin
            lvcolumn := TListView(Sender).Columns.Add;
            lvcolumn.AutoSize := True;
            lvcolumn.Caption := sl[I];
          end;
        end else
        begin
          for I := 0 to sl.Count - 1 do
          begin
            if I = 0 then
            begin
              if ((ListViewCaption(TListView(Sender), sl[I]) = -1) or (sl[I] = ''))  then
              begin
                new := true;
                lvitem := TListView(Sender).Items.Add
              end else
              lvitem := TListView(Sender).Items.Item[ListViewCaption(TListView(Sender), sl[I])];

              lvitem.Caption := sl[I];
            end else
            begin
              if new then
              lvitem.SubItems.Add(sl[I])
              else
              lvitem.SubItems[I-1] := sl[I];
            end;
            if TListView(Sender).Checkboxes then
            if indx = 'TRUE' then
            TListView(Sender).Items.Item[ListViewCaption(TListView(Sender), sl[I])].Checked := True;
          end;
        end;
      finally
        sl.Free;
      end;
    end else if ClassRef = 'TMemo' then
    begin
      if WPDelete.Indexof(Sender) = -1 then
      begin
        TMemo(Sender).Clear;
        WPDelete.Add(Sender);
      end;
      TMemo(Sender).Lines.Add(Val)
    end
    else if ClassRef = 'TRichEdit' then
    begin
      if WPDelete.Indexof(Sender) = -1 then
      begin
        TRichEdit(Sender).Clear;
        WPDelete.Add(Sender);
      end;
      TRichEdit(Sender).Lines.Add(Val)
    end
    else if ClassRef = 'TJvStringGrid' then
    begin
      if StrToInt(Piece(Indx,',',1)) > TJvStringGrid(Sender).ColCount - 1 then
      TJvStringGrid(Sender).InsertCol(StrToInt(Piece(Indx,',',1)));
      if StrToInt(Piece(Indx,',',2)) > TJvStringGrid(Sender).RowCount - 1 then
      TJvStringGrid(Sender).InsertRow(StrToInt(Piece(Indx,',',2)));

      TJvStringGrid(Sender).Cells[StrToInt(Piece(Indx,',',1)), StrToInt(Piece(Indx,',',2))] := Val;
      TJvStringGrid(Sender).AutoSizeCol(StrToInt(Piece(Indx,',',1)), Length(Val), 10);
    end;
  except
  end;
end;

{------------------------------------------------------------------------------}

{$REGION 'ToCNTDialog'}

constructor ToCNTDialog.Create(AOwner: TComponent; Broker: PCPRSComBroker; DebugMode: Boolean; iIEN: string);
var
  str: string;
begin
  inherited Create(AOwner);

  RPCBrokerV := Broker^;
  FDebugMode := DebugMode;
  FIEN := iIEN;
  Self.OnClose := Self.DialogClose;
  FReturnList := TStringList.Create;
  FConfiguration := TStringList.Create;

  try
    RPCBrokerV.SetContext(MENU_CONTEXT);
    str := RPCBrokerV.sCallV('DSIO OCNT DIALOG LOOKUP', [Self.ClassName, FIEN]);
    if FIEN = '' then FIEN := Piece(str,U,1);
    FShare := StrToBool(Piece(str,U,2));
    FAction := Piece(str,U,3);
  except
  end;
  VistASetUp;
end;

destructor ToCNTDialog.Destroy;
begin
//  if ((Self.Parent is TTabSheet) or (Self.Parent is ToPage)) then
//  Save;

  FConfiguration.Free;
  FReturnList.Free;
  inherited Destroy;
end;

procedure ToCNTDialog.DialogClose(Sender: TObject; var Action: TCloseAction);
begin
  if ModalResult <> mrCancel then
  begin
    if not DebugMode then
    Save;
  end;
  Action := caFree;
end;

function ToCNTDialog.GetConfigDataButtonDClass(Button: string): string;
var
  I: Integer;
begin
  for I := 0 to Configuration.Count - 1 do
  begin
    if ((Piece(Piece(Configuration[I],U,1),'|',2) = Button) and (Piece(Piece(Configuration[I],U,1),'|',1) <> '0')) then
    Result := Piece(Configuration[I],U,3) + U + Piece(Piece(Configuration[I],U,1),'|',3);
  end;
end;

function ToCNTDialog.BuildDiscreetData(Sender: TObject; Fld: string): TStringList;
var
  I,x: Integer;
  ClassRef,tmpstr: string;

begin
  Result := TStringList.Create;
  Result.Clear;
  ClassRef := Sender.ClassName;

  if ClassRef = 'TDateTimePicker' then
  Result.Add('S^' + TDateTimePicker(Sender).Name + U + Fld + '^^' + DateToStr(TDateTimePicker(Sender).DateTime))
  else if ClassRef = 'TEdit' then
  Result.Add('S^' + TEdit(Sender).Name + U + Fld + '^^' + TEdit(Sender).Text)
  else if ClassRef = 'TLabeledEdit' then
  Result.Add('S^' + TLabeledEdit(Sender).Name + U + Fld + '^^' + TLabeledEdit(Sender).Text)
  else if ClassRef = 'TCheckBox' then
  begin
    if TCheckBox(Sender).Checked then
    begin
      if TCheckBox(Sender).Caption <> '' then
      Result.Add('S^' + TCheckBox(Sender).Name + U + Fld + '^^' + TCheckBox(Sender).Caption)
      else
      Result.Add('S^' + TCheckBox(Sender).Name + U + Fld + '^^' + TCheckBox(Sender).Hint);
    end else if not TCheckBox(Sender).Checked then
    Result.Add('S^' + TCheckBox(Sender).Name + U + Fld + '^^');
  end
  else if ClassRef = 'TRadioButton' then
  begin
    if TRadioButton(Sender).Checked then
    begin
      if TRadioButton(Sender).Caption <> '' then
      Result.Add('S^' + TRadioButton(Sender).Name + U + Fld + '^^' + TRadioButton(Sender).Caption)
      else
      Result.Add('S^' + TRadioButton(Sender).Name + U + Fld + '^^' + TRadioButton(Sender).Hint);
    end
    else if not TRadioButton(Sender).Checked then
    Result.Add('S^' + TRadioButton(Sender).Name + U + Fld + '^^');
  end
  else if ClassRef = 'TRadioGroup' then
  begin
    if TRadioGroup(Sender).ItemIndex <> -1 then
    Result.Add('M^' + TRadioGroup(Sender).Name + U + Fld + U + IntToStr(TRadioGroup(Sender).ItemIndex) + U +
               TRadioGroup(Sender).Caption + ' - ' + TRadioGroup(Sender).Items.Strings[TRadioGroup(Sender).ItemIndex]);
  end
  else if ClassRef = 'TSpinEdit' then
  Result.Add('S^' + TSpinEdit(Sender).Name + U + Fld + '^^' + TSpinEdit(Sender).Text)
  else if ClassRef = 'TComboBox' then
  Result.Add('S^' + TComboBox(Sender).Name + U + Fld + '^^' + TComboBox(Sender).Text)
  else if ClassRef = 'TListBox' then
  begin
    for x := 0 to TListBox(Sender).Count - 1 do
    Result.Add('M^' + TListBox(Sender).Name + U + Fld + U + IntToStr(I) + U + TListBox(Sender).Items[x]);
  end else if ClassRef = 'TCheckListBox' then
  begin
    for x := 0 to TCheckListBox(Sender).Count - 1 do
    begin
      if TCheckListBox(Sender).Checked[x] then
      Result.Add('M^' + TCheckListBox(Sender).Name + U + Fld + U + 'TRUE' +
                 U + TCheckListBox(Sender).Items[x])
      else
      Result.Add('M^' + TCheckListBox(Sender).Name + U + Fld + U + 'FALSE' +
                 U + TCheckListBox(Sender).Items[x])
    end;
  end else if ClassRef = 'TListView' then
  begin
    for x := 0 to TListView(Sender).Items.Count - 1 do
    begin
      tmpstr := TListView(Sender).Items.Item[x].Caption;
      for I := 0 to TListView(Sender).Items.Item[x].SubItems.Count - 1 do
      tmpstr := tmpstr + U + TListView(Sender).Items.Item[x].SubItems[I];

      if TListView(Sender).Items[x].Checked then
      Result.Add('M^' + TListView(Sender).Name + U + Fld + U + 'TRUE' + U + tmpstr)
      else
      Result.Add('M^' + TListView(Sender).Name + U + Fld + U + 'FALSE' + U + tmpstr)
    end;
  end else if ClassRef = 'TMemo' then
  Result.Add('WP^' + TMemo(Sender).Name + U + Fld + '^^' + TMemo(Sender).Lines.Text)
  else if ClassRef = 'TRichEdit' then
  Result.Add('WP^' + TRichEdit(Sender).Name + U + Fld + '^^' + TRichEdit(Sender).Lines.Text)
  else if ClassRef = 'TJvStringGrid' then
  begin
    for I := 0 to TJvStringGrid(Sender).RowCount - 1 do
    for x := 0 to TJvStringGrid(Sender).ColCount - 1 do
    Result.Add('M^' + TJvStringGrid(Sender).Name + U + Fld + U + IntToStr(x) + ',' + IntToStr(I) + U +
               TJvStringGrid(Sender).Cells[x,I]);
  end;
end;

procedure ToCNTDialog.Save;
var
  Note,Build: TStringList;
  I: Integer;

begin
  try
    if (StrToInt(IEN) > 0) then
    begin
      Note := TStringList.Create;
      for I := 0 to ComponentCount - 1 do
      begin
        Build := TStringList.Create;
        try
          Build := BuildDiscreetData(Components[I], Components[I].Name);
          if Build.Count > 0 then
          Note.AddStrings(Build);
        finally
          Build.Free;
        end;
      end;

      if Note.Count > 0 then
      begin
        try
          RPCBrokerV.SetContext(MENU_CONTEXT);
          RPCBrokerV.CallV('DSIO DDCS STORE (DIRECT)', [RPCBrokerV.TIUNote.IEN, Note, 'D' + IEN]);
        except
        end;
      end;
      Note.Free;
    end;
  except
  end;
end;

procedure ToCNTDialog.VistASetUp;
var
  sl: TStringList;
  I,x: Integer;
  Control: TComponent;
  WPDelete: TList;

begin
  try
    if (StrToInt(IEN) > 0) then
    begin
      // Populate with Configuration Data
      sl := TStringList.Create;
      WPDelete := TList.Create;
      try
        for I := 0 to ComponentCount - 1 do
        begin
          try
            sl.Clear;

            RPCBrokerV.SetContext(MENU_CONTEXT);
            RPCBrokerV.tCallV(sl, 'DSIO OCNT DIALOG POPULATE', [IEN, Components[I].Name, RPCBrokerV.PatientDFN]);

            if sl.Count > 0 then
            begin
              for x := 0 to sl.Count - 1 do
              begin
                if x = 0 then
                begin
                  if sl[0] = '-1' then Break;
                  if sl[0] <> '' then Fill(Components[I], sl[0], '0', False, WPDelete);
                  Configuration.Add('0' + '|' + Components[I].Name + '|' + sl[x]);
                end else
                begin
                  if Components[I] is TButton then
                  TButton(Components[I]).OnClick := TButton(Components[I]).ButtonGetDialogClick
                  else Fill(Components[I], sl[x], '', True, WPDelete);

                  Configuration.Add(IntToStr(x) + '|' + Components[I].Name + '|' + sl[x]);
                end;
              end;
            end;

            if Components[I] is TComboBox then
            TComboBox(Components[I]).OnDropDown := TComboBox(Components[I]).cbAutoWidth;
          except
          end;
        end;
      finally
        WPDelete.Free;
        sl.Free;
      end;

      if not DebugMode then
      begin
        sl := TStringList.Create;
        WPDelete := TList.Create;
        try
          try
            RPCBrokerV.tCallV(sl, 'DSIO OCNT RESTORE', [RPCBrokerV.TIUNote.IEN, oCNT, IEN, RPCBrokerV.PatientDFN]);

            if ((sl.Count > 0) and (sl[0] <> '')) then
            begin
              FRestore := True;
              for I := 0 to sl.Count - 1 do
              begin
                Control := FindComponent(Piece(sl[I],U,1));
                if Control <> nil then
                begin
                  if Piece(sl[I],U,2) = '1' then
                  Fill(Control, Piece(sl[I],U,4,9999), Piece(sl[I],U,3), False, WPDelete)
                  else
                  Fill(Control, Piece(sl[I],U,3,9999), '', False, WPDelete);
                end;
              end;
            end;
          except
          end;
        finally
          WPDelete.Free;
          sl.Free;
        end;
      end;
    end;
  except
  end;
end;

{$ENDREGION}

{$REGION 'Helpers'}

{ Helper for TWinControl }
procedure TWinHelper.CheckListBoxGetDialogDBClick(Sender: TObject);
var
  Note: TNoteItem;
  sl: TStringList;

begin
  inherited;
  if not (Sender is TCheckListBox) then Exit;
  if TCheckListBox(Sender).ItemIndex = -1 then Exit;

  Note := RCollection^.GetNoteItem(Self);
  if Note = nil then Exit;

  if DialogDLL <> 0 then
  begin
    sl := TStringList.Create;
    try
      try
        sl.AddStrings(DisplayDialog(@RPCBrokerV, Piece(Note.Configuration[TCheckListBox(Sender).ItemIndex],U,2), False));
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
end;

procedure TWinHelper.ListBoxGetDialogDBClick(Sender: TObject);
var
  Note: TNoteItem;
  sl: TStringList;

begin
  inherited;
  if not (Sender is TListBox) then Exit;
  if TListBox(Sender).ItemIndex = -1 then Exit;

  Note := RCollection^.GetNoteItem(Self);
  if Note = nil then Exit;

  if DialogDLL <> 0 then
  begin
    sl := TStringList.Create;
    try
      try
        sl.AddStrings(DisplayDialog(@RPCBrokerV, Piece(Note.Configuration[TListBox(Sender).ItemIndex],U,2), False));
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
end;

procedure TWinHelper.ButtonGetDialogClick(Sender: TObject);
var
  Note: TNoteItem;
  sl: TStringList;
  DClass: string;
  DHandle: THandle;

begin
  inherited;
  if not (Sender is TButton) then Exit;

  if TButton(Sender).Owner.ClassParent = ToCNTDialog then
  begin
    DClass := ToCNTDialog(TButton(Sender).Owner).GetConfigDataButtonDClass(TButton(Sender).Name);
    DHandle := LoadDialogs;
    try
      if DHandle <> 0 then
      begin
        RegisterDialogs := GetProcAddress(DHandle, 'RegisterDialogs');
        DisplayDialog := GetProcAddress(DHandle, 'DisplayDialog');

        sl := TStringList.Create;
        try
          try
            sl.AddStrings(DisplayDialog(@RPCBrokerV, DClass, False));
          except
          end;
        finally
          sl.Free;
        end;
      end;
    finally
      FreeLibrary(DHandle);
    end;
  end
  else
  begin
    Note := RCollection^.GetNoteItem(Self);
    if Note = nil then Exit;

    if DialogDLL <> 0 then
    begin
      sl := TStringList.Create;
      try
        try
          sl.AddStrings(DisplayDialog(@RPCBrokerV, Piece(Note.Configuration[0],U,2), False));
        except
        end;

        if Note <> nil then
        begin
          if Note.DialogReturn is TMemo then
          TMemo(Note.DialogReturn).Lines.AddStrings(sl)
          else
          if Note.DialogReturn is TRichEdit then
          TRichEdit(Note.DialogReturn).Lines.AddStrings(sl);
        end;
      finally
        sl.Free;
      end;
    end;
  end;
end;

procedure TWinHelper.cbAutoWidth(Sender: TObject);
var
  cbLength,I: Integer;
begin
  if not (Sender is TComboBox) then Exit;

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

  SetLength(TabSeen, 0);

  if not (csDesigning in ComponentState) then
  begin
    FCMenu := TPopupMenu.Create(Self);
    FCItm := TMenuItem.Create(FCMenu);
    FCItm.Caption := 'Edit Configuration';
    FCItm.OnClick := ToForm(AOwner).EditConfiguration;
    if not RPCBrokerV.HasSecurityKey('DSIO OCNT CONFIGURATION') then
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
  ButtonWidth, ButtonHeight, ButtonLeft: Integer;
  ButtonTop, I: Integer;

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

procedure ToWizardButtonPanel.PageUpdate;

  function Hidden: Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to ToForm(Owner).PageCount - 1 do
    if not ToForm(Owner).Pages[I].TabVisible then
    Inc(Result);
  end;

begin
  if not (csDesigning in ComponentState) then
  begin
    if Length(TabSeen) < ToForm(Owner).PageCount then
    SetLength(TabSeen, ToForm(Owner).PageCount);

    if ToForm(Owner).ActivePageIndex <> -1 then
    TabSeen[ToForm(Owner).ActivePageIndex] := True;
  end;

  PageIndicator.Caption := IntToStr(ToForm(Owner).ActivePageIndex + 1) + ' of ' +
                                    IntToStr(ToForm(Owner).PageCount - Hidden);
  DisableButtons;
end;

{ Disable NextButton if the page is at the last-page and disable PrevButton if
  the page is at the first-page. }
procedure ToWizardButtonPanel.DisableButtons;
begin
  if not (csDesigning in ComponentState) then
  begin
    if (ToForm(Owner).ActivePageIndex + 1 = ToForm(Owner).PageCount) then
    NextButton.Enabled := False
    else
    NextButton.Enabled := True;

    if (ToForm(Owner).ActivePageIndex = 0) then
    PrevButton.Enabled := False
    else
    PrevButton.Enabled := True;
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
    ToForm(Owner).ActivePageIndex := ToForm(Owner).ActivePageIndex - 1;
    PageUpdate;
  end
  else if Sender = NextButton then
  begin
    { Perform page changes. }
    ToForm(Owner).ActivePageIndex := ToForm(Owner).ActivePageIndex + 1;
    PageUpdate;
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
procedure ToForm.EditConfiguration(Sender: TObject);
begin
  oCNTConfiguration.Show;
end;

procedure ToForm.ShowAbout(Sender: TObject);
begin
  oCNTAbout.ShowModal;
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

procedure ToForm.DrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  ARect,Ck,TmpRect: TRect;
  s: string;
  I,Tab: Integer;

  function GetCk: TRect;
  begin
    Result.Left := Rect.Left + 3;
    Result.Top :=  Rect.Top + 3;
    Result.Right := Result.Left + 12;
    Result.Bottom := Result.Top + 12;
  end;

begin
  s := Pages[TabIndex].Caption;
  ARect := Rect;
  Canvas.FillRect(Rect);

  //This needs to happen on starup and only once
  if First then
  begin
    ActivePageIndex := 0;
    TabIndex := 0;
    Tab := TabWidth;
    for I := 0 to PageCount - 1 do
    begin
      if Canvas.TextWidth(Pages[I].Caption) > Tab then
      Tab := Canvas.TextWidth(Pages[I].Caption);
    end;
    TabWidth := Tab + 30;
    First := False;
  end;

  Ck := Getck;
  Canvas.Rectangle(Ck);
  ARect.Left := Ck.Right + 3;
  InflateRect(ARect, 0, -3);
  if Length(ControlPanel.TabSeen) >= TabIndex + 1 then
  begin
    if ControlPanel.TabSeen[TabIndex] then
    DrawFrameControl(Canvas.Handle, Ck, DFC_BUTTON, DFCS_CHECKED)
    else
    DrawFrameControl(Canvas.Handle, Ck, DFC_BUTTON, DFCS_INACTIVE);
  end
  else
  DrawFrameControl(Canvas.Handle, Ck, DFC_BUTTON, DFCS_INACTIVE);

  Canvas.Brush.Style := bsClear;
  TmpRect := Rect;
  OffsetRect( TmpRect, 1, 1 );

  DrawText(Canvas.Handle, PChar(s), Length(s), ARect, DT_LEFT or DT_WORDBREAK or DT_CALCRECT);
  DrawText(Canvas.Handle, PChar(s), Length(s), ARect, DT_LEFT or DT_WORDBREAK);
end;

procedure ToForm.ControlExceptions(Sender: TObject; E: Exception);
begin
  if Pos('comctl32.dll', E.Message) > 0 then
  //Eat it!
end;

constructor ToForm.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited Create(AOwner);
  if AOwner.FindComponent('ofrm1') <> nil then
  raise EInvalidOperation.Create('Only one oCNT base allowed.');

  ControlPanel := ToWizardButtonPanel.Create(Self);
  ControlPanel.Parent := Self;
  ControlPanel.Align := alBottom;

  Align := alBottom;
  Anchors := [akLeft,akTop,akRight];

  // Tabs ------------------------
  TabPosition := tpTop;
  Style := tsButtons;
  OwnerDraw := True;
  OnDrawTab := DrawTab;
  TabHeight := 25;
  // Tabs -------------------------

  FVersion := F_VERSION;

  DLLDialogList := TStringList.Create;
  DLLDialogList2 := TStringList.Create;

  FReportItemList := TReportList.Create(True);
  FReportItemList.Owner := Self;
  FReportCollection := TNoteCollection.Create(Self, TNoteItem);

  // Needed for embedding dialogs
  if not (csDesigning in ComponentState) then
  begin
    Application.OnException := ControlExceptions;

    if not FDisableSplash then
    PostMessage(Handle, WM_SHOW_SPLASH, 0, 0);

    try
      try
        DialogDLL := LoadDialogs;
      except
      end;
    finally
      if DialogDLL = 0 then
      begin
        raise EInvalidOperation.Create('This oCNT requires the oCNTDialogs.dll to be present.')
//        MessageDlg('This oCNT requires the oCNTDialogs.dll to be present.', mtError, mbOKCancel, 0);
//        PostMessage(Self.Handle, WM_CLOSE, 0, 0);
      end else
      begin
        RegisterDialogs := GetProcAddress(DialogDLL, 'RegisterDialogs');
        DisplayDialog := GetProcAddress(DialogDLL, 'DisplayDialog');
        GetDialogComponents := GetProcAddress(DialogDLL, 'GetDialogComponents');
        EmbedDialog := GetProcAddress(DialogDLL, 'EmbedDialog');

        DLLDialogList.Clear; DLLDialogList2.Clear;
        DLLDialogList2.AddStrings(RegisterDialogs);
        for I := 0 to DLLDialogList2.Count - 1 do
        DLLDialogList.Add(Piece(DLLDialogList2[I],U,1));
      end;
    end;

    oCNT := ExtractFileName(GetModuleName(HInstance));
    RCollection := @FReportCollection;
    Tasks := TStringList.Create;

    TForm(Owner).OnCloseQuery := CloseQuery;
    TForm(Owner).OnClose := FormClose;
    TForm(Owner).OnShow := FormShow;
    TForm(Owner).AlphaBlend := True;
    TForm(Owner).AlphaBlendValue := 0;

    oCNTAbout := ToCNTAbout.Create(Self);

    FSaveTimer := TTimer.Create(Self);
    FSaveTimer.Name := 'AutoSaveTimer';
    FSaveTimer.Interval := 60000;
    FSaveTimer.OnTimer := OnAutoSaveTimer;
    FSaveTimer.Enabled := True;

    //Create the Configuration and Development Forms
    PostMessage(Handle, WM_CONFIG_DEV, 0, 0);

    SetLength(ControlPanel.TabSeen, PageCount);
    try
      UpdateControlPanel;
    except
    end;
  end;
end;

procedure ToForm.FormShow(Sender: TObject);
var
  sl: TStringList;
  I: Integer;
  Control: TComponent;
  WPDelete: TList;
begin
  sl := TStringList.Create;
  WPDelete := TList.Create;
  try
    try
      RPCBrokerV.tCallV(sl, 'DSIO OCNT RESTORE', [RPCBrokerV.TIUNote.IEN, oCNT]);

      if ((sl.Count > 0) and (sl[0] <> '')) then
      begin
        if MessageDlg('A backup note for this OCNT exists!' + #10#13 +
                      'If you wish to load it click "Yes."', mtInformation, mbYesNo, 0) = mrYes then
        begin
          VistASetUp;
          for I := 0 to sl.Count - 1 do
          begin
            if Owner is TForm then
            begin
              Control := TForm(Owner).FindComponent(Piece(sl[I],U,1));
              if Control <> nil then
              begin
                if Piece(sl[I],U,2) = '1' then
                Fill(Control, Piece(sl[I],U,4,9999), Piece(sl[I],U,3), False, WPDelete)
                else
                Fill(Control, Piece(sl[I],U,3,9999), '', False, WPDelete);
              end;
            end;
          end;
        end else
        begin
          RPCBrokerV.CallV('DSIO OCNT CLEAR NOTE DATA', [RPCBrokerV.TIUNote.IEN, oCNT]);
          VistASetUp;
        end;
      end else VistASetUp;
    except
      on E: Exception do
      ShowMessage(E.Message);
    end;
  finally
    WPDelete.Free;
    sl.Free;
  end;

//  Embeded dialogs were being restored before the restore method could clear if the
//  user did not wish to restore
//  try
//    //Populate From VistA from DSIO OCNT CONFIGURATION
//    VistASetUp;
//    Restore;
//  except
//  end;

  if Assigned(FOnpbFormShow) then
  FOnpbFormShow(Self);
  BringToFront;
end;

procedure ToForm.SetDisableSplash(Value: Boolean);
begin
  FDisableSplash := Value;
end;

procedure ToForm.WMShowSplash(var Message: TMessage);
begin
  inherited;
  oCNTSplash := ToCNTSplash.Create(nil);
  try
    oCNTSplash.Show;
    oCNTSplash.BringToFront;
    oCNTSplash.Update;
    Sleep(2000);
  finally
    oCNTSplash.Free;
    if Owner is TForm then
    TForm(Owner).AlphaBlend := False;
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
    BComponent: TComponent;
    WPDelete: TList;

  begin
    sl := TStringList.Create;
    WPDelete := TList.Create;
    try
      try
        RPCBrokerV.SetContext(MENU_CONTEXT);
        RPCBrokerV.tCallV(sl, 'DSIO OCNT POPULATE', [oCNT, AComponent.Name, RPCBrokerV.PatientDFN]);

        // 0: DISPLAY TEXT^ORDER^VISTA LABEL^PREFIX^SUFFIX^TITLE^DIALOG RETURN^REQUIRED^
        //    DO NOT SAVE^HIDE FROM NOTE
        // #: <ITEM DISPLAY>^UNIT NAME (IF A DIALOG)

        NItem := FReportCollection.GetNoteItem(TWinControl(AComponent));
        if NItem = nil then
        NItem := FReportCollection.AddNoteItem(TWinControl(AComponent));

        if sl.Count > 0 then    //Info from VistA that is not null will override existing ReportItem
        begin
          for I := 0 to sl.Count - 1 do
          begin
            if I = 0 then
            begin
              if sl[0] = '-1' then Break;
              if Piece(sl[0],U,1) <> '' then Fill(AComponent, Piece(sl[0],U,1), '0', False, WPDelete);
              if Piece(sl[0],U,2) <> '' then NItem.Order := StrToInt(Piece(sl[0],U,2));
              if Piece(sl[0],U,3) <> '' then NItem.VistALabel := Piece(sl[0],U,3);
              if Piece(sl[0],U,4) <> '' then NItem.Prefix := Piece(sl[0],U,4);
              if Piece(sl[0],U,5) <> '' then NItem.Suffix := Piece(sl[0],U,5);
              if Piece(sl[0],U,6) <> '' then NItem.Title := Piece(sl[0],U,6);
              if Piece(sl[0],U,7) <> '' then
              begin
                BComponent := Owner.FindComponent(Piece(sl[0],U,7));
                if BComponent <> nil then
                NItem.DialogReturn := TWinControl(BComponent);
              end;
              if Piece(sl[0],U,8) <> '' then NItem.Required := StrToBool(Piece(sl[0],U,8));
              if Piece(sl[0],U,9) <> '' then NItem.DoNotSave := StrToBool(Piece(sl[0],U,9));
              if Piece(sl[0],U,10) <> '' then NItem.HideFromNote := StrToBool(Piece(sl[0],U,10));
            end else
            begin
              NItem.Configuration.Add(sl[I]);
              if AComponent.ClassName = 'ToPage' then
              Fill(AComponent, Piece(sl[I],U,2), '', True, WPDelete)
              else
              begin
                if Piece(sl[0],U,11) = '1' then
                Fill(AComponent, Piece(sl[I],U,2,9999), Piece(sl[I],U,1), False, WPDelete)
                else
                Fill(AComponent, Piece(sl[I],U,1), '', True, WPDelete);
              end;
            end;
          end;
        end;

        if NItem.DialogReturn <> nil then
        begin
          if AComponent is TCheckListBox then
          TCheckListBox(AComponent).OnDblClick := TCheckListBox(AComponent).CheckListBoxGetDialogDBClick
          else if AComponent is TListBox then
          TListBox(AComponent).OnDblClick := TListBox(AComponent).ListBoxGetDialogDBClick
          else if AComponent is TButton then
          TButton(AComponent).OnClick := TButton(AComponent).ButtonGetDialogClick
          else if AComponent is TComboBox then
          TComboBox(AComponent).OnDropDown := TComboBox(AComponent).cbAutoWidth;
        end;
      except
      end;
    finally
      WPDelete.Free;
      sl.Free;
    end;
  end;

begin
  if not (csDesigning in ComponentState) then
  begin
    for I := 0 to Owner.ComponentCount - 1 do
    begin
      Pop(Owner.Components[I]);
    end;

    ReportCollection.ReIndex;
  end;
end;

procedure ToForm.SetNoteCollection(const Value: TNoteCollection);
begin
  FReportCollection.Assign(Value);
end;

procedure ToForm.WMConfigDev(var Message: TMessage);
begin
  inherited;
  oCNTConfiguration := ToCNTConfiguration.Create(Owner);
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
  case TPageOps(Message.PageOp) of
    poNext : begin
               if ActivePageIndex < PageCount - 1 then
               ActivePageIndex := ActivePageIndex + 1;
               Message.NewPage := Word(ActivePageIndex);
             end;
    poPrev : begin
               if ActivePageIndex > 0 then
               ActivePageIndex := ActivePageIndex - 1;
               Message.NewPage := Word(ActivePageIndex);
             end;
    poAbs  : begin
               ActivePageIndex := Integer(Message.Page);
             end;
  end;
end;

procedure ToForm.UMPanel(var Message: TUMPanel);
begin
  try
    case TPanelOps(Message.PanelOp) of
      pnCommand : ControlPanel.ShowMenu;
      pnSave : Save(False); //PostMessage(Handle, WM_SAVE, 0, 0);
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
  CanClose := True
  else CanClose := False;
end;

procedure ToForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  try
    try
      RPCBrokerV.CallV('DSIO OCNT CANCEL AUTOSAVE', [Tasks]);
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
    TForm(Owner).OnCloseQuery := CloseQuery;
  end;
end;

//procedure ToForm.Restore;
//var
//  sl: TStringList;
//  I: Integer;
//  Control: TComponent;
//  WPDelete: TList;
//begin
//  sl := TStringList.Create;
//  WPDelete := TList.Create;
//  try
//    try
//      RPCBrokerV.tCallV(sl, 'DSIO OCNT RESTORE', [RPCBrokerV.TIUNote.IEN, oCNT]);
//
//      if ((sl.Count > 0) and (sl[0] <> '')) then
//      if MessageDlg('A backup note for this OCNT exists!' + #10#13 +
//                    'If you wish to load it click "Yes."', mtInformation, mbYesNo, 0) = mrYes then
//      begin
//        for I := 0 to sl.Count - 1 do
//        begin
//          if Owner is TForm then
//          begin
//            Control := TForm(Owner).FindComponent(Piece(sl[I],U,1));
//            if Control <> nil then
//            begin
//              if Piece(sl[I],U,2) = '1' then
//              Fill(Control, Piece(sl[I],U,4,9999), Piece(sl[I],U,3), False, WPDelete)
//              else
//              Fill(Control, Piece(sl[I],U,3,9999), '', False, WPDelete);
//            end;
//          end;
//        end;
//      end else
//      RPCBrokerV.CallV('DSIO OCNT CLEAR NOTE DATA', [RPCBrokerV.TIUNote.IEN, oCNT]);
//    except
//      on E: Exception do
//      ShowMessage(E.Message);
//    end;
//  finally
//    WPDelete.Free;
//    sl.Free;
//  end;
//end;

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
      end
    else
    Result := False;
  finally
    ReviewNoteDlg.Free;
  end;
end;

function ToForm.BuildValueLine(var Validated: Boolean; Sender: TWinControl): TStringList;
var
  Item: TNoteItem;
  Title, Before, After: string;
  Hide,Req,Flag: Boolean;
  I: Integer;
  lb: TStringList;
  ClassRef: string;

begin
  Result := TStringList.Create;
  Result.Clear;
  ClassRef := Sender.ClassName;

  Item := ReportCollection.GetNoteItem(Sender);
  if Item <> nil then
  begin
    Title := Item.Title;
    Before := Item.Prefix;
    After := Item.Suffix;
    Hide := Item.HideFromNote;
    Req := Item.Required;
  end else
  begin
    Title := '';
    Before := '';
    After := '';
    Hide := False;
    Req := False;
  end;

  try
    if ClassRef = 'TGroupBox' then
    begin
      if not Hide then
      begin
        lb := TStringList.Create;
        try
          Flag := True;
          lb.Add(TGroupBox(Sender).Caption);
          if Title <> '' then lb.Add(Title);

          for I := 0 to TGroupBox(Sender).ControlCount - 1 do
          begin
            if TGroupBox(Sender).Controls[I] is TLabel then
            lb.Add(Before + TLabel(TGroupBox(Sender).Controls[I]).Caption + After)
            else begin
              Flag := False;
              Break;
            end;
          end;
          if Flag then
          begin
            Result.AddStrings(lb);
            Result.Add('');
          end;
        finally
          lb.Free;
        end;
      end;
    end
    else if ClassRef = 'TDateTimePicker' then
    begin
      if not Hide then
      begin
        if Title <> '' then Result.Add(Title);
        Result.Add(Before + DateToStr(TDateTimePicker(Sender).DateTime) + After);
        Result.Add('');
      end
      else if Req then
      begin
        ShowMessage(VALID_MESS);
        TDateTimePicker(Sender).SetFocus;
        Validated := False;
      end;
    end
    else if ClassRef = 'TEdit' then
    begin
      if Trim(TEdit(Sender).Text) <> '' then
      begin
        if not Hide then
        begin
          if Title <> '' then Result.Add(Title);
          Result.Add(Before + TEdit(Sender).Text + After);
          Result.Add('');
        end;
      end
      else if Req then
      begin
        ShowMessage(VALID_MESS);
        TEdit(Sender).SetFocus;
        Validated := False;
      end;
    end
    else if ClassRef = 'TLabeledEdit' then
    begin
      if Trim(TLabeledEdit(Sender).Text) <> '' then
      begin
        if not Hide then
        begin
          if Title <> '' then Result.Add(Title);
          Result.Add(Before + TLabeledEdit(Sender).Text + After);
          Result.Add('');
        end;
      end
      else if Req then
      begin
        ShowMessage(VALID_MESS);
        TLabeledEdit(Sender).SetFocus;
        Validated := False;
      end;
    end
    else if ClassRef = 'TCheckBox' then
    begin
      if TCheckBox(Sender).Checked then
      if not Hide then
      begin
        if Title <> '' then Result.Add(Title);
        Result.Add(Before + TCheckBox(Sender).Caption + After);
        Result.Add('');
      end;
    end
    else if ClassRef = 'TRadioButton' then
    begin
      if TRadioButton(Sender).Checked then
      if not Hide then
      begin
        if Title <> '' then Result.Add(Title);
        Result.Add(Before + TRadioButton(Sender).Caption + After);
        Result.Add('');
      end;
    end
    else if ClassRef = 'TRadioGroup' then
    begin
      if TRadioGroup(Sender).ItemIndex <> -1 then
      if not Hide then
      begin
        if Title <> '' then Result.Add(Title);
        Result.Add(TRadioGroup(Sender).Caption);
        Result.Add(Before + TRadioGroup(Sender).Items.Strings[TRadioGroup(Sender).ItemIndex] + After);
        Result.Add('');
      end;
    end
    else if ClassRef = 'TSpinEdit' then
    begin
      if not Hide then
      begin
        if Title <> '' then Result.Add(Title);
        Result.Add(Before + TSpinEdit(Sender).Text + After);
        Result.Add('');
      end;
    end
    else if ClassRef = 'TComboBox' then
    begin
      if Trim(TComboBox(Sender).Text) <> '' then
      begin
        if not Hide then
        begin
          if Title <> '' then Result.Add(Title);
          Result.Add(Before + TComboBox(Sender).Text + After);
          Result.Add('');
        end;
      end
      else if Req then
      begin
        ShowMessage(VALID_MESS);
        TComboBox(Sender).SetFocus;
        Validated := False;
      end;
    end
    else if ClassRef = 'TListBox' then
    begin
      if not Hide then
      begin
        lb := TStringList.Create;
        try
          for I := 0 to TListBox(Sender).Count - 1 do
          lb.Add(TListBox(Sender).Items[I]);

          if lb.Count > 0 then
          begin
            if Title <> '' then Result.Add(Title);
            for I := 0 to lb.Count - 1 do
            begin
              if Trim(lb[I]) <> '' then
              Result.Add(Before + lb[I] + After);
            end;
            Result.Add('');
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
    else if ClassRef = 'TMemo' then
    begin
      if not Hide then
      begin
        if TMemo(Sender).Lines.Count > 0 then
        begin
          if Title <> '' then Result.Add(Title);
          for I := 0 to TMemo(Sender).Lines.Count - 1 do
          Result.Add(Before + TMemo(Sender).Lines.Strings[I] + After);

          Result.Add('');
        end else if Req then
        begin
          ShowMessage(VALID_MESS);
          TMemo(Sender).SetFocus;
          Validated := False;
        end;
      end;
    end
    else if ClassRef = 'TRichEdit' then
    begin
      if not Hide then
      begin
        if TRichEdit(Sender).Lines.Count > 0 then
        begin
          if Title <> '' then Result.Add(Title);
          for I := 0 to TRichEdit(Sender).Lines.Count - 1 do
          Result.Add(Before + TRichEdit(Sender).Lines.Strings[I] + After);

          Result.Add('');
        end else if Req then
        begin
          ShowMessage(VALID_MESS);
          TRichEdit(Sender).SetFocus;
          Validated := False;
        end;
      end;
    end
    else if ClassRef = 'TfVitals' then
    begin
      if not Hide then
      Result.AddStrings(TfVitals(Sender).GetNote);
      Result.Add('');
    end
    else if ClassRef = 'ToPage' then
    begin
      if not Hide then
      begin
        if Assigned(ToPage(Sender).FEmbedForm) then
        begin
          Result.AddStrings(ToCNTDialog(ToPage(Sender).FEmbedForm).OnGetTmpStrList);
          Result.Add('');
        end;
      end;
    end;
  except
  end;
end;

function ToForm.GenerateNote(bFinishBtn: Boolean): Boolean;
var
  I: Integer;
  Note: TStringList;
  Validated: Boolean;

begin
  Validated := True;
  Result := False;

  Note := TStringList.Create;
  try
    //To use the configured order we have to loop on ReportItems
    //but VistA Configuration will allow this to be changed from
    //the first configured values
    for I := 0 to ReportCollection.Count - 1 do
    begin
      if Validated then
      Note.AddStrings(BuildValueLine(Validated, ReportCollection.Items[I].OwningObject))
      else
      begin
        Break;
        Exit;
      end;
    end;

    if bFinishBtn then
    begin
      Result := Preview(Note, bFinishBtn);
      if Result then
      Save(False);
    end
    else Preview(Note, bFinishBtn);
  finally
    Note.Free;
  end;
end;

function ToForm.BuildDiscreetData(Sender: TObject; Fld: string): TStringList;
var
  I,x: Integer;
  Note: TNoteItem;
  ClassRef,tmpstr: string;

  {
 ; EXAMPLE ARRAY:
 ; --------------
 ; (S,M,WP)^CONTROL^LABEL 1^INDEX(OPTIONAL ONLY FOR M)^VALUE
 ;  - M AND WP, AND HAVE REPEATED ENTRIES THAT WILL BE APPLIED TO ONE ENTRY
 ;
 ; IN THE CASE OF A "WP" OR A "M" THE NOTE TEXT ONLY HAS TO BE APPLIED TO ONE
 ; ENTRY PER CONTROL ENTRIES - THEY WILL BE PROCESSED AND CREATED AS A SINGLE
 ; ENTRY TO DSIO NOTE DATA.
 ;
 ; REMINDER DIALOG - FROM = R
 ; --------------------------
 ; (S,M,WP)^CLASS|IENS^CAPTION^INDEX(OPTIONAL ONLY FOR M)^VALUE
  }

begin
  Result := TStringList.Create;
  Result.Clear;
  if Sender = nil then Exit;

  ClassRef := Sender.ClassName;

  Note := ReportCollection.GetNoteItem(TWinControl(Sender));
  if Note = nil then Exit;

  if ClassRef = 'ToPage' then
  begin
    if ToPage(Sender).FEmbedForm <> nil then
    ToPage(Sender).FEmbedForm.Save;
  end else
  if ClassRef = 'TDateTimePicker' then
  Result.Add('S^' + TDateTimePicker(Sender).Name + U + Fld + '^^' + DateToStr(TDateTimePicker(Sender).DateTime))
  else if ClassRef = 'TEdit' then
  Result.Add('S^' + TEdit(Sender).Name + U + Fld + '^^' + TEdit(Sender).Text)
  else if ClassRef = 'TLabeledEdit' then
  Result.Add('S^' + TLabeledEdit(Sender).Name + U + Fld + '^^' + TLabeledEdit(Sender).Text)
  else if ClassRef = 'TCheckBox' then
  begin
    if TCheckBox(Sender).Checked then
    begin
      if TCheckBox(Sender).Caption <> '' then
      Result.Add('S^' + TCheckBox(Sender).Name + U + Fld + '^^' + TCheckBox(Sender).Caption)
      else
      Result.Add('S^' + TCheckBox(Sender).Name + U + Fld + '^^' + TCheckBox(Sender).Hint);
    end else if not TCheckBox(Sender).Checked then
    Result.Add('S^' + TCheckBox(Sender).Name + U + Fld + '^^');
  end
  else if ClassRef = 'TRadioButton' then
  begin
    if TRadioButton(Sender).Checked then
    begin
      if TRadioButton(Sender).Caption <> '' then
      Result.Add('S^' + TRadioButton(Sender).Name + U + Fld + '^^' + TRadioButton(Sender).Caption)
      else
      Result.Add('S^' + TRadioButton(Sender).Name + U + Fld + '^^' + TRadioButton(Sender).Hint);
    end
    else if not TRadioButton(Sender).Checked then
    Result.Add('S^' + TRadioButton(Sender).Name + U + Fld + '^^');
  end
  else if ClassRef = 'TRadioGroup' then
  begin
    if TRadioGroup(Sender).ItemIndex <> -1 then
    Result.Add('M^' + TRadioGroup(Sender).Name + U + Fld + U + IntToStr(TRadioGroup(Sender).ItemIndex) + U +
               TRadioGroup(Sender).Caption + ' - ' + TRadioGroup(Sender).Items.Strings[TRadioGroup(Sender).ItemIndex]);
  end
  else if ClassRef = 'TSpinEdit' then
  Result.Add('S^' + TSpinEdit(Sender).Name + U + Fld + '^^' + TSpinEdit(Sender).Text)
  else if ClassRef = 'TComboBox' then
  Result.Add('S^' + TComboBox(Sender).Name + U + Fld + '^^' + TComboBox(Sender).Text)
  else if ClassRef = 'TListBox' then
  begin
    if Note.Configuration.Count = TListBox(Sender).Count then
    begin
      for I := 0 to Note.Configuration.Count - 1 do
      begin
        if Piece(Note.Configuration[I],U,1) <> TListBox(Sender).Items[I] then
        begin
          for x := 0 to TListBox(Sender).Count - 1 do
          Result.Add('M^' + TListBox(Sender).Name + U + Fld + U + IntToStr(I) + U + TListBox(Sender).Items[x]);
          Break;
        end;
      end;
    end else
    begin
      for x := 0 to TListBox(Sender).Count - 1 do
      Result.Add('M^' + TListBox(Sender).Name + U + Fld + U + IntToStr(I) + U + TListBox(Sender).Items[x]);
    end;
  end
  else if ClassRef = 'TCheckListBox' then
  begin
    for x := 0 to TCheckListBox(Sender).Count - 1 do
    begin
      if TCheckListBox(Sender).Checked[x] then
      Result.Add('M^' + TCheckListBox(Sender).Name + U + Fld + U + 'TRUE' +
                 U + TCheckListBox(Sender).Items[x])
      else
      Result.Add('M^' + TCheckListBox(Sender).Name + U + Fld + U + 'FALSE' +
                 U + TCheckListBox(Sender).Items[x])
    end;
  end else if ClassRef = 'TListView' then
  begin
    for x := 0 to TListView(Sender).Items.Count - 1 do
    begin
      for I := 0 to TListView(Sender).Columns.Count - 1 do
      begin
        if I = 0 then tmpstr := TListView(Sender).Items[x].Caption
        else tmpstr := tmpstr + U + TListView(Sender).Items[x].SubItems[I-1];
      end;

      if TListView(Sender).Items[x].Checked then
      Result.Add('M^' + TListView(Sender).Name + U + Fld + U + 'TRUE' + U + tmpstr)
      else
      Result.Add('M^' + TListView(Sender).Name + U + Fld + U + 'FALSE' + U + tmpstr)
    end;
  end else if ClassRef = 'TMemo' then
  begin
    if Note.Configuration.Count = TMemo(Sender).Lines.Count then
    begin
      for I := 0 to Note.Configuration.Count - 1 do
      begin
        if Piece(Note.Configuration[I],U,1) <> TMemo(Sender).Lines.Strings[I] then
        begin
          for x := 0 to TMemo(Sender).Lines.Count - 1 do
          Result.Add('WP^' + TMemo(Sender).Name + U + Fld + '^^' + TMemo(Sender).Lines.Strings[x]);
          Break;
        end;
      end;
    end else
    begin
      for x := 0 to TMemo(Sender).Lines.Count - 1 do
      Result.Add('WP^' + TMemo(Sender).Name + U + Fld + '^^' + TMemo(Sender).Lines.Strings[x]);
    end;
  end else if ClassRef = 'TRichEdit' then
  begin
    if Note.Configuration.Count = TRichEdit(Sender).Lines.Count then
    begin
      for I := 0 to Note.Configuration.Count - 1 do
      begin
        if Piece(Note.Configuration[I],U,1) <> TRichEdit(Sender).Lines.Strings[I] then
        begin
          for x := 0 to TRichEdit(Sender).Lines.Count - 1 do
          Result.Add('WP^' + TRichEdit(Sender).Name + U + Fld + '^^' + TRichEdit(Sender).Lines.Strings[x]);
          Break;
        end;
      end;
    end else
    begin
      for x := 0 to TRichEdit(Sender).Lines.Count - 1 do
      Result.Add('WP^' + TRichEdit(Sender).Name + U + Fld + '^^' + TRichEdit(Sender).Lines.Strings[x]);
    end;
  end else if ClassRef = 'TJvStringGrid' then
  begin
    for I := 0 to TJvStringGrid(Sender).RowCount - 1 do
    for x := 0 to TJvStringGrid(Sender).ColCount - 1 do
    Result.Add('M^' + TJvStringGrid(Sender).Name + U + Fld + U + IntToStr(x) + ',' + IntToStr(I) + U +
               TJvStringGrid(Sender).Cells[x,I]);
  end else if ClassRef = 'TGroupBox' then
  begin
    if TGroupBox(Sender).ControlCount = 1 then
    begin
      if ((TGroupBox(Sender).Controls[0] is TLabel) and (TLabel(TGroupBox(Sender).Controls[0]).Caption <> '')) then
      Result.Add('S^' + TGroupBox(Sender).Name + U + Fld + '^^^' + TGroupBox(Sender).Caption + ' - ' + TLabel(TGroupBox(Sender).Controls[0]).Caption);
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
  Note,Build: TStringList;
  I: Integer;
  Item: TNoteItem;
  Fld: string;
begin
  // We need to check for Vitals and fire SaveDialogs before components are freed
  // because the embedded dialogs do have a save option
  if not auto then
  begin
    for I := 0 to PageCount - 1 do
    begin
      if ToPage(Pages[I]).VitalsStatus then
      begin
        ToPage(Pages[I]).FVitalComp.SaveDialogs;
        Break;
      end;
    end;
  end;

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
            Build := BuildDiscreetData(Item.OwningObject, Fld);
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
        if auto then
        Tasks.Add(RPCBrokerV.sCallV('DSIO DDCS STORE (TASK)', [RPCBrokerV.TIUNote.IEN, Note, 'C' + oCNT]))
        else
        RPCBrokerV.CallV('DSIO DDCS STORE (DIRECT)', [RPCBrokerV.TIUNote.IEN, Note, 'C' + oCNT]);
      except
      end;
    end;
  finally
    Note.Free;
  end;
end;

destructor ToForm.Destroy;
begin
  if RCollection <> nil then
  RCollection := nil;

  FReportItemList.Free;
  Tasks.Free;
  DLLDialogList.Free;
  DLLDialogList2.Free;
  FreeLibrary(DialogDLL);

  inherited Destroy;
end;

{$ENDREGION}

initialization
  RegisterClass(ToCNTDialog);
  RegisterClass(ToPage);
  RegisterClass(ToForm);
  RegisterClass(TfVitals);

end.
