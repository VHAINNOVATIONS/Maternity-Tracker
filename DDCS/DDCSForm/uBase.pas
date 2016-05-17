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
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.TypInfo, System.Classes, System.Actions, Vcl.Graphics, Vcl.Controls,
  Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus,
  Vcl.Themes, Vcl.Styles, Vcl.Consts, Vcl.CheckLst, Vcl.ActnList,
  VAUtils, uCommon, uReportItems, frmVitals, uDialog;

type
  TDDCSForm = class;

  TDDCSHeaderControl = class(THeaderControl)
  private
    FDDCSForm: TDDCSForm;
    FCommandMenu: TPopupMenu;
    FRememberSectionIndex: Integer;
    FSelectedSectionIndex: Integer;
    procedure WMGetMSAAObject(var Message: TMessage); message WM_GETOBJECT;
    procedure SpeakButtons(aText: string);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure FcEditConfigurationClick(Sender: TObject);
    procedure FcLoadDialogsClick(Sender: TObject);
    procedure FcAboutClick(Sender: TObject);
    procedure FcChangeThemeClick(Sender: TObject);
    function IsNext(var iPage: Integer): Boolean;
    function IsPrev(var iPage: Integer): Boolean;
    function TotalPages: Integer;
  protected
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure DrawSection(Section: THeaderSection; const Rect: TRect;
      Pressed: Boolean); override;
    procedure SectionClick(Section: THeaderSection); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateControlPanel;
  end;

  TTabControlStyleHookCheck = class(TTabControlStyleHook)
  private
  strict protected
    procedure DrawTab(Canvas: TCanvas; Index: Integer); override;
  end;

    TpbSaveEvent = procedure(Sender: TObject; AutoSave: Boolean) of object;
  TpbFinishEvent = procedure(Sender: TObject; pbFinish: Boolean) of object;

  TDDCSForm = class(TPageControl)
  private
    // Components --------------------------------------------------------------
    FControlPanel: TDDCSHeaderControl;
    FNavControl: TActionList;
    FAutoSaveTimer: TTimer;
    FVitalsPage: TTabSheet;
    FReportCollection: TDDCSNoteCollection;
    // -------------------------------------------------------------------------
    FDisableSplash: Boolean;
    Tasks: TStringList;    //array of autosave tasks to be canceled onClose of the DDCS Form
    FMultiInterface: Boolean;
    FReturnList: TStringList;
    FValidated: Boolean;
    FTabSwitch: Boolean;
    TabSeen: array of Boolean;
    // Events ------------------------------------------------------------------
    FOnpbSave: TpbSaveEvent;
    FOnpbFinish: TpbFinishEvent;
    FOnpbAccept: TpbFinishEvent;
    FOnpbRestore: TNotifyEvent;
    FOnpbOverrideNote: TNotifyEvent;
    FSaveShow: TNotifyEvent;
    procedure WMGetMSAAObject(var Message: TMessage); message WM_GETOBJECT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMShowSplash(var Message: TMessage); message WM_SHOW_SPLASH;
    procedure WMSave(var Message: TMessage); message WM_SAVE;
    // Properties --------------------------------------------------------------
    procedure SetVitals(Page: TTabSheet);
    procedure SetDisableSplash(const Value: Boolean);
    procedure SetNoteCollection(const Value: TDDCSNoteCollection);
    // Timer
    procedure OnAutoSaveTimer(Sender: TObject);
    // TCustomListBox   (TListBox and TCheckListBox)
    procedure ListBoxGetDialogDBClick(Sender: TObject);
    // TButton
    procedure ButtonGetDialogClick(Sender: TObject);
    // TForm -------------------------------------------------------------------
    procedure FormOverrideShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    // Screen ------------------------------------------------------------------
    procedure ActiveControlChanged(Sender: TObject);
    // Navigation --------------------------------------------------------------
    procedure CtrlTab(Sender: TObject);
    procedure CtrlShiftTab(Sender: TObject);
    // Properties --------------------------------------------------------------
    function GetVitalsForm: TDDCSVitals;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure SetUpControl(iPage: Integer; wControl: TWinControl);
    procedure DrawCheckTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    procedure SaveActive;
    procedure AutoSaveActive;
    procedure RestoreActive;
    procedure FinishActive;
    procedure AcceptActive;
    procedure Save(aSave: Boolean);
    procedure Finish;
    procedure Cancel;
    procedure GoToPageFirstTabItem;
    procedure GoToPageLastTabItem;
    function GenerateNote(bFinishBtn: Boolean): Boolean;
    function Preview(bFinishBtn: Boolean): Boolean;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Change; override;
    // Support and 508 ---------------------------------------------------------
    // TComboBox
    procedure cbAutoWidth(Sender: TObject);
    // TRadioGroup
    procedure RadioGroupEnter(Sender: TObject);
    // Support and 508 ---------------------------------------------------------
    function HasSecurityKey(const KeyName: string): Boolean;
    function GetPatientAllergies: TStringList;
    function GetPatientActiveProblems: TStringList;
    function GetPatientActiveMedications: TStringList;
    property MultiInterface: Boolean read FMultiInterface write FMultiInterface;
    property TmpStrList: TStringList read FReturnList write FReturnList;
    property Validated: Boolean read FValidated write FValidated;
    property VitalsControl: TDDCSVitals read GetVitalsForm;
  published
    property VitalsPage: TTabSheet read FVitalsPage write SetVitals;
    property AutoTimer: TTimer read FAutoSaveTimer write FAutoSaveTimer;
    property DisableSplash: Boolean read FDisableSplash write SetDisableSplash default False;
    property ReportCollection: TDDCSNoteCollection read FReportCollection write SetNoteCollection;
    property OnSave: TpbSaveEvent read FOnpbSave write FOnpbSave;
    property OnFinish: TpbFinishEvent read FOnpbFinish write FOnpbFinish;
    property OnAccept: TpbFinishEvent read FOnpbAccept write FOnpbAccept;
    property OnRestore: TNotifyEvent read FOnpbRestore write FOnpbRestore;
    property OnOverrideNote: TNotifyEvent read FOnpbOverrideNote write FOnpbOverrideNote;
  end;

  procedure Register;

