unit DDCSForm;

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
   VA Contract: TAC-13-06464
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.TypInfo, System.Classes, System.Actions, System.Win.ComObj,
  System.StrUtils, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.ComCtrls, Vcl.Menus, Vcl.Themes, Vcl.Styles,
  Vcl.Consts, Vcl.CheckLst, Vcl.ActnList, FSAPILib_TLB,
  DDCSVitals, DDCSGrid, DDCSReportItems, DDCSComBroker, DDCSCommon;

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
    procedure DrawSection(Section: THeaderSection; const Rect: TRect; Pressed: Boolean); override;
    procedure SectionClick(Section: THeaderSection); override;
    procedure SectionTrack(Section: THeaderSection; Width: Integer; State: TSectionTrackState); override;
  public
    constructor Create(AOwner: TComponent); override;
    procedure UpdateControlPanel;
  end;

  TTabControlStyleHookCheck = class(TTabControlStyleHook)
  private
  strict protected
    procedure DrawTab(Canvas: TCanvas; Index: Integer); override;
  end;

      TRegisterDialogs = procedure(out Return: WideString); stdcall;
  TGetDialogComponents = procedure(dlgName: WideString; out Return: WideString); stdcall;
        TDisplayDialog = function(const Broker: PCPRSComBroker; dlgName: WideString;
                                  DebugMode: Boolean; sTheme: WideString;
                                  out rSave,rConfig,rText: WideString): WordBool; stdcall;

  TpbSaveEvent   = procedure(Sender: TObject; AutoSave: Boolean) of object;
  TpbFinishEvent = procedure(Sender: TObject; pbFinish: Boolean) of object;

  TDDCSForm = class(TPageControl)
  private
    FAccept: Boolean;
    FDisableSplash: Boolean;
    FDoNotBuild: Boolean;
    FDialogsDisabled: Boolean;
    FMultiInterface: Boolean;
    FValidated: Boolean;
    FTabSwitch: Boolean;
    FStyleChange: Boolean;
    TabSeen: array of Boolean;
    FGridArray: array of TDDCSQuestionGrid;
    FStyle: string;
    Tasks: TStringList;    //array of autosave tasks to be canceled onClose of the DDCS Form
    FReturnList: TStringList;
    // Components --------------------------------------------------------------
    FControlPanel: TDDCSHeaderControl;
    FNavControl: TActionList;
    FAutoSaveTimer: TTimer;
    FVitalsPage: TTabSheet;
    FConfigurationCollection: TConfigCollection;
    FReportCollection: TDDCSNoteCollection;
    FScreenReader: IJawsApi;
    // Events ------------------------------------------------------------------
    FOnpbSave: TpbSaveEvent;
    FOnpbFinish: TpbFinishEvent;
    FOnpbAccept: TpbFinishEvent;
    FOnpbRestore: TNotifyEvent;
    FOnpbOverrideAbout: TNotifyEvent;
    FOnpbOverrideNote: TNotifyEvent;
    FSaveShow: TNotifyEvent;
    // Dialogs -----------------------------------------------------------------
    FDialogDLL: THandle;
    FRegisterDialogs: TRegisterDialogs;
    FDLLDialogList: TStringList;
    procedure WMGetMSAAObject(var Message: TMessage); message WM_GETOBJECT;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMShowSplash(var Message: TMessage); message WM_SHOW_SPLASH;
    procedure WMSave(var Message: TMessage); message WM_SAVE;
    // Properties --------------------------------------------------------------
    procedure SetVitals(Page: TTabSheet);
    procedure SetConfigCollection(const Value: TConfigCollection);
    procedure SetNoteCollection(const Value: TDDCSNoteCollection);
    // Timer
    procedure OnAutoSaveTimer(Sender: TObject);
    // Helpers to Display Dialogs ----------------------------------------------
    //    TCustomListBox   (TListBox and TCheckListBox)
    procedure ListBoxGetDialogDBClick(Sender: TObject);
    procedure ListBoxGetDialogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    //    TButton
    procedure ButtonGetDialogClick(Sender: TObject);
    // TForm -------------------------------------------------------------------
    procedure FormOverrideShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    // Builder -----------------------------------------------------------------
    procedure SetFormProperties(sValue: string);
    procedure BuildControl(sValue: string); overload;
    procedure BuildControl(sValue: string; slPage: TStringList); overload;
    procedure BuildCollection(sValue: string);
    procedure BuildValues(sValue: string);
    // Screen ------------------------------------------------------------------
    procedure ActiveControlChanged(Sender: TObject);
    // Navigation --------------------------------------------------------------
    procedure NavTab(Sender: TObject);
    procedure NavCtrlTab(Sender: TObject);
    procedure NavShiftTab(Sender: TObject);
    procedure NavCtrlShiftTab(Sender: TObject);
    // Properties --------------------------------------------------------------
    procedure SetGrid(Index: Integer; Value: TDDCSQuestionGrid);
    function GetGrid(Index: Integer): TDDCSQuestionGrid;
    function GetVitalsForm: TDDCSVitalsForm;
    function ShowDialogandReturn(sBuild: string; var sl: TStringList): Boolean;
    // Questions ---------------------------------------------------------------
    procedure BuildQuestion(sValue: string);
    function AddQuestion(iPage: Integer; sName: string): TQuestion;
    function GetIsGrided: Boolean;
  protected
    procedure Change; override;
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
    function Preview(bFinishBtn: Boolean): Boolean;
  public
    // Dialogs -----------------------------------------------------------------
    DisplayDialog: TDisplayDialog;
    GetDialogComponents: TGetDialogComponents;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure BuildAsGrids;
    // Support and 508 ---------------------------------------------------------
    procedure LoadDialogs;
    function AddPage: TTabSheet;
    function GetQuestion(sName: string): TQuestion; overload;
    function GetQuestion(wControl: TWinControl): TQuestion; overload;
    function GetControl(sName: string): TWinControl;
    property DoNotBuild: Boolean read FDoNotBuild write FDoNotBuild;
    property Grids[Index: Integer]: TDDCSQuestionGrid read GetGrid write SetGrid;
    property IsGrided: Boolean read GetIsGrided;
    property MultiInterface: Boolean read FMultiInterface write FMultiInterface;
    property TmpStrList: TStringList read FReturnList write FReturnList;
    property Validated: Boolean read FValidated write FValidated default False;
    property VitalsControl: TDDCSVitalsForm read GetVitalsForm;
    property ScreenReader: IJawsApi read FScreenReader;
    property CurrentStyle: string read FStyle write FStyle;
    property ConfigurationCollection: TConfigCollection read FConfigurationCollection write SetConfigCollection;
    property DLLDialogList: TStringList read FDLLDialogList;
    property Accept: Boolean read FAccept write FAccept;
  published
    property VitalsPage: TTabSheet read FVitalsPage write SetVitals;
    property AutoTimer: TTimer read FAutoSaveTimer write FAutoSaveTimer;
    property DisableSplash: Boolean read FDisableSplash write FDisableSplash default False;
    property ReportCollection: TDDCSNoteCollection read FReportCollection write SetNoteCollection;
    property OnSave: TpbSaveEvent read FOnpbSave write FOnpbSave;
    property OnFinish: TpbFinishEvent read FOnpbFinish write FOnpbFinish;
    property OnAccept: TpbFinishEvent read FOnpbAccept write FOnpbAccept;
    property OnRestore: TNotifyEvent read FOnpbRestore write FOnpbRestore;
    property OnOverrideAboutClick: TNotifyEvent read FOnpbOverrideAbout write FOnpbOverrideAbout;
    property OnOverrideNote: TNotifyEvent read FOnpbOverrideNote write FOnpbOverrideNote;
  end;

  procedure Register;

