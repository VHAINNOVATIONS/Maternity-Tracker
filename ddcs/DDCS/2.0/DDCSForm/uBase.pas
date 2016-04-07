unit uBase;

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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.ComCtrls, Vcl.Menus, Vcl.Themes, TypInfo, Contnrs, CheckLst,
  uReportItems, frmVitals, uCommon, uDialog, uExtndComBroker;

type
  TDDCSForm = class;

  TDDCSHeaderControl = class(THeaderControl)
  private
    FDDCSForm: TDDCSForm;
    FCommandMenu: TPopupMenu;
    FRememberSectionIndex: Integer;
    FSelectedSectionIndex: Integer;
    procedure SpeakButtons;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure FcEditConfigurationClick(Sender: TObject);
    procedure FcAboutClick(Sender: TObject);
    procedure FcChangeThemeClick(Sender: TObject);
  protected
    procedure DrawSection(Section: THeaderSection; const Rect: TRect;
      Pressed: Boolean); override;
    procedure SectionClick(Section: THeaderSection); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdateControlPanel;
  end;

  TTabControlStyleHookCheck = class(TTabControlStyleHook)
  private
  strict protected
    procedure DrawTab(Canvas: TCanvas; Index: Integer); override;
  public
    constructor Create(AControl: TWinControl); override;
  end;

  TpbSaveEvent = procedure(Sender: TObject; AutoSave: Boolean) of object;
  TpbFinishEvent = procedure(Sender: TObject; pbFinish: Boolean) of object;
  TpbCustomEvent = procedure(Sender: TObject) of object;

  TDDCSForm = class(TPageControl)
  private
    // Components --------------------------------------------------------------
    FControlPanel: TDDCSHeaderControl;
    FAutoSaveTimer: TTimer;           // Make as a custom component
    FVitalsForm: TDDCSVitals;
    FVitalsPage: TTabSheet;
    FReportCollection: TDDCSNoteCollection;
    // -------------------------------------------------------------------------
    FDisableSplash: Boolean;
    Tasks: TStringList;    //array of autosave tasks to be canceled onClose of the DDCS Form
    FMultiInterface: Boolean;
    FReturnList: TStringList;
    FValidated: Boolean;
    TabSeen: array of Boolean;
    // Events ------------------------------------------------------------------
    FOnpbSave: TpbSaveEvent;
    FOnpbFinish: TpbFinishEvent;
    FOnpbAccept: TpbFinishEvent;
    FOnpbRestore: TpbCustomEvent;
    FOnpbFormShow: TpbCustomEvent;
    FOnpbOverrideNote: TpbCustomEvent;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure WMAfterCreate(var Message: TMessage); message WM_AFTER_CREATE;
    procedure WMShowSplash(var Message: TMessage); message WM_SHOW_SPLASH;
    procedure WMConfigDev(var Message: TMessage); message WM_CONFIG_DEV;
    procedure WMSave(var Message: TMessage); message WM_SAVE;
    // Properties --------------------------------------------------------------
    procedure SetVitals(Page: TTabSheet);
    procedure SetDisableSplash(const Value: Boolean);
    procedure SetNoteCollection(const Value: TDDCSNoteCollection);
    //TCheckListbox
    procedure CheckListBoxGetDialogDBClick(Sender: TObject);
    //TListBox
    procedure ListBoxGetDialogDBClick(Sender: TObject);
    //TButton
    procedure ButtonGetDialogClick(Sender: TObject);
    //TComboBox
    procedure cbAutoWidth(Sender: TObject);
    // -------------------------------------------------------------------------
    procedure OnAutoSaveTimer(Sender: TObject);
    function ControlVisible(rControl: TWinControl): Boolean;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetUpControl(wControl: TWinControl);
    procedure DrawCheckTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure SaveActive;
    procedure AutoSaveActive;
    procedure RestoreActive;
    procedure FinishActive;
    procedure AcceptActive;
    procedure Save(aSave: Boolean);
    procedure Finish;
    procedure Cancel;
    function GenerateNote(bFinishBtn: Boolean): Boolean;
    function Preview(bFinishBtn: Boolean): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Change; override;
    // TForm -------------------------------------------------------------------
    procedure CloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    // -------------------------------------------------------------------------
    function HasSecurityKey(const KeyName: string): Boolean;
    function GetPatientAllergies: TStringList;
    function GetPatientActiveProblems: TStringList;
    function GetPatientActiveMedications: TStringList;
    property MultiInterface: Boolean read FMultiInterface write FMultiInterface;
    property TmpStrList: TStringList read FReturnList write FReturnList;
    property Validated: Boolean read FValidated write FValidated;
    property VitalsControl: TDDCSVitals read FVitalsForm write FVitalsForm;
  published
    property VitalsPage: TTabSheet read FVitalsPage write SetVitals;
    property DisableSplash: Boolean read FDisableSplash write SetDisableSplash default False;
    property ReportCollection: TDDCSNoteCollection read FReportCollection write SetNoteCollection;
    property OnSave: TpbSaveEvent read FOnpbSave write FOnpbSave;
    property OnFinish: TpbFinishEvent read FOnpbFinish write FOnpbFinish;
    property OnAccept: TpbFinishEvent read FOnpbAccept write FOnpbAccept;
    property OnRestore: TpbCustomEvent read FOnpbRestore write FOnpbRestore;
    property OnOverrideNote: TpbCustomEvent read FOnpbOverrideNote write FOnpbOverrideNote;
  end;

  procedure Register;

