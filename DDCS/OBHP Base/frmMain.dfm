object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'OB History Consult'
  ClientHeight = 523
  ClientWidth = 742
  Color = clBtnFace
  Constraints.MinHeight = 550
  Constraints.MinWidth = 750
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000000000000B7B7B7B7B7B7B7B7B7B7B00000
    00000070000B000070000B00007000000000000FFBF0FBFF0BFFF0FFFB000000
    000000FFFFFFFFFFFFFFFFFFFFF00000000000FFFFFFFFFFFFFFFFFFFFF00000
    000000FF88888888888888888FF00000000000FFFBFFFBFFFBFFFBFFFBF00000
    000000FFFFFFFFFFFFFFFFFFFFF000000000007788888888888888888FF00000
    0000000000000000007FFFFFFFF000FBFBFBFBFBFBFBFBFBFB07FBFFFBF000BF
    BFBFBFBFBFBFBFBFBFB07FFFFFF000FBFBFBFBFBFBFBFBFBFBF088888FF0000F
    BFBFBFBFBFBFBFBFBFBF07FFFFF0000BFBFBFBFBFBFBFBFBFBFB07FFFBF00000
    BFBFBFBFBFBFBFBFBFBFB07FFFF00000FBFBFBFBFBFBFBFBFBFBF0888FF00000
    0FBFBFBFBFBFBFBFBFBFBF07FFF000000BFBFBFBFBFBFBFBFBFBFB07FBF00000
    00BFBF0000000000000FBFB07FF0000000FBFB0FFFFFFFFFFF0BFBF08FF00000
    000FBFB0F0F0F0F0FFF0BFBF07F00000000BFBF0FF0F0F0F0FF0FBFB07F00000
    0000BFBF0FFFFFFFFFFF0FBFB07000000000FBFB0000000000000BFBF0700000
    00000FBFBFBFBFBFBFBFBFBFBF00000000000BFBFBFBFBFBFBFBFBFBFB000000
    000000BF8FBF8FBF8FBF8FBF8FB0000000000000800080008000800080000000
    000000008080808080808080808000000000000008000800080008000800FFC0
    0001FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF80
    0000FF800000C0000000800000008000000080000000C0000000C0000000E000
    0000E0000000F0000000F0000000F8000000F8000000FC000000FC000000FE00
    0000FE000000FF000000FF000000FF800000FF800000FFF55555FFFBBBBB}
  OldCreateOrder = True
  Position = poOwnerFormCenter
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DDCSForm1: TDDCSForm
    Left = 0
    Top = 0
    Width = 742
    Height = 523
    Cursor = 5
    ActivePage = oPage1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    OwnerDraw = True
    ParentFont = False
    Style = tsButtons
    TabHeight = 25
    TabOrder = 0
    TabStop = False
    VitalsPage = oPage2
    ReportCollection = <
      item
        Order = 0
        IdentifyingName = 'Summary'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = lbSummary
        Required = False
      end
      item
        Order = 1
        IdentifyingName = 'Type of Service'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = True
        OwningObject = RadioGroup3
        Required = True
      end
      item
        Order = 2
        IdentifyingName = 'Chief Complaint'
        Title = 'CHIEF COMPLAINT'
        Prefix = '  '
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = memChief
        Required = True
      end
      item
        Order = 3
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = DDCSVitals
        Required = False
      end
      item
        SayOnFocus = 
          'Additional Complaints and or History of Present Illness check li' +
          'st box press space to check item or return to activate dialog'
        Order = 4
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = True
        OwningObject = ListBoxComplaints
        Required = False
        DialogReturn = MemoComplaints
      end
      item
        Order = 5
        IdentifyingName = 
          'Additional Complints and or History of Present Illness Section N' +
          'ote Text'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = MemoComplaints
        Required = False
      end
      item
        Order = 6
        IdentifyingName = 'Imported Medical Data'
        DoNotSpace = False
        DoNotSave = True
        DoNotRestoreV = True
        HideFromNote = True
        OwningObject = RadioGroupImport
        Required = False
      end
      item
        Order = 7
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = memoMedications
        Required = False
      end
      item
        Order = 8
        Title = 'ACTIVE MEDICATIONS COMMENTS'
        Prefix = '  '
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = memoMedicationsNar
        Required = False
      end
      item
        Order = 9
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = memoProblems
        Required = False
      end
      item
        Order = 10
        Title = 'ACTIVE PROBLEMS COMMENTS'
        Prefix = '  '
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = memoProblemsNar
        Required = False
      end
      item
        Order = 11
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = memoAllergies
        Required = False
      end
      item
        Order = 12
        Title = 'ALLERGIES COMMENTS'
        Prefix = '  '
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = memoAllergiesNar
        Required = False
      end
      item
        Order = 13
        IdentifyingName = 'This patient does NOT have an allergy to Latex.'
        Prefix = '*'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = ckAllergyLatex
        Required = False
      end
      item
        Order = 14
        IdentifyingName = 'History Categories'
        DoNotSpace = False
        DoNotSave = True
        DoNotRestoreV = False
        HideFromNote = True
        OwningObject = RadioGroupHistory
        Required = False
      end
      item
        SayOnFocus = 
          'Medical History check list box press space to check item or retu' +
          'rn to activate dialog'
        Order = 15
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = True
        OwningObject = ListBoxMedicalHist
        Required = False
        DialogReturn = MemoHistory
      end
      item
        SayOnFocus = 
          'Family History check list box press space to check item or retur' +
          'n to activate dialog'
        Order = 16
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = True
        OwningObject = ListBoxFamilyHist
        Required = False
        DialogReturn = MemoHistory
      end
      item
        SayOnFocus = 
          'Social History check list box press space to check item or retur' +
          'n to activate dialog'
        Order = 17
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = True
        OwningObject = ListBoxSocialHist
        Required = False
        DialogReturn = MemoHistory
      end
      item
        Order = 18
        IdentifyingName = 'History Section Note Text'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = MemoHistory
        Required = False
      end
      item
        Order = 19
        IdentifyingName = 'Review of Symptoms since Last Menstrual Period'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ButtonROS
        Required = False
        DialogReturn = MemoROS
      end
      item
        Order = 20
        IdentifyingName = 'Review of Symptoms since Last Menstrual Period Section Note Text'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = MemoROS
        Required = False
      end
      item
        Order = 21
        IdentifyingName = 'A blood transfusion is acceptable'
        Prefix = '*'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = ckBloodTransfusion
        Required = False
      end
      item
        Order = 22
        IdentifyingName = 'Physical Exam'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ButtonPhysical
        Required = False
        DialogReturn = MemoPhysical
      end
      item
        Order = 23
        IdentifyingName = 'Physical Exam Section Note Text'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = MemoPhysical
        Required = False
      end
      item
        Order = 24
        IdentifyingName = 'Pelvic Exam'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ButtonOBExam
        Required = False
        DialogReturn = MemoOBExam
      end
      item
        Order = 25
        IdentifyingName = 'Obstetrics and Gynecology Flow Sheet'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ButtonOBFlow
        Required = False
        DialogReturn = MemoOBExam
      end
      item
        Order = 26
        IdentifyingName = 'Pelvic Exam Section Note Text'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = MemoOBExam
        Required = False
      end
      item
        SayOnFocus = 'Problems check list box press space to check item'
        Order = 27
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = True
        OwningObject = cklstProblems
        Required = False
      end
      item
        Order = 28
        IdentifyingName = 'Patient Education'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = btnEducation
        Required = False
        DialogReturn = MemoPreNatal
      end
      item
        Order = 29
        IdentifyingName = 'Return to Clinic Date'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = ButtonPreNatalNormal
        Required = False
        DialogReturn = MemoPreNatal
      end
      item
        Order = 30
        IdentifyingName = 'Plan Section Note Text'
        Title = 'ASSESSMENT AND PLAN'
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = MemoPreNatal
        Required = False
      end
      item
        Order = 31
        IdentifyingName = 'Anesthesia is planned with delivery'
        Prefix = '*'
        Suffix = ' Yes'
        DoNotSpace = True
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = ckPlannedAnesthesia
        Required = False
      end
      item
        Order = 32
        IdentifyingName = 'General'
        Prefix = '  Type of Anesthesia: '
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = ckACGeneral
        Required = False
      end
      item
        Order = 33
        IdentifyingName = 'Epidural'
        Prefix = '  Type of Anesthesia: '
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = ckACEpidural
        Required = False
      end
      item
        Order = 34
        IdentifyingName = 'Spinal'
        Prefix = '  Type of Anesthesia: '
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = ckACSpinal
        Required = False
      end
      item
        Order = 35
        IdentifyingName = 'Other'
        Prefix = '  Type of Anesthesia: '
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = True
        HideFromNote = False
        OwningObject = ckACOther
        Required = False
      end>
    object oPage1: TTabSheet
      Caption = 'Overview'
      object lbChiefComplaint: TLabel
        Left = 19
        Top = 158
        Width = 89
        Height = 13
        Caption = 'Chief Complaint'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RadioGroup3: TRadioGroup
        Left = 551
        Top = 25
        Width = 169
        Height = 101
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Type of Service'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Items.Strings = (
          'Established Patient'
          'New Patient'
          'Consult')
        ParentFont = False
        TabOrder = 1
        TabStop = True
      end
      object memChief: TCaptionMemo
        Left = 19
        Top = 175
        Width = 701
        Height = 266
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssVertical
        TabOrder = 2
        Caption = 'Chief Complaint'
      end
      object lbSummary: TStaticText
        Left = 19
        Top = 30
        Width = 508
        Height = 96
        Align = alCustom
        Anchors = [akLeft, akTop, akRight]
        AutoSize = False
        BevelKind = bkFlat
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabStop = True
      end
    end
    object oPage2: TTabSheet
      Caption = 'Vitals'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DDCSVitals: TDDCSVitals
        Left = 0
        Top = 0
        Width = 734
        Height = 458
        Align = alClient
        DoubleBuffered = True
        ParentDoubleBuffered = False
        TabOrder = 0
      end
    end
    object oPage3: TTabSheet
      Caption = 'History of Present Illness'
      object lbAdditionalComplaints: TLabel
        Left = 19
        Top = 30
        Width = 307
        Height = 13
        Caption = 'Additional Complaints and or History of Present Illness'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbComplaintsSection: TLabel
        Left = 20
        Top = 199
        Width = 104
        Height = 13
        Caption = 'Section Note Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ListBoxComplaints: TCheckListBox
        Left = 19
        Top = 47
        Width = 701
        Height = 114
        Align = alCustom
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 0
      end
      object ButtonComplaintClear: TButton
        Tag = 1
        Left = 648
        Top = 185
        Width = 72
        Height = 25
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Clear Text'
        TabOrder = 2
        OnClick = ClearTextClick
      end
      object MemoComplaints: TCaptionMemo
        Left = 19
        Top = 216
        Width = 701
        Height = 223
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 1
        Caption = 
          'Additional Complints and or History of Present Illness Section N' +
          'ote Text'
      end
    end
    object oPage4: TTabSheet
      Caption = 'Imports'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbImportSection: TLabel
        Left = 19
        Top = 115
        Width = 104
        Height = 13
        Caption = 'Section Note Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RadioGroupImport: TRadioGroup
        Left = 19
        Top = 30
        Width = 422
        Height = 57
        Caption = 'Imported Medical Data'
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'Active Medications'
          'Active Problems'
          'Allergies')
        ParentFont = False
        TabOrder = 0
        TabStop = True
        OnClick = RadioGroupImportClick
      end
      object pnlSectionImports: TPanel
        Left = 19
        Top = 132
        Width = 701
        Height = 307
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        BevelOuter = bvNone
        ParentBackground = False
        TabOrder = 2
        object pnlAllergies: TPanel
          Left = 0
          Top = 0
          Width = 701
          Height = 307
          Align = alCustom
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 0
          OnResize = pnlAllergiesResize
          object lbAllergies: TLabel
            Left = 1
            Top = 174
            Width = 58
            Height = 13
            Align = alCustom
            Caption = 'Comments'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object memoAllergiesNar: TMemo
            Left = 0
            Top = 191
            Width = 701
            Height = 116
            TabStop = False
            Align = alCustom
            Anchors = [akLeft, akRight, akBottom]
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 2
          end
          object memoAllergies: TMemo
            Left = 0
            Top = 0
            Width = 701
            Height = 140
            TabStop = False
            Align = alCustom
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
          object ckAllergyLatex: TCheckBox
            Left = 1
            Top = 146
            Width = 341
            Height = 17
            Caption = 'Patient has no known latex allergy'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 1
            OnClick = ckAllergyLatexClick
          end
        end
        object pnlProblems: TPanel
          Left = 0
          Top = 0
          Width = 701
          Height = 307
          Align = alCustom
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 1
          OnResize = pnlProblemsResize
          object lbActiveProblems: TLabel
            Left = 0
            Top = 150
            Width = 58
            Height = 13
            Align = alCustom
            Caption = 'Comments'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object memoProblemsNar: TMemo
            Left = 0
            Top = 167
            Width = 701
            Height = 140
            TabStop = False
            Align = alCustom
            Anchors = [akLeft, akRight, akBottom]
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 1
          end
          object memoProblems: TMemo
            Left = 0
            Top = 0
            Width = 701
            Height = 140
            TabStop = False
            Align = alCustom
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
        object pnlMedications: TPanel
          Left = 0
          Top = 0
          Width = 701
          Height = 307
          Align = alCustom
          Anchors = [akLeft, akTop, akRight, akBottom]
          BevelOuter = bvNone
          ParentBackground = False
          TabOrder = 2
          OnResize = pnlMedicationsResize
          object lbActiveMedications: TLabel
            Left = 0
            Top = 150
            Width = 58
            Height = 13
            Align = alCustom
            Caption = 'Comments'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object memoMedicationsNar: TMemo
            Left = 0
            Top = 167
            Width = 701
            Height = 140
            Align = alCustom
            Anchors = [akLeft, akRight, akBottom]
            Font.Charset = ANSI_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ScrollBars = ssVertical
            TabOrder = 1
          end
          object memoMedications: TMemo
            Left = 0
            Top = 0
            Width = 701
            Height = 140
            Align = alCustom
            Anchors = [akLeft, akTop, akRight]
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Courier New'
            Font.Style = []
            ParentFont = False
            ReadOnly = True
            ScrollBars = ssVertical
            TabOrder = 0
          end
        end
      end
      object ButtonReload: TButton
        Left = 447
        Top = 30
        Width = 82
        Height = 63
        Caption = 'Reload Imported Information'
        TabOrder = 1
        WordWrap = True
        OnClick = RadioGroupImportClick
      end
    end
    object oPage5: TTabSheet
      Caption = 'History'
      object lbHistorySection: TLabel
        Left = 272
        Top = 66
        Width = 104
        Height = 13
        Caption = 'Section Note Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object RadioGroupHistory: TRadioGroup
        Left = 19
        Top = 20
        Width = 230
        Height = 57
        Caption = 'History Categories'
        Columns = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ItemIndex = 0
        Items.Strings = (
          'Medical'
          'Family'
          'Social')
        ParentFont = False
        TabOrder = 0
        TabStop = True
        OnClick = RadioGroupHistoryClick
      end
      object ButtonHistoryClear: TButton
        Tag = 2
        Left = 645
        Top = 52
        Width = 75
        Height = 25
        Align = alCustom
        Anchors = [akTop, akRight]
        Caption = 'Clear Text'
        TabOrder = 3
        OnClick = ClearTextClick
      end
      object pnlHistoryCategories: TPanel
        Left = 19
        Top = 83
        Width = 231
        Height = 356
        Align = alCustom
        Anchors = [akLeft, akTop, akBottom]
        BevelOuter = bvNone
        TabOrder = 1
        OnEnter = pnlHistoryCategoriesEnter
        object ListBoxSocialHist: TCheckListBox
          Left = 0
          Top = 0
          Width = 231
          Height = 356
          TabStop = False
          Align = alClient
          ItemHeight = 13
          TabOrder = 2
        end
        object ListBoxFamilyHist: TCheckListBox
          Left = 0
          Top = 0
          Width = 231
          Height = 356
          TabStop = False
          Align = alClient
          ItemHeight = 13
          TabOrder = 1
        end
        object ListBoxMedicalHist: TCheckListBox
          Left = 0
          Top = 0
          Width = 231
          Height = 356
          Align = alClient
          ItemHeight = 13
          TabOrder = 0
        end
      end
      object MemoHistory: TCaptionMemo
        Left = 272
        Top = 83
        Width = 448
        Height = 358
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 2
        Caption = 'History Section Note Text'
      end
    end
    object oPage6: TTabSheet
      Caption = 'Review of Symptoms'
      DesignSize = (
        734
        458)
      object lbRosSection: TLabel
        Left = 19
        Top = 76
        Width = 104
        Height = 13
        Caption = 'Section Note Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ButtonROS: TButton
        Left = 19
        Top = 30
        Width = 310
        Height = 25
        Caption = 'Review of Symptoms since Last Menstrual Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object ButtonROSClear: TButton
        Tag = 3
        Left = 645
        Top = 62
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Clear Text'
        TabOrder = 3
        OnClick = ClearTextClick
      end
      object MemoROS: TCaptionMemo
        Left = 19
        Top = 93
        Width = 701
        Height = 346
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 2
        Caption = 'Review of Symptoms since Last Menstrual Period Section Note Text'
      end
      object ckBloodTransfusion: TCheckBox
        Left = 368
        Top = 34
        Width = 225
        Height = 17
        Caption = 'A blood transfusion is acceptable'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        OnClick = ckBloodTransfusionClick
      end
    end
    object oPage7: TTabSheet
      Caption = 'Physical Exam'
      DesignSize = (
        734
        458)
      object lbPhysicalSection: TLabel
        Left = 19
        Top = 76
        Width = 104
        Height = 13
        Caption = 'Section Note Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ButtonPhysicalClear: TButton
        Tag = 4
        Left = 645
        Top = 62
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Clear Text'
        TabOrder = 2
        OnClick = ClearTextClick
      end
      object ButtonPhysical: TButton
        Left = 19
        Top = 30
        Width = 108
        Height = 25
        Caption = 'Physical Exam'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object MemoPhysical: TCaptionMemo
        Left = 19
        Top = 93
        Width = 701
        Height = 346
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 1
        Caption = 'Physical Exam Section Note Text'
      end
    end
    object oPage8: TTabSheet
      Caption = 'Pelvic Exam'
      DesignSize = (
        734
        458)
      object lbPelvicSection: TLabel
        Left = 19
        Top = 76
        Width = 104
        Height = 13
        Caption = 'Section Note Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object ButtonOBFlow: TButton
        Left = 117
        Top = 30
        Width = 244
        Height = 25
        Caption = 'Obstetrics and Gynecology Flow Sheet'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object ButtonOBExam: TButton
        Left = 19
        Top = 30
        Width = 92
        Height = 25
        Caption = 'Pelvic Exam'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object ButtonOBClear: TButton
        Tag = 5
        Left = 645
        Top = 62
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Clear Text'
        TabOrder = 3
        OnClick = ClearTextClick
      end
      object MemoOBExam: TCaptionMemo
        Left = 19
        Top = 93
        Width = 701
        Height = 346
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 2
        Caption = 'Pelvic Exam Section Note Text'
      end
    end
    object oPage9: TTabSheet
      Caption = 'Plan'
      DesignSize = (
        734
        458)
      object lbProblems: TLabel
        Left = 19
        Top = 21
        Width = 52
        Height = 13
        Caption = 'Problems'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbPlanSection: TLabel
        Left = 19
        Top = 183
        Width = 104
        Height = 13
        Caption = 'Section Note Text'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object cklstProblems: TCheckListBox
        Left = 19
        Top = 38
        Width = 508
        Height = 112
        OnClickCheck = cklstProblemsClickCheck
        Align = alCustom
        Anchors = [akLeft, akTop, akRight]
        ItemHeight = 13
        TabOrder = 0
      end
      object btnEducation: TButton
        Left = 533
        Top = 38
        Width = 187
        Height = 53
        Anchors = [akTop, akRight]
        Caption = 'Patient Education'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
      end
      object ButtonPreNatalNormal: TButton
        Left = 533
        Top = 97
        Width = 187
        Height = 53
        Anchors = [akTop, akRight]
        Caption = 'Return to Clinic Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object ButtonPlanClear: TButton
        Tag = 6
        Left = 645
        Top = 169
        Width = 75
        Height = 25
        Anchors = [akTop, akRight]
        Caption = 'Clear Text'
        TabOrder = 9
        OnClick = ClearTextClick
      end
      object MemoPreNatal: TCaptionMemo
        Left = 19
        Top = 200
        Width = 701
        Height = 240
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        Font.Charset = ANSI_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Courier New'
        Font.Style = []
        ParentFont = False
        ScrollBars = ssVertical
        TabOrder = 8
        Caption = 'Plan Section Note Text'
      end
      object ckPlannedAnesthesia: TCheckBox
        Left = 20
        Top = 156
        Width = 333
        Height = 17
        Caption = 'Is an Anesthesia Consult planned for this pregnancy?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        OnClick = ckPlannedAnesthesiaClick
      end
      object ckACGeneral: TCheckBox
        Tag = 1
        Left = 359
        Top = 156
        Width = 60
        Height = 17
        Caption = 'General'
        TabOrder = 4
        Visible = False
        OnClick = ShowOnNote
      end
      object ckACEpidural: TCheckBox
        Tag = 2
        Left = 425
        Top = 156
        Width = 60
        Height = 17
        Caption = 'Epidural'
        TabOrder = 5
        Visible = False
        OnClick = ShowOnNote
      end
      object ckACSpinal: TCheckBox
        Tag = 3
        Left = 359
        Top = 177
        Width = 60
        Height = 17
        Caption = 'Spinal'
        TabOrder = 6
        Visible = False
        OnClick = ShowOnNote
      end
      object ckACOther: TCheckBox
        Tag = 4
        Left = 425
        Top = 179
        Width = 60
        Height = 17
        Caption = 'Other'
        TabOrder = 7
        Visible = False
        OnClick = ShowOnNote
      end
    end
  end
end