implementation

uses
  JvStringGrid, DDCSSplash, DDCSReview, DDCSConfiguration, DDCSAbout, DDCSUtils,
  DDCSPatient, DDCSUser;

procedure Register;
begin
  RegisterClass(TDDCSNoteCollection);
  RegisterClass(TDDCSNoteItem);
  RegisterClass(TDDCSHeaderControl);
  RegisterClass(TDDCSVitalsForm);
  RegisterComponents('DDCS', [TDDCSForm]);
end;

{$REGION 'TDDCSHeaderControl'}

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
  else
    SayText := Sections[FSelectedSectionIndex].Text + aText;

  if Sections[FSelectedSectionIndex].AllowClick then
    SayText := SayText + ', press space or enter to activate.';

  if Assigned(FDDCSForm.ScreenReader) then
    FDDCSForm.ScreenReader.SayString(SayText, False);
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
    if Sections[FSelectedSectionIndex].AllowClick then
      SectionClick(Sections[FSelectedSectionIndex]);

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
  if fConfiguration <> nil then
    fConfiguration.Show;
end;

procedure TDDCSHeaderControl.FcLoadDialogsClick(Sender: TObject);
begin
  FDDCSForm.LoadDialogs;
  if FDDCSForm.FDialogDLL <> 0 then
    ShowMsg('Successfully loaded the shared dialogs.');
end;

procedure TDDCSHeaderControl.FcAboutClick(Sender: TObject);
begin
  if Assigned(FDDCSForm.FOnpbOverrideAbout) then
    FDDCSForm.FOnpbOverrideAbout(Sender)
  else
  begin
    fAbout := TfAbout.Create(FDDCSForm);
    try
      fAbout.ShowModal;
    finally
      fAbout.Free;
    end;
  end;
end;

procedure TDDCSHeaderControl.FcChangeThemeClick(Sender: TObject);
var
  Style: string;
  I: Integer;
begin
  if Assigned(TStyleManager.ActiveStyle) and
     (TStyleManager.ActiveStyle.Name <> TMenuItem(Sender).Caption) then
  begin
    Style := TMenuItem(Sender).Caption;
    if Pos('&', Style) > 0 then
      Delete(Style, 1, 1);

    try
      if Style = 'Default' then
        TStyleManager.TrySetStyle('Windows')
      else
        TStyleManager.TrySetStyle(Style);

      FDDCSForm.FStyle := Style;

      for I := 0 to FCommandMenu.Items[3].Count - 1 do
        TMenuItem(FCommandMenu.Items[3].Items[I]).Checked := False;
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

procedure TDDCSHeaderControl.DrawSection(Section: THeaderSection; const Rect: TRect; Pressed: Boolean);
var
  X,Y: Integer;
  R: TRect;
begin
  inherited;

  Canvas.Brush.Style := bsClear;
  Canvas.FillRect(Rect);

  X := Round(Rect.Left + (Rect.Width div 2) - (Canvas.TextWidth(Section.Text) div 2));
  Y := Round(Rect.Top + (Rect.Height div 2) - (Canvas.TextHeight(Section.Text) div 2));

  if Section.Index = FSelectedSectionIndex then
  begin
    Canvas.Font.Color := clGrayText;
    Canvas.TextOut(X, Y, Section.Text);
    R := Rect;
    InflateRect(R, -3, -3);
    Canvas.DrawFocusRect(R);

    if (not Section.AllowClick) or (Section.Index = 6) then
      Canvas.Font.Color := clGrayText
    else
      Canvas.Font.Color := clMenuText;
    Canvas.TextOut(X, Y, Section.Text);
  end
  else
  begin
    if (not Section.AllowClick) or (Section.Index = 6) then
      Canvas.Font.Color := clGrayText
    else
      Canvas.Font.Color := clMenuText;
    Canvas.TextOut(X, Y, Section.Text);
  end;
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
        for I := 0 to Popup.Items.Count - 1 do
          if Popup.Items[I].Visible then
            Inc(Result, y);
    end;

  begin
    APoint := ClientToScreen(Point(0, ClientHeight - Height - PopupMenuHeight(FCommandMenu) - 2));
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
    6: ;
    7: FDDCSForm.SelectNextPage(True);
  end;
end;

procedure TDDCSHeaderControl.SectionTrack(Section: THeaderSection; Width: Integer; State: TSectionTrackState);
begin
  Abort;
end;

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
  TabStop := True;
  TabOrder := 1;
  DragCursor := crDefault;

  for I := 0 to 7 do
    AddControlPanelButton(I);

  if csDesigning in ComponentState then
    Exit;

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
  FCommandItem.Visible := False;

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

procedure TDDCSForm.WMSave(var Message: TMessage);
begin
  inherited;

  Save(True);
end;

procedure TDDCSForm.SetVitals(Page: TTabSheet);
var
  FVitalsForm: TDDCSVitalsForm;
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
    FVitalsForm := TDDCSVitalsForm.Create(Self);
    FVitalsForm.Parent := Page;
    FVitalsForm.Name := 'DDCSVitals';
    FVitalsForm.Align := alClient;
    FVitalsForm.Show;

    // If we create with owner then it will fail with already exists because the Frame
    // Create is probably being called multiple times so we set the owner later, here
    // Owner.InsertComponent(FVitalsForm);
  end;
end;

procedure TDDCSForm.SetConfigCollection(const Value: TConfigCollection);
begin
  FConfigurationCollection.Assign(Value);
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

function TDDCSForm.ShowDialogandReturn(sBuild: string; var sl: TStringList): Boolean;
var
  wSave,wConfig,wText: WideString;
begin
  Result := False;

  sl.Clear;
  try
    if Assigned(DisplayDialog) then
      if DisplayDialog(@RPCBrokerV, sBuild, False, CurrentStyle, wSave, wConfig, wText) then
      begin
        Result := True;

        if DDCSObjects <> nil then
          Exit;

        if wSave <> '' then
        begin
          sl.Text := wSave;
          UpdateContext(MENU_CONTEXT);
          CallV('DSIO DDCS STORE', [DDCSObjects.ControlObject, RPCBrokerV.TIUNote.IEN,
                                    Piece(sBuild,'|',1) + ';DSIO(19641.49,', sl]);
        end;
        sl.Clear;
        if wConfig <> '' then
        begin
          sl.Text := wConfig;
          UpdateContext(MENU_CONTEXT);
          CallV('DSIO DDCS STORE', [DDCSObjects.ControlObject, RPCBrokerV.TIUNote.IEN,
                                    Piece(sBuild,'|',1) + ';DSIO(19641.49,', sl, 'C']);
        end;
        sl.Clear;
        sl.Text := wText;
      end;
  except
    on E: Exception do
    ShowMessage(E.Message);
  end;
end;

procedure TDDCSForm.ListBoxGetDialogDBClick(Sender: TObject);
var
  ls: TCustomListBox;
  nItem: TDDCSNoteItem;
  sl: TStringList;