implementation

uses
  Vcl.Styles, Consts, frmSplash, frmPreview, frmReportOrder, frmConfiguration, frmAbout;

procedure Register;
begin
  RegisterClass(TDDCSDialog);
  RegisterClass(TDDCSNoteCollection);
  RegisterClass(TDDCSNoteItem);
  RegisterClass(TDDCSHeaderControl);
  RegisterNoIcon([TDDCSVitals]);
  RegisterComponents('DDCSForm', [TDDCSForm]);
end;

{$REGION 'TDDCSHeaderControl'}

// Private ---------------------------------------------------------------------

procedure TDDCSHeaderControl.SpeakButtons;
begin
  if FSelectedSectionIndex = 0 then
    ScreenReader.Say('Command Menu', False)
  else ScreenReader.Say(Sections[FSelectedSectionIndex].Text, False);
end;

procedure TDDCSHeaderControl.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;

  FSelectedSectionIndex := FRememberSectionIndex;
  if FSelectedSectionIndex = -1 then
    FSelectedSectionIndex := 0;

  SpeakButtons;

  Invalidate;
end;

procedure TDDCSHeaderControl.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;

  FRememberSectionIndex := FSelectedSectionIndex;
  FSelectedSectionIndex := -1;

  Invalidate;
end;

procedure TDDCSHeaderControl.KeyDown(var Key: Word; Shift: TShiftState);
begin
  // Prevent the reordering of the Control Panel Buttons
  if ((Shift = [ssCtrl]) and ((Key = VK_LEFT) or (Key = VK_RIGHT))) then
    Shift := [];

  inherited;

  // Key 37 = Left Arrow
  if Key = VK_LEFT then
  begin
    if FSelectedSectionIndex > 0 then
      FSelectedSectionIndex := FSelectedSectionIndex - 1
    else
      FSelectedSectionIndex := Sections.Count - 1;

    SpeakButtons;
  end;

  // Key 39 = Right Arrow
  if Key = VK_RIGHT then
  begin
    if FSelectedSectionIndex < Sections.Count - 1 then
      FSelectedSectionIndex := FSelectedSectionIndex + 1
    else
      FSelectedSectionIndex := 0;

    SpeakButtons;
  end;

  // Enter or Spacebar
  if (Key = VK_RETURN) or (Key = VK_SPACE) then
  begin
    if Sections[FSelectedSectionIndex].AllowClick then
      SectionClick(Sections[FSelectedSectionIndex]);
  end;

  // Tab - Exit the Control Panel
  if Key = VK_TAB then
    FDDCSForm.SetFocus;

  Invalidate;
end;

procedure TDDCSHeaderControl.KeyPress(var Key: Char);
begin
  inherited;
end;

procedure TDDCSHeaderControl.FcEditConfigurationClick(Sender: TObject);
begin
  DDCSFormConfig.Show;
end;

procedure TDDCSHeaderControl.FcAboutClick(Sender: TObject);
begin
  DDCSAbout := TDDCSAbout.Create(FDDCSForm);
  try
    DDCSAbout.ShowModal;
  finally
    DDCSAbout.Free;
  end;
end;

procedure TDDCSHeaderControl.FcChangeThemeClick(Sender: TObject);
var
  I: Integer;
  Style: string;
begin
  if Assigned(TStyleManager.ActiveStyle) and (TStyleManager.ActiveStyle.Name <> TMenuItem(Sender).Caption) then
  begin
    Style := TMenuItem(Sender).Caption;
    if Pos('&', Style) > 0 then
      Delete(Style, 1, 1);

    try
      if Style = 'Default' then
        TStyleManager.TrySetStyle('Windows')
      else
        TStyleManager.TrySetStyle(Style);

      TMenuItem(Sender).Checked := True;
    except
    end;
  end;
end;

// Protected -------------------------------------------------------------------

procedure TDDCSHeaderControl.DrawSection(Section: THeaderSection; const Rect: TRect; Pressed: Boolean);
var
  X,Y: Integer;
  R: TRect;
begin
  inherited;

  R := Rect;

  if Section.Index = FSelectedSectionIndex then
  begin
    Canvas.Brush.Style := bsSolid;
    Canvas.Brush.Color := clBtnHighlight;
  end else
  begin
    Canvas.Brush.Style := bsClear;
  end;
  Canvas.FillRect(R);

  if ((not Section.AllowClick) and (Section.Index <> 6)) then
    Canvas.Font.Color := clGrayText
  else
    Canvas.Font.Color := clWindowText;

  X := Round(R.Left + (R.Width div 2) - (Canvas.TextWidth(Section.Text) div 2));
  Y := Round(R.Top + (R.Height div 2) - (Canvas.TextHeight(Section.Text) div 2));
  Canvas.TextOut(X, Y, Section.Text);
end;

procedure TDDCSHeaderControl.SectionClick(Section: THeaderSection);

  procedure ShowMenu;
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
    APoint := ClientToScreen(Point(0, ClientHeight - Height - PopupMenuHeight(FCommandMenu) - 10));
    FCommandMenu.Popup(APoint.X, APoint.Y);
  end;