implementation

uses
  frmSplash, frmPreview, frmConfiguration, frmAbout, uExtndComBroker;

procedure Register;
begin
  RegisterClass(TDDCSDialog);
  RegisterClass(TDDCSNoteCollection);
  RegisterClass(TDDCSNoteItem);
  RegisterClass(TDDCSHeaderControl);
  RegisterClass(TDDCSVitals);
  RegisterComponents('DDCSForm', [TDDCSForm]);
end;

{$REGION 'TDDCSHeaderControl'}

// Private ---------------------------------------------------------------------

procedure TDDCSHeaderControl.WMGetMSAAObject(var Message: TMessage);
begin
  // If the window that receives the message does not implement IAccessible, it should return zero.
  // If the window does not handle the WM_GETOBJECT message, the DefWindowProc function returns zero.

  if Message.LParam = OBJID_CLIENT then
    Message.Result := 0
  else
    Message.Result := DefWindowProc(Handle, Message.Msg, Message.WParam, Message.LParam);
end;

procedure TDDCSHeaderControl.SpeakButtons(aText: string);
var
  SayText: string;
begin
  if FSelectedSectionIndex = 0 then
    SayText := 'Command Menu' + aText
  else SayText := Sections[FSelectedSectionIndex].Text + aText;

  if Sections[FSelectedSectionIndex].AllowClick then
    SayText := SayText + ', press space or enter to activate.';

  if ScreenReader <> nil then
    ScreenReader.Say(SayText, False);
end;

procedure TDDCSHeaderControl.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;

  FDDCSForm.FTabSwitch := False;

  FSelectedSectionIndex := FRememberSectionIndex;
  if FSelectedSectionIndex = -1 then
    FSelectedSectionIndex := 0;

  SpeakButtons(', press the left or right arrows to navigate');

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

    SpeakButtons('');
  end;

  // Key 39 = Right Arrow
  if Key = VK_RIGHT then
  begin
    if FSelectedSectionIndex < Sections.Count - 1 then
      FSelectedSectionIndex := FSelectedSectionIndex + 1
    else
      FSelectedSectionIndex := 0;

    SpeakButtons('');
  end;

  // Enter or Spacebar
  if (Key = VK_RETURN) or (Key = VK_SPACE) then
  begin
    if Sections[FSelectedSectionIndex].AllowClick then
      SectionClick(Sections[FSelectedSectionIndex]);
  end;

  // Tab - Exit the Control Panel
  if Key = VK_TAB then
  begin
    if Shift = [ssShift] then
      FDDCSForm.GoToPageLastTabItem
    else
      FDDCSForm.SetFocus;
  end;

  Invalidate;
end;

procedure TDDCSHeaderControl.FcEditConfigurationClick(Sender: TObject);
begin
  if DDCSFormConfig <> nil then
    DDCSFormConfig.Show;
end;

procedure TDDCSHeaderControl.FcLoadDialogsClick(Sender: TObject);
begin
  DialogDLL := LoadDialogs;

  if DialogDLL <> 0 then
    ShowMsg('Successfully loaded the shared dialogs.');
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