begin
  inherited;

  if FDialogDLL = 0 then
    Exit;
  if not Sender.InheritsFrom(TCustomListBox) then
    Exit;
  ls := TCustomListBox(Sender);
  if ls.ItemIndex = -1 then
    Exit;
  nItem := FReportCollection.GetNoteItem(TWinControl(Sender));
  if nItem = nil then
    Exit;
  if nItem.Configuration.Count - 1 < ls.ItemIndex then
    Exit;
  if nItem.Configuration[ls.ItemIndex] = '' then
    Exit;

  sl := TStringList.Create;
  try
    if ShowDialogandReturn(nItem.Configuration[ls.ItemIndex], sl) then
    begin
      if Sender.InheritsFrom(TCheckListBox) then
        TCheckListBox(Sender).Checked[ls.ItemIndex] := True;
      if nItem.DialogReturn <> nil then
        TCustomMemo(nItem.DialogReturn).Lines.AddStrings(sl);
    end;
  finally
    sl.Free;
  end;
end;

procedure TDDCSForm.ListBoxGetDialogKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  ls: TCustomListBox;
  nItem: TDDCSNoteItem;
  tmp: string;
  sl: TStringList;
begin
  inherited;

  if ((Key <> VK_SPACE) and (Key <> VK_RETURN)) then
    Exit;

  if FDialogDLL = 0 then
    Exit;
  if not Sender.InheritsFrom(TCustomListBox) then
    Exit;
  ls := TCustomListBox(Sender);
  if ls.ItemIndex = -1 then
    Exit;
  nItem := FReportCollection.GetNoteItem(TWinControl(Sender));
  if nItem = nil then
    Exit;
  if nItem.Configuration.Count - 1 < ls.ItemIndex then
    Exit;
  if nItem.Configuration[ls.ItemIndex] = '' then
    Exit;

  if Key = VK_SPACE then
  begin
    if ls.InheritsFrom(TCheckListBox) then
    begin
      tmp := ls.Items[ls.ItemIndex];

      if TCheckListBox(ls).Checked[ls.ItemIndex] then        // KeyDown before checked
        tmp := tmp + ' not checked'
      else
        tmp := tmp + ' checked';

      ScreenReader.SayString(tmp, False);
    end;

    Exit;
  end;

  sl := TStringList.Create;
  try
    if ShowDialogandReturn(nItem.Configuration[ls.ItemIndex], sl) then
    begin
      if Sender.InheritsFrom(TCheckListBox) then
        (Sender as TCheckListBox).Checked[ls.ItemIndex] := True;
      if nItem.DialogReturn <> nil then
        (nItem.DialogReturn as TCustomMemo).Lines.AddStrings(sl);
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

  if FDialogDLL = 0 then
    Exit;
  if not Sender.InheritsFrom(TButton) then
    Exit;
  nItem := FReportCollection.GetNoteItem(TWinControl(Sender));
  if nItem = nil then
    Exit;
  if nItem.Configuration.Count < 1 then
    Exit;
  if nItem.Configuration[0] = '' then
    Exit;

  sl := TStringList.Create;
  try
    if ShowDialogandReturn(nItem.Configuration[0], sl) then
      if nItem.DialogReturn <> nil then
        (nItem.DialogReturn as TCustomMemo).Lines.AddStrings(sl);
  finally
    sl.Free;
  end;
end;

{$ENDREGION}

procedure TDDCSForm.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;

  if (FReportCollection = nil) or (not (AComponent is TWinControl)) or (AComponent = Self) then
    Exit;
  if AComponent is TStaticText then
    Exit;

  if ((csDesigning in ComponentState) and (not (csLoading in ComponentState))) then
  begin
    if Operation = opInsert then
      FReportCollection.GetNoteItemAddifNil(TWinControl(AComponent))
    else
    if Operation = opRemove then
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
  end
  else
  begin
    if wControl is TStaticText then
      Exit;

    if wControl.InheritsFrom(TComboBox) then
    begin
      wComboBox := TComboBox(wControl);
      if not Assigned(wComboBox.OnDropDown) then
        wComboBox.OnDropDown := TComponentHelper.cbAutoWidth;
    end;

    if wControl.InheritsFrom(TRadioGroup) then
    begin
      wRadioGroup := TRadioGroup(wControl);
      if not Assigned(wRadioGroup.OnEnter) then
        wRadioGroup.OnEnter := TComponentHelper.RadioGroupEnter;
    end;

    // Only what was set by the developer will be a note item, later the VistA configuration
    // will create and edit the note items
    nItem := FReportCollection.GetNoteItem(wControl);
    if nItem = nil then
      Exit;

    if Assigned(nItem.DialogReturn) then
    begin
      if wControl.InheritsFrom(TCheckListBox) then
      begin
        TCheckListBox(wControl).OnDblClick := ListBoxGetDialogDBClick;
        TCheckListBox(wControl).OnKeyDown := ListBoxGetDialogKeyDown;
      end
      else
      if wControl.InheritsFrom(TListBox) then
      begin
        TListBox(wControl).OnDblClick := ListBoxGetDialogDBClick;
        TListBox(wControl).OnKeyDown := ListBoxGetDialogKeyDown;
      end
      else
      if wControl.InheritsFrom(TButton) then
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
  sl,cl: TStringList;
  I: Integer;
  nItem: TDDCSNoteItem;
begin
  if RPCBrokerV = nil then
    Exit;
  if not FControlPanel.Sections[1].AllowClick then
    Exit;
  if PageCount < 1 then
    Exit;
  if (not Assigned(ReportCollection)) or (ReportCollection.Count < 1) then
    Exit;

  FControlPanel.Sections[1].AllowClick := False;
  try
    sl := TStringList.Create;
    try
      cl := TStringList.Create;
      try
        try
          for I := 0 to ReportCollection.Count - 1 do
          begin
            nItem := ReportCollection.Items[I];

            // Data format -----------------------------------------------------------
            //   CONTROL^(INDEXED^VALUE)

            if not nItem.DoNotSave then
            begin
              nItem.GetValueSave(sl);
              if sl.Count > 0 then
                cl.AddStrings(sl);
            end;
          end;

          if Assigned(VitalsControl) then
            VitalsControl.Save;

          if ((cl.Count > 0) and (DDCSObjects <> nil)) then
          begin
            if aSave then
            begin
              UpdateContext(MENU_CONTEXT);
              Tasks.Add(sCallV('DSIO DDCS STORE', [DDCSObjects.ControlObject, RPCBrokerV.TIUNote.IEN,
                                                   DDCSObjects.DDCSInterface, cl, 1]));
            end
            else
            begin
              UpdateContext(MENU_CONTEXT);
              CallV('DSIO DDCS STORE', [DDCSObjects.ControlObject, RPCBrokerV.TIUNote.IEN,
                                        DDCSObjects.DDCSInterface, cl]);
            end;
          end;
          cl.Clear;

          FConfigurationCollection.GetCollectiveText(cl);
          if ((cl.Count > 0) and (DDCSObjects <> nil)) then
          begin
            UpdateContext(MENU_CONTEXT);
            CallV('DSIO DDCS STORE', [DDCSObjects.ControlObject, RPCBrokerV.TIUNote.IEN,
                                      DDCSObjects.DDCSInterface, cl, 'C']);
          end;
        except
          on E: Exception do
          begin
            if not aSave then
              ShowMsg(E.Message, smiError, smbOK);
          end;
        end;
      finally
        cl.Free;
      end;
    finally
      sl.Free;
    end;
  finally
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
    FAccept := True;
    TForm(Owner).OnCloseQuery := nil;
    Cancel;
  end
  else
    FAccept := False;
end;

procedure TDDCSForm.Cancel;
begin
  (Owner as TForm).Close;
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

