object dlgFamMem: TdlgFamMem
  Left = 202
  Top = 127
  BorderStyle = bsDialog
  ClientHeight = 259
  ClientWidth = 632
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 14
    Top = 63
    Width = 85
    Height = 14
    Caption = 'Family Member'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 14
    Top = 101
    Width = 54
    Height = 14
    Caption = 'Diagnosis'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object SpeedButton2: TSpeedButton
    Tag = 3
    Left = 277
    Top = 138
    Width = 25
    Height = 25
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
    OnClick = SpeedButton2Click
  end
  object Panel1: TPanel
    Tag = 19641
    Left = 0
    Top = 0
    Width = 632
    Height = 41
    Align = alTop
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lbltitle: TLabel
      Left = 4
      Top = 4
      Width = 224
      Height = 20
      Caption = 'Family Member Assessment'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblInstructions: TLabel
      Left = 4
      Top = 24
      Width = 231
      Height = 13
      Caption = 'Enter appropriate information.  Press OK to close.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      ParentFont = False
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 230
    Width = 632
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object bbtnOK: TBitBtn
      Left = 474
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 555
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object cobfammem: TComboBox
    Left = 104
    Top = 59
    Width = 193
    Height = 22
    TabOrder = 2
  end
  object cblive: TCheckBox
    Tag = 1
    Left = 319
    Top = 62
    Width = 53
    Height = 17
    Caption = 'Living'
    TabOrder = 3
    OnClick = cbliveClick
  end
  object cbdead: TCheckBox
    Tag = 5
    Left = 378
    Top = 62
    Width = 75
    Height = 17
    Caption = 'Deceased'
    TabOrder = 4
    OnClick = cbdeadClick
  end
  object cobdx: TComboBox
    Left = 104
    Top = 98
    Width = 200
    Height = 22
    TabOrder = 5
    Items.Strings = (
      'Arthritis'
      'Asthma'
      'Bleeding Tendency'
      'Cancer'
      'Colitis'
      'Congenital Heart Disease'
      'Depression'
      'Diabetes'
      'Dyslipidemia'
      'Epilepsy'
      'Goiter'
      'Hay Fever'
      'Heart Attack'
      'High Blood Pressure'
      'Hypothyroidism for Goiter'
      'Kidney Disease'
      'Leukemia'
      'Migraine'
      'Rheumatic Heart Disease'
      'Stomach Ulcers'
      'Stroke'
      'Suicide'
      'Tuberculosis')
  end
  object leddate: TLabeledEdit
    Left = 104
    Top = 140
    Width = 167
    Height = 22
    EditLabel.Width = 24
    EditLabel.Height = 14
    EditLabel.Caption = 'Date'
    EditLabel.Font.Charset = DEFAULT_CHARSET
    EditLabel.Font.Color = clWindowText
    EditLabel.Font.Height = -11
    EditLabel.Font.Name = 'Arial'
    EditLabel.Font.Style = [fsBold]
    EditLabel.ParentFont = False
    TabOrder = 6
  end
  object ledcomments: TLabeledEdit
    Left = 66
    Top = 181
    Width = 551
    Height = 22
    EditLabel.Width = 50
    EditLabel.Height = 14
    EditLabel.Caption = 'Comments'
    EditLabel.Color = clMoneyGreen
    EditLabel.ParentColor = False
    LabelPosition = lpLeft
    TabOrder = 7
  end
  object ListBox1: TListBox
    Left = 391
    Top = 98
    Width = 200
    Height = 64
    ItemHeight = 14
    TabOrder = 8
  end
  object Button1: TButton
    Left = 323
    Top = 98
    Width = 49
    Height = 22
    Caption = 'Add'
    TabOrder = 9
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 323
    Top = 126
    Width = 49
    Height = 22
    Caption = 'Delete'
    TabOrder = 10
    OnClick = Button2Click
  end
end
