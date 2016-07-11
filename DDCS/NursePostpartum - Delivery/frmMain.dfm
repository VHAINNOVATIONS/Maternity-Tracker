object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Nurse Postpartum - Delivery'
  ClientHeight = 463
  ClientWidth = 742
  Color = clBtnFace
  Constraints.MinHeight = 490
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
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DDCSForm1: TDDCSForm
    Left = 0
    Top = 0
    Width = 742
    Height = 463
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
    ReportCollection = <
      item
        SayOnFocus = 'Primary'
        Order = 0
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = edCPrimaryFor
        Required = False
      end
      item
        SayOnFocus = 'Other Primary Indications for Cesarean'
        Order = 1
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = edReasonsCOthPrimary
        Required = False
      end
      item
        SayOnFocus = 'Other Secondary Indications for Cesarean'
        Order = 2
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = edReasonsCOthSecondary
        Required = False
      end
      item
        SayOnFocus = 'Other'
        Order = 3
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = edProceduresOther
        Required = False
      end
      item
        Order = 4
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = Panel1
        Required = False
      end
      item
        Order = 5
        DoNotSpace = False
        DoNotSave = False
        DoNotRestoreV = False
        HideFromNote = False
        OwningObject = spnGAWeeks
        Required = False
      end>
    OnOverrideNote = Finished
    object oPage1: TTabSheet
      Caption = 'Delivery Details'
      DesignSize = (
        734
        398)
      object lbGADays: TLabel
        Left = 334
        Top = 110
        Width = 24
        Height = 13
        Caption = 'Days'
      end
      object lbDeliveryDate: TLabel
        Left = 19
        Top = 19
        Width = 78
        Height = 13
        Caption = 'Delivery Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbDischargeDate: TLabel
        Left = 19
        Top = 50
        Width = 142
        Height = 13
        Caption = 'Maternal Discharge Date'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbDaysIn: TLabel
        Left = 19
        Top = 79
        Width = 197
        Height = 13
        Caption = 'Days in Hospital following Delivery'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbAnesthesia: TLabel
        Left = 19
        Top = 142
        Width = 63
        Height = 13
        Caption = 'Anesthesia'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbLabor: TLabel
        Left = 395
        Top = 79
        Width = 33
        Height = 13
        Caption = 'Labor'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbDeliveryNotes: TLabel
        Left = 19
        Top = 209
        Width = 84
        Height = 13
        Caption = 'Delivery Notes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbGestationalAge: TLabel
        Left = 19
        Top = 111
        Width = 91
        Height = 13
        Caption = 'Gestational Age'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbLaborLength: TLabel
        Left = 395
        Top = 111
        Width = 140
        Height = 13
        Caption = 'Length of Labor in hours'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbDeliveryPlace: TLabel
        Left = 19
        Top = 178
        Width = 98
        Height = 13
        Caption = 'Place of Delivery'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbOutcome: TLabel
        Left = 395
        Top = 142
        Width = 51
        Height = 13
        Caption = 'Outcome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbGAWeeks: TLabel
        Left = 240
        Top = 111
        Width = 34
        Height = 13
        Caption = 'Weeks'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object dtDelivery: TORDateBox
        Left = 187
        Top = 15
        Width = 166
        Height = 21
        TabOrder = 0
        DateOnly = True
        RequireTime = False
        Caption = 'Delivery Date'
      end
      object dtMaternal: TORDateBox
        Left = 187
        Top = 46
        Width = 166
        Height = 21
        TabOrder = 1
        DateOnly = False
        RequireTime = False
        Caption = 'Maternal Discharge Date'
      end
      object edtDeliveryAt: TSpinEdit
        Left = 225
        Top = 75
        Width = 50
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 2
        Value = 0
        OnChange = SpinCheck
      end
      object cbAnesthesia: TCaptionComboBox
        Left = 187
        Top = 139
        Width = 166
        Height = 21
        Style = csDropDownList
        TabOrder = 5
        Caption = 'Anesthesia'
      end
      object cbLabor: TCaptionComboBox
        Left = 455
        Top = 76
        Width = 162
        Height = 21
        Style = csDropDownList
        TabOrder = 7
        Caption = 'Labor'
      end
      object rgPretermDelivery: TRadioGroup
        Left = 395
        Top = 15
        Width = 222
        Height = 45
        Caption = 'Preterm Delivery'
        Columns = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        Items.Strings = (
          'No'
          'Yes')
        ParentFont = False
        TabOrder = 6
        TabStop = True
        OnClick = rgPretermDeliveryClick
      end
      object spnLaborLength: TSpinEdit
        Left = 544
        Top = 107
        Width = 73
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 8
        Value = 0
        OnChange = SpinCheck
      end
      object Panel1: TPanel
        Left = 282
        Top = 105
        Width = 51
        Height = 23
        BevelOuter = bvNone
        TabOrder = 4
        object spnGADays: TSpinEdit
          Left = 0
          Top = 0
          Width = 50
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = spnGADaysChange
        end
      end
      object cbDeliveryPlace: TCaptionComboBox
        Left = 132
        Top = 174
        Width = 485
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        TabOrder = 10
        Caption = 'Place of Delivery'
      end
      object cbOutcome: TCaptionComboBox
        Left = 455
        Top = 138
        Width = 162
        Height = 21
        Style = csDropDownList
        TabOrder = 9
        Caption = 'Outcome'
      end
      object meDeliveryNotes: TCaptionMemo
        Left = 19
        Top = 228
        Width = 694
        Height = 152
        Align = alCustom
        Anchors = [akLeft, akTop, akRight, akBottom]
        ScrollBars = ssVertical
        TabOrder = 11
        Caption = 'Delivery Notes'
      end
      object spnGAWeeks: TSpinEdit
        Left = 187
        Top = 105
        Width = 50
        Height = 22
        MaxValue = 0
        MinValue = 0
        TabOrder = 3
        Value = 0
        OnChange = SpinCheck
      end
    end
    object oPage2: TTabSheet
      Caption = 'Neonatal Information'
      object pnlBirthCount: TPanel
        Left = 0
        Top = 0
        Width = 734
        Height = 40
        Align = alTop
        BorderStyle = bsSingle
        TabOrder = 0
        object lbBirthCount: TLabel
          Left = 19
          Top = 11
          Width = 128
          Height = 13
          Caption = 'Total Number of Births'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object spnBirthCount: TSpinEdit
          Left = 156
          Top = 7
          Width = 41
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = spnBirthCountChange
        end
      end
      object pnlSpacer: TPanel
        Left = 0
        Top = 40
        Width = 734
        Height = 10
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
      end
      object pgBaby: TPageControl
        Left = 0
        Top = 50
        Width = 734
        Height = 348
        Align = alClient
        Style = tsFlatButtons
        TabOrder = 1
      end
    end
    object oPage3: TTabSheet
      Caption = 'Delivery Method'
      object gbVaginal: TGroupBox
        Left = 14
        Top = 19
        Width = 224
        Height = 233
        Caption = 'Vaginal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabStop = True
        object ckVagSVD: TCheckBox
          Left = 15
          Top = 30
          Width = 200
          Height = 17
          Caption = 'Normal Spontaneous Vaginal Delivery'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ckVagVacuum: TCheckBox
          Left = 15
          Top = 53
          Width = 97
          Height = 17
          Caption = 'Vacuum'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object ckVagForceps: TCheckBox
          Left = 15
          Top = 76
          Width = 97
          Height = 17
          Caption = 'Forceps'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object ckVagEpisiotomy: TCheckBox
          Left = 15
          Top = 98
          Width = 97
          Height = 17
          Caption = 'Episiotomy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ckVagLacerations: TCheckBox
          Left = 15
          Top = 121
          Width = 97
          Height = 17
          Caption = 'Lacerations'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object ckVagVBAC: TCheckBox
          Left = 15
          Top = 143
          Width = 177
          Height = 17
          Caption = 'Vaginal Birth after Cesarean'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
      end
      object gbCesarean: TGroupBox
        Left = 244
        Top = 19
        Width = 475
        Height = 233
        Caption = 'Cesarean'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = True
        object lbCesareanReasons: TLabel
          Left = 19
          Top = 101
          Width = 138
          Height = 13
          Caption = 'Indications for Cesarean'
        end
        object lbReasonsCPrimary: TLabel
          Left = 19
          Top = 120
          Width = 36
          Height = 13
          Caption = 'Primary'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbReasonsCSecondary: TLabel
          Left = 19
          Top = 147
          Width = 51
          Height = 13
          Caption = 'Secondary'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object lbReasonforCOther: TLabel
          Left = 275
          Top = 101
          Width = 32
          Height = 13
          Caption = 'Other'
        end
        object ckCPrimaryFor: TCheckBox
          Left = 19
          Top = 30
          Width = 63
          Height = 17
          Caption = 'Primary'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object edCPrimaryFor: TEdit
          Left = 78
          Top = 28
          Width = 376
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object ckCUnsuccessfulVBAC: TCheckBox
          Left = 19
          Top = 74
          Width = 289
          Height = 17
          Caption = 'Repeat - Unsuccessful Vaginal Birth at Cesarean'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object rgIncision: TRadioGroup
          Left = 19
          Top = 173
          Width = 435
          Height = 44
          Caption = 'Uterine Incision'
          Columns = 3
          Items.Strings = (
            'Low Transverse'
            'Low Vertical'
            'Classical')
          TabOrder = 8
          TabStop = True
        end
        object ckRepeatwoLabor: TCheckBox
          Left = 19
          Top = 52
          Width = 169
          Height = 17
          Caption = 'Repeat without Labor'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object cbReasonsCPrimary: TCaptionComboBox
          Left = 74
          Top = 117
          Width = 195
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
          Caption = 'Primary Indications for Cesarean'
        end
        object cbReasonsCSecondary: TCaptionComboBox
          Left = 74
          Top = 144
          Width = 195
          Height = 21
          Style = csDropDownList
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
          Caption = 'Secondary Indications for Cesarean'
        end
        object edReasonsCOthPrimary: TEdit
          Left = 275
          Top = 117
          Width = 179
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object edReasonsCOthSecondary: TEdit
          Left = 275
          Top = 144
          Width = 179
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
      end
      object gbOtherProcedures: TGroupBox
        Left = 14
        Top = 259
        Width = 705
        Height = 122
        Caption = 'Other Procedures done during same Hospitalization'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        TabStop = True
        object lbProceduresOther: TLabel
          Left = 301
          Top = 92
          Width = 32
          Height = 13
          Caption = 'Other'
        end
        object ckProUterineCurettage: TCheckBox
          Left = 23
          Top = 67
          Width = 121
          Height = 17
          Caption = 'Uterine Curettage'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
        end
        object ckProTubalLigationatCesarean: TCheckBox
          Left = 23
          Top = 43
          Width = 158
          Height = 17
          Caption = 'Tubal Ligation at Cesarean'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
        end
        object ckProPostpartumTubalLigation: TCheckBox
          Left = 23
          Top = 91
          Width = 153
          Height = 17
          Caption = 'Postpartum Tubal Ligation'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
        end
        object ckProPostpartumHysterectomy: TCheckBox
          Left = 301
          Top = 20
          Width = 153
          Height = 17
          Caption = 'Postpartum Hysterectomy'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 4
        end
        object ckNexplanonImplant: TCheckBox
          Left = 23
          Top = 19
          Width = 138
          Height = 19
          Caption = 'Nexplanon Implant'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
        end
        object ckIUDInsertion: TCheckBox
          Left = 301
          Top = 43
          Width = 237
          Height = 17
          Caption = 'Intrauterine Contraceptive Device Insertion'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 5
        end
        object ckBakri: TCheckBox
          Left = 301
          Top = 67
          Width = 149
          Height = 17
          Caption = 'Bakri Balloon Placement'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 6
        end
        object edProceduresOther: TEdit
          Left = 342
          Top = 88
          Width = 342
          Height = 21
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 7
        end
      end
      object ckDeliveryMethodV: TCheckBox
        Left = 89
        Top = 17
        Width = 97
        Height = 17
        TabStop = False
        Caption = 'Vaginal'
        TabOrder = 3
        Visible = False
      end
      object ckDeliveryMethodC: TCheckBox
        Left = 483
        Top = 17
        Width = 97
        Height = 17
        TabStop = False
        Caption = 'Cesarean'
        TabOrder = 4
        Visible = False
      end
    end
    object oPage4: TTabSheet
      Caption = 'Data Control'
      TabVisible = False
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lstDelivery: TListView
        Left = 0
        Top = 0
        Width = 734
        Height = 398
        Align = alClient
        Columns = <>
        TabOrder = 0
        TabStop = False
        ViewStyle = vsReport
      end
    end
  end
end