function TDDCSForm.Preview(bFinishBtn: Boolean): Boolean;
var
  sl: TStringList;
  I,iPage,J: Integer;
  nItem: TDDCSNoteItem;
  nItemPage: TTabSheet;
  qQuestion: TQuestion;
  wControl,vControl: TWinControl;
  cVitals: TDDCSVitalsForm;
  errMsg: string;
  cBool: Boolean;
  aReport: array of array of string;
  sPad: string;
begin
  Result := False;

  if IsGrided then
    for I := 0 to Length(FGridArray) - 1 do
      FGridArray[I].HideControl;

  FReturnList.Clear;

  // Validate that all pages have been seen
  cBool := True;
  errMsg := 'The following pages have not been viewed:';
  for I := 0 to High(TabSeen) do
    if not TabSeen[I] then
    begin
      cBool := False;
      errMsg := errMsg + #13#10 + '   ' + Pages[I].Caption;
    end;
  if not cBool then
  begin
    ShowMsg(errMsg);
    Exit;
  end;

  wControl := nil;
  errMsg := 'The following elements are required but are currently invalid:';

  SetLength(aReport, PageCount);
  try
    sl := TStringList.Create;
    try
      cBool := True;
      for I := 0 to ReportCollection.Count - 1 do
      begin
        nItem := ReportCollection.Items[I];
        nItemPage := nItem.Page;
        if nItemPage <> nil then
        begin
          if IsGrided then
          begin
            qQuestion := GetQuestion(nItem.OwningObject);
            if qQuestion <> nil then
              if qQuestion.IsAssociatedControl then
                Continue;
          end;

          if (nItemPage.TabVisible) or ((not nItemPage.TabVisible) and (PageCount = 1)) then
            if not nItem.IsValid then
            begin
              cBool := False;
              // Collection all the errors (above) but just jump to the first control
              if wControl = nil then
              begin
                if nItem.OwningObject is TDDCSVitalsForm then
                  wControl := TDDCSVitalsForm(nItem.OwningObject).ValidationControl
                else
                  wControl := nItem.OwningObject;
              end;

              if nItem.IdentifyingName <> '' then
                errMsg := errMsg + #13#10 + '  - ' + nItem.IdentifyingName
              else
                errMsg := errMsg + #13#10 + '  - ' + nItem.OwningObject.Name;

              if nItem.OwningObject is TDDCSVitalsForm then
              begin
                vControl := nItem.OwningObject;
                errMsg := errMsg + #13#10 + TDDCSVitalsForm(nItem.OwningObject).ValidateMsg;
              end;
            end
            else
            begin
              nItem.GetValueNote(sl);
              if sl.Count > 0 then
              begin
                SetLength(aReport[nItem.Page.PageIndex], (Length(aReport[nItem.Page.PageIndex]) + 1));
                aReport[nItem.Page.PageIndex, (Length(aReport[nItem.Page.PageIndex]) - 1)] := sl.Text;
              end;
            end;
        end;
      end;

      // ReportItems have checked out but if we were to set Result like cBool and there
      // was a booboo then we could exit resulting in True, and we don't want that.
      Result := cBool;

      if not Result then
      begin
        ShowMsg(errMsg);
        nItem := ReportCollection.GetNoteItem(wControl);
        if nItem <> nil then
        begin
          if nItem.Page <> nil then
          begin
            ActivePageIndex := nItem.Page.PageIndex;
            Change;
            if wControl.Visible then
              wControl.SetFocus;
          end;
        end
        else
        if vControl <> nil then
        begin
          nItem := ReportCollection.GetNoteItem(vControl);
          if nItem <> nil then
            if nItem.Page <> nil then
            begin
              ActivePageIndex := nItem.Page.PageIndex;
              Change;
              // There's only one Vitals control required, if that changes then this
              // could either be the first or third page.
              cVitals := TDDCSVitalsForm(vControl);
              cVitals.fVitalsControl.ActivePageIndex := 0;
              if wControl.Visible then
                wControl.SetFocus;
            end;
        end;
      end
      else
      begin
        if Assigned(FOnpbOverrideNote) then
        begin
          FReturnList.Clear;
          onOverrideNote(nil);
          Result := FValidated;
        end
        else
        begin
          if fReview <> nil then
          begin
            for iPage := 0 to High(aReport) do
            begin
              if Length(aReport) > 1 then
              begin
                FReturnList.Add('--------------------------------------------------------------------------');
                FReturnList.Add(Pages[iPage].Caption);
                FReturnList.Add('--------------------------------------------------------------------------');
                sPad := ' ';
              end;

              for I := 0 to High(aReport[iPage]) do
              begin
                sl.Clear;
                sl.Text := aReport[iPage,I];
                for J := 0 to sl.Count - 1 do
                  FReturnList.Add(sPad + sl[J]);
              end;
            end;

            fReview.btnAccept.Enabled := bFinishBtn;
            fReview.meNote.Lines.Assign(FReturnList);

            fReview.ShowModal;
            if fReview.ModalResult = mrOK then
            begin
              Result := True;
              FReturnList.Clear;
              FReturnList.Assign(fReview.meNote.Lines);
              FValidated := Result;
            end
            else
              Result := False;
          end;
        end;
      end;
    finally
      sl.Free;
    end;
  finally
    SetLength(aReport, 0);
  end;
end;

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
  Ctl3D := False;

  FControlPanel := TDDCSHeaderControl.Create(Self);
  FControlPanel.Parent := Self;

  FConfigurationCollection := TConfigCollection.Create(Self, TConfigItem);
  FReportCollection := TDDCSNoteCollection.Create(Self, TDDCSNoteItem);         // Create last to prevent adding ReportCollection Items we shouldn't have
                                                                                // - components that are part of TDDCSForm
  if csDesigning in ComponentState then
    Exit;

  OnDrawTab := DrawCheckTab;       // This needs to be part of the class

  TForm(AOwner).AlphaBlend := True;
  TForm(AOwner).AlphaBlendValue := 0;

  Screen.OnActiveControlChange := ActiveControlChanged;

  FSaveShow := TForm(AOwner).OnShow;
  TForm(AOwner).OnShow := FormOverrideShow;

  TForm(AOwner).OnCloseQuery := FormCloseQuery;
  TForm(AOwner).OnClose := FormClose;

  // Navigation ----------------------------------------------------------------
  FNavControl := TActionList.Create(Self);

  // Tab
  nAct := TAction.Create(FNavControl);
  nAct.ActionList := FNavControl;
  nAct.ShortCut := ShortCut(VK_TAB, []);
  nAct.OnExecute := NavTab;

  // Ctrl Tab
  nAct := TAction.Create(FNavControl);
  nAct.ActionList := FNavControl;
  nAct.ShortCut := ShortCut(VK_TAB, [ssCtrl]);
  nAct.OnExecute := NavCtrlTab;

  // Shift Tab
  nAct := TAction.Create(FNavControl);
  nAct.ActionList := FNavControl;
  nAct.ShortCut := ShortCut(VK_TAB, [ssShift]);
  nAct.OnExecute := NavShiftTab;

  // Ctrl Shift Tab
  nAct := TAction.Create(FNavControl);
  nAct.ActionList := FNavControl;
  nAct.ShortCut := ShortCut(VK_TAB, [ssCtrl, ssShift]);
  nAct.OnExecute := NavCtrlShiftTab;

  // ---------------------------------------------------------------------------

  FAutoSaveTimer := TTimer.Create(Self);
  FAutoSaveTimer.Name := 'DDCSAutoTimer';
  FAutoSaveTimer.Interval := 600000;
  FAutoSaveTimer.OnTimer := OnAutoSaveTimer;

  FDLLDialogList := TStringList.Create;
  Tasks := TStringList.Create;
  FReturnList := TStringList.Create;
  LoadDialogs;

  try
    FScreenReader := CreateComObject(CLASS_JawsApi) as IJawsApi;
  except
  end;