begin
  inherited;

  case Section.Index of
    0: ShowMenu;
    1: FDDCSForm.Save(False);
    2: FDDCSForm.Preview(False);
    3: FDDCSForm.Finish;
    4: FDDCSForm.Cancel;
    5: begin
         FDDCSForm.ActivePageIndex := FDDCSForm.ActivePageIndex - 1;
         FDDCSForm.Change;
       end;
    6: ;
    7: begin
         FDDCSForm.ActivePageIndex := FDDCSForm.ActivePageIndex + 1;
         FDDCSForm.Change;
       end;
  end;
end;

// Public ----------------------------------------------------------------------

constructor TDDCSHeaderControl.Create(AOwner: TComponent);
var
  FCommandItem: TMenuItem;
  I: Integer;

  procedure AddControlPanelButton(iIndex: Integer);
  begin
    Sections.Add;

    Sections[iIndex].Style := hsOwnerDraw;
    case iIndex of
     0: begin
          Sections[iIndex].AllowClick := True;
          Sections[iIndex].AutoSize := False;
          Sections[iIndex].FixedWidth := True;
          Sections[iIndex].Width := 30;
          Exit;
        end;
     1: begin
          Sections[iIndex].Text := 'Save';
        end;
     2: begin
          Sections[iIndex].Text := 'Preview';
        end;
     3: begin
          Sections[iIndex].Text := 'Finish';
        end;
     4: begin
          Sections[iIndex].Text := 'Cancel';
        end;
     5: begin
          Sections[iIndex].Text := 'Previous';
        end;
     6: begin
          Sections[iIndex].Text := '0 of 0';
          Sections[iIndex].AllowClick := False;
          Sections[iIndex].AutoSize := False;
          Sections[iIndex].FixedWidth := True;
          Sections[iIndex].Width := 100;
          Sections[iIndex].Alignment := taCenter;
          Exit;
        end;
     7: begin
          Sections[iIndex].Text := 'Next';
        end;
    end;

    Sections[iIndex].AllowClick := True;
    Sections[iIndex].AutoSize := True;
    Sections[iIndex].FixedWidth := False;
    Sections[iIndex].Width := 50;
    Sections[iIndex].Alignment := taCenter;
  end;

begin
  inherited;

  FDDCSForm := TDDCSForm(AOwner);
  FRememberSectionIndex := -1;
  FSelectedSectionIndex := -1;

  Align := alBottom;
  Height := 30;
  Style := hsButtons;
  DoubleBuffered := True;
  TabStop := True;
  TabOrder := 1;

  FCommandMenu := TPopupMenu.Create(Self);
  FCommandMenu.MenuAnimation := [maBottomToTop];

  FCommandItem := TMenuItem.Create(FCommandMenu);
  FCommandItem.Caption := 'About';
  FCommandItem.OnClick := FcAboutClick;
  FCommandMenu.Items.Add(FCommandItem);

  FCommandItem := TMenuItem.Create(FCommandMenu);
  FCommandItem.Caption := 'Edit Configuration';
  FCommandItem.OnClick := FcEditConfigurationClick;
  FCommandMenu.Items.Add(FCommandItem);

  FCommandItem := TMenuItem.Create(FCommandMenu);
  FCommandItem.Caption := 'Change Theme';
  FCommandItem.Enabled := False;
  FCommandMenu.Items.Add(FCommandItem);

  FCommandItem := TMenuItem.Create(FCommandMenu);
  FCommandItem.Caption := 'Default';
  FCommandItem.OnClick := FcChangeThemeClick;
  FCommandMenu.Items[2].Add(FCommandItem);
  FCommandItem.Click;                           // Including other themes but use Default for now

  FCommandItem := TMenuItem.Create(FCommandMenu);
  FCommandItem.Caption := 'Windows10';
  FCommandItem.OnClick := FcChangeThemeClick;
  FCommandMenu.Items[2].Add(FCommandItem);

  for I := 0 to 7 do AddControlPanelButton(I);
end;

destructor TDDCSHeaderControl.Destroy;
begin
  inherited;
end;

procedure TDDCSHeaderControl.UpdateControlPanel;
var
  I: Integer;
begin
  // Next
  if FDDCSForm.ActivePageIndex = (FDDCSForm.PageCount - 1) then
    FDDCSForm.FControlPanel.Sections[7].AllowClick := False
  else
    FDDCSForm.FControlPanel.Sections[7].AllowClick := True;

  // Previous
  if FDDCSForm.ActivePageIndex <= 0 then
    FDDCSForm.FControlPanel.Sections[5].AllowClick := False
  else
    FDDCSForm.FControlPanel.Sections[5].AllowClick := True;

  // Page Indicator
  for I := 0 to FDDCSForm.PageCount - 1 do
    if FDDCSForm.Pages[I] = FDDCSForm.ActivePage then
    begin
      FDDCSForm.FControlPanel.Sections[6].Text := IntToStr(I+1) + ' of ' + IntToStr(FDDCSForm.PageCount);
      Break;
    end;

  Invalidate;
end;

{$ENDREGION}

{$REGION 'TTabControlStyleHookCheck'}

constructor TTabControlStyleHookCheck.Create(AControl: TWinControl);
begin
  inherited;
end;

