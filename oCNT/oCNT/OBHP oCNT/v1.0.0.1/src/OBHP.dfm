object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'OB H&P Initial'
  ClientHeight = 463
  ClientWidth = 612
  Color = clBtnFace
  Constraints.MinHeight = 490
  Constraints.MinWidth = 620
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object ofrm1: ToForm
    Left = 0
    Top = 0
    Width = 612
    Height = 463
    Cursor = 5
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    DisableSplash = False
    ReportCollection = <
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = RadioGroup3
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ListBoxComplaints
        Required = False
        DialogReturn = MemoComplaints
      end
      item
        Title = 'ADDITIONAL COMPLAINTS/HISTORY OF PRESENT ILLNESS'
        HideFromNote = False
        DoNotSave = False
        OwningObject = MemoComplaints
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = RadioGroupImport
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ButtonReload
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = RadioGroupHistory
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ListBoxMedicalHist
        Required = False
        DialogReturn = MemoHistory
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ListBoxFamilyHist
        Required = False
        DialogReturn = MemoHistory
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ListBoxSocialHist
        Required = False
        DialogReturn = MemoHistory
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = MemoHistory
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = ButtonHistoryClear
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = ButtonROS
        Required = False
        DialogReturn = MemoROS
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = MemoROS
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = ButtonROSClear
        Required = False
        DialogReturn = MemoROS
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = ButtonPhysical
        Required = False
        DialogReturn = MemoPhysical
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = MemoPhysical
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = ButtonPhysicalClear
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ButtonOBExam
        Required = False
        DialogReturn = MemoOBExam
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = MemoOBExam
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = ButtonOBClear
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ButtonEDDCal
        Required = False
        DialogReturn = MemoPreNatal
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ButtonPreNatalNormal
        Required = False
        DialogReturn = MemoPreNatal
      end
      item
        Title = 'PRE NATAL PLAN'
        HideFromNote = False
        DoNotSave = False
        OwningObject = MemoPreNatal
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = ButtonPlanClear
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = Panel1
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = GroupBox3
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = Panel2
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = SpinEdit1
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = SpinEdit2
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = SpinEdit3
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = SpinEdit4
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = SpinEdit5
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = SpinEdit6
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = Edit17
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = Edit18
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = Edit19
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = SpinEdit7
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = SpinEdit8
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = False
        OwningObject = LabeledEdit1
        Required = False
      end
      item
        HideFromNote = True
        DoNotSave = True
        OwningObject = ButtonLMPDate
        Required = False
      end
      item
        HideFromNote = False
        DoNotSave = False
        OwningObject = Panel3
        Required = False
      end>
    object Page1: ToPage
      Left = 0
      Top = 0
      Caption = 'HPI'
      object Label1: TLabel
        Left = 16
        Top = 274
        Width = 81
        Height = 16
        Caption = 'VITAL SIGNS'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 23
        Top = 318
        Width = 30
        Height = 13
        Caption = 'Temp:'
      end
      object Label10: TLabel
        Left = 191
        Top = 318
        Width = 29
        Height = 13
        Caption = 'Pulse:'
      end
      object Label11: TLabel
        Left = 192
        Top = 346
        Width = 28
        Height = 13
        Caption = 'Resp:'
      end
      object Label12: TLabel
        Left = 196
        Top = 374
        Width = 24
        Height = 13
        Caption = 'Pain:'
      end
      object Label13: TLabel
        Left = 19
        Top = 346
        Width = 34
        Height = 13
        Caption = 'Height:'
      end
      object Label14: TLabel
        Left = 16
        Top = 374
        Width = 37
        Height = 13
        Caption = 'Weight:'
      end
      object Label15: TLabel
        Left = 315
        Top = 318
        Width = 39
        Height = 13
        Caption = 'Systolic:'
      end
      object Label16: TLabel
        Left = 311
        Top = 346
        Width = 43
        Height = 13
        Caption = 'Diastolic:'
      end
      object Label17: TLabel
        Left = 459
        Top = 318
        Width = 22
        Height = 13
        Caption = 'BMI:'
      end
      object Label18: TLabel
        Left = 456
        Top = 293
        Width = 25
        Height = 13
        Caption = 'AGE:'
      end
      object Label19: TLabel
        Left = 455
        Top = 346
        Width = 26
        Height = 13
        Caption = 'EDD:'
      end
      object ButtonLMPDate: TSpeedButton
        Tag = 2
        Left = 487
        Top = 370
        Width = 24
        Height = 24
        Hint = 'Pick Date From Calendar'
        Flat = True
        Glyph.Data = {
          76010000424D7601000000000000760000002800000020000000100000000100
          04000000000000010000120B0000120B00001000000000000000000000000000
          800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
          FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
          33333FFFFFFFFFFFFFFF000000000000000077777777777777770FF7FF7FF7FF
          7FF07FF7FF7FF7F37F3709F79F79F7FF7FF077F77F77F7FF7FF7077777777777
          777077777777777777770FF7FF7FF7FF7FF07FF7FF7FF7FF7FF709F79F79F79F
          79F077F77F77F77F77F7077777777777777077777777777777770FF7FF7FF7FF
          7FF07FF7FF7FF7FF7FF709F79F79F79F79F077F77F77F77F77F7077777777777
          777077777777777777770FFFFF7FF7FF7FF07F33337FF7FF7FF70FFFFF79F79F
          79F07FFFFF77F77F77F700000000000000007777777777777777CCCCCC8888CC
          CCCC777777FFFF777777CCCCCCCCCCCCCCCC7777777777777777}
        NumGlyphs = 2
        ParentShowHint = False
        ShowHint = True
        Visible = False
      end
      object Panel1: TPanel
        Left = 0
        Top = 0
        Width = 612
        Height = 9
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 12
      end
      object GroupBox3: TGroupBox
        Left = 0
        Top = 65
        Width = 612
        Height = 192
        Align = alTop
        Caption = 'ADDITIONAL COMPLAINTS/HISTORY OF PRESENT ILLNESS'
        TabOrder = 13
        object MemoComplaints: TMemo
          Left = 10
          Top = 21
          Width = 381
          Height = 160
          Align = alCustom
          Anchors = [akLeft, akTop, akRight, akBottom]
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
        end
        object ListBoxComplaints: TListBox
          Left = 399
          Top = 21
          Width = 204
          Height = 124
          Align = alCustom
          Anchors = [akTop, akRight, akBottom]
          ItemHeight = 13
          TabOrder = 1
        end
        object ButtonComplaintClear: TButton
          Tag = 1
          Left = 399
          Top = 149
          Width = 204
          Height = 32
          Align = alCustom
          Anchors = [akRight, akBottom]
          Caption = 'Clear Text'
          TabOrder = 2
          OnClick = ClearTextClick
        end
      end
      object Panel2: TPanel
        Left = 0
        Top = 9
        Width = 612
        Height = 56
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 14
        object GroupBox2: TGroupBox
          Left = 356
          Top = 0
          Width = 256
          Height = 56
          Align = alRight
          Caption = 'CHIEF COMPLAINT/REASON FOR VISIT'
          TabOrder = 0
          object Label8: TLabel
            Left = 92
            Top = 27
            Width = 66
            Height = 13
            Align = alCustom
            Caption = 'Pre Natal Visit'
          end
        end
        object RadioGroup3: TRadioGroup
          Left = 0
          Top = 0
          Width = 352
          Height = 56
          Align = alCustom
          Anchors = [akLeft, akTop, akRight, akBottom]
          Caption = 'TYPE OF SERVICE'
          Columns = 3
          Items.Strings = (
            'Established Patient'
            'New Patient'
            'Consult')
          TabOrder = 1
        end
      end
      object SpinEdit1: TSpinEdit
        Left = 59
        Top = 315
        Width = 62
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object SpinEdit2: TSpinEdit
        Left = 59
        Top = 343
        Width = 62
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
      end
      object SpinEdit3: TSpinEdit
        Left = 59
        Top = 371
        Width = 62
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 4
        Value = 0
      end
      object SpinEdit4: TSpinEdit
        Left = 226
        Top = 315
        Width = 62
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 6
        Value = 0
      end
      object SpinEdit5: TSpinEdit
        Left = 226
        Top = 343
        Width = 62
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 7
        Value = 0
      end
      object SpinEdit6: TSpinEdit
        Left = 226
        Top = 371
        Width = 62
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 8
        Value = 0
      end
      object Edit17: TEdit
        Tag = 1
        Left = 127
        Top = 315
        Width = 36
        Height = 21
        TabOrder = 1
      end
      object Edit18: TEdit
        Left = 127
        Top = 343
        Width = 36
        Height = 21
        TabOrder = 3
      end
      object Edit19: TEdit
        Left = 127
        Top = 371
        Width = 36
        Height = 21
        TabOrder = 5
      end
      object SpinEdit7: TSpinEdit
        Left = 360
        Top = 315
        Width = 62
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 9
        Value = 0
      end
      object SpinEdit8: TSpinEdit
        Left = 360
        Top = 343
        Width = 62
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 10
        Value = 0
      end
      object LabeledEdit1: TLabeledEdit
        Left = 360
        Top = 371
        Width = 121
        Height = 21
        EditLabel.Width = 25
        EditLabel.Height = 13
        EditLabel.Caption = 'LMP:'
        LabelPosition = lpLeft
        TabOrder = 11
      end
    end
    object Page2: ToPage
      Left = 0
      Top = 0
      Caption = 'Imports'
      object RadioGroupImport: TRadioGroup
        Left = 23
        Top = 22
        Width = 360
        Height = 57
        Align = alCustom
        Anchors = [akLeft, akTop, akRight]
        Caption = 'IMPORTED MEDICAL DATA'
        Columns = 3
        Items.Strings = (
          'Allergies'
          'Active Problems'
          'Active Medications')
        TabOrder = 1
        OnClick = RadioGroupImportClick
      end
      object ButtonReload: TButton
        Left = 409
        Top = 40
        Width = 179
        Height = 25
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Reload Imported Information'
        TabOrder = 0
        OnClick = ButtonReloadClick
      end
      object Panel3: TPanel
        Left = 0
        Top = 104
        Width = 612
        Height = 312
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        TabOrder = 2
        OnResize = Panel3Resize
        object MemoActiveMedications: TMemo
          Left = 0
          Top = 2
          Width = 612
          Height = 310
          Align = alCustom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 1
        end
        object MemoActiveProblems: TMemo
          Left = 0
          Top = 2
          Width = 612
          Height = 310
          Align = alCustom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 2
        end
        object MemoAllergies: TMemo
          Left = 0
          Top = 2
          Width = 612
          Height = 310
          Align = alBottom
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Courier New'
          Font.Style = []
          ParentFont = False
          ScrollBars = ssBoth
          TabOrder = 0
        end
      end
    end
    object Page3: ToPage
      Left = 0
      Top = 0
      Caption = 'History'
      object RadioGroupHistory: TRadioGroup
        Left = 20
        Top = 20
        Width = 246
        Height = 57
        Align = alCustom
        Anchors = [akLeft, akTop, akRight]
        Caption = 'HISTORIES'
        Columns = 3
        Items.Strings = (
          'Medical'
          'Family'
          'Social')
        TabOrder = 0
        OnClick = RadioGroupHistoryClick
      end
      object MemoHistory: TMemo
        Left = 0
        Top = 160
        Width = 612
        Height = 256
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 3
      end
      object ListBoxMedicalHist: TListBox
        Left = 287
        Top = 20
        Width = 306
        Height = 122
        Align = alCustom
        Anchors = [akTop, akRight]
        ItemHeight = 13
        TabOrder = 4
      end
      object ButtonHistoryClear: TButton
        Tag = 2
        Left = 20
        Top = 104
        Width = 75
        Height = 25
        Caption = 'Clear Text'
        TabOrder = 2
        OnClick = ClearTextClick
      end
      object ListBoxFamilyHist: TListBox
        Left = 287
        Top = 20
        Width = 306
        Height = 122
        Align = alCustom
        Anchors = [akTop, akRight]
        ItemHeight = 13
        TabOrder = 5
      end
      object ListBoxSocialHist: TListBox
        Left = 287
        Top = 20
        Width = 306
        Height = 122
        Align = alCustom
        Anchors = [akTop, akRight]
        ItemHeight = 13
        TabOrder = 1
      end
    end
    object Page4: ToPage
      Left = 0
      Top = 0
      Caption = 'ROS'
      object Label3: TLabel
        Left = 16
        Top = 27
        Width = 185
        Height = 16
        Caption = 'ROS: SYMPTOMS SINCE LMP'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MemoROS: TMemo
        Left = 0
        Top = 71
        Width = 612
        Height = 345
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object ButtonROS: TButton
        Left = 311
        Top = 24
        Width = 75
        Height = 25
        Caption = 'ROS'
        TabOrder = 1
      end
      object ButtonROSClear: TButton
        Tag = 3
        Left = 513
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Clear Text'
        TabOrder = 2
        OnClick = ClearTextClick
      end
    end
    object Page5: ToPage
      Left = 0
      Top = 0
      Caption = 'Phys Exam'
      object Label4: TLabel
        Left = 16
        Top = 27
        Width = 105
        Height = 16
        Caption = 'PHYSICAL EXAM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MemoPhysical: TMemo
        Left = 0
        Top = 71
        Width = 612
        Height = 345
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 0
      end
      object ButtonPhysical: TButton
        Left = 311
        Top = 24
        Width = 92
        Height = 25
        Caption = 'Physical Exam'
        TabOrder = 1
      end
      object ButtonPhysicalClear: TButton
        Tag = 4
        Left = 513
        Top = 24
        Width = 75
        Height = 25
        Caption = 'Clear Text'
        TabOrder = 2
        OnClick = ClearTextClick
      end
    end
    object Page6: ToPage
      Left = 0
      Top = 0
      Caption = 'OB Exam'
      object Label7: TLabel
        Left = 27
        Top = 27
        Width = 106
        Height = 16
        Caption = 'OB INITIAL EXAM'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object MemoOBExam: TMemo
        Left = 0
        Top = 71
        Width = 612
        Height = 345
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 2
      end
      object ButtonOBExam: TButton
        Left = 191
        Top = 24
        Width = 75
        Height = 25
        Caption = 'OB Exam'
        TabOrder = 0
      end
      object ButtonOBClear: TButton
        Tag = 5
        Left = 513
        Top = 24
        Width = 75
        Height = 25
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Clear Text'
        TabOrder = 1
        OnClick = ClearTextClick
      end
    end
    object Page7: ToPage
      Left = 0
      Top = 0
      Caption = 'Plan'
      object Label5: TLabel
        Left = 24
        Top = 23
        Width = 220
        Height = 16
        Caption = 'DX1: INTRAUTERINE PREGNANCY'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label6: TLabel
        Left = 24
        Top = 70
        Width = 113
        Height = 16
        Caption = 'PRE NATAL PLAN'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -15
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object ButtonEDDCal: TButton
        Left = 296
        Top = 20
        Width = 123
        Height = 25
        Caption = 'EDD Calculator'
        TabOrder = 0
      end
      object MemoPreNatal: TMemo
        Left = 0
        Top = 120
        Width = 612
        Height = 296
        Align = alBottom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssBoth
        TabOrder = 3
      end
      object ButtonPreNatalNormal: TButton
        Left = 296
        Top = 67
        Width = 123
        Height = 25
        Caption = 'Normal'
        TabOrder = 1
      end
      object ButtonPlanClear: TButton
        Tag = 6
        Left = 518
        Top = 67
        Width = 75
        Height = 25
        Caption = 'Clear Text'
        TabOrder = 2
        OnClick = ClearTextClick
      end
    end
  end
end