function TDDCSHeaderControl.IsNext(var iPage: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  iPage := FDDCSForm.ActivePageIndex;

  if FDDCSForm.ActivePageIndex = FDDCSForm.PageCount - 1 then
    Exit;

  for I := FDDCSForm.ActivePageIndex + 1 to FDDCSForm.PageCount - 1 do
    if FDDCSForm.Pages[I].TabVisible then
    begin
      Result := True;
      iPage := I;
      Break;
    end;
end;

function TDDCSHeaderControl.IsPrev(var iPage: Integer): Boolean;
var
  I: Integer;
begin
  Result := False;
  iPage := FDDCSForm.ActivePageIndex;

  if FDDCSForm.ActivePageIndex < 1 then
    Exit;

  for I := FDDCSForm.ActivePageIndex - 1 downto 0 do
    if FDDCSForm.Pages[I].TabVisible then
    begin
      Result := True;
      iPage := I;
      Break;
    end;
end;

function TDDCSHeaderControl.TotalPages: Integer;
var
  I: Integer;
begin
  Result := 0;

  if ((FDDCSForm.PageCount = 1) and not (FDDCSForm.Pages[0].TabVisible)) then
  begin
    Result := 1;
    Exit;
  end;

  for I := 0 to FDDCSForm.PageCount - 1 do
    if FDDCSForm.Pages[I].TabVisible then
      Inc(Result);
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
    Canvas.Brush.Color := clGray;
    Canvas.Font.Style := [fsBold];
  end else
  begin
    Canvas.Brush.Style := bsClear;
  end;
  Canvas.FillRect(R);

  if ((not Section.AllowClick) and (Section.Index <> 6)) then
  begin
    if Section.Index = FSelectedSectionIndex then
      Canvas.Font.Color := clBlack
    else
      Canvas.Font.Color := clGrayText;
  end else
    Canvas.Font.Color := clWindowText;

  X := Round(R.Left + (R.Width div 2) - (Canvas.TextWidth(Section.Text) div 2));
  Y := Round(R.Top + (R.Height div 2) - (Canvas.TextHeight(Section.Text) div 2));
  Canvas.TextOut(X, Y, Section.Text);
end;

procedure TDDCSHeaderControl.SectionClick(Section: THeaderSection);
var
  I: Integer;

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
    5: FDDCSForm.SelectNextPage(False);
//         if IsPrev(I) then
//           FDDCSForm.ActivePageIndex := I;
//         FDDCSForm.Change;
//       end;
    6: ;
    7: FDDCSForm.SelectNextPage(True);
//         if IsNext(I) then
//           FDDCSForm.ActivePageIndex := I;
//         FDDCSForm.Change;
//       end;
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
  FCommandItem.Caption := 'Load Dialogs';
  FCommandItem.OnClick := FcLoadDialogsClick;
  FCommandMenu.Items.Add(FCommandItem);

  FCommandItem := TMenuItem.Create(FCommandMenu);
  FCommandItem.Caption := 'Change Theme';
  FCommandItem.Enabled := False;
  FCommandMenu.Items.Add(FCommandItem);

  FCommandItem := TMenuItem.Create(FCommandMenu);
  FCommandItem.Caption := 'Default';
  FCommandItem.OnClick := FcChangeThemeClick;
  FCommandMenu.Items[3].Add(FCommandItem);
  FCommandItem.Click;                           // Including other themes but use Default for now

  FCommandItem := TMenuItem.Create(FCommandMenu);
  FCommandItem.Caption := 'Windows10';
  FCommandItem.OnClick := FcChangeThemeClick;
  FCommandMenu.Items[3].Add(FCommandItem);

  for I := 0 to 7 do AddControlPanelButton(I);
end;

procedure TDDCSHeaderControl.UpdateControlPanel;
var
  I: Integer;
begin
  // Next
  if IsNext(I) then
    FDDCSForm.FControlPanel.Sections[7].AllowClick := True
  else
    FDDCSForm.FControlPanel.Sections[7].AllowClick := False;

  // Previous
  if IsPrev(I) then
    FDDCSForm.FControlPanel.Sections[5].AllowClick := True
  else
    FDDCSForm.FControlPanel.Sections[5].AllowClick := False;

  // Page Indicator
  for I := 0 to FDDCSForm.PageCount - 1 do
    if FDDCSForm.Pages[I] = FDDCSForm.ActivePage then
    begin
      FDDCSForm.FControlPanel.Sections[6].Text := IntToStr(I+1) + ' of ' + IntToStr(TotalPages);
      Break;
    end;

  Invalidate;
end;

{$ENDREGION}

// 03/28/2016 - This isn't right - don't use themes yet
{$REGION 'TTabControlStyleHookCheck'}

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
    // Use DrawText with TTextFormat
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

procedure TDDCSForm.WMSave(var Message: TMessage);
begin
  inherited;

  Save(True);
end;

procedure TDDCSForm.SetVitals(Page: TTabSheet);
var
  FVitalsForm: TDDCSVitals;
begin
  if ((Page <> nil) and ((Page.PageControl <> nil) and (Page.PageControl <> Self))) then
    Exit;
  if Page = FVitalsPage then
    Exit;

  FVitalsPage := Page;

  if csLoading in ComponentState then
    Exit;

  if GetVitalsForm <> nil then
    GetVitalsForm.Free;

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

procedure TDDCSForm.OnAutoSaveTimer(Sender: TObject);
begin
  PostMessage(Handle, WM_SAVE, 0, 0);
end;

{$REGION 'Helpers'}

procedure TDDCSForm.ListBoxGetDialogDBClick(Sender: TObject);
var
  ls: TCustomListBox;
  nItem: TDDCSNoteItem;
  sl: TStringList;
begin
  inherited;

  if DialogDLL = 0 then
    Exit;
  if not Sender.InheritsFrom(TCustomListBox) then
    Exit;
  ls := TCustomListBox(Sender);
  if ls.ItemIndex = -1 then
    Exit;
  nItem := FReportCollection.GetNoteItem(TWinControl(Sender));
  if nItem = nil then
    Exit;

  sl := TStringList.Create;
  try
    try
      sl.Text := DisplayDialog(@RPCBrokerV, nItem.Configuration[ls.ItemIndex], False);

      if ((Sender.InheritsFrom(TCheckListBox)) and (sl.Count > 0)) then
        TCheckListBox(Sender).Checked[ls.ItemIndex] := True;

      if nItem.DialogReturn <> nil then
        TCustomMemo(nItem.DialogReturn).Lines.AddStrings(sl);
    except
    end;
  finally
    sl.Free;
  end;
end;

procedure TDDCSForm.ButtonGetDialogClick(Sender: TObject);
var
  nItem: TDDCSNoteItem;
  sl: TStringList;
begin
  inherited;

  if DialogDLL = 0 then
    Exit;
  if not Sender.InheritsFrom(TButton) then
    Exit;
  nItem := FReportCollection.GetNoteItem(TWinControl(Sender));
  if nItem = nil then
    Exit;

  sl := TStringList.Create;
  try
    try
      sl.Text := DisplayDialog(@RPCBrokerV, nItem.Configuration[0], False);

      if nItem.DialogReturn <> nil then
        TCustomMemo(nItem.DialogReturn).Lines.AddStrings(sl);
    except
    end;
  finally
    sl.Free;
  end;
end;

procedure TDDCSForm.cbAutoWidth(Sender: TObject);
var
  cb: TCustomComboBox;
  cbLength,I: Integer;
begin
  if not Sender.InheritsFrom(TCustomComboBox) then
    Exit;

  cb := TCustomComboBox(Sender);

  cbLength := cb.Width;
  for I := 0 to cb.Items.Count - 1 do
    if cb.Canvas.TextWidth(cb.Items[I]) > cbLength then
      cbLength := cb.Canvas.TextWidth(cb.Items[I]) + GetSystemMetrics(SM_CXVSCROLL);

  SendMessage(cb.Handle, CB_SETDROPPEDWIDTH, (cblength + 7), 0);
end;

procedure TDDCSForm.RadioGroupEnter(Sender: TObject);
var
  rg: TRadioGroup;
  I: Integer;
begin
  if not Sender.InheritsFrom(TRadioGroup) then
    Exit;

  rg := TRadioGroup(Sender);
  if rg.ItemIndex = -1 then
    for I := 0 to rg.ControlCount - 1 do
      TWinControl(rg.Controls[0]).TabStop := True;
end;

{$ENDREGION}

// Protected -------------------------------------------------------------------

procedure TDDCSForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (FReportCollection = nil) or not (AComponent is TWinControl) or
    (AComponent = Self) then
    Exit;
  if AComponent is TStaticText then
    Exit;

  if ((csDesigning in ComponentState) and not (csLoading in ComponentState)) then
  begin
    if Operation = opInsert then
      FReportCollection.GetNoteItemAddifNil(TWinControl(AComponent))
    else if Operation = opRemove then
      FReportCollection.DeleteNoteItem(TWinControl(AComponent));
  end;
end;

procedure TDDCSForm.SetUpControl(iPage: Integer; wControl: TWinControl);
var
  I: Integer;
  wComboBox: TComboBox;
  wRadioGroup: TRadioGroup;
  nItem: TDDCSNoteItem;
begin
  if (((wControl.InheritsFrom(TCustomPanel)) or (wControl.InheritsFrom(TCustomGroupBox)) or
       (wControl.InheritsFrom(TCustomTabControl))) and (not wControl.InheritsFrom(TRadioGroup)) and
     (wControl.ControlCount > 0)) then
  begin
    for I := 0 to wControl.ControlCount - 1 do
      if wControl.Controls[I] is TWinControl then
        SetUpControl(iPage, TWinControl(wControl.Controls[I]));
  end else
  begin
    if wControl is TStaticText then
      Exit;

    if wControl.InheritsFrom(TComboBox) then
    begin
      wComboBox := TComboBox(wControl);
      if not Assigned(wComboBox.OnDropDown) then
        wComboBox.OnDropDown := cbAutoWidth;
    end;

    if wControl.InheritsFrom(TRadioGroup) then
    begin
      wRadioGroup := TRadioGroup(wControl);
      if not Assigned(wRadioGroup.OnEnter) then
        wRadioGroup.OnEnter :=  RadioGroupEnter;
    end;

    // Only what was set by the developer will be a note item, later the VistA configuration
    // will create and edit the note items
    nItem := FReportCollection.GetNoteItem(wControl);
    if nItem = nil then
      Exit;

    if Assigned(nItem.DialogReturn) then
    begin
      if wControl.InheritsFrom(TCheckListBox) then
        TCheckListBox(wControl).OnDblClick := ListBoxGetDialogDBClick
      else if wControl.InheritsFrom(TListBox) then
        TListBox(wControl).OnDblClick := ListBoxGetDialogDBClick
      else if wControl.InheritsFrom(TButton) then
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
      VitalsControl.Save;

    if sl.Count > 0 then
    try
      if not UpdateContext(MENU_CONTEXT) then
        Exit;

      if aSave then
        Tasks.Add(sCallV('DSIO DDCS STORE', [RPCBrokerV.ControlObject,
                                             RPCBrokerV.Source.IEN, RPCBrokerV.DDCSInterface, sl, 1]))
      else
        CallV('DSIO DDCS STORE', [RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN, RPCBrokerV.DDCSInterface, sl]);
    except
      on E: Exception do
      if not aSave then
        ShowMsg(E.Message, smiError, smbOK);
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

procedure TDDCSForm.GoToPageFirstTabItem;
var
  Form: TCustomForm;
  Control: TWinControl;
begin
  Form := GetParentForm(Self);
  if Form <> nil then
  begin
    Control := FindNextControl(ActivePage, True, True, False);
    if Control = nil then
      Control := FindNextControl(nil, True, False, False);
    if ((Control <> nil) and (Control is TDDCSHeaderControl)) then
      Control := FindNextControl(ActivePage, True, True, False);
    if Control <> nil then
      Form.ActiveControl := Control;
  end;
end;

procedure TDDCSForm.GoToPageLastTabItem;
var
  Form: TCustomForm;
  Control: TWinControl;
begin
  Form := GetParentForm(Self);
  if Form <> nil then
  begin
    Control := FindNextControl(nil, False, True, False);
    if Control = nil then
      Control := FindNextControl(nil, False, False, False);
    if Control <> nil then
      Form.ActiveControl := Control;
  end;
end;

function TDDCSForm.GenerateNote(bFinishBtn: Boolean): Boolean;
var
  I: Integer;
  tmpstrE: string;
  nItem: TDDCSNoteItem;
  wControl: TWinControl;
begin
  TmpStrList.Clear;
  tmpstrE := 'The following elements are required but are currently invalid.';
  nItem := nil;
  wControl := nil;
  FValidated := True;

  try
    for I := 0 to ReportCollection.Count - 1 do
    begin
      nItem := ReportCollection.Items[I];
      if ((nItem.Page <> nil) and (nItem.Page.Visible)) then
      begin
        if not nItem.IsValid then
        begin
          FValidated := False;
          if nItem.IdentifyingName <> '' then
            tmpstrE := tmpstrE + #13#10 + '  - ' + nItem.IdentifyingName
          else
            tmpstrE := tmpstrE + #13#10 + '  - ' + nItem.OwningObject.Name;

          if wControl = nil then
            wControl := nItem.OwningObject;
        end else
          TmpStrList.AddStrings(nItem.GetValueNote);
      end;
    end;

    if FValidated and Assigned(FOnpbOverrideNote) then
    begin
      TmpStrList.Clear;
      onOverrideNote(nil);
    end;

    if not FValidated then
    begin
      ShowMsg(tmpstrE, smiWarning, smbOK);

      nItem := ReportCollection.GetNoteItem(wControl);
      if ((nItem <> nil) and (nItem.Page <> nil)) then
      begin
        ActivePageIndex := nItem.Page.PageIndex;
        Change;

        if wControl.Visible then
          wControl.SetFocus;
      end;
    end;
  finally
    Result := FValidated;
  end;
end;

function TDDCSForm.Preview(bFinishBtn: Boolean): Boolean;
begin
  Result := False;

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
var
  nAct: TAction;
begin
  inherited;

  if not (AOwner is TForm) then
    raise Exception.Create('Component must be placed on a Form.');

  // Need these values but we cannot hide them without creating a whole new pagecontrol
  // so we need to override them to ensure our values at design time.
  Align := alClient;
  TabStop := False;
  TabOrder := 0;
  MultiLine := False;
  Style := tsButtons;
  TabPosition := tpTop;
  OwnerDraw := True;

  FControlPanel := TDDCSHeaderControl.Create(Self);
  FControlPanel.Parent := Self;

  FReportCollection := TDDCSNoteCollection.Create(Self, TDDCSNoteItem);         // Create last to prevent adding ReportCollection Items we shouldn't have
                                                                                // - components that are part of TDDCSForm
  if not (csDesigning in ComponentState) then
  begin
    OnDrawTab := DrawCheckTab;       // This needs to be part of the class

    TForm(AOwner).AlphaBlend := True;
    TForm(AOwner).AlphaBlendValue := 0;

    Screen.OnActiveControlChange := ActiveControlChanged;

    FSaveShow := TForm(AOwner).OnShow;
    TForm(AOwner).OnShow := FormOverrideShow;
    TForm(AOwner).OnCloseQuery := FormCloseQuery;
    TForm(AOwner).OnClose := FormClose;

    FNavControl := TActionList.Create(AOwner);
    nAct := TAction.Create(FNavControl);
    nAct.ActionList := FNavControl;
    nAct.ShortCut := ShortCut(VK_TAB, [ssCtrl]);
    nAct.OnExecute := CtrlTab;
    nAct := TAction.Create(FNavControl);
    nAct.ActionList := FNavControl;
    nAct.ShortCut := ShortCut(VK_TAB, [ssShift, ssCtrl]);
    nAct.OnExecute := CtrlShiftTab;

    ScreenReader := TScreenReader.Create;

    FAutoSaveTimer := TTimer.Create(Self);
    FAutoSaveTimer.Name := 'DDCSAutoTimer';
    FAutoSaveTimer.Interval := 600000;
    FAutoSaveTimer.OnTimer := OnAutoSaveTimer;

    DLLDialogList := TStringList.Create;
    Tasks := TStringList.Create;
    FReturnList := TStringList.Create;

    DialogDLL := LoadDialogs;
  end;
end;

procedure TDDCSForm.FormOverrideShow(Sender: TObject);
var
  tmp: string;
  dl,sl: TStringList;
  I,J,P: Integer;
  vPropertyList,vProp,vValue: string;
  wControl: TWinControl;
  cControl,dReturn: TComponent;
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
  dl := TStringList.Create;
  sl := TStringList.Create;
  try
    try
      if RPCBrokerV <> nil then
      begin
        if UpdateContext(MENU_CONTEXT) then
        begin
          tmp := sCallV('DSIO DDCS CONFIGURATION', [RPCBrokerV.DDCSInterface, 'SHOW SPLASH']);
          if tmp <> '' then
            FDisableSplash := not StrToBool(tmp);
        end;
      end;

      if not FDisableSplash then
        PostMessage(Handle, WM_SHOW_SPLASH, 0, 0);

      DDCSFormConfig := TDDCSFormConfig.Create(Owner, Self);

      // We're going through all of the component's controls rather than just the report collection
      // because we're adding the TWinControls to the Configuration form and adding click methods to
      // control types, thus SetUpControl NOT SetUpNoteItem.
      for I := 0 to PageCount - 1 do
        for J := 0 to Pages[I].ControlCount - 1 do
          if Pages[I].Controls[J] is TWinControl then
            SetUpControl(I, TWinControl(Pages[I].Controls[J]));


      if RPCBrokerV <> nil then
      begin
        if not HasSecurityKey('DSIO DDCS CONFIG') then
          FControlPanel.FCommandMenu.Items[1].Visible := False;

        if RPCBrokerV.DDCSInterfacePages.Count > 0 then
        begin
          FMultiInterface := True;
          dl.AddStrings(RPCBrokerV.DDCSInterfacePages);
        end else
        begin
          FMultiInterface := False;
          dl.Add(RPCBrokerV.DDCSInterface);
        end;

        if UpdateContext(MENU_CONTEXT) then
          tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, RPCBrokerV.ControlObject, RPCBrokerV.Source.IEN]);

        if sl.Count < 1 then
          Exit;

        for I := 0 to sl.Count - 1 do
        begin
          // Form --------------------------------------------------------------
          //           I^TITLE|VALUE
          if Piece(sl[I],U,1) = 'I' then
          begin
            // Set Properties
            vPropertyList := Pieces(sl[I],U,2,99);
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
                Pages[J - 1].Caption := Piece(sl[I],U,3);
              if Piece(sl[I],U,4) <> '' then
                Pages[J - 1].TabVisible := not StrToBool(Piece(sl[I],U,4));
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
              vPropertyList := Pieces(sl[I],U,3,99);
              J := SubCount(vPropertyList,U) + 1;

              for P := 1 to J do
              begin
                vProp := Piece(Piece(vPropertyList,U,P),'|',1);
                vValue := Piece(Piece(vPropertyList,U,P),'|',2);

                  //  IdentifyingName := nItem.IdentifyingName;
                  //  Order           := nItem.Order;
                  //  Title           := nItem.Title;
                  //  Prefix          := nItem.Prefix;
                  //  Suffix          := nItem.Suffix;
                  //  DoNotSpace      := nItem.DoNotSpace;
                  //  DoNotSave       := nItem.DoNotSave;
                  //  DoNotRestoreV   := nItem.DoNotRestoreV;
                  //  HideFromNote    := nItem.HideFromNote;
                  //  Required        := nItem.Required;
                  //  DialogReturn    := nItem.DialogReturn;

                if ((vProp = 'IDENTIFYINGNAME') and (vValue <> '')) then
                  nItem.IdentifyingName := vValue
                else if ((vProp = 'ORDER') and (vValue <> '')) then
                  nItem.Order := StrToInt(vValue)
                else if ((vProp = 'TITLE') and (vValue <> '')) then
                  nItem.Title := vValue
                else if ((vProp = 'PREFIX') and (vValue <> '')) then
                  nItem.Prefix := vValue
                else if ((vProp = 'SUFFIX') and (vValue <> '')) then
                  nItem.Suffix := vValue
                else if ((vProp = 'DONOTSPACE') and (vValue <> '')) then
                  nItem.DoNotSpace := StrToBool(vValue)
                else if ((vProp = 'DONOTSAVE') and (vValue <> '')) then
                  nItem.DoNotSave := StrToBool(vValue)
                else if ((vProp = 'DONOTRESTORE') and (vValue <> '')) then
                  nItem.DoNotRestoreV := StrToBool(vValue)
                else if ((vProp = 'HIDEFROMNOTE') and (vValue <> '')) then
                  nItem.HideFromNote := StrToBool(vValue)
                else if ((vProp = 'REQUIRED') and (vValue <> '')) then
                  nItem.Required := StrToBool(vValue)
                else if ((vProp = 'DIALOGRETURN') and (vValue <> '')) then
                begin
                  dReturn := TForm(Owner).FindComponent(vValue);
                  if dReturn is TWinControl then
                    nItem.DialogReturn := TWinControl(dReturn);
                end;
              end;
            end;
          end;

          // Control Value --------------------------------------------------
          //               CV^NAME^F^(INDEXED^VALUE)
          //               CV^NAME^D^IEN|NAME|CLASS
          if Piece(sl[I],U,1) = 'CV' then
          begin
            cControl := TForm(Owner).FindComponent(Piece(sl[I],U,2));
            if ((cControl <> nil) and (cControl is TWinControl)) then
            begin
              wControl := TWinControl(cControl);
              nItem := FReportCollection.GetNoteItemAddifNil(wControl);

              if Piece(sl[I],U,3) = 'F' then
                Fill(wControl, Piece(sl[I],U,4), Pieces(sl[I],U,5,9999))
              else if Piece(sl[I],U,3) = 'D' then
              begin
                nItem.Configuration.Add(Piece(sl[I],U,4));
                Fill(wControl, '', Piece(Piece(sl[I],U,4),'|',2));
              end;
            end;
          end;
        end;
      end;
    except
      on E: Exception do
      ShowMsg(E.Message, smiError, smbOK);
    end;
  finally
    dl.Free;
    sl.Free;

    TabHeight := 30;
    for I := 0 to PageCount - 1 do
    begin
      Pages[I].Caption := Pages[I].Caption + '      ';  // The caption is clipped when the checkbox is drawn
      Pages[I].TabStop := False;

      if PageCount = 1 then
      begin
        Pages[I].TabVisible := False;
        if ActivePageIndex < 0 then
          ActivePageIndex := I;
        GoToPageFirstTabItem;
      end;
    end;

    if FDisableSplash then
      TForm(Owner).AlphaBlend := False;

    FControlPanel.UpdateControlPanel;

    if Assigned(FSaveShow) then
      FSaveShow(Owner);
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
  Screen.OnActiveControlChange := nil;

  FReportCollection.Free;
  SetLength(TabSeen, 0);

  if Assigned(ScreenReader) then
    ScreenReader.Free;
  if Assigned(DLLDialogList) then
    DLLDialogList.Free;
  if Assigned(Tasks) then
    Tasks.Free;
  if Assigned(FReturnList) then
    FReturnList.Free;
  if DialogDLL <> 0 then
    FreeLibrary(DialogDLL);

  inherited;