// 03/28/2016 - This isn't right - don't use themes yet
procedure TTabControlStyleHookCheck.DrawTab(Canvas: TCanvas; Index: Integer);
var
  FButtonState: TThemedButton;
  Details: TThemedElementDetails;
  thisTab,rCheckBox: TRect;
  ThemeTextColor: TColor;

    function GetButtonCheckRect(Index: Integer): TRect;
    var
      FButtonState: TThemedButton;
      Details: TThemedElementDetails;
      R,ButtonR: TRect;
    begin
      R := TabRect[Index];
      if R.Left < 0 then Exit;

      if TabPosition in [tpTop, tpBottom] then
      begin
        if Index = TabIndex then
          InflateRect(R, 0, 2);
      end else
      if Index = TabIndex then
        Dec(R.Left, 2)
      else
        Dec(R.Right, 2);

      Result := R;

      Details := StyleServices.GetElementDetails(FButtonState);
      if not StyleServices.GetElementContentRect(0, Details, Result, ButtonR) then
        ButtonR := Rect(0, 0, 0, 0);

      // Return the size of the checkbox (ButtonR turns out to be the same as R)
      Result.Left := Result.Right - Result.Width - 10;
      Result.Width := 50;
    end;

begin
  inherited;

  if Control is TDDCSForm then
  begin
    if ((Length(TDDCSForm(Control).TabSeen) > 0) and (TDDCSForm(Control).TabSeen[Index])) then
      FButtonState := tbCheckBoxCheckedNormal
    else if Index = TabIndex then
      FButtonState := tbCheckBoxCheckedNormal
    else
      FButtonState := tbCheckBoxUncheckedNormal;

    Details := StyleServices.GetElementDetails(FButtonState);

    thisTab := TabRect[Index];
    Canvas.FillRect(thisTab);

    rCheckBox := GetButtonCheckRect(Index);

    thisTab.Left := rCheckBox.Right + 3;
    InflateRect(thisTab, -3, -5);

    StyleServices.DrawElement(Canvas.Handle, Details, rCheckBox);

    if StyleServices.GetElementColor(Details, ecTextColor, ThemeTextColor) then
      Canvas.Font.Color := ThemeTextColor;
    StyleServices.DrawText(Canvas.Handle, Details, Tabs[Index], thisTab, DT_LEFT or DT_SINGLELINE, ThemeTextColor);
  end;
end;

procedure TDDCSForm.DrawCheckTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  iCaption: string;
  thisTab,rCheckBox: TRect;

  function GetCkRect: TRect;
  begin
    Result.Left   := Rect.Left + 3;
    Result.Top    := Rect.Top + 6;
    Result.Right  := Result.Left + 12;
    Result.Bottom := Result.Top + 12;
  end;

begin
  SetLength(TabSeen, PageCount);
  iCaption := Pages[TabIndex].Caption;

  thisTab := Rect;
  Canvas.FillRect(Rect);

  rCheckBox := GetCkRect;
  Canvas.Rectangle(rCheckBox);

  thisTab.Left := rCheckBox.Right + 3;
  InflateRect(thisTab, -3, -5);          // This is the size of the text area

  if TabIndex <> -1 then
  begin
    if Active then
      TabSeen[TabIndex] := True;

    if TabSeen[TabIndex] then
      DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_CHECKED)
    else
      DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_INACTIVE);
  end else
    DrawFrameControl(Control.Canvas.Handle, rCheckBox, DFC_BUTTON, DFCS_INACTIVE);

  DrawText(Canvas.Handle, PChar(iCaption), Length(iCaption), thisTab, DT_LEFT or DT_SINGLELINE);
end;

{$ENDREGION}

{$REGION 'TDDCSForm'}

// Private ---------------------------------------------------------------------

procedure TDDCSForm.WMConfigDev(var Message: TMessage);
begin
  inherited;

  DDCSFormConfig := TDDCSFormConfig.Create(Self);
end;

procedure TDDCSForm.WMSave(var Message: TMessage);
begin
  inherited;

  Save(True);
end;

procedure TDDCSForm.SetVitals(Page: TTabSheet);
begin
  if (Page <> nil) and (Page.PageControl <> Self) then
    Exit;

  FVitalsPage := Page;

  if Assigned(FVitalsForm) then
    FreeAndNil(FVitalsForm);

  if Page <> nil then
  begin
    FVitalsForm := TDDCSVitals.Create(nil);
    FVitalsForm.Parent := Page;
    FVitalsForm.Name := 'DDCSVitals';
    FVitalsForm.Align := alClient;
    FVitalsForm.Show;

    FEDDLoad := True;
    FLMPLoad := True;

    // If we create with owner then it will fail with already exists because the Frame
    // Create is probably being called multiple times so we set the owner later, here
    Owner.InsertComponent(FVitalsForm);
  end;
end;

procedure TDDCSForm.SetDisableSplash(const Value: Boolean);
begin
  FDisableSplash := Value;
end;

procedure TDDCSForm.SetNoteCollection(const Value: TDDCSNoteCollection);
begin
  FReportCollection.Assign(Value);
end;

{$REGION 'Helpers'}

procedure TDDCSForm.CheckListBoxGetDialogDBClick(Sender: TObject);
var
  ckBox: TCheckListBox;
  Note: TDDCSNoteItem;
  sl: TStringList;
