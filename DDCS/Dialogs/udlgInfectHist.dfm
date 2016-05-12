object dlgInfectHist: TdlgInfectHist
  Left = 252
  Top = 137
  BorderStyle = bsDialog
  Caption = 'Infection History'
  ClientHeight = 394
  ClientWidth = 797
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
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 365
    Width = 797
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object bbtnOK: TBitBtn
      Left = 640
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 721
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object pnlbody: TPanel
    Left = 0
    Top = 35
    Width = 797
    Height = 330
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TStaticText
      Tag = 1
      Left = 11
      Top = 9
      Width = 258
      Height = 18
      Caption = 'Live with someone with TB or exposed to TB?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      TabStop = True
    end
    object Label3: TStaticText
      Left = 38
      Top = 62
      Width = 4
      Height = 4
      TabOrder = 65
    end
    object Label4: TStaticText
      Tag = 4
      Left = 11
      Top = 81
      Width = 193
      Height = 18
      Caption = 'Rash since last menstrual period?'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 15
      TabStop = True
    end
    object CheckBox2: TCheckBox
      Tag = 1
      Left = 276
      Top = 9
      Width = 46
      Height = 17
      Caption = 'Yes'
      TabOrder = 1
      OnClick = CheckBoxClick
    end
    object CheckBox3: TCheckBox
      Tag = 1
      Left = 324
      Top = 9
      Width = 37
      Height = 17
      Caption = 'No'
      TabOrder = 2
      OnClick = CheckBoxClick
    end
    object CheckBox4: TCheckBox
      Tag = 2
      Left = 276
      Top = 33
      Width = 46
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 6
      OnClick = CheckBoxClick
    end
    object CheckBox5: TCheckBox
      Tag = 2
      Left = 324
      Top = 33
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 7
      OnClick = CheckBoxClick
    end
    object CheckBox8: TCheckBox
      Tag = 3
      Left = 276
      Top = 57
      Width = 46
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 11
      OnClick = CheckBoxClick
    end
    object CheckBox9: TCheckBox
      Tag = 3
      Left = 324
      Top = 57
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 12
      OnClick = CheckBoxClick
    end
    object CheckBox10: TCheckBox
      Tag = 4
      Left = 276
      Top = 81
      Width = 46
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 16
      OnClick = CheckBoxClick
    end
    object CheckBox11: TCheckBox
      Tag = 4
      Left = 324
      Top = 81
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 17
      OnClick = CheckBoxClick
    end
    object CheckBox6: TCheckBox
      Tag = 4
      Left = 366
      Top = 81
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 18
      OnClick = CheckBoxClick
    end
    object CheckBox7: TCheckBox
      Tag = 3
      Left = 366
      Top = 57
      Width = 77
      Height = 17
      Caption = 'Not Known'
      TabOrder = 13
      OnClick = CheckBoxClick
    end
    object CheckBox12: TCheckBox
      Tag = 2
      Left = 366
      Top = 33
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 8
      OnClick = CheckBoxClick
    end
    object CheckBox13: TCheckBox
      Tag = 1
      Left = 366
      Top = 9
      Width = 77
      Height = 17
      Caption = 'Not Known'
      TabOrder = 3
      OnClick = CheckBoxClick
    end
    object CheckBox14: TCheckBox
      Tag = 5
      Left = 276
      Top = 105
      Width = 45
      Height = 17
      Caption = 'Yes'
      TabOrder = 21
      OnClick = CheckBoxClick
    end
    object CheckBox15: TCheckBox
      Tag = 5
      Left = 324
      Top = 105
      Width = 37
      Height = 17
      Caption = 'No'
      TabOrder = 22
      OnClick = CheckBoxClick
    end
    object CheckBox16: TCheckBox
      Tag = 5
      Left = 366
      Top = 105
      Width = 79
      Height = 17
      Caption = 'Not Known'
      TabOrder = 23
      OnClick = CheckBoxClick
    end
    object CheckBox17: TCheckBox
      Tag = 6
      Left = 276
      Top = 129
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 26
      OnClick = CheckBoxClick
    end
    object CheckBox18: TCheckBox
      Tag = 6
      Left = 324
      Top = 129
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 27
      OnClick = CheckBoxClick
    end
    object CheckBox19: TCheckBox
      Tag = 6
      Left = 366
      Top = 129
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 28
      OnClick = CheckBoxClick
    end
    object CheckBox20: TCheckBox
      Tag = 7
      Left = 276
      Top = 153
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 31
      OnClick = CheckBoxClick
    end
    object CheckBox21: TCheckBox
      Tag = 8
      Left = 276
      Top = 177
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 36
      OnClick = CheckBoxClick
    end
    object CheckBox22: TCheckBox
      Tag = 7
      Left = 324
      Top = 153
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 32
      OnClick = CheckBoxClick
    end
    object CheckBox23: TCheckBox
      Tag = 8
      Left = 324
      Top = 177
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 37
      OnClick = CheckBoxClick
    end
    object CheckBox24: TCheckBox
      Tag = 21
      Left = 366
      Top = 153
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 33
      OnClick = CheckBoxClick
    end
    object CheckBox25: TCheckBox
      Tag = 8
      Left = 366
      Top = 177
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 38
      OnClick = CheckBoxClick
    end
    object StaticText1: TStaticText
      Tag = 2
      Left = 11
      Top = 33
      Width = 141
      Height = 18
      Caption = 'History of Genital Herpes'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      TabStop = True
    end
    object StaticText2: TStaticText
      Tag = 3
      Left = 11
      Top = 57
      Width = 156
      Height = 18
      Caption = 'Exposed to Genital Herpes?'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 10
      TabStop = True
    end
    object StaticText3: TStaticText
      Tag = 5
      Left = 11
      Top = 105
      Width = 231
      Height = 18
      Caption = 'Viral illness since last menstrual period?'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 20
      TabStop = True
    end
    object StaticText4: TStaticText
      Tag = 6
      Left = 11
      Top = 129
      Width = 62
      Height = 18
      Caption = 'Hepatitis B'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 25
      TabStop = True
    end
    object StaticText5: TStaticText
      Tag = 7
      Left = 11
      Top = 153
      Width = 63
      Height = 18
      Caption = 'Hepatitis C'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 30
      TabStop = True
    end
    object StaticText6: TStaticText
      Tag = 8
      Left = 11
      Top = 177
      Width = 81
      Height = 18
      Caption = 'History of STD'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 35
      TabStop = True
    end
    object StaticText7: TStaticText
      Tag = 9
      Left = 11
      Top = 201
      Width = 119
      Height = 18
      Caption = 'History of Gonorrhea'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 40
      TabStop = True
    end
    object StaticText8: TStaticText
      Tag = 10
      Left = 11
      Top = 225
      Width = 117
      Height = 18
      Caption = 'History of Chlamydia'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 45
      TabStop = True
    end
    object StaticText9: TStaticText
      Tag = 11
      Left = 11
      Top = 249
      Width = 82
      Height = 18
      Caption = 'History of HPV'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 50
      TabStop = True
    end
    object StaticText10: TStaticText
      Tag = 12
      Left = 11
      Top = 273
      Width = 78
      Height = 18
      Caption = 'History of HIV'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 55
      TabStop = True
    end
    object StaticText11: TStaticText
      Tag = 13
      Left = 11
      Top = 297
      Width = 103
      Height = 18
      Caption = 'History of Syphilis'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 60
      TabStop = True
    end
    object CheckBox1: TCheckBox
      Tag = 9
      Left = 276
      Top = 201
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 41
      OnClick = CheckBoxClick
    end
    object CheckBox26: TCheckBox
      Tag = 10
      Left = 276
      Top = 225
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 46
      OnClick = CheckBoxClick
    end
    object CheckBox27: TCheckBox
      Tag = 11
      Left = 276
      Top = 249
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 51
      OnClick = CheckBoxClick
    end
    object CheckBox28: TCheckBox
      Tag = 12
      Left = 276
      Top = 273
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 56
      OnClick = CheckBoxClick
    end
    object CheckBox29: TCheckBox
      Tag = 13
      Left = 276
      Top = 297
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 61
      OnClick = CheckBoxClick
    end
    object CheckBox30: TCheckBox
      Tag = 9
      Left = 324
      Top = 201
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 42
      OnClick = CheckBoxClick
    end
    object CheckBox31: TCheckBox
      Tag = 10
      Left = 324
      Top = 225
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 47
      OnClick = CheckBoxClick
    end
    object CheckBox32: TCheckBox
      Tag = 11
      Left = 324
      Top = 249
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 52
      OnClick = CheckBoxClick
    end
    object CheckBox33: TCheckBox
      Tag = 12
      Left = 324
      Top = 273
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 57
      OnClick = CheckBoxClick
    end
    object CheckBox34: TCheckBox
      Tag = 13
      Left = 324
      Top = 297
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 62
      OnClick = CheckBoxClick
    end
    object CheckBox35: TCheckBox
      Tag = 9
      Left = 366
      Top = 201
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 43
      OnClick = CheckBoxClick
    end
    object CheckBox36: TCheckBox
      Tag = 10
      Left = 366
      Top = 225
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 48
      OnClick = CheckBoxClick
    end
    object CheckBox37: TCheckBox
      Tag = 11
      Left = 366
      Top = 249
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 53
      OnClick = CheckBoxClick
    end
    object CheckBox38: TCheckBox
      Tag = 12
      Left = 366
      Top = 273
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 58
      OnClick = CheckBoxClick
    end
    object CheckBox39: TCheckBox
      Tag = 13
      Left = 366
      Top = 297
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 63
      OnClick = CheckBoxClick
    end
    object CaptionEdit1: TCaptionEdit
      Tag = 1
      Left = 449
      Top = 6
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 4
      Caption = 'Live with someone with TB or exposed to TB narrative'
    end
    object CaptionEdit2: TCaptionEdit
      Tag = 2
      Left = 449
      Top = 30
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 9
      Caption = 'History of Genital Herpes narrative'
    end
    object CaptionEdit3: TCaptionEdit
      Tag = 3
      Left = 449
      Top = 54
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 14
      Caption = 'Exposed to Genital Herpes narrative'
    end
    object CaptionEdit4: TCaptionEdit
      Tag = 4
      Left = 449
      Top = 78
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 19
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit5: TCaptionEdit
      Tag = 5
      Left = 449
      Top = 102
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 24
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit6: TCaptionEdit
      Tag = 7
      Left = 449
      Top = 150
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 34
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit7: TCaptionEdit
      Tag = 6
      Left = 449
      Top = 126
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 29
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit8: TCaptionEdit
      Tag = 8
      Left = 449
      Top = 174
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 39
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit9: TCaptionEdit
      Tag = 9
      Left = 449
      Top = 198
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 44
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit10: TCaptionEdit
      Tag = 10
      Left = 449
      Top = 221
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 49
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit11: TCaptionEdit
      Tag = 11
      Left = 449
      Top = 246
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 54
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit12: TCaptionEdit
      Tag = 12
      Left = 449
      Top = 270
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 59
      Caption = 'Rash since last menstrual period narrative'
    end
    object CaptionEdit13: TCaptionEdit
      Tag = 13
      Left = 449
      Top = 294
      Width = 337
      Height = 22
      Enabled = False
      TabOrder = 64
      Caption = 'Rash since last menstrual period narrative'
    end
  end
  object pnlheader: TPanel
    Left = 0
    Top = 0
    Width = 797
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    object ckNotInfectionHistory: TCheckBox
      Left = 11
      Top = 12
      Width = 138
      Height = 17
      Caption = 'No History of Infection'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 0
      OnClick = ckNotInfectionHistoryClick
    end
  end
end
