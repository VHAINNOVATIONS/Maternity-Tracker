object dlgROS: TdlgROS
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  ClientHeight = 492
  ClientWidth = 640
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
  object Label1: TLabel
    Left = 19
    Top = 75
    Width = 26
    Height = 13
    Caption = 'Mood'
  end
  object Label2: TLabel
    Left = 19
    Top = 369
    Width = 294
    Height = 21
    HelpContext = 17
    AutoSize = False
    Caption = 'Skin Rash / Itch'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label3: TLabel
    Left = 19
    Top = 315
    Width = 294
    Height = 21
    AutoSize = False
    Caption = 'Bone or Joint Pain / Joint Swelling'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label4: TLabel
    Left = 19
    Top = 399
    Width = 112
    Height = 13
    Caption = 'Heat / Cold Intolerance'
  end
  object Label5: TLabel
    Left = 19
    Top = 153
    Width = 286
    Height = 21
    AutoSize = False
    Caption = 'Visual Changes'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label6: TLabel
    Left = 19
    Top = 261
    Width = 286
    Height = 21
    AutoSize = False
    Caption = 'GI Symptoms: Nausea / Vomiting'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label7: TLabel
    Left = 19
    Top = 345
    Width = 134
    Height = 13
    Caption = 'Vaginal Bleeding / Discharge'
  end
  object Label8: TLabel
    Left = 19
    Top = 291
    Width = 175
    Height = 13
    Caption = 'GU Symptoms: Burning / Pain / Blood'
  end
  object Label9: TLabel
    Left = 19
    Top = 207
    Width = 286
    Height = 21
    AutoSize = False
    Caption = 'Chest Pain / Palpitation'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label10: TLabel
    Left = 19
    Top = 183
    Width = 85
    Height = 13
    Caption = 'Ears/Nose/Throat'
  end
  object Label11: TLabel
    Left = 19
    Top = 237
    Width = 148
    Height = 13
    Caption = 'Dyspnea / Cough / Hemoptysis'
  end
  object Label12: TLabel
    Left = 19
    Top = 129
    Width = 160
    Height = 13
    Caption = 'Weight Loss (-) / Weight Gain (+)'
  end
  object Label13: TLabel
    Left = 19
    Top = 99
    Width = 318
    Height = 21
    AutoSize = False
    Caption = 'Headaches'
    Color = clMoneyGreen
    ParentColor = False
    Transparent = False
    Layout = tlCenter
  end
  object Label14: TLabel
    Left = 210
    Top = 51
    Width = 18
    Height = 13
    Caption = 'YES'
  end
  object Label15: TLabel
    Left = 258
    Top = 51
    Width = 15
    Height = 13
    Caption = 'NO'
  end
  object Label29: TLabel
    Left = 296
    Top = 51
    Width = 214
    Height = 13
    Caption = 'COMMENTS - To include Date and Treatment'
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 640
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
      Width = 219
      Height = 20
      Caption = 'ROS: Symptoms since LMP'
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
    Top = 463
    Width = 640
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 41
    object bbtnOK: TBitBtn
      Left = 482
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 563
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object BitBtn1: TBitBtn
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
      OnClick = BitBtn1Click
    end
  end
  object Edit1: TEdit
    Left = 296
    Top = 72
    Width = 321
    Height = 21
    TabOrder = 3
  end
  object Edit2: TEdit
    Left = 296
    Top = 99
    Width = 321
    Height = 21
    TabOrder = 6
  end
  object Edit3: TEdit
    Left = 296
    Top = 126
    Width = 321
    Height = 21
    TabOrder = 9
  end
  object Edit4: TEdit
    Left = 296
    Top = 153
    Width = 321
    Height = 21
    TabOrder = 12
  end
  object Edit5: TEdit
    Left = 296
    Top = 180
    Width = 321
    Height = 21
    TabOrder = 15
  end
  object Edit6: TEdit
    Left = 296
    Top = 207
    Width = 321
    Height = 21
    TabOrder = 18
  end
  object Edit7: TEdit
    Left = 296
    Top = 234
    Width = 321
    Height = 21
    TabOrder = 21
  end
  object Edit8: TEdit
    Left = 296
    Top = 261
    Width = 321
    Height = 21
    TabOrder = 24
  end
  object Edit9: TEdit
    Left = 296
    Top = 288
    Width = 321
    Height = 21
    TabOrder = 27
  end
  object Edit10: TEdit
    Left = 296
    Top = 315
    Width = 321
    Height = 21
    TabOrder = 30
  end
  object Edit11: TEdit
    Left = 296
    Top = 342
    Width = 321
    Height = 21
    TabOrder = 33
  end
  object Edit12: TEdit
    Left = 296
    Top = 369
    Width = 321
    Height = 21
    TabOrder = 36
  end
  object Edit13: TEdit
    Left = 296
    Top = 396
    Width = 321
    Height = 21
    TabOrder = 39
  end
  object CheckBox1: TCheckBox
    Tag = 1
    Left = 210
    Top = 74
    Width = 23
    Height = 17
    Hint = 'YES'
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object CheckBox2: TCheckBox
    Tag = 2
    Left = 258
    Top = 74
    Width = 22
    Height = 17
    Hint = 'NO'
    TabOrder = 2
    OnClick = CheckBox1Click
  end
  object CheckBox3: TCheckBox
    Tag = 3
    Left = 210
    Top = 101
    Width = 22
    Height = 17
    Hint = 'YES'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 4
    OnClick = CheckBox1Click
  end
  object CheckBox4: TCheckBox
    Tag = 4
    Left = 258
    Top = 101
    Width = 22
    Height = 17
    Hint = 'NO'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 5
    OnClick = CheckBox1Click
  end
  object CheckBox5: TCheckBox
    Tag = 5
    Left = 210
    Top = 128
    Width = 22
    Height = 17
    Hint = 'YES'
    TabOrder = 7
    OnClick = CheckBox1Click
  end
  object CheckBox6: TCheckBox
    Tag = 6
    Left = 258
    Top = 128
    Width = 22
    Height = 17
    Hint = 'NO'
    TabOrder = 8
    OnClick = CheckBox1Click
  end
  object CheckBox7: TCheckBox
    Tag = 7
    Left = 210
    Top = 155
    Width = 22
    Height = 17
    Hint = 'YES'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 10
    OnClick = CheckBox1Click
  end
  object CheckBox8: TCheckBox
    Tag = 8
    Left = 258
    Top = 155
    Width = 22
    Height = 17
    Hint = 'NO'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 11
    OnClick = CheckBox1Click
  end
  object CheckBox9: TCheckBox
    Tag = 9
    Left = 210
    Top = 182
    Width = 22
    Height = 17
    Hint = 'YES'
    TabOrder = 13
    OnClick = CheckBox1Click
  end
  object CheckBox10: TCheckBox
    Tag = 10
    Left = 258
    Top = 182
    Width = 22
    Height = 17
    Hint = 'NO'
    TabOrder = 14
    OnClick = CheckBox1Click
  end
  object CheckBox11: TCheckBox
    Tag = 11
    Left = 210
    Top = 209
    Width = 22
    Height = 17
    Hint = 'YES'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 16
    OnClick = CheckBox1Click
  end
  object CheckBox12: TCheckBox
    Tag = 12
    Left = 258
    Top = 209
    Width = 22
    Height = 17
    Hint = 'NO'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 17
    OnClick = CheckBox1Click
  end
  object CheckBox13: TCheckBox
    Tag = 13
    Left = 210
    Top = 236
    Width = 22
    Height = 17
    Hint = 'YES'
    TabOrder = 19
    OnClick = CheckBox1Click
  end
  object CheckBox14: TCheckBox
    Tag = 14
    Left = 258
    Top = 236
    Width = 22
    Height = 17
    Hint = 'NO'
    TabOrder = 20
    OnClick = CheckBox1Click
  end
  object CheckBox15: TCheckBox
    Tag = 15
    Left = 210
    Top = 263
    Width = 22
    Height = 17
    Hint = 'YES'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 22
    OnClick = CheckBox1Click
  end
  object CheckBox16: TCheckBox
    Tag = 16
    Left = 258
    Top = 263
    Width = 22
    Height = 17
    Hint = 'NO'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 23
    OnClick = CheckBox1Click
  end
  object CheckBox17: TCheckBox
    Tag = 17
    Left = 210
    Top = 290
    Width = 22
    Height = 17
    Hint = 'YES'
    TabOrder = 25
    OnClick = CheckBox1Click
  end
  object CheckBox18: TCheckBox
    Tag = 18
    Left = 258
    Top = 290
    Width = 22
    Height = 17
    Hint = 'NO'
    TabOrder = 26
    OnClick = CheckBox1Click
  end
  object CheckBox19: TCheckBox
    Tag = 19
    Left = 210
    Top = 317
    Width = 22
    Height = 17
    Hint = 'YES'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 28
    OnClick = CheckBox1Click
  end
  object CheckBox20: TCheckBox
    Tag = 20
    Left = 258
    Top = 317
    Width = 22
    Height = 17
    Hint = 'NO'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 29
    OnClick = CheckBox1Click
  end
  object CheckBox21: TCheckBox
    Tag = 21
    Left = 210
    Top = 344
    Width = 22
    Height = 17
    Hint = 'YES'
    TabOrder = 31
    OnClick = CheckBox1Click
  end
  object CheckBox22: TCheckBox
    Tag = 22
    Left = 258
    Top = 344
    Width = 22
    Height = 17
    Hint = 'NO'
    TabOrder = 32
    OnClick = CheckBox1Click
  end
  object CheckBox23: TCheckBox
    Tag = 23
    Left = 210
    Top = 371
    Width = 22
    Height = 17
    Hint = 'YES'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 34
    OnClick = CheckBox1Click
  end
  object CheckBox24: TCheckBox
    Tag = 24
    Left = 258
    Top = 371
    Width = 22
    Height = 17
    Hint = 'NO'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 35
    OnClick = CheckBox1Click
  end
  object CheckBox25: TCheckBox
    Tag = 25
    Left = 210
    Top = 398
    Width = 22
    Height = 17
    Hint = 'YES'
    TabOrder = 37
    OnClick = CheckBox1Click
  end
  object CheckBox26: TCheckBox
    Tag = 26
    Left = 258
    Top = 398
    Width = 22
    Height = 17
    Hint = 'NO'
    TabOrder = 38
    OnClick = CheckBox1Click
  end
  object LabeledEdit1: TLabeledEdit
    Left = 49
    Top = 432
    Width = 568
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Other'
    EditLabel.Color = clMoneyGreen
    EditLabel.ParentColor = False
    LabelPosition = lpLeft
    TabOrder = 40
  end
end