end;

procedure TDDCSForm.FormOverrideShow(Sender: TObject);
var
  dl,sl: TStringList;
  sReturn,sHold: string;
  I,J: Integer;
  cI,cII,cIII: Integer;
  cD: Char;
  cItem: TConfigItem;
  p1,p2,p3: string;

  procedure CompleteShow;
  var
    I: Integer;
  begin
    TabHeight := 30;
    for I := 0 to PageCount - 1 do
    begin
      // The caption is clipped when the checkbox is drawn
      Pages[I].Caption := Pages[I].Caption + '      ';
      Pages[I].TabStop := False;
    end;

    if PageCount = 1 then
    begin
      (Owner as TForm).Caption := Pages[0].Caption;
      Pages[0].TabVisible := False;
    end;

    ActivePageIndex := 0;
    GoToPageFirstTabItem;

    if FDisableSplash then
      (Owner as TForm).AlphaBlend := False;

    FControlPanel.UpdateControlPanel;

    if Assigned(FSaveShow) then
      FSaveShow(Owner);
  end;

begin
  if FStyleChange then
    Exit;
  FStyleChange := True;

  if (RPCBrokerV = nil) or (DDCSObjects = nil) then
    Exit;

  try
    dl := TStringList.Create;
    try
      sl := TStringList.Create;
      try
        UpdateContext(MENU_CONTEXT);
        sReturn := sCallV('DSIO DDCS CONFIGURATION', [DDCSObjects.DDCSInterface, 'SHOW SPLASH']);
        if sReturn <> '' then
          FDisableSplash := not StrToBool(sReturn);
        if not FDisableSplash then
          PostMessage(Handle, WM_SHOW_SPLASH, 0, 0);

        fConfiguration := TfConfiguration.Create(Self);
        fReview := TfReview.Create(Self);
        if PageCount = 1 then
          fReview.Caption := fReview.Caption + ': ' + Pages[0].Caption;

        UpdateContext(MENU_CONTEXT);
        sHold := sCallV('DSIO DDCS CONFIGURATION', [DDCSObjects.DDCSInterface, 'HOLD ON SHOW']);
        if sHold <> '1'  then
        begin
          RPCBrokerV.HostEnabled := True;
          EnableTaskWindows(RPCBrokerV.Host);
        end;

        // We're going through all of the component's controls rather than just the report collection
        // because we're adding the TWinControls to the Configuration form and adding click methods to
        // control types, thus SetUpControl NOT SetUpNoteItem.
        for I := 0 to PageCount - 1 do
          for J := 0 to Pages[I].ControlCount - 1 do
            if Pages[I].Controls[J] is TWinControl then
              SetUpControl(I, TWinControl(Pages[I].Controls[J]));

        if HasSecurityKey('DSIO DDCS CONFIG') then
          FControlPanel.FCommandMenu.Items[1].Visible := True;

        if DDCSObjects.DDCSInterfacePages.Count > 0 then
        begin
          FMultiInterface := True;
          dl.AddStrings(DDCSObjects.DDCSInterfacePages);
        end
        else
        begin
          FMultiInterface := False;
          dl.Add(DDCSObjects.DDCSInterface);
        end;

        if FDoNotBuild then
        begin
          CompleteShow;
          Exit;
        end;

        UpdateContext(MENU_CONTEXT);
        tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, DDCSObjects.ControlObject, RPCBrokerV.TIUNote.IEN]);
        if sl.Count < 1 then
          Exit;

        for I := 0 to sl.Count - 1 do
        begin
          // Form --------------------------------------------------------------
          // I^TITLE|VALUE
          if Piece(sl[I],U,1) = 'I' then
          begin
            SetFormProperties(Pieces(sl[I],U,2,99));
            Continue;
          end;

          // Page --------------------------------------------------------------
          // P^NUMBER^CAPTION^HIDE
          if Piece(sl[I],U,1) = 'P' then
          begin
            if TryStrToInt(Piece(sl[I],U,2), J) then
              if ((J > 0) and (J <= PageCount)) then
              begin
                if Piece(sl[I],U,3) <> '' then
                  Pages[J - 1].Caption := Piece(sl[I],U,3);
                if Piece(sl[I],U,4) <> '' then
                  Pages[J - 1].TabVisible := not StrToBool(Piece(sl[I],U,4));
              end;
            Continue;
          end;

          // Control --------------------------------------------------------
          // CC^NAME^COLLECTION_NAME|VALUE
          if Piece(sl[I],U,1) = 'CC' then
          begin
            BuildCollection(sl[I]);
            Continue;
          end;

          // Control Value --------------------------------------------------
          // CV^NAME^F^(INDEXED^VALUE)
          // CV^NAME^D^IEN|NAME|CLASS
          if Piece(sl[I],U,1) = 'CV' then
            BuildValues(sl[I]);
        end;

        UpdateContext(MENU_CONTEXT);
        tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, DDCSObjects.ControlObject, RPCBrokerV.TIUNote.IEN, '1']);
        if sl.Count > 1 then
        begin
          cI := StrToIntDef(Piece(Piece(sl[0],':',1),',',1), 0);
          cII := StrToIntDef(Piece(Piece(sl[0],':',1),',',2), 0);
          cIII := StrToIntDef(Piece(Piece(sl[0],':',1),',',3), 0);
          FConfigurationCollection.Pieces[1] := cI;
          FConfigurationCollection.Pieces[2] := cII;
          FConfigurationCollection.Pieces[3] := cIII;

          sReturn := Piece(sl[0],':',2);
          if sReturn <> '' then
            cD := sReturn[1]
          else
            cD := U;
          FConfigurationCollection.Delimiter := cD;

          for I := 1 to sl.Count - 1 do
          begin
            if CI > 0 then
              p1 := Piece(sl[I],cD,cI)
            else
              p1 := '';

            if CII > 0 then
              p2 := Piece(sl[I],cD,cII)
            else
              p2 := '';

            if CIII > 0 then
              p3 := Piece(sl[I],cD,cIII)
            else
              p3 := '';

            cItem := FConfigurationCollection.LookUp(p1, p2, p3);
            if cItem = nil then
            begin
              cItem := TConfigItem.Create(FConfigurationCollection);
              cItem.ID[1] := p1;
              cItem.ID[2] := p2;
              cItem.ID[3] := p3;
            end;
            cItem.Data.Add(sl[I]);
          end;
        end;

        CompleteShow;
      finally
        sl.Free;
      end;
    finally
      dl.Free;
    end;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

procedure TDDCSForm.BuildAsGrids;
var
  dl,sl,slPage: TStringList;
  I: Integer;
  tTab: TTabSheet;
  Grid: TDDCSQuestionGrid;
