object dlgInfectHist: TdlgInfectHist
  Left = 252
  Top = 137
  BorderStyle = bsDialog
  ClientHeight = 275
  ClientWidth = 494
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
    Width = 494
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
    Top = 246
    Width = 494
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
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
    TabOrder = 1
    OnClick = CheckBox1Click
  end
  object Panel3: TPanel
    Left = 8
    Top = 74
    Width = 481
    Height = 170
    BevelOuter = bvNone
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 7
      Width = 170
      Height = 14
      Caption = 'Live with someone exposed to TB?'
    end
    object Label2: TLabel
      Left = 16
      Top = 31
      Width = 441
      Height = 17
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
      Top = 57
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
      Height = 17
      AutoSize = False
      Caption = 'STI: Gonorrhea, Chlamydia, HIV, HPV, Syphilis'
      Color = clMoneyGreen
      Constraints.MinWidth = 331
      ParentColor = False
      Transparent = False
      Layout = tlCenter
    end
    object CheckBox2: TCheckBox
      Tag = 1
      Left = 356
      Top = 7
      Width = 46
      Height = 17
      Caption = 'YES'
      TabOrder = 0
      OnClick = CheckBox2Click
    end
    object CheckBox3: TCheckBox
      Tag = 2
      Left = 420
      Top = 7
      Width = 37
      Height = 17
      Caption = 'NO'
      TabOrder = 1
      OnClick = CheckBox2Click
    end
    object CheckBox4: TCheckBox
      Tag = 3
      Left = 356
      Top = 31
      Width = 46
      Height = 17
      Caption = 'YES'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 2
      OnClick = CheckBox2Click
    end
    object CheckBox5: TCheckBox
      Tag = 4
      Left = 420
      Top = 31
      Width = 37
      Height = 17
      Caption = 'NO'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 3
      OnClick = CheckBox2Click
    end
    object CheckBox8: TCheckBox
      Tag = 5
      Left = 356
      Top = 57
      Width = 46
      Height = 17
      Caption = 'YES'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 4
      OnClick = CheckBox2Click
    end
    object CheckBox9: TCheckBox
      Tag = 6
      Left = 420
      Top = 57
      Width = 37
      Height = 17
      Caption = 'NO'
      Color = clBtnFace
      ParentColor = False
      TabOrder = 5
      OnClick = CheckBox2Click
    end
    object CheckBox10: TCheckBox
      Tag = 7
      Left = 356
      Top = 83
      Width = 46
      Height = 17
      Caption = 'YES'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 6
      OnClick = CheckBox2Click
    end
    object CheckBox11: TCheckBox
      Tag = 8
      Left = 420
      Top = 83
      Width = 37
      Height = 17
      Caption = 'NO'
      Color = clMoneyGreen
      ParentColor = False
      TabOrder = 7
      OnClick = CheckBox2Click
    end
    object LabeledEdit1: TLabeledEdit
      Left = 56
      Top = 134
      Width = 401
      Height = 22
      EditLabel.Width = 37
      EditLabel.Height = 14
      EditLabel.Caption = 'OTHER:'
      LabelPosition = lpLeft
      TabOrder = 9
    end
    object LabeledEdit2: TLabeledEdit
      Left = 128
      Top = 106
      Width = 329
      Height = 22
      EditLabel.Width = 65
      EditLabel.Height = 14
      EditLabel.Caption = 'STI Comment:'
      LabelPosition = lpLeft
      TabOrder = 8
    end
  end
end
