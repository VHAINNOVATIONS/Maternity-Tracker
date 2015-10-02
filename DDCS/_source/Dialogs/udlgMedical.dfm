object dlgMedical: TdlgMedical
  Left = 208
  Top = 148
  BorderStyle = bsDialog
  ClientHeight = 668
  ClientWidth = 652
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
    Width = 652
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
      Width = 123
      Height = 20
      Caption = 'Medical History'
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
    Top = 639
    Width = 652
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object bbtnOK: TBitBtn
      Left = 494
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 575
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object BitBtn2: TBitBtn
      Left = 2
      Top = 2
      Width = 96
      Height = 25
      Caption = 'Negative for all'
      Default = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = BitBtn2Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 33
    Width = 652
    Height = 606
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = 'Page1'
      object Label2: TLabel
        Left = 10
        Top = 31
        Width = 42
        Height = 14
        Caption = 'Diabetes'
      end
      object Label3: TLabel
        Left = 174
        Top = 5
        Width = 21
        Height = 14
        Caption = 'POS'
      end
      object Label4: TLabel
        Left = 204
        Top = 5
        Width = 21
        Height = 14
        Caption = 'NEG'
      end
      object Label5: TLabel
        Left = 10
        Top = 84
        Width = 255
        Height = 22
        AutoSize = False
        Caption = 'Hypertension'
        Color = clMoneyGreen
        Constraints.MinWidth = 217
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 10
        Top = 115
        Width = 68
        Height = 14
        Caption = 'Heart Disease'
      end
      object Label7: TLabel
        Left = 10
        Top = 140
        Width = 255
        Height = 22
        AutoSize = False
        Caption = 'Autoimmune Disorder'
        Color = clMoneyGreen
        Constraints.MinWidth = 217
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label8: TLabel
        Left = 10
        Top = 171
        Width = 93
        Height = 14
        Caption = 'Kidney Disease/UTI'
      end
      object Label9: TLabel
        Left = 10
        Top = 196
        Width = 255
        Height = 22
        AutoSize = False
        Caption = 'Neurologic/Epilepsy'
        Color = clMoneyGreen
        Constraints.MinWidth = 217
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label11: TLabel
        Left = 10
        Top = 223
        Width = 255
        Height = 22
        AutoSize = False
        Caption = 'Depression/Anxiety'
        Color = clBtnFace
        Constraints.MinWidth = 217
        ParentColor = False
        Transparent = True
        Layout = tlCenter
      end
      object Label10: TLabel
        Left = 10
        Top = 252
        Width = 271
        Height = 22
        AutoSize = False
        Caption = 'Psychiatric (Other)'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label12: TLabel
        Left = 11
        Top = 283
        Width = 110
        Height = 14
        Caption = 'Hepatitis/Liver Disease'
      end
      object Label13: TLabel
        Left = 11
        Top = 308
        Width = 254
        Height = 22
        AutoSize = False
        Caption = 'Varicosities/Phlebitis/Blood Clots'
        Color = clMoneyGreen
        Constraints.MinWidth = 217
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label14: TLabel
        Left = 11
        Top = 339
        Width = 97
        Height = 14
        Caption = 'Thyroid Dysfunction'
      end
      object Label15: TLabel
        Left = 250
        Top = 5
        Width = 212
        Height = 14
        Caption = 'COMMENTS - To include Date and Treatment'
      end
      object Label30: TLabel
        Left = 10
        Top = 364
        Width = 271
        Height = 22
        AutoSize = False
        Caption = 'Rheumatic Fever'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label31: TLabel
        Left = 10
        Top = 395
        Width = 81
        Height = 14
        Caption = 'Seizure Disorder'
      end
      object Label1: TLabel
        Left = 11
        Top = 430
        Width = 53
        Height = 14
        Caption = 'Comments:'
      end
      object CheckBox1: TCheckBox
        Tag = 1
        Left = 174
        Top = 31
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Tag = 2
        Left = 204
        Top = 31
        Width = 17
        Height = 17
        Hint = 'NEG'
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object Edit1: TEdit
        Left = 250
        Top = 28
        Width = 374
        Height = 22
        TabOrder = 2
      end
      object CheckBox3: TCheckBox
        Tag = 3
        Left = 174
        Top = 87
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 6
        OnClick = CheckBox1Click
      end
      object CheckBox4: TCheckBox
        Tag = 4
        Left = 204
        Top = 87
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 7
        OnClick = CheckBox1Click
      end
      object Edit2: TEdit
        Left = 250
        Top = 84
        Width = 374
        Height = 22
        TabOrder = 8
      end
      object CheckBox5: TCheckBox
        Tag = 5
        Left = 174
        Top = 115
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 9
        OnClick = CheckBox1Click
      end
      object CheckBox6: TCheckBox
        Tag = 6
        Left = 204
        Top = 115
        Width = 17
        Height = 17
        Hint = 'NEG'
        TabOrder = 10
        OnClick = CheckBox1Click
      end
      object Edit3: TEdit
        Left = 250
        Top = 113
        Width = 374
        Height = 22
        TabOrder = 11
      end
      object CheckBox7: TCheckBox
        Tag = 7
        Left = 174
        Top = 143
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 12
        OnClick = CheckBox1Click
      end
      object CheckBox8: TCheckBox
        Tag = 8
        Left = 204
        Top = 143
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 13
        OnClick = CheckBox1Click
      end
      object Edit4: TEdit
        Left = 250
        Top = 140
        Width = 374
        Height = 22
        TabOrder = 14
      end
      object CheckBox9: TCheckBox
        Tag = 9
        Left = 174
        Top = 171
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 15
        OnClick = CheckBox1Click
      end
      object CheckBox10: TCheckBox
        Tag = 10
        Left = 204
        Top = 171
        Width = 17
        Height = 17
        Hint = 'NEG'
        TabOrder = 16
        OnClick = CheckBox1Click
      end
      object Edit5: TEdit
        Left = 250
        Top = 168
        Width = 374
        Height = 22
        TabOrder = 17
      end
      object CheckBox11: TCheckBox
        Tag = 11
        Left = 174
        Top = 199
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 18
        OnClick = CheckBox1Click
      end
      object CheckBox12: TCheckBox
        Tag = 12
        Left = 204
        Top = 199
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 19
        OnClick = CheckBox1Click
      end
      object Edit6: TEdit
        Left = 250
        Top = 196
        Width = 374
        Height = 22
        TabOrder = 20
      end
      object CheckBox15: TCheckBox
        Tag = 15
        Left = 174
        Top = 227
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 21
        OnClick = CheckBox1Click
      end
      object CheckBox16: TCheckBox
        Tag = 16
        Left = 204
        Top = 227
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 22
        OnClick = CheckBox1Click
      end
      object Edit8: TEdit
        Left = 250
        Top = 224
        Width = 374
        Height = 22
        TabOrder = 23
      end
      object CheckBox13: TCheckBox
        Tag = 13
        Left = 174
        Top = 255
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 24
        OnClick = CheckBox1Click
      end
      object CheckBox14: TCheckBox
        Tag = 14
        Left = 204
        Top = 255
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 25
        OnClick = CheckBox1Click
      end
      object Edit7: TEdit
        Left = 250
        Top = 252
        Width = 374
        Height = 22
        TabOrder = 26
      end
      object CheckBox17: TCheckBox
        Tag = 17
        Left = 174
        Top = 283
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 27
        OnClick = CheckBox1Click
      end
      object CheckBox18: TCheckBox
        Tag = 18
        Left = 204
        Top = 283
        Width = 17
        Height = 17
        Hint = 'NEG'
        TabOrder = 28
        OnClick = CheckBox1Click
      end
      object Edit9: TEdit
        Left = 250
        Top = 280
        Width = 374
        Height = 22
        TabOrder = 29
      end
      object CheckBox19: TCheckBox
        Tag = 19
        Left = 174
        Top = 311
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 30
        OnClick = CheckBox1Click
      end
      object CheckBox20: TCheckBox
        Tag = 20
        Left = 204
        Top = 311
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 31
        OnClick = CheckBox1Click
      end
      object Edit10: TEdit
        Left = 250
        Top = 308
        Width = 374
        Height = 22
        TabOrder = 32
      end
      object CheckBox21: TCheckBox
        Tag = 21
        Left = 174
        Top = 339
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 33
        OnClick = CheckBox1Click
      end
      object CheckBox22: TCheckBox
        Tag = 22
        Left = 204
        Top = 339
        Width = 17
        Height = 17
        Hint = 'NEG'
        TabOrder = 34
        OnClick = CheckBox1Click
      end
      object Edit11: TEdit
        Left = 250
        Top = 336
        Width = 374
        Height = 22
        TabOrder = 35
      end
      object CheckBox998: TCheckBox
        Tag = 998
        Left = 18
        Top = 51
        Width = 55
        Height = 17
        Hint = 'Type I'
        Caption = 'Type I'
        Enabled = False
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object CheckBox999: TCheckBox
        Tag = 999
        Left = 79
        Top = 51
        Width = 56
        Height = 17
        Hint = 'Type II'
        Caption = 'Type II'
        Enabled = False
        TabOrder = 5
        OnClick = CheckBox1Click
      end
      object Edit24: TEdit
        Left = 250
        Top = 364
        Width = 374
        Height = 22
        TabOrder = 38
      end
      object Edit25: TEdit
        Left = 250
        Top = 392
        Width = 374
        Height = 22
        TabOrder = 41
      end
      object CheckBox23: TCheckBox
        Tag = 23
        Left = 174
        Top = 367
        Width = 19
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 36
        OnClick = CheckBox1Click
      end
      object CheckBox24: TCheckBox
        Tag = 24
        Left = 204
        Top = 367
        Width = 27
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 37
        OnClick = CheckBox1Click
      end
      object CheckBox25: TCheckBox
        Tag = 25
        Left = 174
        Top = 395
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 39
        OnClick = CheckBox1Click
      end
      object CheckBox26: TCheckBox
        Tag = 26
        Left = 204
        Top = 395
        Width = 21
        Height = 17
        Hint = 'NEG'
        TabOrder = 40
        OnClick = CheckBox1Click
      end
      object CheckBox997: TCheckBox
        Tag = 997
        Left = 141
        Top = 51
        Width = 86
        Height = 17
        Caption = 'Gestational'
        Enabled = False
        TabOrder = 3
      end
      object memNarrative: TMemo
        Left = 11
        Top = 447
        Width = 614
        Height = 113
        ScrollBars = ssVertical
        TabOrder = 42
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Page2'
      ImageIndex = 1
      object Label16: TLabel
        Left = 10
        Top = 34
        Width = 106
        Height = 14
        Caption = 'Dermatologic Disorder'
      end
      object Label17: TLabel
        Left = 184
        Top = 5
        Width = 21
        Height = 14
        Caption = 'POS'
      end
      object Label18: TLabel
        Left = 216
        Top = 5
        Width = 21
        Height = 14
        Caption = 'NEG'
      end
      object Label20: TLabel
        Left = 10
        Top = 145
        Width = 84
        Height = 14
        Caption = 'D (Rh) Sensitized'
      end
      object Label22: TLabel
        Left = 10
        Top = 201
        Width = 89
        Height = 14
        Caption = 'Seasonal Allergies'
      end
      object Label27: TLabel
        Left = 11
        Top = 257
        Width = 217
        Height = 14
        Caption = 'History of Abnormal PAP'
        Color = clBtnFace
        Constraints.MinWidth = 217
        ParentColor = False
        Transparent = True
      end
      object Label29: TLabel
        Left = 252
        Top = 5
        Width = 212
        Height = 14
        Caption = 'COMMENTS - To include Date and Treatment'
      end
      object Label19: TLabel
        Left = 10
        Top = 58
        Width = 287
        Height = 22
        AutoSize = False
        Caption = 'History of Blood Transfusion'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label21: TLabel
        Left = 10
        Top = 170
        Width = 271
        Height = 22
        AutoSize = False
        Caption = 'Pulmonary (TB/Asthma)'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label23: TLabel
        Left = 10
        Top = 226
        Width = 258
        Height = 22
        AutoSize = False
        Caption = 'Breast Disease'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label26: TLabel
        Left = 10
        Top = 282
        Width = 271
        Height = 22
        AutoSize = False
        Caption = 'Uterine Anomaly/DES'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object SpeedButton1: TSpeedButton
        Tag = 2
        Left = 605
        Top = 252
        Width = 25
        Height = 25
        Hint = 'Pick Date From Calendar'
        Enabled = False
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
        OnClick = LastPAPDate
      end
      object Label24: TLabel
        Left = 10
        Top = 313
        Width = 81
        Height = 14
        Caption = 'Trauma/Violence'
      end
      object Label25: TLabel
        Left = 10
        Top = 338
        Width = 258
        Height = 22
        AutoSize = False
        Caption = 'Broken Bone/Concussion'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label28: TLabel
        Left = 11
        Top = 369
        Width = 137
        Height = 14
        Caption = 'Infertility Problems/Concerns'
      end
      object Label32: TLabel
        Left = 10
        Top = 89
        Width = 99
        Height = 14
        Caption = 'Bleeding Tendencies'
      end
      object Label33: TLabel
        Left = 10
        Top = 114
        Width = 258
        Height = 22
        AutoSize = False
        Caption = 'GI: Ulcers/Colitis/Reflux'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label34: TLabel
        Left = 10
        Top = 394
        Width = 287
        Height = 22
        AutoSize = False
        Caption = 'Used Reproductive Technologies?'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object CheckBox27: TCheckBox
        Tag = 27
        Left = 184
        Top = 34
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object CheckBox28: TCheckBox
        Tag = 28
        Left = 216
        Top = 34
        Width = 17
        Height = 17
        Hint = 'NEG'
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object Edit12: TEdit
        Left = 252
        Top = 31
        Width = 378
        Height = 22
        TabOrder = 2
      end
      object CheckBox29: TCheckBox
        Tag = 29
        Left = 184
        Top = 61
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object CheckBox30: TCheckBox
        Tag = 30
        Left = 216
        Top = 61
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object Edit13: TEdit
        Left = 252
        Top = 58
        Width = 378
        Height = 22
        TabOrder = 5
      end
      object CheckBox31: TCheckBox
        Tag = 31
        Left = 184
        Top = 89
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 6
      end
      object CheckBox32: TCheckBox
        Tag = 32
        Left = 216
        Top = 89
        Width = 21
        Height = 17
        Hint = 'NEG'
        TabOrder = 7
      end
      object Edit26: TEdit
        Left = 252
        Top = 86
        Width = 378
        Height = 22
        TabOrder = 8
      end
      object CheckBox33: TCheckBox
        Tag = 33
        Left = 184
        Top = 117
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 9
      end
      object CheckBox34: TCheckBox
        Tag = 34
        Left = 216
        Top = 117
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 10
      end
      object Edit27: TEdit
        Left = 252
        Top = 114
        Width = 378
        Height = 22
        TabOrder = 11
      end
      object CheckBox35: TCheckBox
        Tag = 35
        Left = 184
        Top = 145
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 12
        OnClick = CheckBox1Click
      end
      object CheckBox36: TCheckBox
        Tag = 36
        Left = 216
        Top = 145
        Width = 17
        Height = 17
        Hint = 'NEG'
        TabOrder = 13
        OnClick = CheckBox1Click
      end
      object Edit14: TEdit
        Left = 252
        Top = 142
        Width = 378
        Height = 22
        TabOrder = 14
      end
      object CheckBox37: TCheckBox
        Tag = 37
        Left = 184
        Top = 173
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 15
        OnClick = CheckBox1Click
      end
      object CheckBox38: TCheckBox
        Tag = 38
        Left = 216
        Top = 173
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 16
        OnClick = CheckBox1Click
      end
      object Edit15: TEdit
        Left = 252
        Top = 170
        Width = 378
        Height = 22
        TabOrder = 17
      end
      object CheckBox39: TCheckBox
        Tag = 39
        Left = 184
        Top = 201
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 18
        OnClick = CheckBox1Click
      end
      object CheckBox40: TCheckBox
        Tag = 40
        Left = 216
        Top = 201
        Width = 17
        Height = 17
        Hint = 'NEG'
        TabOrder = 19
        OnClick = CheckBox1Click
      end
      object Edit16: TEdit
        Left = 252
        Top = 198
        Width = 378
        Height = 22
        TabOrder = 20
      end
      object CheckBox41: TCheckBox
        Tag = 41
        Left = 184
        Top = 229
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 21
        OnClick = CheckBox1Click
      end
      object CheckBox42: TCheckBox
        Tag = 42
        Left = 216
        Top = 229
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 22
        OnClick = CheckBox1Click
      end
      object Edit17: TEdit
        Left = 252
        Top = 226
        Width = 378
        Height = 22
        TabOrder = 23
      end
      object CheckBox43: TCheckBox
        Tag = 43
        Left = 184
        Top = 257
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 24
        OnClick = CheckBox1Click
      end
      object CheckBox44: TCheckBox
        Tag = 44
        Left = 216
        Top = 257
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 25
        OnClick = CheckBox1Click
      end
      object Edit21: TEdit
        Left = 252
        Top = 254
        Width = 150
        Height = 22
        Enabled = False
        TabOrder = 26
      end
      object LabeledEdit2: TLabeledEdit
        Left = 493
        Top = 254
        Width = 106
        Height = 22
        EditLabel.Width = 81
        EditLabel.Height = 14
        EditLabel.Caption = 'Date of Last PAP'
        Enabled = False
        LabelPosition = lpLeft
        TabOrder = 27
      end
      object CheckBox45: TCheckBox
        Tag = 45
        Left = 184
        Top = 285
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 28
        OnClick = CheckBox1Click
      end
      object CheckBox46: TCheckBox
        Tag = 46
        Left = 216
        Top = 285
        Width = 17
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 29
        OnClick = CheckBox1Click
      end
      object Edit22: TEdit
        Left = 252
        Top = 282
        Width = 378
        Height = 22
        TabOrder = 30
      end
      object CheckBox47: TCheckBox
        Tag = 47
        Left = 184
        Top = 313
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 31
      end
      object CheckBox48: TCheckBox
        Tag = 48
        Left = 216
        Top = 313
        Width = 21
        Height = 17
        Hint = 'NEG'
        TabOrder = 32
      end
      object Edit19: TEdit
        Left = 252
        Top = 310
        Width = 378
        Height = 22
        TabOrder = 33
      end
      object CheckBox49: TCheckBox
        Tag = 49
        Left = 184
        Top = 341
        Width = 21
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 34
      end
      object CheckBox50: TCheckBox
        Tag = 50
        Left = 216
        Top = 341
        Width = 21
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 35
      end
      object Edit20: TEdit
        Left = 252
        Top = 338
        Width = 378
        Height = 22
        TabOrder = 36
      end
      object CheckBox51: TCheckBox
        Tag = 51
        Left = 184
        Top = 369
        Width = 21
        Height = 17
        Hint = 'POS'
        TabOrder = 37
      end
      object CheckBox52: TCheckBox
        Tag = 52
        Left = 216
        Top = 369
        Width = 21
        Height = 17
        Hint = 'NEG'
        TabOrder = 38
      end
      object Edit23: TEdit
        Left = 252
        Top = 366
        Width = 378
        Height = 22
        TabOrder = 39
      end
      object CheckBox53: TCheckBox
        Tag = 53
        Left = 184
        Top = 397
        Width = 23
        Height = 17
        Hint = 'POS'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 40
      end
      object CheckBox54: TCheckBox
        Tag = 54
        Left = 216
        Top = 397
        Width = 19
        Height = 17
        Hint = 'NEG'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 41
      end
      object Edit28: TEdit
        Left = 252
        Top = 394
        Width = 378
        Height = 22
        TabOrder = 42
      end
      object LabeledEdit1: TLabeledEdit
        Left = 49
        Top = 422
        Width = 581
        Height = 22
        EditLabel.Width = 30
        EditLabel.Height = 14
        EditLabel.Caption = 'Other:'
        LabelPosition = lpLeft
        TabOrder = 43
      end
    end
  end
end