begin
  inherited;

  if not (Sender is TCheckListBox) then
    Exit;
  ckBox := TCheckListBox(Sender);
  if ckBox.ItemIndex = -1 then
    Exit;

  Note := RCollection^.GetNoteItem(Self);
  if Note = nil then
    Exit;

  sl := TStringList.Create;
  try
    try
      sl.Text := DisplayDialog(@RPCBrokerV, Note.Configuration[ckBox.ItemIndex], False);
    except
    end;

    ckBox.Checked[ckBox.ItemIndex] := True;

    if Note.DialogReturn is TMemo then
      TMemo(Note.DialogReturn).Lines.AddStrings(sl)
    else
      if Note.DialogReturn is TRichEdit then
        TRichEdit(Note.DialogReturn).Lines.AddStrings(sl);
  finally
    sl.Free;
  end;
end;

procedure TDDCSForm.ListBoxGetDialogDBClick(Sender: TObject);
var
  lsBox: TListBox;
  Note: TDDCSNoteItem;
  sl: TStringList;
begin
  inherited;

  if not (Sender is TListBox) then
    Exit;
  lsBox := TListBox(Sender);
  if lsBox.ItemIndex = -1 then
    Exit;

  Note := RCollection^.GetNoteItem(Self);
  if Note = nil then
    Exit;
  if Note.Configuration.Count < 1 then
    Exit;

  sl := TStringList.Create;
  try
    try
      sl.Text := DisplayDialog(@RPCBrokerV, Note.Configuration[lsBox.ItemIndex], False);
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

procedure TDDCSForm.ButtonGetDialogClick(Sender: TObject);
var
  Note: TDDCSNoteItem;
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
      sl.Text := DisplayDialog(@RPCBrokerV, Note.Configuration[0], False);

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

procedure TDDCSForm.cbAutoWidth(Sender: TObject);
var
  cbBox: TComboBox;
  cbLength,I: Integer;
begin
  if not (Sender is TComboBox) then
    Exit;

  cbBox := TComboBox(Sender);

  cblength := cbBox.Width;
  for I := 0 to cbBox.Items.Count - 1 do
    if cbBox.Canvas.TextWidth(cbBox.Items[I]) > cblength then
      cblength := cbBox.Canvas.TextWidth(cbBox.Items[I]);

  if cbBox.Items.Count > cbBox.DropDownCount then
    cblength := cblength + GetSystemMetrics(SM_CXVSCROLL);

  SendMessage(cbBox.Handle, CB_SETDROPPEDWIDTH, (cblength + 7), 0);
end;

{$ENDREGION}

procedure TDDCSForm.OnAutoSaveTimer(Sender: TObject);
begin
  PostMessage(Handle, WM_SAVE, 0, 0);
end;

function TDDCSForm.ControlVisible(rControl: TWinControl): Boolean;
var
  I: Integer;
begin
  Result := True;

  if PageCount = 1 then
    Exit;

  for I := 0 to PageCount - 1 do
  begin
    if Pages[I].ContainsControl(rControl) then
    begin
      Result := Pages[I].TabVisible;
      Break;
    end;
  end;
end;

// Protected -------------------------------------------------------------------

procedure TDDCSForm.Notification(AComponent: TComponent; Operation: TOperation);
var
  nItem: TDDCSNoteItem;
begin
  inherited Notification(AComponent, Operation);

  if (FReportCollection = nil) or not (AComponent is TWinControl) or
     (AComponent = Self) then
    Exit;

  if ((csDesigning in ComponentState) and not (csLoading in ComponentState)) then
  begin
    if Operation = opInsert then
      nItem := FReportCollection.GetNoteItemAddifNil(TWinControl(AComponent))
    else if Operation = opRemove then
      FReportCollection.DeleteNoteItem(TWinControl(AComponent));
  end;
end;

procedure TDDCSForm.SetUpControl(wControl: TWinControl);
var
  I: Integer;
  wComboBox: TComboBox;
  wCheckListBox: TCheckListBox;
  wListBox: TListBox;
  wButton: TButton;
  nItem: TDDCSNoteItem;
begin
  if wControl.ControlCount > 0 then
  begin
    for I := 0 to wControl.ControlCount - 1 do
      if wControl.Controls[I] is TWinControl then
        SetUpControl(TWinControl(wControl.Controls[I]));
  end else
  begin
    DDCSFormConfig.FObjects.AddObject(wControl.Name, wControl);

    if wControl is TComboBox then
    begin
      wComboBox := TComboBox(wControl);
      if not Assigned(wComboBox.OnDragDrop) then
        wComboBox.OnDropDown := cbAutoWidth;
    end;

    // Only what was set by the developer will be a note item, later the VistA configuration
    // will create and edit the note items
    nItem := FReportCollection.GetNoteItem(wControl);
    if nItem = nil then
      Exit;

    if Assigned(nItem.DialogReturn) then
    begin
      if wControl is TCheckListBox then
        TCheckListBox(wControl).OnDblClick := CheckListBoxGetDialogDBClick
      else if wControl is TListBox then
        TListBox(wControl).OnDblClick := ListBoxGetDialogDBClick
      else if wControl is TButton then
        TButton(wControl).OnClick := ButtonGetDialogClick;
    end;
  end;
end;

procedure TDDCSForm.SaveActive;
begin
  if Assigned(FOnpbSave) then
    FOnpbSave(Self, False);
end;

procedure TDDCSForm.AutoSaveActive;
begin
  if Assigned(FOnpbSave) then
    FOnpbSave(Self, True);
end;

procedure TDDCSForm.RestoreActive;
begin
  if Assigned(FOnpbRestore) then
    FOnpbRestore(Self);
end;

