object dlgMaternal: TdlgMaternal
  Left = 238
  Top = 90
  BorderStyle = bsDialog
  ClientHeight = 391
  ClientWidth = 350
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
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 20
    Top = 47
    Width = 77
    Height = 13
    Caption = 'Feeding Method'
  end
  object Label2: TLabel
    Left = 20
    Top = 98
    Width = 107
    Height = 13
    Caption = 'Contraceptive Method'
  end
  object Label4: TLabel
    Left = 20
    Top = 178
    Width = 170
    Height = 13
    Caption = 'Ongoing Chronic Medical Conditions'
  end
  object Label6: TLabel
    Left = 20
    Top = 260
    Width = 110
    Height = 13
    Caption = 'Maternal Complications'
  end
  object lblSDOther: TLabel
    Left = 136
    Top = 228
    Width = 28
    Height = 13
    Caption = 'Other'
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 362
    Width = 350
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 15
    object bbtnOK: TBitBtn
      Left = 192
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 273
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object chkFeedBreast: TCheckBox
    Left = 32
    Top = 66
    Width = 97
    Height = 17
    Caption = 'Breast Milk'
    TabOrder = 1
  end
  object chkFeedBottle: TCheckBox
    Left = 135
    Top = 66
    Width = 97
    Height = 17
    Caption = 'Bottle'
    TabOrder = 2
  end
  object edtCntrOther: TLabeledEdit
    Left = 51
    Top = 146
    Width = 262
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Other'
    LabelPosition = lpLeft
    TabOrder = 5
  end
  object chkSDAsthma: TCheckBox
    Left = 32
    Top = 202
    Width = 97
    Height = 17
    Caption = 'Asthma'
    TabOrder = 6
  end
  object chkSDDiabetes: TCheckBox
    Left = 135
    Top = 202
    Width = 97
    Height = 17
    Caption = 'Diabetes'
    TabOrder = 7
  end
  object chkSDHypertension: TCheckBox
    Left = 32
    Top = 227
    Width = 97
    Height = 17
    Caption = 'Hypertension'
    TabOrder = 8
  end
  object edtSDOther: TEdit
    Left = 170
    Top = 225
    Width = 144
    Height = 21
    TabOrder = 9
  end
  object edtMCOther: TLabeledEdit
    Left = 64
    Top = 327
    Width = 249
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Other'
    LabelPosition = lpLeft
    TabOrder = 14
    OnChange = chkMCHemorrhageClick
  end
  object chkMCNone: TCheckBox
    Left = 32
    Top = 279
    Width = 97
    Height = 17
    Caption = 'None'
    TabOrder = 10
    OnClick = chkMCNoneClick
  end
  object chkMCHemorrhage: TCheckBox
    Left = 135
    Top = 279
    Width = 168
    Height = 17
    Caption = 'Postpartum Hemorrhage'
    TabOrder = 11
    OnClick = chkMCHemorrhageClick
  end
  object chkMCInfection: TCheckBox
    Left = 135
    Top = 304
    Width = 65
    Height = 17
    Caption = 'Infection'
    TabOrder = 13
    OnClick = chkMCHemorrhageClick
  end
  object chkMCHypertension: TCheckBox
    Left = 32
    Top = 302
    Width = 97
    Height = 17
    Caption = 'Pre-eclampsia'
    TabOrder = 12
    OnClick = chkMCHemorrhageClick
  end
  object Panel3: TPanel
    Left = 0
    Top = 0
    Width = 350
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
      Width = 168
      Height = 20
      Caption = 'Maternal Information'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object ckFeedFormula: TCheckBox
    Left = 211
    Top = 66
    Width = 97
    Height = 17
    Caption = 'Formula'
    TabOrder = 3
  end
  object cbContraceptives: TComboBox
    Left = 20
    Top = 119
    Width = 293
    Height = 21
    TabOrder = 4
  end
end
