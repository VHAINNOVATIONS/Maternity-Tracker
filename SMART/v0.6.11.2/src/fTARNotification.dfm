object frmTARNotification: TfrmTARNotification
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'System for Mammogram Results Tracking (SMART), Provider-specific'
  ClientHeight = 313
  ClientWidth = 666
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object ListBox1: TListBox
    Left = 8
    Top = 24
    Width = 233
    Height = 65
    Columns = 1
    ItemHeight = 13
    Items.Strings = (
      'BHYHGDST,KRUDLA IHWHYILYS'
      'CPRSPATIENT,EIGHT F'
      'DSSPTFPATIENT,THREE'
      'ZNALB,HIPLUI')
    TabOrder = 7
    Visible = False
    OnDblClick = ListBox1DblClick
  end
  object lstATRAlerts: TCaptionListView
    Left = 8
    Top = 24
    Width = 649
    Height = 251
    Columns = <
      item
        Caption = 'Patient'
        Width = 150
      end
      item
        Caption = 'Status'
        Width = 100
      end
      item
        Caption = 'Criticality'
        Width = 75
      end
      item
        Caption = 'Tracked Abnormal Type'
        Width = 150
      end
      item
        Caption = 'Last Followup'
        Width = 100
      end
      item
        Caption = 'Source'
        Width = 80
      end
      item
        Caption = 'ATR_ien'
        Width = 60
      end
      item
        Caption = 'Proc Level'
        Width = 70
      end
      item
        Caption = 'TIU_ien'
      end>
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    ParentShowHint = False
    ShowWorkAreas = True
    ShowHint = True
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
    OnColumnClick = lstATRAlertsColumnClick
    OnCompare = lstATRAlertsCompare
    OnDblClick = lstATRAlertsDblClick
    OnMouseDown = lstATRAlertsMouseDown
    Caption = 'tctcap'
  end
  object buOK: TButton
    Left = 494
    Top = 283
    Width = 75
    Height = 25
    Caption = 'OK'
    ModalResult = 1
    TabOrder = 5
    OnClick = buOkClick
  end
  object buCancel: TButton
    Left = 583
    Top = 283
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 6
    OnClick = buCancelClick
  end
  object buSetNextTARNotificationDateTime: TButton
    Left = 247
    Top = 177
    Width = 195
    Height = 25
    Caption = 'Set Next SMART Notification Date/Time'
    TabOrder = 8
    Visible = False
    OnClick = buSetNextTARNotificationDateTimeClick
  end
  object meRemindMeLater: TMaskEdit
    Left = 115
    Top = 283
    Width = 40
    Height = 24
    EditMask = '!90:00;1;_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxLength = 5
    ParentFont = False
    TabOrder = 3
    Text = '  :  '
  end
  object cbRemindMeLater: TCheckBox
    Left = 8
    Top = 287
    Width = 107
    Height = 17
    Caption = 'Remind Me After:'
    TabOrder = 2
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 8
    Width = 181
    Height = 17
    Caption = 'Tracked Abnormal Test Results'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    TabStop = True
  end
  object StaticText2: TStaticText
    Left = 163
    Top = 289
    Width = 101
    Height = 17
    Caption = '(24hr time, HR:MIN)'
    TabOrder = 4
    TabStop = True
  end
  object dlgNextATRPopup: TORDateTimeDlg
    FMDateTime = 3120720.000000000000000000
    DateOnly = False
    RequireTime = True
    Left = 296
    Top = 144
  end
end