procedure TDDCSForm.FinishActive;
begin
  if Assigned(FOnpbFinish) then
    FOnpbFinish(Self, True);
end;

procedure TDDCSForm.AcceptActive;
begin
  if Assigned(FOnpbAccept) then
    FOnpbAccept(Self, True);
end;

procedure TDDCSForm.Save(aSave: Boolean);
var
  sl: TStringList;
  I: Integer;
  nItem: TDDCSNoteItem;
begin
  if (RPCBrokerV = nil) or (not FControlPanel.Sections[1].AllowClick) then
    Exit;

  FControlPanel.Sections[1].AllowClick := False;

  sl := TStringList.Create;
  try
    for I := 0 to ReportCollection.Count - 1 do
    begin
      nItem := ReportCollection.Items[I];

      // Data format -----------------------------------------------------------
      //   CONTROL^(INDEXED^VALUE)

      if not nItem.DoNotSave then
        sl.AddStrings(nItem.GetValueSave);
    end;

    if Assigned(VitalsControl) then
      sl.AddStrings(VitalsControl.GetVitalsNote);

    if sl.Count > 0 then
    try
      RPCBrokerV.SetContext(MENU_CONTEXT);

      if aSave then
        Tasks.Add(RPCBrokerV.sCallV('DSIO DDCS STORE', [RPCBrokerV.ControlObject,
                                    RPCBrokerV.Source.IEN, RPCBrokerV.DDCSInterface, sl, 1]))
      else
        RPCBrokerV.CallV('DSIO DDCS STORE', [RPCBrokerV.ControlObject,
                         RPCBrokerV.Source.IEN, RPCBrokerV.DDCSInterface, sl]);
    except
      on E: Exception do
      if not aSave then
        ShowDialog(Owner, E.Message, mtError);
    end;
  finally
    sl.Free;

    FControlPanel.Sections[1].AllowClick := True;
  end;
end;

procedure TDDCSForm.Finish;
begin
  FinishActive;

  if Preview(True) then
  begin
    Save(True);
    AcceptActive;
    TForm(Owner).OnCloseQuery := nil;
    Cancel;
  end;
end;

procedure TDDCSForm.Cancel;
begin
  TForm(Owner).Close;
end;

function TDDCSForm.GenerateNote(bFinishBtn: Boolean): Boolean;
var
  I: Integer;
  nItem: TDDCSNoteItem;
begin
  FValidated := True;
  try
    TmpStrList.Clear;

    if Assigned(FOnpbOverrideNote) then
    begin
      onOverrideNote(nil);
    end else
    begin
      for I := 0 to ReportCollection.Count - 1 do
      begin
        nItem := ReportCollection.Items[I];

        if not nItem.IsValid then
        begin
          FValidated := False;
          ShowDialog(Owner, 'The "' + nItem.OwningObject.Name + '" is required but invalid.', mtWarning);
          Exit;
        end;

        TmpStrList.AddStrings(nItem.GetValueNote);
      end;
    end;
  finally
    Result := FValidated;
  end;
end;

function TDDCSForm.Preview(bFinishBtn: Boolean): Boolean;
begin
  if not GenerateNote(bFinishBtn) then
    Exit;

  ReviewNoteDlg := TReviewNoteDlg.Create(Self);
  try
    ReviewNoteDlg.btnAccept.Enabled := bFinishBtn;
    ReviewNoteDlg.SetNote(TmpStrList);

    if not bFinishBtn = True then
    begin
      ReviewNoteDlg.NoteMemo.Font.Color := clGray;
      ReviewNoteDlg.NoteMemo.ReadOnly := True;
    end;

    ReviewNoteDlg.ShowModal;

    if ReviewNoteDlg.ModalResult = mrOK then
    begin
      Result := True;
      TmpStrList.SetText(ReviewNoteDlg.DialogResult.GetText);
    end else
      Result := False;
  finally
    ReviewNoteDlg.Free;
  end;
end;

// Public ----------------------------------------------------------------------

constructor TDDCSForm.Create(AOwner: TComponent);
begin
  inherited;

  if not (AOwner is TForm) then
    raise Exception.Create('Component must be placed on a Form.');

  Align := alClient;                          // Hide
  TabStop := True;
  TabOrder := 0;
  MultiLine := False;                         // Hide
  Style := tsButtons;                         // Hide
  TabPosition := tpTop;                       // Hide
  OwnerDraw := True;                          // Hide
  OnDrawTab := DrawCheckTab;                  // Hide this from the developer

  ScreenReader := TScreenReader.Create;

  DLLDialogList := TStringList.Create;
  Tasks := TStringList.Create;
  FReturnList := TStringList.Create;

  FReportCollection := TDDCSNoteCollection.Create(Self, TDDCSNoteItem);

  FControlPanel := TDDCSHeaderControl.Create(Self);
  FControlPanel.Parent := Self;

  FAutoSaveTimer := TTimer.Create(Self);
  FAutoSaveTimer.Interval := 60000;
  FAutoSaveTimer.OnTimer := OnAutoSaveTimer;

  if not (csDesigning in ComponentState) then
  begin
    TForm(AOwner).AlphaBlend := True;
    TForm(AOwner).AlphaBlendValue := 0;

    TForm(AOwner).OnCloseQuery := CloseQuery;
    TForm(AOwner).OnClose := FormClose;

    DialogDLL := LoadDialogs;

    PostMessage(Handle, WM_AFTER_CREATE, 0, 0);
  end;