end;

procedure TDDCSForm.WMGetMSAAObject(var Message: TMessage);
begin
  // If the window that receives the message does not implement IAccessible, it should return zero.
  // If the window does not handle the WM_GETOBJECT message, the DefWindowProc function returns zero.

  if Message.LParam = OBJID_CLIENT then
    Message.Result := 0
  else
    Message.Result := DefWindowProc(Handle, Message.Msg, Message.WParam, Message.LParam);
end;

procedure TDDCSForm.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;

  if not FTabSwitch then
  begin
    FTabSwitch := True;
    GoToPageFirstTabItem;
  end else
    FControlPanel.SetFocus;
end;

procedure TDDCSForm.Change;
begin
  inherited;

  FControlPanel.UpdateControlPanel;

  if ActivePage.TabVisible then
    if ScreenReader <> nil then
    begin
      ScreenReader.Say(ActivePage.Caption + ' Currently on page ' + FControlPanel.Sections.Items[6].Text, False);

      if ActivePage = VitalsPage then
        VitalsControl.fVitalsControlChange(nil);
    end;
end;

procedure TDDCSForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ShowMsg('Are you sure you want to exit?', smiWarning, smbYesNo) = smrYes then
    CanClose := True
  else
    CanClose := False;
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
      if UpdateContext(MENU_CONTEXT) then
        CallV('DSIO DDCS CANCEL AUTOSAVE', [Tasks]);
    except
    end;
  finally
    Save(False);
    Action := caFree;
  end;
