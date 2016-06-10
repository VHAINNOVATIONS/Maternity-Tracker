object dlgROS: TdlgROS
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Review of Symptoms since Last Menstrual Period'
  ClientHeight = 389
  ClientWidth = 653
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbOther: TLabel
    Tag = 14
    Left = 16
    Top = 328
    Width = 32
    Height = 13
    Caption = 'Other'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTreatment: TLabel
    Left = 344
    Top = 8
    Width = 121
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Treatment Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbComment: TLabel
    Left = 471
    Top = 8
    Width = 167
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Comment'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object dtOther: TORDateBox
    Tag = 14
    Left = 344
    Top = 325
    Width = 121
    Height = 21
    TabOrder = 53
    DateOnly = False
    RequireTime = False
    Caption = 'Other treatment date'
  end
  object Edit1: TEdit
    Tag = 1
    Left = 471
    Top = 26
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object Edit10: TEdit
    Tag = 10
    Left = 471
    Top = 233
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 39
  end
  object Edit11: TEdit
    Tag = 11
    Left = 471
    Top = 256
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 43
  end
  object Edit12: TEdit
    Tag = 12
    Left = 471
    Top = 279
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 47
  end
  object Edit13: TEdit
    Tag = 13
    Left = 471
    Top = 302
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 51
  end
  object Edit2: TEdit
    Tag = 2
    Left = 471
    Top = 49
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object Edit3: TEdit
    Tag = 3
    Left = 471
    Top = 72
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 11
  end
  object Edit4: TEdit
    Tag = 4
    Left = 471
    Top = 95
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 15
  end
  object Edit5: TEdit
    Tag = 5
    Left = 471
    Top = 118
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 19
  end
  object Edit6: TEdit
    Tag = 6
    Left = 471
    Top = 141
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 23
  end
  object Edit7: TEdit
    Tag = 7
    Left = 471
    Top = 164
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 27
  end
  object Edit8: TEdit
    Tag = 8
    Left = 471
    Top = 187
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 31
  end
  object Edit9: TEdit
    Tag = 9
    Left = 471
    Top = 210
    Width = 167
    Height = 21
    Enabled = False
    TabOrder = 35
  end
  object edOtherComments: TEdit
    Tag = 14
    Left = 471
    Top = 325
    Width = 167
    Height = 21
    TabOrder = 54
  end
  object ORDateBox1: TORDateBox
    Tag = 1
    Left = 344
    Top = 26
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 2
    DateOnly = False
    RequireTime = False
    Caption = 'Mood treatment date'
  end
  object ORDateBox10: TORDateBox
    Tag = 10
    Left = 344
    Top = 233
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 38
    DateOnly = False
    RequireTime = False
    Caption = 'bone or joint pain or swelling treatment date'
  end
  object ORDateBox11: TORDateBox
    Tag = 11
    Left = 344
    Top = 256
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 42
    DateOnly = False
    RequireTime = False
    Caption = 'vaginal bleeding or discharge treatment date'
  end
  object ORDateBox12: TORDateBox
    Tag = 12
    Left = 344
    Top = 279
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 46
    DateOnly = False
    RequireTime = False
    Caption = 'Skin rash or itch treatment date'
  end
  object ORDateBox13: TORDateBox
    Tag = 13
    Left = 344
    Top = 302
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 50
    DateOnly = False
    RequireTime = False
    Caption = 'Heat or cold intolerance treatment date'
  end
  object ORDateBox2: TORDateBox
    Tag = 2
    Left = 344
    Top = 49
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 6
    DateOnly = False
    RequireTime = False
    Caption = 'Headache treatment date'
  end
  object ORDateBox3: TORDateBox
    Tag = 3
    Left = 344
    Top = 72
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 10
    DateOnly = False
    RequireTime = False
    Caption = 'Weight loss or weight gain treatment date'
  end
  object ORDateBox4: TORDateBox
    Tag = 4
    Left = 344
    Top = 95
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 14
    DateOnly = False
    RequireTime = False
    Caption = 'visual change treatment date'
  end
  object ORDateBox5: TORDateBox
    Tag = 5
    Left = 344
    Top = 118
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 18
    DateOnly = False
    RequireTime = False
    Caption = 'ear, nose, and throat treatment date'
  end
  object ORDateBox6: TORDateBox
    Tag = 6
    Left = 344
    Top = 141
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 22
    DateOnly = False
    RequireTime = False
    Caption = 'chest pain or palpitation treatment date'
  end
  object ORDateBox7: TORDateBox
    Tag = 7
    Left = 344
    Top = 164
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 26
    DateOnly = False
    RequireTime = False
    Caption = 'dyspnea, cough, or hemoptysis treatment date'
  end
  object ORDateBox8: TORDateBox
    Tag = 8
    Left = 344
    Top = 187
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 30
    DateOnly = False
    RequireTime = False
    Caption = 'GI symptoms of nausea or vomiting treatment date'
  end
  object ORDateBox9: TORDateBox
    Tag = 9
    Left = 344
    Top = 210
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 34
    DateOnly = False
    RequireTime = False
    Caption = 'GU symptoms of burning, pain, or blood treatment date'
  end
  object CheckBox1: TCheckBox
    Tag = 1
    Left = 258
    Top = 28
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 0
    OnClick = CheckBoxClick
  end
  object CheckBox2: TCheckBox
    Tag = 1
    Left = 303
    Top = 28
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 1
    OnClick = CheckBoxClick
  end
  object CheckBox3: TCheckBox
    Tag = 2
    Left = 258
    Top = 51
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 4
    OnClick = CheckBoxClick
  end
  object CheckBox4: TCheckBox
    Tag = 2
    Left = 303
    Top = 51
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 5
    OnClick = CheckBoxClick
  end
  object CheckBox5: TCheckBox
    Tag = 3
    Left = 258
    Top = 74
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    OnClick = CheckBoxClick
  end
  object CheckBox6: TCheckBox
    Tag = 3
    Left = 303
    Top = 74
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 9
    OnClick = CheckBoxClick
  end
  object CheckBox7: TCheckBox
    Tag = 4
    Left = 258
    Top = 97
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 12
    OnClick = CheckBoxClick
  end
  object CheckBox8: TCheckBox
    Tag = 4
    Left = 303
    Top = 97
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 13
    OnClick = CheckBoxClick
  end
  object CheckBox9: TCheckBox
    Tag = 5
    Left = 258
    Top = 120
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 16
    OnClick = CheckBoxClick
  end
  object CheckBox10: TCheckBox
    Tag = 5
    Left = 303
    Top = 120
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 17
    OnClick = CheckBoxClick
  end
  object CheckBox11: TCheckBox
    Tag = 6
    Left = 258
    Top = 143
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 20
    OnClick = CheckBoxClick
  end
  object CheckBox12: TCheckBox
    Tag = 6
    Left = 303
    Top = 143
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 21
    OnClick = CheckBoxClick
  end
  object CheckBox13: TCheckBox
    Tag = 7
    Left = 258
    Top = 166
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 24
    OnClick = CheckBoxClick
  end
  object CheckBox14: TCheckBox
    Tag = 7
    Left = 303
    Top = 166
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 25
    OnClick = CheckBoxClick
  end
  object CheckBox15: TCheckBox
    Tag = 8
    Left = 258
    Top = 189
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 28
    OnClick = CheckBoxClick
  end
  object CheckBox16: TCheckBox
    Tag = 8
    Left = 303
    Top = 189
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 29
    OnClick = CheckBoxClick
  end
  object CheckBox17: TCheckBox
    Tag = 9
    Left = 258
    Top = 212
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 32
    OnClick = CheckBoxClick
  end
  object CheckBox18: TCheckBox
    Tag = 9
    Left = 303
    Top = 212
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 33
    OnClick = CheckBoxClick
  end
  object CheckBox19: TCheckBox
    Tag = 10
    Left = 258
    Top = 235
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 36
    OnClick = CheckBoxClick
  end
  object CheckBox20: TCheckBox
    Tag = 10
    Left = 303
    Top = 235
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 37
    OnClick = CheckBoxClick
  end
  object CheckBox21: TCheckBox
    Tag = 11
    Left = 258
    Top = 258
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 40
    OnClick = CheckBoxClick
  end
  object CheckBox22: TCheckBox
    Tag = 11
    Left = 303
    Top = 258
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 41
    OnClick = CheckBoxClick
  end
  object CheckBox23: TCheckBox
    Tag = 12
    Left = 258
    Top = 281
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 44
    OnClick = CheckBoxClick
  end
  object CheckBox24: TCheckBox
    Tag = 12
    Left = 303
    Top = 281
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 45
    OnClick = CheckBoxClick
  end
  object CheckBox25: TCheckBox
    Tag = 13
    Left = 258
    Top = 304
    Width = 40
    Height = 17
    Caption = 'Yes'
    TabOrder = 48
    OnClick = CheckBoxClick
  end
  object CheckBox26: TCheckBox
    Tag = 13
    Left = 303
    Top = 304
    Width = 40
    Height = 17
    Caption = 'No'
    TabOrder = 49
    OnClick = CheckBoxClick
  end
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 360
    Width = 653
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 55
    object btnOK: TBitBtn
      Left = 496
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 577
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnNeg: TBitBtn
      Left = 1
      Top = 3
      Width = 96
      Height = 25
      Align = alCustom
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
      OnClick = btnNegClick
    end
  end
  object edOther: TEdit
    Tag = 14
    Left = 70
    Top = 325
    Width = 268
    Height = 21
    TabOrder = 52
  end
  object pnlLabels: TPanel
    Left = 4
    Top = 11
    Width = 237
    Height = 311
    BevelOuter = bvNone
    TabOrder = 56
    object Label10: TLabel
      Tag = 5
      Left = 12
      Top = 110
      Width = 125
      Height = 13
      Caption = 'Ears, Nose, and Throat'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label13: TLabel
      Tag = 2
      Left = 12
      Top = 41
      Width = 62
      Height = 13
      Caption = 'Headaches'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label12: TLabel
      Tag = 3
      Left = 12
      Top = 64
      Width = 154
      Height = 13
      Caption = 'Weight Loss or Weight Gain'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Tag = 7
      Left = 12
      Top = 156
      Width = 178
      Height = 13
      Caption = 'Dyspnea, Cough, or Hemoptysis'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label9: TLabel
      Tag = 6
      Left = 12
      Top = 133
      Width = 138
      Height = 13
      Caption = 'Chest Pain or Palpitation'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label8: TLabel
      Tag = 9
      Left = 12
      Top = 202
      Width = 222
      Height = 13
      Caption = 'GU Symptoms of Burning, Pain, or Blood'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label7: TLabel
      Tag = 11
      Left = 12
      Top = 248
      Width = 166
      Height = 13
      Caption = 'Vaginal Bleeding or Discharge'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Tag = 8
      Left = 12
      Top = 179
      Width = 203
      Height = 13
      Caption = 'GI Symptoms of Nausea or Vomiting'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label5: TLabel
      Tag = 4
      Left = 12
      Top = 87
      Width = 84
      Height = 13
      Caption = 'Visual Changes'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label4: TLabel
      Tag = 13
      Left = 12
      Top = 294
      Width = 138
      Height = 13
      Caption = 'Heat or Cold Intolerance'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Tag = 10
      Left = 12
      Top = 225
      Width = 165
      Height = 13
      Caption = 'Bone or Joint Pain or Swelling'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label2: TLabel
      Tag = 12
      Left = 12
      Top = 271
      Width = 96
      Height = 13
      HelpContext = 17
      Caption = 'Skin Rash or Itch'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object Label1: TLabel
      Tag = 1
      Left = 12
      Top = 18
      Width = 31
      Height = 13
      Caption = 'Mood'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
end