end;

procedure TDDCSForm.WMAfterCreate(var Message: TMessage);
var
  SplashV: Boolean;
  tmp: string;
  di,sl: TStringList;
  I,J,P: Integer;
  vPropertyList,vProp,vValue: string;
  wControl: TWinControl;
  cControl: TComponent;
  nItem: TDDCSNoteItem;
  vKey: Word;

  function SubCount(str: string; d: Char): Integer;
  var
    I: Integer;
  begin
    Result := 0;
    for I := 0 to Length(str) - 1 do
      if str[I] = d then
        inc(Result);
  end;

begin
  if not (csDesigning in ComponentState) then
  begin
    try
      if RPCBrokerV <> nil then
      begin
        tmp := RPCBrokerV.sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'SHOW SPLASH']);
        if tmp <> '' then
          FDisableSplash := not StrToBool(tmp);
      end;

      if not FDisableSplash then
        PostMessage(Handle, WM_SHOW_SPLASH, 0, 0);
    except
      on E: Exception do
      ShowDialog(Owner, E.Message, mtError);
    end;
  end;

  DDCSFormConfig := TDDCSFormConfig.Create(Self);

  // We're going through all of the component's controls rather than just the report collection
  // because we're adding the TWinControls to the Configuration form and adding click methods to
  // control types, thus SetUpControl NOT SetUpNoteItem.
  for I := 0 to PageCount - 1 do
    for J := 0 to Pages[I].ControlCount - 1 do
      if Pages[I].Controls[J] is TWinControl then
        SetUpControl(TWinControl(Pages[I].Controls[J]));

  di := TStringList.Create;
  sl := TStringList.Create;
  try
    if RPCBrokerV <> nil then
    begin
      try
        if not HasSecurityKey('DSIO DDCS CONFIG') then
          FControlPanel.FCommandMenu.Items[1].Visible := False;

        if RPCBrokerV.DDCSInterfacePages.Count > 0 then
        begin
          FMultiInterface := True;
          di.AddStrings(RPCBrokerV.DDCSInterfacePages);
        end else
        begin
          FMultiInterface := False;
          di.Add(RPCBrokerV.DDCSInterface);
        end;

        RPCBrokerV.SetContext(MENU_CONTEXT);
        RPCBrokerV.tCallV(sl, 'DSIO DDCS BUILD FORM', [di, RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN]);

        if sl.Count < 1 then
          Exit;

        for I := 0 to sl.Count - 1 do
        begin
          // Form --------------------------------------------------------------
          //           I^TITLE|VALUE
          if Piece(sl[I],U,1) = 'I' then
          begin
            // Set Properties
            vPropertyList := Piece(sl[I],U,2,99);
            J := SubCount(vPropertyList,U) + 1;

            for P := 1 to J do
            begin
              vProp := Piece(Piece(vPropertyList,U,P),'|',1);

              if IsPublishedProp(TForm(Owner), vProp) then
              begin
                vValue := Piece(Piece(vPropertyList,U,P),'|',2);

                if vValue <> '' then
                  SetPropValue(TForm(Owner), vProp, vValue);
              end;
            end;
          end;

          // Page --------------------------------------------------------------
          //      P^NUMBER^CAPTION^HIDE
          if Piece(sl[I],U,1) = 'P' then
           if ((TryStrToInt(Piece(sl[I],U,2),J)) and (J <= PageCount)) then
            begin
              if Piece(sl[I],U,3) <> '' then
                Pages[J-1].Caption := Piece(sl[I],U,3);
              if Piece(sl[I],U,4) <> '' then
                Pages[J-1].TabVisible := not StrToBool(Piece(sl[I],U,4));
            end;

          // Control --------------------------------------------------------
          //         CC^NAME^^^PROPERTY|VALUE
          if Piece(sl[I],U,1) = 'CC' then
          begin
            cControl := TForm(Owner).FindComponent(Piece(sl[I],U,2));
            if ((cControl <> nil) and (cControl is TWinControl)) then
            begin
              wControl := TWinControl(cControl);
              nItem := FReportCollection.GetNoteItemAddifNil(wControl);

              // Set Properties
              vPropertyList := Piece(sl[I],U,3,99);
              J := SubCount(vPropertyList,U) + 1;

              for P := 1 to J do
              begin
                vProp := Piece(Piece(vPropertyList,U,P),'|',1);
                vValue := Piece(Piece(vPropertyList,U,P),'|',2);

                if ((vProp = 'ORDER') and (vValue <> '')) then
                  nItem.Order := StrToInt(vValue)
                else if ((vProp = 'PREFIX') and (vValue <> '')) then
                  nItem.Prefix := vValue
                else if ((vProp = 'SUFFIX') and (vValue <> '')) then
                  nItem.Suffix := vValue
                else if ((vProp = 'DO NOT SPACE') and (vValue <> '')) then
                  nItem.DoNotSpace := StrToBool(vValue)
                else if ((vProp = 'TITLE') and (vValue <> '')) then
                  nItem.Title := vValue
                else if ((vProp = 'DIALOG RETURN') and (vValue <> '')) then
                  nItem.DialogReturn := TWinControl(TForm(Owner).FindComponent(vValue))
                else if ((vProp = 'REQUIRED') and (vValue <> '')) then
                  nItem.Required := StrToBool(vValue)
                else if ((vProp = 'DO NOT SAVE') and (vValue <> '')) then
                  nItem.DoNotSave := StrToBool(vValue)
                else if ((vProp = 'HIDE FROM NOTE') and (vValue <> '')) then
                  nItem.HideFromNote := StrToBool(vValue);
              end;

              if Assigned(nItem.DialogReturn) then
              begin
                if wControl is TCheckListBox then
                  TCheckListBox(wControl).OnDblClick := CheckListBoxGetDialogDBClick
                else if wControl is TListBox then
                  TListBox(wControl).OnDblClick := ListBoxGetDialogDBClick
                else if wControl is TButton then
                  TButton(wControl).OnClick := ButtonGetDialogClick;
              end;
            end;
          end;

          // Control Value --------------------------------------------------
          //               CV^NAME^F^(INDEXED^VALUE)
          //               CV^NAME^D^IEN|NAME|CLASS
          if Piece(sl[I],'^',1) = 'CV' then
          begin
            cControl := TForm(Owner).FindComponent(Piece(sl[I],U,2));
            if ((cControl <> nil) and (cControl is TWinControl)) then
            begin
              wControl := TWinControl(cControl);
              nItem := FReportCollection.GetNoteItemAddifNil(wControl);

              if Piece(sl[I],U,3) = 'F' then
                Fill(wControl, Piece(sl[I],U,4), Piece(sl[I],U,5,9999))
              else if Piece(sl[I],U,3) = 'D' then
              begin
                nItem.Configuration.Add(Piece(sl[I],U,4));
                Fill(wControl, '', Piece(Piece(sl[I],U,4),'|',2));
              end;
            end;
          end;
        end;
      except
        on E: Exception do
        ShowDialog(Owner, E.Message, mtError);
      end;
    end;
  finally
    di.Free;
    sl.Free;

    TabHeight := 30;
    for I := 0 to PageCount - 1 do
    begin
      Pages[I].Caption := Pages[I].Caption + '      ';  // The caption is clipped when the checkbox is drawn

      if PageCount = 1 then
      begin
        Pages[I].TabVisible := False;

        if ActivePageIndex < 0 then
          ActivePageIndex := I;
      end;
    end;

    if FDisableSplash then
      TForm(Owner).AlphaBlend := False;

    if not ActivePage.TabVisible then
    begin
      vKey := VK_DOWN;
      KeyDown(vKey, [ssShift]);
    end;

    FControlPanel.UpdateControlPanel;
  end;