end;

procedure TDDCSForm.ActiveControlChanged(Sender: TObject);
var
  nItem: TDDCSNoteItem;
begin
  if Owner <> nil then
  begin
    nItem := FReportCollection.GetNoteItem(TForm(Owner).ActiveControl);
    if nItem <> nil then
      if nItem.SayOnFocus <> '' then
        if ScreenReader <> nil then
          ScreenReader.Say(nItem.SayOnFocus, False);
  end;
end;

procedure TDDCSForm.CtrlTab(Sender: TObject);
var
  wControl: TWinControl;
  vpg: TPageControl;
begin
  wControl := TForm(Owner).ActiveControl;
  if ((wControl <> nil) and (wControl.InheritsFrom(TPageControl)) and
      not (wControl is TDDCSForm) and
      not (wControl is TDDCSVitals)) then
  begin
    TPageControl(wControl).SelectNextPage(True);
    Exit;
  end;

  if VitalsPage = ActivePage then
  begin
    vpg := VitalsControl.fVitalsControl;
    if ((vpg.ActivePageIndex < VitalsControl.fVitalsControl.PageCount - 1) and
        (vpg.Pages[vpg.ActivePageIndex + 1].TabVisible)) then
      vpg.SelectNextPage(True)
    else
      SelectNextPage(True);
  end else
    SelectNextPage(True);
