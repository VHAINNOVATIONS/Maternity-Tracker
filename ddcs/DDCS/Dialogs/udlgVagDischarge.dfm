object dlgVagDischarge: TdlgVagDischarge
  Left = 217
  Top = 135
  BorderStyle = bsDialog
  ClientHeight = 147
  ClientWidth = 419
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
  object Label3: TLabel
    Left = 266
    Top = 54
    Width = 27
    Height = 14
    Caption = 'Odor:'
  end
  object Label1: TLabel
    Left = 266
    Top = 84
    Width = 34
    Height = 14
    Caption = 'Itching:'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 419
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
      Width = 147
      Height = 20
      Caption = 'Vaginal Discharge'
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
    Top = 118
    Width = 419
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 7
    object bbtnOK: TBitBtn
      Left = 261
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 342
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object leOnset: TLabeledEdit
    Left = 45
    Top = 50
    Width = 155
    Height = 22
    EditLabel.Width = 32
    EditLabel.Height = 14
    EditLabel.Caption = 'Onset:'
    LabelPosition = lpLeft
    TabOrder = 1
  end
  object leColor: TLabeledEdit
    Left = 45
    Top = 80
    Width = 155
    Height = 22
    EditLabel.Width = 28
    EditLabel.Height = 14
    EditLabel.Caption = 'Color:'
    LabelPosition = lpLeft
    TabOrder = 2
  end
  object CheckBox1: TCheckBox
    Tag = 1
    Left = 306
    Top = 53
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 3
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Tag = 2
    Left = 354
    Top = 53
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object CheckBox3: TCheckBox
    Tag = 3
    Left = 306
    Top = 83
    Width = 43
    Height = 17
    Caption = 'Yes'
    TabOrder = 5
    OnClick = CheckBox1Click
  end
  object CheckBox4: TCheckBox
    Tag = 4
    Left = 354
    Top = 83
    Width = 36
    Height = 17
    Caption = 'No'
    TabOrder = 6
    OnClick = CheckBox1Click
  end
  object amgrMain: TVA508AccessibilityManager
    Left = 253
    Top = 40
    Data = (
      (
        'Component = dlgVagDischarge'
        'Status = stsDefault'))
  end
end
