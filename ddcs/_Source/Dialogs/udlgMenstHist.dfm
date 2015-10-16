object dlgMenstHist: TdlgMenstHist
  Left = 218
  Top = 142
  BorderStyle = bsDialog
  ClientHeight = 278
  ClientWidth = 557
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Label1: TLabel
    Left = 32
    Top = 122
    Width = 44
    Height = 14
    Caption = 'Menses: '
  end
  object sbtnGetDate1: TSpeedButton
    Tag = 1
    Left = 128
    Top = 80
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
    OnClick = sbtnGetDate1Click
  end
  object Label2: TLabel
    Left = 77
    Top = 172
    Width = 67
    Height = 14
    Caption = '(Fill in # days)'
  end
  object Label3: TLabel
    Left = 77
    Top = 218
    Width = 95
    Height = 14
    Caption = '(Fill in age of onset)'
  end
  object Label4: TLabel
    Left = 287
    Top = 44
    Width = 40
    Height = 14
    Caption = 'Amount:'
  end
  object Label5: TLabel
    Left = 239
    Top = 84
    Width = 87
    Height = 14
    Caption = 'On Contraception:'
  end
  object SpeedButton1: TSpeedButton
    Tag = 2
    Left = 359
    Top = 147
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
    OnClick = sbtnGetDate1Click
  end
  object Label8: TLabel
    Left = 284
    Top = 64
    Width = 43
    Height = 14
    Caption = 'Duration:'
  end
  object Label6: TLabel
    Left = 239
    Top = 181
    Width = 53
    Height = 14
    Caption = 'Comments:'
  end
  object Label7: TLabel
    Left = 239
    Top = 104
    Width = 298
    Height = 14
    Caption = 'What type(s) of contraception were you using most recently?'
  end
  object edtLMP: TLabeledEdit
    Left = 42
    Top = 81
    Width = 83
    Height = 22
    EditLabel.Width = 23
    EditLabel.Height = 14
    EditLabel.Caption = 'LMP:'
    LabelPosition = lpLeft
    TabOrder = 2
    OnChange = edtLMPChange
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 557
    Height = 30
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
      Width = 141
      Height = 20
      Caption = 'Menstrual History'
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
    Top = 249
    Width = 557
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 15
    object bbtnOK: TBitBtn
      Left = 379
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 460
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object ckMensesNo: TCheckBox
    Tag = 2
    Left = 146
    Top = 122
    Width = 75
    Height = 17
    Caption = 'Abnormal'
    TabOrder = 4
    OnClick = ckMensesYesClick
  end
  object edtFrequency: TLabeledEdit
    Left = 77
    Top = 148
    Width = 112
    Height = 22
    EditLabel.Width = 55
    EditLabel.Height = 14
    EditLabel.Caption = 'Frequency:'
    LabelPosition = lpLeft
    TabOrder = 5
  end
  object edtMenarche: TLabeledEdit
    Left = 77
    Top = 193
    Width = 112
    Height = 22
    EditLabel.Width = 51
    EditLabel.Height = 14
    EditLabel.Caption = 'Menarche:'
    LabelPosition = lpLeft
    TabOrder = 6
  end
  object ckAmountNo: TCheckBox
    Tag = 4
    Left = 412
    Top = 44
    Width = 82
    Height = 17
    Caption = 'Abnormal'
    TabOrder = 8
    OnClick = ckMensesYesClick
  end
  object ckContraceptionYes: TCheckBox
    Tag = 5
    Left = 342
    Top = 84
    Width = 52
    Height = 17
    Caption = 'Yes'
    TabOrder = 11
    OnClick = ckMensesYesClick
  end
  object ckContraceptionNo: TCheckBox
    Tag = 6
    Left = 412
    Top = 84
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 12
    OnClick = ckMensesYesClick
  end
  object edthcg: TLabeledEdit
    Left = 274
    Top = 148
    Width = 83
    Height = 22
    EditLabel.Width = 27
    EditLabel.Height = 14
    EditLabel.Caption = 'hCG+'
    LabelPosition = lpLeft
    TabOrder = 13
  end
  object ckDurationNo: TCheckBox
    Tag = 8
    Left = 412
    Top = 64
    Width = 82
    Height = 17
    Caption = 'Abnormal'
    TabOrder = 10
    OnClick = ckMensesYesClick
  end
  object memLMP: TMemo
    Left = 239
    Top = 196
    Width = 296
    Height = 43
    TabOrder = 14
  end
  object btnHistory: TButton
    Left = 16
    Top = 40
    Width = 75
    Height = 25
    Caption = 'History'
    TabOrder = 1
  end
  object ckAmountYes: TCheckBox
    Tag = 3
    Left = 342
    Top = 44
    Width = 63
    Height = 17
    Caption = 'Normal'
    TabOrder = 7
    OnClick = ckMensesYesClick
  end
  object ckDurationYes: TCheckBox
    Tag = 7
    Left = 342
    Top = 64
    Width = 64
    Height = 17
    Caption = 'Normal'
    TabOrder = 9
    OnClick = ckMensesYesClick
  end
  object ckMensesYes: TCheckBox
    Tag = 1
    Left = 77
    Top = 122
    Width = 63
    Height = 17
    Caption = 'Normal'
    TabOrder = 3
    OnClick = ckMensesYesClick
  end
  object edtContraceptionType: TComboBox
    Left = 239
    Top = 120
    Width = 296
    Height = 22
    Style = csDropDownList
    TabOrder = 16
  end
end
