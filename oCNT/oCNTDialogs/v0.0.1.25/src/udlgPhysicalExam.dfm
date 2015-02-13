object dlgPhysicalExam: TdlgPhysicalExam
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 589
  ClientWidth = 639
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label15: TLabel
    Left = 201
    Top = 51
    Width = 45
    Height = 13
    Caption = 'Abnormal'
  end
  object Label14: TLabel
    Left = 151
    Top = 51
    Width = 33
    Height = 13
    Caption = 'Normal'
  end
  object Label13: TLabel
    Left = 19
    Top = 99
    Width = 254
    Height = 21
    AutoSize = False
    Caption = 'Psych'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label12: TLabel
    Left = 19
    Top = 129
    Width = 32
    Height = 13
    Caption = 'HEENT'
  end
  object Label11: TLabel
    Left = 19
    Top = 237
    Width = 23
    Height = 13
    Caption = 'Neck'
  end
  object Label10: TLabel
    Left = 19
    Top = 183
    Width = 28
    Height = 13
    Caption = 'Teeth'
  end
  object Label9: TLabel
    Left = 19
    Top = 207
    Width = 254
    Height = 21
    AutoSize = False
    Caption = 'Thyroid'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label8: TLabel
    Left = 19
    Top = 291
    Width = 66
    Height = 13
    Caption = 'Thorax/Lungs'
  end
  object Label7: TLabel
    Left = 19
    Top = 345
    Width = 71
    Height = 13
    Caption = 'Cardiovascular'
  end
  object Label6: TLabel
    Left = 19
    Top = 261
    Width = 254
    Height = 21
    AutoSize = False
    Caption = 'Breasts'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label5: TLabel
    Left = 19
    Top = 153
    Width = 254
    Height = 21
    AutoSize = False
    Caption = 'Fundi'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 19
    Top = 399
    Width = 22
    Height = 13
    Caption = 'Back'
  end
  object Label3: TLabel
    Left = 19
    Top = 315
    Width = 254
    Height = 21
    AutoSize = False
    Caption = 'Heart'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label2: TLabel
    Left = 19
    Top = 369
    Width = 254
    Height = 21
    AutoSize = False
    Caption = 'Abdomen'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label1: TLabel
    Left = 19
    Top = 75
    Width = 37
    Height = 13
    Caption = 'General'
  end
  object Label29: TLabel
    Left = 262
    Top = 51
    Width = 214
    Height = 13
    Caption = 'COMMENTS - To include Date and Treatment'
  end
  object Label16: TLabel
    Left = 19
    Top = 423
    Width = 254
    Height = 21
    AutoSize = False
    Caption = 'Pelvic Exam'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label17: TLabel
    Left = 19
    Top = 453
    Width = 53
    Height = 13
    Caption = 'Extremities'
  end
  object Label18: TLabel
    Left = 19
    Top = 477
    Width = 254
    Height = 21
    AutoSize = False
    Caption = 'Skin'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label19: TLabel
    Left = 19
    Top = 507
    Width = 64
    Height = 13
    Caption = 'Lymph Nodes'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 639
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
      Width = 115
      Height = 20
      Caption = 'Physical Exam'
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
    Top = 560
    Width = 639
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 53
    object bbtnOK: TBitBtn
      Left = 481
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 562
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
      Left = 4
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
      OnClick = BitBtn1Click
    end
  end
  object CheckBox1: TCheckBox
    Tag = 1
    Left = 160
    Top = 74
    Width = 23
    Height = 17
    Hint = 'Normal'
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Tag = 2
    Left = 212
    Top = 74
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object CheckBox3: TCheckBox
    Tag = 3
    Left = 160
    Top = 101
    Width = 22
    Height = 17
    Hint = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object CheckBox4: TCheckBox
    Tag = 4
    Left = 212
    Top = 101
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 5
    OnClick = CheckBox1Click
  end
  object CheckBox5: TCheckBox
    Tag = 5
    Left = 160
    Top = 126
    Width = 22
    Height = 17
    Hint = 'Normal'
    TabOrder = 7
    OnClick = CheckBox1Click
  end
  object CheckBox6: TCheckBox
    Tag = 6
    Left = 212
    Top = 128
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 8
    OnClick = CheckBox1Click
  end
  object CheckBox7: TCheckBox
    Tag = 7
    Left = 160
    Top = 155
    Width = 22
    Height = 17
    Hint = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 10
    OnClick = CheckBox1Click
  end
  object CheckBox8: TCheckBox
    Tag = 8
    Left = 212
    Top = 155
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 11
    OnClick = CheckBox1Click
  end
  object CheckBox9: TCheckBox
    Tag = 9
    Left = 160
    Top = 182
    Width = 22
    Height = 17
    Hint = 'Normal'
    TabOrder = 13
    OnClick = CheckBox1Click
  end
  object CheckBox10: TCheckBox
    Tag = 10
    Left = 212
    Top = 182
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 14
    OnClick = CheckBox1Click
  end
  object CheckBox11: TCheckBox
    Tag = 11
    Left = 160
    Top = 209
    Width = 22
    Height = 17
    Hint = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 16
    OnClick = CheckBox1Click
  end
  object CheckBox12: TCheckBox
    Tag = 12
    Left = 212
    Top = 209
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 17
    OnClick = CheckBox1Click
  end
  object CheckBox13: TCheckBox
    Tag = 13
    Left = 160
    Top = 236
    Width = 22
    Height = 17
    Hint = 'Normal'
    TabOrder = 19
    OnClick = CheckBox1Click
  end
  object CheckBox14: TCheckBox
    Tag = 14
    Left = 212
    Top = 236
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 20
    OnClick = CheckBox1Click
  end
  object CheckBox15: TCheckBox
    Tag = 15
    Left = 160
    Top = 263
    Width = 22
    Height = 17
    Hint = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 22
    OnClick = CheckBox1Click
  end
  object CheckBox16: TCheckBox
    Tag = 16
    Left = 212
    Top = 263
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 23
    OnClick = CheckBox1Click
  end
  object CheckBox17: TCheckBox
    Tag = 17
    Left = 160
    Top = 290
    Width = 22
    Height = 17
    Hint = 'Normal'
    TabOrder = 25
    OnClick = CheckBox1Click
  end
  object CheckBox18: TCheckBox
    Tag = 18
    Left = 212
    Top = 290
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 26
    OnClick = CheckBox1Click
  end
  object CheckBox19: TCheckBox
    Tag = 19
    Left = 160
    Top = 317
    Width = 22
    Height = 17
    Hint = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 28
    OnClick = CheckBox1Click
  end
  object CheckBox20: TCheckBox
    Tag = 20
    Left = 212
    Top = 317
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 29
    OnClick = CheckBox1Click
  end
  object CheckBox21: TCheckBox
    Tag = 21
    Left = 160
    Top = 344
    Width = 22
    Height = 17
    Hint = 'Normal'
    TabOrder = 31
    OnClick = CheckBox1Click
  end
  object CheckBox22: TCheckBox
    Tag = 22
    Left = 212
    Top = 344
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 32
    OnClick = CheckBox1Click
  end
  object CheckBox23: TCheckBox
    Tag = 23
    Left = 160
    Top = 371
    Width = 22
    Height = 17
    Hint = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 34
    OnClick = CheckBox1Click
  end
  object CheckBox24: TCheckBox
    Tag = 24
    Left = 212
    Top = 371
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 35
    OnClick = CheckBox1Click
  end
  object CheckBox25: TCheckBox
    Tag = 25
    Left = 160
    Top = 398
    Width = 22
    Height = 17
    Hint = 'Normal'
    TabOrder = 37
    OnClick = CheckBox1Click
  end
  object CheckBox26: TCheckBox
    Tag = 26
    Left = 212
    Top = 398
    Width = 22
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 38
    OnClick = CheckBox1Click
  end
  object Edit13: TEdit
    Left = 262
    Top = 396
    Width = 355
    Height = 21
    TabOrder = 39
  end
  object Edit12: TEdit
    Left = 262
    Top = 369
    Width = 355
    Height = 21
    TabOrder = 36
  end
  object Edit11: TEdit
    Left = 262
    Top = 342
    Width = 355
    Height = 21
    TabOrder = 33
  end
  object Edit10: TEdit
    Left = 262
    Top = 315
    Width = 355
    Height = 21
    TabOrder = 30
  end
  object Edit9: TEdit
    Left = 262
    Top = 288
    Width = 355
    Height = 21
    TabOrder = 27
  end
  object Edit8: TEdit
    Left = 262
    Top = 261
    Width = 355
    Height = 21
    TabOrder = 24
  end
  object Edit7: TEdit
    Left = 262
    Top = 234
    Width = 355
    Height = 21
    TabOrder = 21
  end
  object Edit6: TEdit
    Left = 262
    Top = 207
    Width = 355
    Height = 21
    TabOrder = 18
  end
  object Edit5: TEdit
    Left = 262
    Top = 180
    Width = 355
    Height = 21
    TabOrder = 15
  end
  object Edit4: TEdit
    Left = 262
    Top = 153
    Width = 355
    Height = 21
    TabOrder = 12
  end
  object Edit3: TEdit
    Left = 262
    Top = 126
    Width = 355
    Height = 21
    TabOrder = 9
  end
  object Edit2: TEdit
    Left = 262
    Top = 99
    Width = 355
    Height = 21
    TabOrder = 6
  end
  object Edit1: TEdit
    Left = 262
    Top = 72
    Width = 355
    Height = 21
    TabOrder = 3
  end
  object LabeledEdit1: TLabeledEdit
    Left = 49
    Top = 531
    Width = 568
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Other'
    EditLabel.Color = clMoneyGreen
    EditLabel.ParentColor = False
    LabelPosition = lpLeft
    TabOrder = 52
  end
  object Edit14: TEdit
    Left = 262
    Top = 423
    Width = 355
    Height = 21
    TabOrder = 42
  end
  object Edit15: TEdit
    Left = 262
    Top = 450
    Width = 355
    Height = 21
    TabOrder = 45
  end
  object Edit16: TEdit
    Left = 262
    Top = 477
    Width = 355
    Height = 21
    TabOrder = 48
  end
  object Edit17: TEdit
    Left = 262
    Top = 504
    Width = 355
    Height = 21
    TabOrder = 51
  end
  object CheckBox27: TCheckBox
    Tag = 27
    Left = 160
    Top = 425
    Width = 25
    Height = 17
    Hint = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 40
    OnClick = CheckBox1Click
  end
  object CheckBox28: TCheckBox
    Tag = 28
    Left = 212
    Top = 425
    Width = 25
    Height = 17
    Hint = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 41
    OnClick = CheckBox1Click
  end
  object CheckBox29: TCheckBox
    Tag = 29
    Left = 160
    Top = 452
    Width = 25
    Height = 17
    Hint = 'Normal'
    TabOrder = 43
    OnClick = CheckBox1Click
  end
  object CheckBox30: TCheckBox
    Tag = 30
    Left = 212
    Top = 452
    Width = 25
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 44
    OnClick = CheckBox1Click
  end
  object CheckBox31: TCheckBox
    Tag = 31
    Left = 160
    Top = 479
    Width = 25
    Height = 17
    Hint = 'Normal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 46
    OnClick = CheckBox1Click
  end
  object CheckBox32: TCheckBox
    Tag = 32
    Left = 212
    Top = 479
    Width = 25
    Height = 17
    Hint = 'Abnormal'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 47
    OnClick = CheckBox1Click
  end
  object CheckBox33: TCheckBox
    Tag = 33
    Left = 160
    Top = 506
    Width = 25
    Height = 17
    Hint = 'Normal'
    TabOrder = 49
    OnClick = CheckBox1Click
  end
  object CheckBox34: TCheckBox
    Tag = 34
    Left = 212
    Top = 506
    Width = 25
    Height = 17
    Hint = 'Abnormal'
    TabOrder = 50
    OnClick = CheckBox1Click
  end
end