begin
  FDoNotBuild := True;

  if DDCSObjects = nil then
  begin
    ShowMsg('The interface has not been defined.');
    Exit;
  end;

  try
    dl := TStringList.Create;
    try
      if DDCSObjects.DDCSInterfacePages.Count > 0 then
        dl.AddStrings(DDCSObjects.DDCSInterfacePages)
      else
        dl.Add(DDCSObjects.DDCSInterface);

      sl := TStringList.Create;
      try
        UpdateContext(MENU_CONTEXT);
        tCallV(sl, 'DSIO DDCS BUILD FORM', [dl, DDCSObjects.ControlObject, RPCBrokerV.TIUNote.IEN]);
        if sl.Count < 1 then
          Exit;

        slPage := TStringList.Create;
        try
          for I := 0 to sl.Count - 1 do
          begin
            // I^TITLE|VALUE
            if Piece(sl[I],U,1) = 'I' then
            begin
              SetFormProperties(Pieces(sl[I],U,2,99));
              Continue;
            end;

            // P^NUMBER^CAPTION^HIDE
            if Piece(sl[I],U,1) = 'P' then
            begin
              if not StrToBool(Piece(sl[I],U,4)) then         // HIDE (FALSE = Do not Hide)
              begin
                tTab := AddPage;
                tTab.Caption := Piece(sl[I],U,3);
                slPage.AddObject(Piece(sl[I],U,2), tTab);

                Grid := TDDCSQuestionGrid.Create(tTab);
                Grid.Parent := tTab;

                FGridArray[(PageCount - 1)] := Grid;
              end;
            end;
          end;

          for I := 0 to sl.Count - 1 do
          begin
            // CR^NAME^CLASS^PG#^VALIDATE^PROPERITES
            if Piece(sl[I],U,1) = 'CR' then
              BuildControl(sl[I], slPage);
          end;

          for I := 0 to sl.Count - 1 do
          begin
            // CI^NAME^IDENTIFIER^QUESTION^ASSOCIATED_CONTROL
            if Piece(sl[I],U,1) = 'CI' then
            begin
              BuildQuestion(sl[I]);
              Continue;
            end;

            // CC^NAME^COLLECTION_NAME|VALUE
            if Piece(sl[I],U,1) = 'CC' then
            begin
              BuildCollection(sl[I]);
              Continue;
            end;

            // CV^NAME^(D,F)^(INDEX^VALUE)
            if Piece(sl[I],U,1) = 'CV' then
              BuildValues(sl[I]);
          end;

          // Populate Question Controls
          for I := 0 to Length(FGridArray) - 1 do
            FGridArray[I].QuestionCollection.UpdateQuestionControls;
        finally
          slPage.Free;
        end;
      finally
        sl.Free;
      end;
    finally
      dl.Free;
    end;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

procedure TDDCSForm.WMShowSplash(var Message: TMessage);
var
  Start,Elapsed: DWORD;
begin
  inherited;

  if not FDisableSplash then
  begin
    fSplash := TfSplash.Create(nil);
    try
      fSplash.Show;
      fSplash.BringToFront;
      fSplash.Update;

      Start := GetTickCount;
      Elapsed := 0;
      repeat
        if MsgWaitForMultipleObjects(0, Pointer(nil)^, False, 5000 - Elapsed, QS_ALLINPUT) <>
           WAIT_OBJECT_0 then
          Break;
        Application.ProcessMessages;
        Elapsed := GetTickCount - Start;
      until Elapsed >= 5000;
    finally
      fSplash.Free;
      (Owner as TForm).AlphaBlend := False;
    end;
  end;
end;

destructor TDDCSForm.Destroy;
begin
  if not (csDesigning in ComponentState) then
    Screen.OnActiveControlChange := nil;

  FreeAndNil(FConfigurationCollection);
  FreeAndNil(FReportCollection);
  FreeAndNil(FDLLDialogList);
  FreeAndNil(Tasks);
  FreeAndNil(FReturnList);
  FreeAndNil(FNavControl);

  SetLength(TabSeen, 0);
  SetLength(FGridArray, 0);

  if FDialogDLL <> 0 then
    FreeLibrary(FDialogDLL);

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
  end
  else
    FControlPanel.SetFocus;
end;

procedure TDDCSForm.Change;
begin
  inherited;

  FControlPanel.UpdateControlPanel;

  if csDesigning in ComponentState then
    Exit;

  if ActivePage.TabVisible then
    if Assigned(ScreenReader) then
    begin
      ScreenReader.SayString(ActivePage.Caption + ' Currently on page ' +
                             FControlPanel.Sections.Items[6].Text, False);

      if ActivePage = VitalsPage then
        VitalsControl.fVitalsControlChange(nil);
    end;
end;

procedure TDDCSForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  FAccept := False;
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
      UpdateContext(MENU_CONTEXT);
      CallV('DSIO DDCS CANCEL AUTOSAVE', [Tasks]);
    except
    end;
  finally
    Save(False);
    Action := caFree;
  end;
end;

function TDDCSForm.GetIsGrided: Boolean;
begin
  Result := (Length(FGridArray) > 0);
end;

procedure TDDCSForm.BuildQuestion(sValue: string);
var
  qQuestion: TQuestion;
begin
  // CI^NAME^IDENTIFIER^QUESTION^ASSOCIATED_CONTROL
  qQuestion := GetQuestion(Piece(sValue,U,2));
  if qQuestion <> nil then
  begin
    qQuestion.ID := Piece(sValue,U,3);
    // If the control has an associated control then it is not a question and
    // is install a supporting response.
    qQuestion.Question := Piece(sValue,U,4);
    qQuestion.AssociatedControl := GetControl(Piece(sValue,U,5));
  end;
end;

function TDDCSForm.AddQuestion(iPage: Integer; sName: string): TQuestion;
begin
  Result := FGridArray[iPage].QuestionCollection.GetQuestionAddifNil(sName);
end;

function TDDCSForm.GetQuestion(sName: string): TQuestion;
var
  I: Integer;
begin
  Result := nil;

  if sName = '' then
    Exit;

  for I := 0 to Length(FGridArray) - 1 do
  begin
    Result := FGridArray[I].QuestionCollection.GetQuestion(sName);
    if Result <> nil then
      Break;
  end;
end;

function TDDCSForm.GetQuestion(wControl: TWinControl): TQuestion;
var
  I: Integer;
begin
  Result := nil;

  if wControl = nil then
    Exit;

  for I := 0 to Length(FGridArray) - 1 do
  begin
    Result := FGridArray[I].QuestionCollection.GetQuestion(wControl);
    if Result <> nil then
      Break;
  end;
end;

function TDDCSForm.GetControl(sName: string): TWinControl;
var
  I: Integer;
  qQuestion: TQuestion;
begin
  Result := nil;

  if sName = '' then
    Exit;

  if Assigned(FReportCollection) then
    Result := FReportCollection.GetAControl(sName);
  if Result = nil then
    for I := 0 to Length(FGridArray) - 1 do
    begin
      qQuestion := FGridArray[I].QuestionCollection.GetQuestion(sName);
      if qQuestion <> nil then
      begin
        Result := qQuestion.Control;
        Break;
      end;
    end;
end;

procedure TDDCSForm.SetFormProperties(sValue: string);
var
  iCount,I: Integer;
  sProp,sPropValue: string;
begin
  // I^PROPERTY|VALUE
  if sValue = '' then
    Exit;

  iCount := SubCount(sValue, U) + 1;
  for I := 1 to iCount do
  begin
    sProp := Piece(Piece(sValue,U,I),'|',1);
    if IsPublishedProp(Owner, sProp) then
    begin
      sPropValue := Piece(Piece(sValue,U,I),'|',2);
      if sPropValue <> '' then
        SetPropValue(Owner, sProp, sPropValue);
    end;
  end;
end;

procedure TDDCSForm.BuildControl(sValue: string);
var
  iPage: Integer;
  qQuestion: TQuestion;
