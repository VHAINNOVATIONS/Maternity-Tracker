object dlgPreNatal: TdlgPreNatal
  Left = 195
  Top = 173
  BorderStyle = bsDialog
  ClientHeight = 419
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 632
    Height = 29
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
      Width = 108
      Height = 20
      Caption = 'Prenatal Visit'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 390
    Width = 632
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object bbtnOK: TBitBtn
      Left = 474
      Top = 3
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 555
      Top = 3
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object gb1: TGroupBox
    Left = 0
    Top = 29
    Width = 632
    Height = 248
    Align = alTop
    Caption = 'MEDICAL'
    TabOrder = 1
    object ed1: TEdit
      Left = 131
      Top = 16
      Width = 121
      Height = 22
      TabOrder = 1
    end
    object ed2: TEdit
      Left = 131
      Top = 44
      Width = 121
      Height = 22
      TabOrder = 3
    end
    object ed3: TEdit
      Left = 131
      Top = 72
      Width = 121
      Height = 22
      TabOrder = 5
    end
    object ed4: TEdit
      Left = 131
      Top = 100
      Width = 121
      Height = 22
      TabOrder = 7
    end
    object ed5: TEdit
      Left = 131
      Top = 128
      Width = 121
      Height = 22
      TabOrder = 9
    end
    object ed6: TEdit
      Left = 131
      Top = 156
      Width = 121
      Height = 22
      TabOrder = 11
    end
    object ed7: TEdit
      Left = 131
      Top = 184
      Width = 121
      Height = 22
      TabOrder = 13
    end
    object cb1: TCheckBox
      Tag = 1
      Left = 7
      Top = 19
      Width = 97
      Height = 17
      Caption = 'Allergies'
      TabOrder = 0
      OnClick = cb1Click
    end
    object cb2: TCheckBox
      Tag = 2
      Left = 7
      Top = 47
      Width = 97
      Height = 17
      Caption = 'Asthma'
      TabOrder = 2
      OnClick = cb1Click
    end
    object cb3: TCheckBox
      Tag = 3
      Left = 7
      Top = 75
      Width = 115
      Height = 17
      Caption = 'Bleeding Disorder'
      TabOrder = 4
      OnClick = cb1Click
    end
    object cb4: TCheckBox
      Tag = 4
      Left = 7
      Top = 103
      Width = 97
      Height = 17
      Caption = 'CAD'
      TabOrder = 6
      OnClick = cb1Click
    end
    object cb5: TCheckBox
      Tag = 5
      Left = 7
      Top = 131
      Width = 97
      Height = 17
      Caption = 'Cancer'
      TabOrder = 8
      OnClick = cb1Click
    end
    object cb6: TCheckBox
      Tag = 6
      Left = 7
      Top = 159
      Width = 97
      Height = 17
      Caption = 'Cancer Lung'
      TabOrder = 10
      OnClick = cb1Click
    end
    object cb7: TCheckBox
      Tag = 7
      Left = 7
      Top = 187
      Width = 92
      Height = 17
      Caption = 'COPD'
      TabOrder = 12
      OnClick = cb1Click
    end
    object cb8: TCheckBox
      Tag = 8
      Left = 312
      Top = 19
      Width = 146
      Height = 17
      Caption = 'Coronary Bypass Graft'
      TabOrder = 14
      OnClick = cb1Click
    end
    object cb9: TCheckBox
      Tag = 9
      Left = 312
      Top = 47
      Width = 97
      Height = 17
      Caption = 'Diabetes Mellitus'
      TabOrder = 16
      OnClick = cb1Click
    end
    object cb10: TCheckBox
      Tag = 10
      Left = 312
      Top = 75
      Width = 97
      Height = 17
      Caption = 'Emphysema'
      TabOrder = 18
      OnClick = cb1Click
    end
    object cb11: TCheckBox
      Tag = 11
      Left = 312
      Top = 103
      Width = 97
      Height = 17
      Caption = 'Hypertension'
      TabOrder = 20
      OnClick = cb1Click
    end
    object cb12: TCheckBox
      Tag = 12
      Left = 312
      Top = 131
      Width = 146
      Height = 17
      Caption = 'Hypertension Pulmonary'
      TabOrder = 22
      OnClick = cb1Click
    end
    object cb13: TCheckBox
      Tag = 13
      Left = 312
      Top = 159
      Width = 97
      Height = 17
      Caption = 'Renal Failure'
      TabOrder = 24
      OnClick = cb1Click
    end
    object cb14: TCheckBox
      Tag = 14
      Left = 312
      Top = 187
      Width = 132
      Height = 17
      Caption = 'Rheumatoid Arthritis'
      TabOrder = 26
      OnClick = cb1Click
    end
    object ed8: TEdit
      Left = 478
      Top = 16
      Width = 121
      Height = 22
      TabOrder = 15
    end
    object ed9: TEdit
      Left = 478
      Top = 44
      Width = 121
      Height = 22
      TabOrder = 17
    end
    object ed10: TEdit
      Left = 478
      Top = 72
      Width = 121
      Height = 22
      TabOrder = 19
    end
    object ed11: TEdit
      Left = 478
      Top = 100
      Width = 121
      Height = 22
      TabOrder = 21
    end
    object ed12: TEdit
      Left = 478
      Top = 128
      Width = 121
      Height = 22
      TabOrder = 23
    end
    object ed13: TEdit
      Left = 478
      Top = 156
      Width = 121
      Height = 22
      TabOrder = 25
    end
    object ed14: TEdit
      Left = 478
      Top = 184
      Width = 121
      Height = 22
      TabOrder = 27
    end
    object ledMedical: TLabeledEdit
      Left = 131
      Top = 212
      Width = 470
      Height = 22
      EditLabel.Width = 103
      EditLabel.Height = 14
      EditLabel.Caption = 'Additional Information'
      EditLabel.Color = clBtnFace
      EditLabel.ParentColor = False
      LabelPosition = lpLeft
      TabOrder = 28
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 277
    Width = 632
    Height = 113
    Align = alClient
    Caption = 'SURGICAL'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    object Memo1: TMemo
      Left = 2
      Top = 16
      Width = 628
      Height = 95
      Align = alClient
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
end
