object dlgInfectHist: TdlgInfectHist
  Left = 252
  Top = 137
  BorderStyle = bsDialog
  ClientHeight = 466
  ClientWidth = 493
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 493
    Height = 33
    Align = alTop
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 3
    object lbltitle: TLabel
      Left = 4
      Top = 4
      Width = 133
      Height = 20
      Caption = 'Infection History'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clGray
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      OnDblClick = bbtnOKClick
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 437
    Width = 493
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object bbtnOK: TBitBtn
      Left = 335
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 416
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 50
    Width = 138
    Height = 17
    Caption = 'No history of infection'
    Color = clMoneyGreen
    ParentColor = False
    TabOrder = 0
    OnClick = CheckBox1Click
  end
  object Panel3: TPanel
    Left = 8
    Top = 74
    Width = 481
    Height = 359
    BevelOuter = bvNone
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 9
      Width = 170
      Height = 14
      Caption = 'Live with someone exposed to TB?'
    end
    object Label2: TLabel
      Left = 16
      Top = 31
      Width = 441
      Height = 21
      AutoSize = False
      Caption = 'Patient or Partner has history of Genital Herpes?'
      Color = clMoneyGreen
      Constraints.MinWidth = 331
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object Label3: TLabel
      Left = 38
      Top = 62
      Width = 3
      Height = 14
    end
    object Label4: TLabel
      Left = 16
      Top = 60
      Width = 234
      Height = 14
      Caption = 'Rash or Viral Illness since last Menstrual Period?'
      Color = clBtnFace
      ParentColor = False
    end
    object Label5: TLabel
      Left = 16
      Top = 83
      Width = 441
      Height = 21
      AutoSize = False
      Caption = 'STI: Gonorrhea, Chlamydia, HIV, HPV, Syphilis'
      Color = clMoneyGreen
      Constraints.MinWidth = 331
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object Label6: TLabel
      Left = 16
      Top = 255
      Width = 53
      Height = 14
      Caption = 'Comments:'
    end
    object Label7: TLabel
      Left = 16
      Top = 143
      Width = 121
      Height = 14
      Caption = 'Prior GBS-Infected child?'
    end
    object Label8: TLabel
      Left = 16
      Top = 168
      Width = 441
      Height = 21
      AutoSize = False
      Caption = 'Live in a house with cats (toxoplasmosis)?'
      Color = clMoneyGreen
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object Label9: TLabel
      Left = 16
      Top = 199
      Width = 141
      Height = 14
      Caption = 'Lived or stationed overseas?'
    end
    object Label10: TLabel
      Left = 16
      Top = 221
      Width = 441
      Height = 21
      AutoSize = False
      Caption = 'Born outside the US?'
      Color = clMoneyGreen
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object CheckBox2: TCheckBox
      Tag = 1
      Left = 284
      Top = 7
      Width = 46
      Height = 17
      Caption = 'Yes'
      TabOrder = 0
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Tag = 2
      Left = 335
      Top = 7
      Width = 37
      Height = 17
      Caption = 'No'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox4: TCheckBox
      Tag = 4
      Left = 284
      Top = 33
      Width = 46
      Height = 17
      Caption = 'Yes'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 3
      OnClick = CheckBox2Click
    end
    object CheckBox5: TCheckBox
      Tag = 5
      Left = 335
      Top = 33
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 4
      OnClick = CheckBox2Click
    end
    object CheckBox8: TCheckBox
      Tag = 7
      Left = 284
      Top = 58
      Width = 46
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 6
      OnClick = CheckBox2Click
    end
    object CheckBox9: TCheckBox
      Tag = 8
      Left = 335
      Top = 58
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 7
      OnClick = CheckBox2Click
    end
    object CheckBox10: TCheckBox
      Tag = 10
      Left = 284
      Top = 85
      Width = 46
      Height = 17
      Caption = 'Yes'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 9
      OnClick = CheckBox2Click
    end
    object CheckBox11: TCheckBox
      Tag = 11
      Left = 335
      Top = 85
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 10
      OnClick = CheckBox2Click
    end
    object LabeledEdit2: TLabeledEdit
      Left = 104
      Top = 110
      Width = 353
      Height = 22
      EditLabel.Width = 65
      EditLabel.Height = 14
      EditLabel.Caption = 'STI Comment:'
      LabelPosition = lpLeft
      TabOrder = 12
    end
    object CheckBox6: TCheckBox
      Tag = 12
      Left = 378
      Top = 85
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 11
      OnClick = CheckBox2Click
    end
    object CheckBox7: TCheckBox
      Tag = 9
      Left = 378
      Top = 58
      Width = 97
      Height = 17
      Caption = 'Not Known'
      TabOrder = 8
      OnClick = CheckBox2Click
    end
    object CheckBox12: TCheckBox
      Tag = 6
      Left = 378
      Top = 33
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 5
      OnClick = CheckBox2Click
    end
    object CheckBox13: TCheckBox
      Tag = 3
      Left = 378
      Top = 7
      Width = 97
      Height = 17
      Caption = 'Not Known'
      TabOrder = 2
      OnClick = CheckBox2Click
    end
    object memNarrative: TMemo
      Left = 16
      Top = 272
      Width = 441
      Height = 81
      ScrollBars = ssVertical
      TabOrder = 25
    end
    object CheckBox14: TCheckBox
      Tag = 13
      Left = 284
      Top = 141
      Width = 45
      Height = 17
      Caption = 'Yes'
      TabOrder = 13
      OnClick = CheckBox2Click
    end
    object CheckBox15: TCheckBox
      Tag = 14
      Left = 335
      Top = 141
      Width = 37
      Height = 17
      Caption = 'No'
      TabOrder = 14
      OnClick = CheckBox2Click
    end
    object CheckBox16: TCheckBox
      Tag = 15
      Left = 378
      Top = 141
      Width = 79
      Height = 17
      Caption = 'Not Known'
      TabOrder = 15
      OnClick = CheckBox2Click
    end
    object CheckBox17: TCheckBox
      Tag = 16
      Left = 284
      Top = 170
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 16
      OnClick = CheckBox2Click
    end
    object CheckBox18: TCheckBox
      Tag = 17
      Left = 335
      Top = 170
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 17
      OnClick = CheckBox2Click
    end
    object CheckBox19: TCheckBox
      Tag = 18
      Left = 378
      Top = 170
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 18
      OnClick = CheckBox2Click
    end
    object CheckBox20: TCheckBox
      Tag = 19
      Left = 284
      Top = 197
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 19
      OnClick = CheckBox2Click
    end
    object CheckBox21: TCheckBox
      Tag = 22
      Left = 284
      Top = 223
      Width = 45
      Height = 17
      Caption = 'Yes'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 22
      OnClick = CheckBox2Click
    end
    object CheckBox22: TCheckBox
      Tag = 20
      Left = 335
      Top = 197
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 20
      OnClick = CheckBox2Click
    end
    object CheckBox23: TCheckBox
      Tag = 23
      Left = 335
      Top = 223
      Width = 37
      Height = 17
      Caption = 'No'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 23
      OnClick = CheckBox2Click
    end
    object CheckBox24: TCheckBox
      Tag = 21
      Left = 378
      Top = 197
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 21
      OnClick = CheckBox2Click
    end
    object CheckBox25: TCheckBox
      Tag = 24
      Left = 378
      Top = 223
      Width = 79
      Height = 17
      Caption = 'Not Known'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 24
      OnClick = CheckBox2Click
    end
  end
end