begin
  // CR^NAME^CLASS^PG#^VALIDATE^PROPERITES
  iPage := StrToIntDef(Piece(sValue,U,4), -1);
  if ((iPage > 0) and (iPage <= PageCount)) then
  begin
    qQuestion := AddQuestion(iPage, Piece(sValue,U,2));
    if qQuestion <> nil then
      qQuestion.CreateControl(Piece(sValue,U,2), Piece(sValue,U,3), Piece(sValue,U,5), Pieces(sValue,U,6,99));
  end;
end;

procedure TDDCSForm.BuildControl(sValue: string; slPage: TStringList);
var
  iPage: Integer;
  qQuestion: TQuestion;
begin
  // CR^NAME^CLASS^PG#^VALIDATE^PROPERITES
  iPage := slPage.IndexOf(Piece(sValue,U,4));
  if iPage = -1 then
    Exit;
  iPage := TTabSheet(slPage.Objects[iPage]).PageIndex;
  if ((iPage > -1) and (iPage < PageCount)) then
  begin
    qQuestion := AddQuestion(iPage, Piece(sValue,U,2));
    if qQuestion <> nil then
      qQuestion.CreateControl(Piece(sValue,U,2), Piece(sValue,U,3), Piece(sValue,U,5), Pieces(sValue,U,6,99));
  end;
end;

procedure TDDCSForm.BuildCollection(sValue: string);
var
  qQuestion: TQuestion;
  wControl: TWinControl;
  cComponent: TComponent;
  nItem: TDDCSNoteItem;
  sPropertyList: string;
  I,J: Integer;
  sProp: string;
  sPropValue: string;
begin
  // CC^NAME^PROPERTY|VALUE^PROPERTY|VALUE...
  qQuestion := GetQuestion(Piece(sValue,U,2));
  if qQuestion <> nil then
    wControl := qQuestion.Control;
  if wControl = nil then
  begin
    cComponent := TForm(Owner).FindComponent(Piece(sValue,U,2));
    if ((cComponent <> nil) and (cComponent is TWinControl)) then
      wControl := TWinControl(cComponent);
  end;
  if wControl = nil then
    Exit;

  nItem := FReportCollection.GetNoteItemAddifNil(wControl);
  if nItem = nil then
    Exit;

  // Set Properties
  sPropertyList := Pieces(sValue,U,3,99);
  J := SubCount(sPropertyList,U) + 1;
  for I := 1 to J do
  begin
    sProp := Piece(Piece(sPropertyList,U,I),'|',1);
    sPropValue := Piece(Piece(sPropertyList,U,I),'|',2);

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

    if sPropValue <> '' then
    begin
      if sProp = 'IDENTIFYINGNAME' then
        nItem.IdentifyingName := sPropValue
      else
      if sProp = 'ORDER' then
        nItem.Order := StrToInt(sPropValue)
      else
      if sProp = 'TITLE' then
        nItem.Title := sPropValue
      else
      if sProp = 'PREFIX' then
        nItem.Prefix := sPropValue
      else
      if sProp = 'SUFFIX' then
        nItem.Suffix := sPropValue
      else
      if sProp = 'DONOTSPACE' then
        nItem.DoNotSpace := StrToBool(sPropValue)
      else
      if sProp = 'DONOTSAVE' then
        nItem.DoNotSave := StrToBool(sPropValue)
      else
      if sProp = 'DONOTRESTORE' then
        nItem.DoNotRestoreV := StrToBool(sPropValue)
      else
      if sProp = 'HIDEFROMNOTE' then
        nItem.HideFromNote := StrToBool(sPropValue)
      else
      if sProp = 'REQUIRED' then
        nItem.Required := StrToBool(sPropValue)
      else
      if sProp = 'DIALOGRETURN' then
      begin
        cComponent := TForm(Owner).FindComponent(sPropValue);
        if cComponent is TWinControl then
          nItem.DialogReturn := TWinControl(cComponent);
      end;
    end;
  end;
end;

procedure TDDCSForm.BuildValues(sValue: string);
var
  qQuestion: TQuestion;
  sAnswer: string;
  cComponent: TComponent;
  wControl: TWinControl;
  nItem: TDDCSNoteItem;
begin
  // CV^NAME^F^(INDEXED^VALUE)
  // CV^NAME^D^IEN|NAME|CLASS
  qQuestion := GetQuestion(Piece(sValue,U,2));
  if qQuestion <> nil then
  begin
    sAnswer := Pieces(sValue,U,5,999);
    qQuestion.AddPossibleAnswer(sAnswer);
    if AnsiContainsText(Piece(sValue,U,4), 'TRUE') then
      qQuestion.AddDefaultAnswer(sAnswer);
    Exit;
  end;

  cComponent := TForm(Owner).FindComponent(Piece(sValue,U,2));
  if ((cComponent <> nil) and (cComponent is TWinControl)) then
  begin
    wControl := TWinControl(cComponent);
    nItem := FReportCollection.GetNoteItemAddifNil(wControl);

    if Piece(sValue,U,3) = 'F' then
      Fill(wControl, Piece(sValue,U,4), Pieces(sValue,U,5,999))
    else
    if Piece(sValue,U,3) = 'D' then
    begin
      nItem.Configuration.Add(Piece(sValue,U,4));
      Fill(wControl, '', Piece(Piece(sValue,U,4),'|',2));
    end;
  end;
end;

procedure TDDCSForm.ActiveControlChanged(Sender: TObject);
var
  tmp: string;
  nItem: TDDCSNoteItem;
begin
  if Owner <> nil then
  begin
    if (Assigned(VitalsPage) and (VitalsPage = ActivePage)) then
    begin
      tmp := VitalsControl.GetTextforFocus((Owner as TForm).ActiveControl);
      if ((tmp <> '') and (Assigned(ScreenReader))) then
        ScreenReader.SayString(tmp, False);
    end
    else
    begin
      nItem := FReportCollection.GetNoteItem((Owner as TForm).ActiveControl);
      if ((nItem <> nil) and (nItem.SayOnFocus <> '')) then
        if Assigned(ScreenReader) then
          ScreenReader.SayString(nItem.SayOnFocus, False);
    end;
  end;
end;

procedure TDDCSForm.NavTab(Sender: TObject);
var
  wControl: TWinControl;
  vpg: TPageControl;
  grd: TJvStringGrid;
begin
  if VitalsPage = ActivePage then
  begin
    vpg := VitalsControl.fVitalsControl;
    if ((vpg.ActivePageIndex < VitalsControl.fVitalsControl.PageCount - 1) and
        (vpg.Pages[vpg.ActivePageIndex + 1].TabVisible)) then
      vpg.SelectNextPage(True)
    else
      SelectNextPage(True);

    Exit;
  end;

  if FGridArray[ActivePageIndex] <> nil then
    grd := FGridArray[ActivePageIndex].StringGrid;

  if grd <> nil then
  begin
    if grd.Col <> grd.ColCount - 1 then
    begin
      grd.Col := grd.Col + 1;
      Exit;
    end;

    if grd.Row <> grd.RowCount - 1 then
    begin
      grd.Col := 0;
      grd.Row := grd.Row + 1;
      Exit;
    end;
  end;

  wControl := (Owner as TForm).ActiveControl;

  if ((wControl <> nil) and (wControl.InheritsFrom(TPageControl)) and
      (not (wControl is TDDCSForm))) then
    (wControl as TPageControl).SelectNextPage(True)
  else
  begin
    // If on the last page go to the bottom menu bar
    if ActivePageIndex = (PageCount - 1) then
    begin
      if FControlPanel.Focused then
        SelectNextPage(True)
      else
        FControlPanel.SetFocus;
      Exit;
    end;

    SelectNextPage(True);
  end;

  if grd <> nil then
    PostMessage(FGridArray[ActivePageIndex].Handle, WM_CELLSELECT, 0, 0);