end;

procedure TDDCSForm.CtrlShiftTab(Sender: TObject);
var
  wControl: TWinControl;
  vpg: TPageControl;
begin
  wControl := TForm(Owner).ActiveControl;
  if ((wControl <> nil) and (wControl.InheritsFrom(TPageControl)) and
      not (wControl is TDDCSForm) and
      not (wControl is TDDCSVitals)) then
  begin
    TPageControl(wControl).SelectNextPage(False);
    Exit;
  end;

  if VitalsPage = ActivePage then
  begin
    vpg := VitalsControl.fVitalsControl;
    if ((vpg.ActivePageIndex > 0) and
        (vpg.Pages[vpg.ActivePageIndex - 1].TabVisible)) then
      vpg.SelectNextPage(False)
    else
      SelectNextPage(False);
  end else
    SelectNextPage(False);
end;

function TDDCSForm.GetVitalsForm: TDDCSVitals;
var
  I: Integer;
begin
  Result := nil;

  if FVitalsPage <> nil then
    for I := 0 to FVitalsPage.ControlCount - 1 do
      if FVitalsPage.Controls[I] is TDDCSVitals then
      begin
        Result := TDDCSVitals(FVitalsPage.Controls[I]);
        Break;
      end;
end;

function TDDCSForm.HasSecurityKey(const KeyName: string): Boolean;
var
  x: string;
begin
  Result := False;

  if RPCBrokerV = nil then
    Exit;

  try
    if UpdateContext(MENU_CONTEXT) then
    begin
      x := sCallV('ORWU HASKEY', [KeyName]);
      if x = '1' then
        Result := True;
    end;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
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

  if RPCBrokerV = nil then
    Exit;

  try
    if UpdateContext(MENU_CONTEXT) then
      tCallV(Result, 'DSIO DDCS ORQQAL LIST', [RPCBrokerV.PatientDFN]);
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

  if RPCBrokerV = nil then
    Exit;

  try
    if UpdateContext(MENU_CONTEXT) then
      tCallV(Result, 'DSIO DDCS ORQQPL LIST', [RPCBrokerV.PatientDFN]);
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

  if RPCBrokerV = nil then
    Exit;

  try
    if UpdateContext(MENU_CONTEXT) then
      tCallV(Result, 'DSIO DDCS ORQQPS LIST', [RPCBrokerV.PatientDFN]);
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

end.
