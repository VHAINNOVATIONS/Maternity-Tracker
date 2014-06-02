object frmTARProcess: TfrmTARProcess
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = ' System for Mammogram Results Tracking (SMART), Patient-specific'
  ClientHeight = 327
  ClientWidth = 662
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
  object buProcessATR: TButton
    Left = 442
    Top = 296
    Width = 100
    Height = 25
    Caption = 'Process SMART'
    Enabled = False
    ModalResult = 1
    TabOrder = 2
    OnClick = buProcessATRClick
  end
  object buDeferProcessing: TButton
    Left = 554
    Top = 296
    Width = 100
    Height = 25
    Caption = 'Defer Processing'
    ModalResult = 7
    TabOrder = 3
    OnClick = buDeferProcessingClick
  end
  object StaticText1: TStaticText
    Left = 8
    Top = 8
    Width = 153
    Height = 41
    AutoSize = False
    Caption = 'Patient'
    Color = clGray
    ParentColor = False
    TabOrder = 4
    Visible = False
  end
  object lstATRAlerts: TCaptionListView
    Left = 8
    Top = 134
    Width = 646
    Height = 154
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
        Caption = 'TIU_IEN'
        Width = 60
      end>
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    MultiSelect = True
    ReadOnly = True
    RowSelect = True
    ParentFont = False
    ParentShowHint = False
    ShowWorkAreas = True
    ShowHint = True
    SortType = stText
    TabOrder = 1
    ViewStyle = vsReport
    OnClick = lstATRAlertsClick
    OnColumnClick = lstATRAlertsColumnClick
    OnCompare = lstATRAlertsCompare
    OnDblClick = lstATRAlertsDblClick
    OnMouseDown = lstATRAlertsMouseDown
    Caption = 'tctcap'
  end
  object Memo1: TMemo
    Left = 8
    Top = 5
    Width = 644
    Height = 123
    Color = clCream
    Lines.Strings = (
      'Click an Alert to see details here . . .')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 0
  end
end