end;

procedure TDDCSForm.WMShowSplash(var Message: TMessage);
begin
  inherited;

  if not FDisableSplash then
  begin
    DDCSSplash := TDDCSSplash.Create(nil);
    try
      DDCSSplash.Show;
      DDCSSplash.BringToFront;
      DDCSSplash.Update;
      Sleep(2000);
    finally
      DDCSSplash.Free;

      TForm(Owner).AlphaBlend := False;
    end;
  end;
end;

destructor TDDCSForm.Destroy;
begin
  ScreenReader.Free;
  DLLDialogList.Free;
  FreeLibrary(DialogDLL);
  Tasks.Free;
  FReturnList.Free;
  SetLength(TabSeen, 0);

  inherited;
end;

procedure TDDCSForm.KeyDown(var Key: Word; Shift: TShiftState);
var
  wControl: TWinControl;
begin
  inherited;

  // Tab on one page or Shift Down for multiple pages to go into the TabSheet
  if ((PageCount = 1) and (Key = VK_TAB)) or ((Key = VK_DOWN) and (Shift = [ssShift])) then
  begin
    wControl := FindNextControl(ActivePage, True, True, False);

    if wControl <> nil then
      wControl.SetFocus;
  end;
end;

procedure TDDCSForm.KeyPress(var Key: Char);
begin
  inherited;
end;

procedure TDDCSForm.Change;
begin
  inherited;

  FControlPanel.UpdateControlPanel;
end;

procedure TDDCSForm.CloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ShowDialog(Owner, 'Are you sure you want to exit?', mtConfirmation) <> 6 then
    CanClose := False
  else
    CanClose := True;
end;

procedure TDDCSForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if RPCBrokerV = nil then
  begin
    Action := caFree;
    Exit;
  end;

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

function TDDCSForm.HasSecurityKey(const KeyName: string): Boolean;
var
  x: string;
begin
  Result := False;

  try
    x := RPCBrokerV.sCallV('ORWU HASKEY', [KeyName]);
    if x = '1' then Result := True;
  except
    on E: Exception do
    ShowDialog(Owner, E.Message, mtError);
  end;
end;

function TDDCSForm.GetPatientAllergies: TStringList;
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

function TDDCSForm.GetPatientActiveProblems: TStringList;
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

function TDDCSForm.GetPatientActiveMedications: TStringList;
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

{$ENDREGION}

initialization
  TStyleManager.Engine.RegisterStyleHook(TDDCSForm, TTabControlStyleHookCheck);
  TStyleManager.Engine.RegisterStyleHook(TTabControl, TTabControlStyleHookCheck);
  RegisterClass(TDDCSDialog);
  RegisterClass(TDDCSNoteCollection);
  RegisterClass(TDDCSNoteItem);
  RegisterClass(TDDCSHeaderControl);
  RegisterClass(TDDCSVitals);
  RegisterClass(TDDCSForm);

end.
