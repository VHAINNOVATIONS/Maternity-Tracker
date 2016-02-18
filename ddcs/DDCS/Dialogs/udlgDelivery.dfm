object dlgDelivery: TdlgDelivery
  Left = 238
  Top = 90
  BorderStyle = bsDialog
  ClientHeight = 642
  ClientWidth = 858
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lstDelivery: TListView
    Left = 394
    Top = 7
    Width = 381
    Height = 166
    Columns = <>
    TabOrder = 6
    TabStop = False
    ViewStyle = vsReport
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 13
    Top = 44
    Width = 411
    Height = 244
    Caption = 'Delivery Details'
    TabOrder = 2
    object Label1: TLabel
      Left = 21
      Top = 24
      Width = 69
      Height = 13
      Caption = 'Delivery Date:'
    end
    object Label2: TLabel
      Left = 21
      Top = 51
      Width = 125
      Height = 13
      Caption = 'Maternal Discharge  Date:'
    end
    object Label3: TLabel
      Left = 21
      Top = 84
      Width = 53
      Height = 13
      Caption = 'Delivery At'
    end
    object Label4: TLabel
      Left = 177
      Top = 84
      Width = 51
      Height = 13
      Caption = '(# Weeks)'
    end
    object Label8: TLabel
      Left = 21
      Top = 116
      Width = 53
      Height = 13
      Caption = 'Anesthesia'
    end
    object lblLabor: TLabel
      Left = 21
      Top = 143
      Width = 27
      Height = 13
      Caption = 'Labor'
    end
    object lbDeliveryNotes: TLabel
      Left = 21
      Top = 168
      Width = 70
      Height = 13
      Caption = 'Delivery Notes'
    end
    object dtMaternal: TDateTimePicker
      Left = 163
      Top = 48
      Width = 113
      Height = 21
      Date = 39503.200689733800000000
      Time = 39503.200689733800000000
      TabOrder = 0
    end
    object edtDeliveryAt: TSpinEdit
      Left = 109
      Top = 81
      Width = 62
      Height = 22
      MaxValue = 0
      MinValue = 0
      TabOrder = 1
      Value = 0
      OnChange = edtDeliveryAtChange
    end
    object cbLabor: TComboBox
      Left = 109
      Top = 141
      Width = 167
      Height = 21
      Style = csDropDownList
      TabOrder = 3
    end
    object cbAnesthesia: TComboBox
      Left = 109
      Top = 114
      Width = 167
      Height = 21
      Style = csDropDownList
      TabOrder = 2
    end
    object memoDeliveryNotes: TMemo
      Left = 21
      Top = 187
      Width = 369
      Height = 42
      TabOrder = 4
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 613
    Width = 858
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object bbtnOK: TBitBtn
      Left = 700
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 781
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object gbDeliveryMethod: TGroupBox
    Left = 439
    Top = 41
    Width = 404
    Height = 562
    Caption = 'Delivery Method'
    TabOrder = 4
    object lbDeliveryMethodComplications: TLabel
      Left = 23
      Top = 430
      Width = 117
      Height = 13
      Caption = 'Complications/Anomalies'
    end
    object gbVaginal: TGroupBox
      Left = 23
      Top = 48
      Width = 354
      Height = 233
      Caption = 'Vaginal'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      object chkVagVacuum: TCheckBox
        Left = 32
        Top = 50
        Width = 97
        Height = 17
        Caption = 'Vacuum'
        TabOrder = 1
      end
      object chkVagForceps: TCheckBox
        Left = 32
        Top = 70
        Width = 97
        Height = 17
        Caption = 'Forceps'
        TabOrder = 2
      end
      object chkVagEpisiotomy: TCheckBox
        Left = 32
        Top = 90
        Width = 97
        Height = 17
        Caption = 'Episiotomy'
        TabOrder = 3
      end
      object chkVagLacerations: TCheckBox
        Left = 32
        Top = 110
        Width = 97
        Height = 17
        Caption = 'Lacerations'
        TabOrder = 4
      end
      object chkVagVBAC: TCheckBox
        Left = 32
        Top = 130
        Width = 201
        Height = 17
        Caption = 'Vaginal Birth after Cesarean'
        TabOrder = 5
      end
      object chkVagSVD: TCheckBox
        Left = 32
        Top = 30
        Width = 209
        Height = 17
        Caption = 'Spontaneous Vaginal Delivery'
        TabOrder = 0
      end
    end
    object gbCesarean: TGroupBox
      Left = 23
      Top = 48
      Width = 354
      Height = 233
      Caption = 'Cesarean'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
      object lbCesareanReasons: TLabel
        Left = 19
        Top = 98
        Width = 118
        Height = 13
        Caption = 'Indications for Cesarean'
      end
      object lbReasonsCPrimary: TLabel
        Left = 19
        Top = 120
        Width = 36
        Height = 13
        Caption = 'Primary'
      end
      object lbReasonsCSecondary: TLabel
        Left = 19
        Top = 147
        Width = 51
        Height = 13
        Caption = 'Secondary'
      end
      object lblReasonforCOther: TLabel
        Left = 248
        Top = 98
        Width = 28
        Height = 13
        Caption = 'Other'
      end
      object chkCPrimaryFor: TCheckBox
        Left = 19
        Top = 30
        Width = 70
        Height = 17
        Caption = 'Primary'
        TabOrder = 0
      end
      object edtCPrimaryFor: TEdit
        Left = 88
        Top = 28
        Width = 247
        Height = 21
        TabOrder = 1
      end
      object chkCUnsuccessfulVBAC: TCheckBox
        Left = 19
        Top = 72
        Width = 289
        Height = 17
        Caption = 'Repeat - Unsuccessful Vaginal Birth at Cesarean'
        TabOrder = 3
      end
      object rgincision: TRadioGroup
        Left = 19
        Top = 173
        Width = 316
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
        Top = 51
        Width = 169
        Height = 17
        Caption = 'Repeat without Labor'
        TabOrder = 2
      end
      object cbReasonsCPrimary: TComboBox
        Left = 74
        Top = 117
        Width = 167
        Height = 21
        Style = csDropDownList
        TabOrder = 4
      end
      object cbReasonsCSecondary: TComboBox
        Left = 74
        Top = 144
        Width = 167
        Height = 21
        Style = csDropDownList
        TabOrder = 6
      end
      object edtReasonsCOthPrimary: TEdit
        Left = 248
        Top = 117
        Width = 87
        Height = 21
        TabOrder = 5
      end
      object edtReasonsCOthSecondary: TEdit
        Left = 248
        Top = 144
        Width = 87
        Height = 21
        TabOrder = 7
      end
    end
    object rbVaginal: TRadioButton
      Left = 111
      Top = 25
      Width = 78
      Height = 17
      Caption = 'Vaginal'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbVaginalClick
    end
    object rbCesarean: TRadioButton
      Left = 195
      Top = 25
      Width = 94
      Height = 17
      Caption = 'Cesarean'
      TabOrder = 1
      OnClick = rbVaginalClick
    end
    object gbOtherProcedures: TGroupBox
      Left = 23
      Top = 291
      Width = 354
      Height = 131
      Caption = 'Other Procedures done during same Hospitalization'
      TabOrder = 4
      object edtProceduresOther: TLabeledEdit
        Left = 60
        Top = 95
        Width = 273
        Height = 21
        EditLabel.Width = 32
        EditLabel.Height = 13
        EditLabel.Caption = 'Other:'
        LabelPosition = lpLeft
        TabOrder = 6
      end
      object ckProUterineCurettage: TCheckBox
        Left = 23
        Top = 47
        Width = 121
        Height = 17
        Caption = 'Uterine Curettage'
        TabOrder = 2
      end
      object ckProTubalLigationatCesarean: TCheckBox
        Left = 179
        Top = 24
        Width = 158
        Height = 17
        Caption = 'Tubal Ligation at Cesarean'
        TabOrder = 1
      end
      object ckProPostpartumTubalLigation: TCheckBox
        Left = 179
        Top = 47
        Width = 153
        Height = 17
        Caption = 'Postpartum Tubal Ligation'
        TabOrder = 3
      end
      object ckProPostpartumHysterectomy: TCheckBox
        Left = 23
        Top = 70
        Width = 153
        Height = 17
        Caption = 'Postpartum Hysterectomy'
        TabOrder = 4
      end
      object ckNexplanonImplant: TCheckBox
        Left = 23
        Top = 24
        Width = 138
        Height = 17
        Caption = 'Nexplanon Implant'
        TabOrder = 0
      end
      object ckIUDInsertion: TCheckBox
        Left = 179
        Top = 72
        Width = 97
        Height = 17
        Caption = 'IUD Insertion'
        TabOrder = 5
      end
    end
    object memoDeliveryMethodComplications: TMemo
      Left = 23
      Top = 449
      Width = 354
      Height = 97
      TabOrder = 5
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 858
    Height = 33
    Align = alTop
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object lbltitle: TLabel
      Left = 4
      Top = 4
      Width = 161
      Height = 20
      Caption = 'Delivery Information'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object GroupBox3: TGroupBox
    Left = 13
    Top = 294
    Width = 411
    Height = 311
    Align = alCustom
    Caption = 'Neonatal Information'
    TabOrder = 3
    object rbSingleton: TRadioButton
      Left = 32
      Top = 28
      Width = 73
      Height = 17
      Caption = 'Singleton'
      Checked = True
      TabOrder = 0
      TabStop = True
      OnClick = rbSingletonClick
    end
    object rbMultiple: TRadioButton
      Left = 111
      Top = 28
      Width = 74
      Height = 17
      Caption = 'Multiple'
      TabOrder = 1
      OnClick = rbMultipleClick
    end
    object edtNumBabies: TSpinEdit
      Left = 191
      Top = 26
      Width = 41
      Height = 22
      MaxValue = 8
      MinValue = 2
      TabOrder = 2
      Value = 2
      Visible = False
      OnChange = edtNumBabiesChange
      OnKeyDown = edtNumBabiesKeyDown
    end
    object pgCtrlBaby: TPageControl
      Left = 2
      Top = 58
      Width = 407
      Height = 251
      ActivePage = TsBaby1
      Align = alBottom
      TabOrder = 3
      object TsBaby1: TTabSheet
        Caption = 'Baby 1'
        object lblBirthweight1: TLabel
          Left = 15
          Top = 60
          Width = 59
          Height = 13
          Caption = 'Birth Weight'
        end
        object lblLB1: TLabel
          Left = 157
          Top = 60
          Width = 8
          Height = 13
          Caption = 'lb'
        end
        object lblOz1: TLabel
          Left = 244
          Top = 60
          Width = 11
          Height = 13
          Caption = 'oz'
        end
        object lblComplications1: TLabel
          Left = 15
          Top = 125
          Width = 117
          Height = 13
          Caption = 'Complications/Anomalies'
        end
        object lblg1: TLabel
          Left = 355
          Top = 60
          Width = 29
          Height = 13
          Caption = 'grams'
        end
        object rgSex1: TRadioGroup
          Left = 173
          Top = 11
          Width = 212
          Height = 33
          Caption = 'Gender'
          Columns = 3
          Items.Strings = (
            'Male'
            'Female'
            'Unknown')
          TabOrder = 2
          TabStop = True
        end
        object edtLb1: TJvSpinEdit
          Left = 83
          Top = 57
          Width = 70
          Height = 21
          Decimal = 0
          ValueType = vtFloat
          TabOrder = 3
          OnChange = edtLb1Change
        end
        object edtOz1: TJvSpinEdit
          Left = 171
          Top = 57
          Width = 70
          Height = 21
          Decimal = 0
          ValueType = vtFloat
          TabOrder = 4
          OnChange = edtOz1Change
        end
        object memComplications1: TMemo
          Left = 15
          Top = 145
          Width = 370
          Height = 66
          TabOrder = 9
        end
        object rbLiving1: TRadioButton
          Left = 15
          Top = 22
          Width = 65
          Height = 17
          Caption = 'Living'
          TabOrder = 0
          TabStop = True
        end
        object rbDemised1: TRadioButton
          Left = 86
          Top = 22
          Width = 73
          Height = 17
          Caption = 'Demise'
          TabOrder = 1
        end
        object edtAPGAR1: TLabeledEdit
          Left = 83
          Top = 92
          Width = 54
          Height = 21
          EditLabel.Width = 64
          EditLabel.Height = 13
          EditLabel.Caption = 'APGAR Score'
          LabelPosition = lpLeft
          TabOrder = 6
        end
        object ckNICU1: TCheckBox
          Left = 216
          Top = 94
          Width = 156
          Height = 17
          Caption = 'NICU Admission'
          TabOrder = 8
        end
        object edtAPGARs1: TEdit
          Left = 143
          Top = 92
          Width = 54
          Height = 21
          TabOrder = 7
        end
        object edtg1: TJvSpinEdit
          Left = 269
          Top = 57
          Width = 81
          Height = 21
          ValueType = vtFloat
          TabOrder = 5
          OnChange = UpdateLBOZ
        end
      end
    end
  end
  object dtDelivery: TDateTimePicker
    Left = 176
    Top = 65
    Width = 113
    Height = 21
    Date = 39503.200650671300000000
    Time = 39503.200650671300000000
    TabOrder = 1
  end
end
