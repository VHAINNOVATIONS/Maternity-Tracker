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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
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
    TabOrder = 2
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
      Left = 2
      Top = 2
      Width = 96
      Height = 25
      Caption = 'Normal for all'
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
  object PageControl1: TPageControl
    Left = 0
    Top = 33
    Width = 639
    Height = 527
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Page1'
      object Label13: TLabel
        Left = 19
        Top = 61
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Psych'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label20: TLabel
        Left = 19
        Top = 439
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Ears'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label19: TLabel
        Left = 19
        Top = 469
        Width = 64
        Height = 13
        Caption = 'Lymph Nodes'
      end
      object Label18: TLabel
        Left = 19
        Top = 385
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Integumentary'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label17: TLabel
        Left = 19
        Top = 415
        Width = 53
        Height = 13
        Caption = 'Extremities'
      end
      object Label29: TLabel
        Left = 262
        Top = 13
        Width = 214
        Height = 13
        Caption = 'COMMENTS - To include Date and Treatment'
      end
      object Label1: TLabel
        Left = 19
        Top = 37
        Width = 37
        Height = 13
        Caption = 'General'
      end
      object Label2: TLabel
        Left = 19
        Top = 331
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Abdomen'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label3: TLabel
        Left = 19
        Top = 277
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Heart'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label4: TLabel
        Left = 19
        Top = 361
        Width = 74
        Height = 13
        Caption = 'Musculoskeletal'
      end
      object Label5: TLabel
        Left = 19
        Top = 115
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Fundi'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label6: TLabel
        Left = 19
        Top = 223
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Breasts'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label7: TLabel
        Left = 19
        Top = 307
        Width = 71
        Height = 13
        Caption = 'Cardiovascular'
      end
      object Label8: TLabel
        Left = 19
        Top = 253
        Width = 66
        Height = 13
        Caption = 'Thorax/Lungs'
      end
      object Label9: TLabel
        Left = 19
        Top = 169
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Endocrine'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label10: TLabel
        Left = 19
        Top = 145
        Width = 28
        Height = 13
        Caption = 'Teeth'
      end
      object Label11: TLabel
        Left = 19
        Top = 199
        Width = 23
        Height = 13
        Caption = 'Neck'
      end
      object Label12: TLabel
        Left = 19
        Top = 91
        Width = 30
        Height = 13
        Caption = 'Mouth'
      end
      object Label14: TLabel
        Left = 151
        Top = 13
        Width = 33
        Height = 13
        Caption = 'Normal'
      end
      object Label15: TLabel
        Left = 201
        Top = 13
        Width = 45
        Height = 13
        Caption = 'Abnormal'
      end
      object CheckBox36: TCheckBox
        Tag = 36
        Left = 212
        Top = 441
        Width = 25
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 46
        OnClick = CheckBox1Click
      end
      object CheckBox35: TCheckBox
        Tag = 35
        Left = 160
        Top = 441
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 45
        OnClick = CheckBox1Click
      end
      object Edit18: TEdit
        Left = 262
        Top = 439
        Width = 355
        Height = 21
        TabOrder = 47
      end
      object CheckBox34: TCheckBox
        Tag = 34
        Left = 212
        Top = 468
        Width = 25
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 49
        OnClick = CheckBox1Click
      end
      object CheckBox33: TCheckBox
        Tag = 33
        Left = 160
        Top = 468
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 48
        OnClick = CheckBox1Click
      end
      object CheckBox32: TCheckBox
        Tag = 32
        Left = 212
        Top = 387
        Width = 25
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 40
        OnClick = CheckBox1Click
      end
      object CheckBox31: TCheckBox
        Tag = 31
        Left = 160
        Top = 387
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 39
        OnClick = CheckBox1Click
      end
      object CheckBox30: TCheckBox
        Tag = 30
        Left = 212
        Top = 414
        Width = 25
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 43
        OnClick = CheckBox1Click
      end
      object CheckBox29: TCheckBox
        Tag = 29
        Left = 160
        Top = 414
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 42
        OnClick = CheckBox1Click
      end
      object Edit17: TEdit
        Left = 262
        Top = 466
        Width = 355
        Height = 21
        TabOrder = 50
      end
      object Edit16: TEdit
        Left = 262
        Top = 385
        Width = 355
        Height = 21
        TabOrder = 41
      end
      object Edit15: TEdit
        Left = 262
        Top = 412
        Width = 355
        Height = 21
        TabOrder = 44
      end
      object Edit1: TEdit
        Left = 262
        Top = 34
        Width = 355
        Height = 21
        TabOrder = 2
      end
      object Edit2: TEdit
        Left = 262
        Top = 61
        Width = 355
        Height = 21
        TabOrder = 5
      end
      object Edit3: TEdit
        Left = 262
        Top = 88
        Width = 355
        Height = 21
        TabOrder = 8
      end
      object Edit4: TEdit
        Left = 262
        Top = 115
        Width = 355
        Height = 21
        TabOrder = 11
      end
      object Edit5: TEdit
        Left = 262
        Top = 142
        Width = 355
        Height = 21
        TabOrder = 14
      end
      object Edit6: TEdit
        Left = 262
        Top = 169
        Width = 355
        Height = 21
        TabOrder = 17
      end
      object Edit7: TEdit
        Left = 262
        Top = 196
        Width = 355
        Height = 21
        TabOrder = 20
      end
      object Edit8: TEdit
        Left = 262
        Top = 223
        Width = 355
        Height = 21
        TabOrder = 23
      end
      object Edit9: TEdit
        Left = 262
        Top = 250
        Width = 355
        Height = 21
        TabOrder = 26
      end
      object Edit10: TEdit
        Left = 262
        Top = 277
        Width = 355
        Height = 21
        TabOrder = 29
      end
      object Edit11: TEdit
        Left = 262
        Top = 304
        Width = 355
        Height = 21
        TabOrder = 32
      end
      object Edit12: TEdit
        Left = 262
        Top = 331
        Width = 355
        Height = 21
        TabOrder = 35
      end
      object Edit13: TEdit
        Left = 262
        Top = 358
        Width = 355
        Height = 21
        TabOrder = 38
      end
      object CheckBox26: TCheckBox
        Tag = 26
        Left = 212
        Top = 360
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 37
        OnClick = CheckBox1Click
      end
      object CheckBox25: TCheckBox
        Tag = 25
        Left = 160
        Top = 360
        Width = 22
        Height = 17
        Hint = 'Normal'
        TabOrder = 36
        OnClick = CheckBox1Click
      end
      object CheckBox24: TCheckBox
        Tag = 24
        Left = 212
        Top = 333
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 34
        OnClick = CheckBox1Click
      end
      object CheckBox23: TCheckBox
        Tag = 23
        Left = 160
        Top = 333
        Width = 22
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 33
        OnClick = CheckBox1Click
      end
      object CheckBox22: TCheckBox
        Tag = 22
        Left = 212
        Top = 306
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 31
        OnClick = CheckBox1Click
      end
      object CheckBox21: TCheckBox
        Tag = 21
        Left = 160
        Top = 306
        Width = 22
        Height = 17
        Hint = 'Normal'
        TabOrder = 30
        OnClick = CheckBox1Click
      end
      object CheckBox20: TCheckBox
        Tag = 20
        Left = 212
        Top = 279
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 28
        OnClick = CheckBox1Click
      end
      object CheckBox19: TCheckBox
        Tag = 19
        Left = 160
        Top = 279
        Width = 22
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 27
        OnClick = CheckBox1Click
      end
      object CheckBox18: TCheckBox
        Tag = 18
        Left = 212
        Top = 252
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 25
        OnClick = CheckBox1Click
      end
      object CheckBox17: TCheckBox
        Tag = 17
        Left = 160
        Top = 252
        Width = 22
        Height = 17
        Hint = 'Normal'
        TabOrder = 24
        OnClick = CheckBox1Click
      end
      object CheckBox16: TCheckBox
        Tag = 16
        Left = 212
        Top = 225
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 22
        OnClick = CheckBox1Click
      end
      object CheckBox15: TCheckBox
        Tag = 15
        Left = 160
        Top = 225
        Width = 22
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 21
        OnClick = CheckBox1Click
      end
      object CheckBox14: TCheckBox
        Tag = 14
        Left = 212
        Top = 198
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 19
        OnClick = CheckBox1Click
      end
      object CheckBox13: TCheckBox
        Tag = 13
        Left = 160
        Top = 198
        Width = 22
        Height = 17
        Hint = 'Normal'
        TabOrder = 18
        OnClick = CheckBox1Click
      end
      object CheckBox12: TCheckBox
        Tag = 12
        Left = 212
        Top = 171
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 16
        OnClick = CheckBox1Click
      end
      object CheckBox11: TCheckBox
        Tag = 11
        Left = 160
        Top = 171
        Width = 22
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 15
        OnClick = CheckBox1Click
      end
      object CheckBox10: TCheckBox
        Tag = 10
        Left = 212
        Top = 144
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 13
        OnClick = CheckBox1Click
      end
      object CheckBox9: TCheckBox
        Tag = 9
        Left = 160
        Top = 144
        Width = 22
        Height = 17
        Hint = 'Normal'
        TabOrder = 12
        OnClick = CheckBox1Click
      end
      object CheckBox8: TCheckBox
        Tag = 8
        Left = 212
        Top = 117
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 10
        OnClick = CheckBox1Click
      end
      object CheckBox7: TCheckBox
        Tag = 7
        Left = 160
        Top = 117
        Width = 22
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 9
        OnClick = CheckBox1Click
      end
      object CheckBox6: TCheckBox
        Tag = 6
        Left = 212
        Top = 88
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 7
        OnClick = CheckBox1Click
      end
      object CheckBox5: TCheckBox
        Tag = 5
        Left = 160
        Top = 88
        Width = 22
        Height = 17
        Hint = 'Normal'
        TabOrder = 6
        OnClick = CheckBox1Click
      end
      object CheckBox4: TCheckBox
        Tag = 4
        Left = 212
        Top = 63
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object CheckBox3: TCheckBox
        Tag = 3
        Left = 160
        Top = 63
        Width = 22
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Tag = 2
        Left = 212
        Top = 36
        Width = 22
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object CheckBox1: TCheckBox
        Tag = 1
        Left = 160
        Top = 36
        Width = 23
        Height = 17
        Hint = 'Normal'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Page2'
      ImageIndex = 1
      object Label23: TLabel
        Left = 151
        Top = 13
        Width = 33
        Height = 13
        Caption = 'Normal'
      end
      object Label24: TLabel
        Left = 201
        Top = 13
        Width = 45
        Height = 13
        Caption = 'Abnormal'
      end
      object Label25: TLabel
        Left = 262
        Top = 13
        Width = 214
        Height = 13
        Caption = 'COMMENTS - To include Date and Treatment'
      end
      object Label22: TLabel
        Left = 19
        Top = 62
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Head'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label21: TLabel
        Left = 19
        Top = 37
        Width = 23
        Height = 13
        Caption = 'Eyes'
      end
      object Label26: TLabel
        Left = 19
        Top = 91
        Width = 158
        Height = 13
        Caption = 'Visible Implanted Medical Devices'
      end
      object Label27: TLabel
        Left = 19
        Top = 137
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Chest Wall'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label28: TLabel
        Left = 19
        Top = 169
        Width = 56
        Height = 13
        Caption = 'Respiratory'
      end
      object Label30: TLabel
        Left = 19
        Top = 195
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Vessels'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label31: TLabel
        Left = 20
        Top = 228
        Width = 50
        Height = 13
        Caption = 'Neurologic'
      end
      object Label32: TLabel
        Left = 19
        Top = 256
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Genitalia'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object Label33: TLabel
        Left = 20
        Top = 289
        Width = 36
        Height = 13
        Caption = 'Rectum'
      end
      object Label16: TLabel
        Left = 19
        Top = 317
        Width = 254
        Height = 21
        AutoSize = False
        Caption = 'Back'
        Color = clMoneyGreen
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object LabeledEdit1: TLabeledEdit
        Left = 49
        Top = 358
        Width = 568
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'Other'
        EditLabel.Color = clMoneyGreen
        EditLabel.ParentColor = False
        LabelPosition = lpLeft
        TabOrder = 30
      end
      object CheckBox37: TCheckBox
        Tag = 37
        Left = 160
        Top = 36
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object CheckBox38: TCheckBox
        Tag = 38
        Left = 212
        Top = 36
        Width = 25
        Height = 17
        Hint = 'Abnormal'
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object Edit19: TEdit
        Left = 262
        Top = 34
        Width = 355
        Height = 21
        TabOrder = 2
      end
      object Edit20: TEdit
        Left = 262
        Top = 62
        Width = 355
        Height = 21
        TabOrder = 5
      end
      object CheckBox39: TCheckBox
        Tag = 39
        Left = 160
        Top = 63
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object CheckBox40: TCheckBox
        Tag = 40
        Left = 212
        Top = 63
        Width = 25
        Height = 17
        Hint = 'Abnormal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object CheckBox41: TCheckBox
        Tag = 41
        Left = 160
        Top = 110
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 6
        OnClick = CheckBox1Click
      end
      object CheckBox42: TCheckBox
        Tag = 42
        Left = 212
        Top = 110
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 7
        OnClick = CheckBox1Click
      end
      object Edit21: TEdit
        Left = 262
        Top = 108
        Width = 355
        Height = 21
        TabOrder = 8
      end
      object Edit22: TEdit
        Left = 262
        Top = 137
        Width = 355
        Height = 21
        TabOrder = 11
      end
      object Edit23: TEdit
        Left = 262
        Top = 166
        Width = 355
        Height = 21
        TabOrder = 14
      end
      object Edit24: TEdit
        Left = 262
        Top = 195
        Width = 355
        Height = 21
        TabOrder = 17
      end
      object Edit25: TEdit
        Left = 262
        Top = 225
        Width = 355
        Height = 21
        TabOrder = 20
      end
      object Edit26: TEdit
        Left = 262
        Top = 256
        Width = 355
        Height = 21
        TabOrder = 23
      end
      object Edit27: TEdit
        Left = 262
        Top = 286
        Width = 355
        Height = 21
        TabOrder = 26
      end
      object CheckBox43: TCheckBox
        Tag = 43
        Left = 160
        Top = 139
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 9
        OnClick = CheckBox1Click
      end
      object CheckBox44: TCheckBox
        Tag = 44
        Left = 212
        Top = 139
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 10
        OnClick = CheckBox1Click
      end
      object CheckBox45: TCheckBox
        Tag = 45
        Left = 159
        Top = 168
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 12
        OnClick = CheckBox1Click
      end
      object CheckBox46: TCheckBox
        Tag = 46
        Left = 212
        Top = 168
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 13
        OnClick = CheckBox1Click
      end
      object CheckBox47: TCheckBox
        Tag = 47
        Left = 159
        Top = 197
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 15
        OnClick = CheckBox1Click
      end
      object CheckBox48: TCheckBox
        Tag = 48
        Left = 212
        Top = 197
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 16
        OnClick = CheckBox1Click
      end
      object CheckBox49: TCheckBox
        Tag = 49
        Left = 160
        Top = 227
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 18
        OnClick = CheckBox1Click
      end
      object CheckBox50: TCheckBox
        Tag = 50
        Left = 212
        Top = 227
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 19
        OnClick = CheckBox1Click
      end
      object CheckBox51: TCheckBox
        Tag = 51
        Left = 160
        Top = 258
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 21
        OnClick = CheckBox1Click
      end
      object CheckBox52: TCheckBox
        Tag = 52
        Left = 212
        Top = 258
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 22
        OnClick = CheckBox1Click
      end
      object CheckBox53: TCheckBox
        Tag = 53
        Left = 160
        Top = 288
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 24
        OnClick = CheckBox1Click
      end
      object CheckBox54: TCheckBox
        Tag = 54
        Left = 212
        Top = 288
        Width = 25
        Height = 17
        Hint = 'Normal'
        TabOrder = 25
        OnClick = CheckBox1Click
      end
      object Edit14: TEdit
        Left = 262
        Top = 317
        Width = 355
        Height = 21
        TabOrder = 29
      end
      object CheckBox55: TCheckBox
        Tag = 55
        Left = 159
        Top = 319
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 27
        OnClick = CheckBox1Click
      end
      object CheckBox56: TCheckBox
        Tag = 56
        Left = 212
        Top = 319
        Width = 25
        Height = 17
        Hint = 'Normal'
        Color = clMoneyGreen
        ParentColor = False
        TabOrder = 28
        OnClick = CheckBox1Click
      end
    end
  end
end
