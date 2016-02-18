object dlgHeadache: TdlgHeadache
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 226
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 17
    Top = 130
    Width = 35
    Height = 14
    Caption = '(if any)'
  end
  object Label2: TLabel
    Left = 250
    Top = 71
    Width = 109
    Height = 14
    Caption = '(visual changes/other)'
  end
  object Label3: TLabel
    Left = 250
    Top = 97
    Width = 60
    Height = 14
    Caption = 'Treatments?'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 565
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
      Width = 83
      Height = 20
      Caption = 'Headache'
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
    Top = 197
    Width = 565
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 9
    object bbtnOK: TBitBtn
      Left = 406
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 487
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 80
    Top = 50
    Width = 137
    Height = 22
    EditLabel.Width = 68
    EditLabel.Height = 14
    EditLabel.Caption = 'Time of onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leChar: TLabeledEdit
    Left = 80
    Top = 80
    Width = 137
    Height = 22
    EditLabel.Width = 51
    EditLabel.Height = 14
    EditLabel.Caption = 'Character:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object leLocat: TLabeledEdit
    Left = 80
    Top = 112
    Width = 137
    Height = 22
    EditLabel.Width = 60
    EditLabel.Height = 14
    EditLabel.Caption = 'Localization:'
    LabelPosition = lpLeft
    TabOrder = 3
  end
  object leDur: TLabeledEdit
    Left = 80
    Top = 155
    Width = 137
    Height = 22
    EditLabel.Width = 43
    EditLabel.Height = 14
    EditLabel.Caption = 'Duration:'
    LabelPosition = lpLeft
    TabOrder = 4
  end
  object leAssoc: TLabeledEdit
    Left = 363
    Top = 50
    Width = 182
    Height = 22
    EditLabel.Width = 110
    EditLabel.Height = 14
    EditLabel.Caption = 'Associated symptoms:'
    LabelPosition = lpLeft
    TabOrder = 5
  end
  object leWhat: TLabeledEdit
    Left = 252
    Top = 142
    Width = 293
    Height = 22
    EditLabel.Width = 137
    EditLabel.Height = 14
    EditLabel.Caption = ' What used? Effectiveness?'
    TabOrder = 8
    Visible = False
  end
  object cbTreatYes: TCheckBox
    Tag = 1
    Left = 322
    Top = 96
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 6
    OnClick = cbTreatYesClick
  end
  object cbTreatNo: TCheckBox
    Tag = 2
    Left = 370
    Top = 96
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 7
    OnClick = cbTreatYesClick
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 501
    Top = 40
    Data = (
      (
        'Component = dlgHeadache'
        'Status = stsDefault'))
  end
end