end;

procedure TDDCSForm.NavCtrlTab(Sender: TObject);
var
  wControl: TWinControl;
begin
  wControl := (Owner as TForm).ActiveControl;
  if ((wControl <> nil) and (wControl.InheritsFrom(TPageControl)) and
      (not (wControl is TDDCSForm))) then
    (wControl as TPageControl).SelectNextPage(True)
  else
    SelectNextPage(True);
end;

procedure TDDCSForm.NavShiftTab(Sender: TObject);
var
  wControl: TWinControl;
  vpg: TPageControl;
  grd: TJvStringGrid;
begin
  if VitalsPage = ActivePage then
  begin
    vpg := VitalsControl.fVitalsControl;
    if ((vpg.ActivePageIndex > 0) and
        (vpg.Pages[vpg.ActivePageIndex - 1].TabVisible)) then
      vpg.SelectNextPage(False)
    else
      SelectNextPage(False);

    Exit;
  end;

  if FGridArray[ActivePageIndex] <> nil then
    grd := FGridArray[ActivePageIndex].StringGrid;

  if grd <> nil then
  begin
    if grd.Col > 0 then
    begin
      grd.Col := grd.Col - 1;
      Exit;
    end;

    if grd.Row > 1 then
    begin
      grd.Col := grd.ColCount - 1;
      grd.Row := grd.Row - 1;
      Exit;
    end;
  end;

  wControl := TForm(Owner).ActiveControl;

  if ((wControl <> nil) and (wControl.InheritsFrom(TPageControl)) and
      (not (wControl is TDDCSForm))) then
    TPageControl(wControl).SelectNextPage(False)
  else
  begin
    // If on the first page go to the bottom menu bar
    if ActivePageIndex = 0 then
    begin
      if FControlPanel.Focused then
        SelectNextPage(False)
      else
        FControlPanel.SetFocus;
      Exit;
    end;

    SelectNextPage(False);
  end;

  if grd <> nil then
    PostMessage(FGridArray[ActivePageIndex].Handle, WM_CELLSELECT, 0, 0);
end;

procedure TDDCSForm.NavCtrlShiftTab(Sender: TObject);
var
  wControl: TWinControl;
begin
  wControl := TForm(Owner).ActiveControl;
  if ((wControl <> nil) and (wControl.InheritsFrom(TPageControl)) and
      (not (wControl is TDDCSForm))) then
    TPageControl(wControl).SelectNextPage(False)
  else
    SelectNextPage(False);
end;

procedure TDDCSForm.SetGrid(Index: Integer; Value: TDDCSQuestionGrid);
begin
  FGridArray[Index] := Value;
end;

function TDDCSForm.GetGrid(Index: Integer): TDDCSQuestionGrid;
begin
  Result := FGridArray[Index];
end;

function TDDCSForm.GetVitalsForm: TDDCSVitalsForm;
var
  I: Integer;
begin
  Result := nil;

  if FVitalsPage <> nil then
    for I := 0 to FVitalsPage.ControlCount - 1 do
      if FVitalsPage.Controls[I] is TDDCSVitalsForm then
      begin
        Result := TDDCSVitalsForm(FVitalsPage.Controls[I]);
        Break;
      end;
end;

procedure TDDCSForm.LoadDialogs;
var
  tmp: string;
  sPathToDLLs: string;
  I: Integer;
  wStr: WideString;

  procedure ReportDLLnotFound;
  var
    sMsg,sReturn: string;
  begin
    sMsg := 'Once the DDCSDialogs.dll is in place you can attempt to reload it via the "Load Dialogs" ' +
            'option accessed from the commend menu.';

    if (RPCBrokerV = nil) or (DDCSObjects = nil) then
      Exit;

    UpdateContext(MENU_CONTEXT);
    sReturn := sCallV('DSIO DDCS CONFIGURATION', [DDCSObjects.DDCSInterface, 'DIALOGS REQUIRED']);
    if sReturn = '1' then
      ShowMsg('This interface requires the DDCSDialogs.dll to be present but was not found.' + #13#10 + sMsg)
    else
      ShowMsg(sMsg);
  end;

begin
  if (RPCBrokerV = nil) or (DDCSObjects = nil) then
    Exit;

  UpdateContext(MENU_CONTEXT);
  tmp := sCallV('DSIO DDCS CONFIGURATION', [DDCSObjects.DDCSInterface, 'DIALOGS DISABLED']);
  if tmp <> '' then
    FDialogsDisabled := StrToBool(tmp);

  if FDialogsDisabled then
  begin
    FControlPanel.FCommandMenu.Items[2].Enabled := False;
    Exit;
  end;

  FDLLDialogList.Clear;

  if FDialogDLL <> 0 then
    FreeLibrary(FDialogDLL);

  sPathToDLLs := ExtractFilePath(GetModuleName(HInstance));

  if FileExists(sPathToDLLs + 'DDCSDialogs.dll') then
    sPathToDLLs := sPathToDLLs + 'DDCSDialogs.dll'
  else
  if DirectoryExists(sPathToDLLs + 'Extensions\') then
  begin
    if FileExists(sPathToDLLs + 'Extensions\DDCSDialogs.dll') then
      sPathToDLLs := sPathToDLLs + 'Extensions\DDCSDialogs.dll'
    else
      sPathToDLLs := '';
  end
  else
  begin
    sPathToDLLs := ExtractFileDir(GetModuleName(HInstance));

    for I := Length(sPathToDLLs) downto 1 do
    begin
      if ((sPathToDLLs[I] = ':') or (sPathToDLLs[I] = '\')) then
        Break
      else
        Delete(sPathToDLLs, I, Length(sPathToDLLs));
    end;

    if FileExists(sPathToDLLs + 'Extensions\DDCSDialogs.dll') then
      sPathToDLLs := sPathToDLLs + 'Extensions\DDCSDialogs.dll'
    else
      sPathToDLLs := '';
  end;

  if sPathToDLLs = '' then
  begin
    ReportDLLnotFound;
    Exit;
  end;

  try
    FDialogDLL := SafeLoadLibrary(sPathToDLLs);
    if FDialogDLL <> 0 then
    begin
      FRegisterDialogs := GetProcAddress(FDialogDLL, 'RegisterDialogs');
      GetDialogComponents := GetProcAddress(FDialogDLL, 'GetDialogComponents');
      DisplayDialog := GetProcAddress(FDialogDLL, 'DisplayDialog');

      FRegisterDialogs(wStr);
      FDLLDialogList.Text := wStr;
    end
    else
      ReportDLLnotFound;
  except
    on E: Exception do
    ShowMsg(E.Message, smiError, smbOK);
  end;
end;

function TDDCSForm.AddPage: TTabSheet;
begin
  Result := TTabSheet.Create(Self);
  Result.Parent := Self;
  Result.PageControl := Self;
  Result.Show;

  SetLength(FGridArray, PageCount);
end;

{$ENDREGION}

initialization
//  TStyleManager.Engine.RegisterStyleHook(TDDCSForm, TTabControlStyleHookCheck);
//  TStyleManager.Engine.RegisterStyleHook(TTabControl, TTabControlStyleHookCheck);

end.
