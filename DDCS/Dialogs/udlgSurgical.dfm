object dlgSurgical: TdlgSurgical
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Surgical History'
  ClientHeight = 525
  ClientWidth = 799
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
  object lbComments: TLabel
    Left = 10
    Top = 350
    Width = 61
    Height = 13
    Caption = 'Comments'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbTreatment: TLabel
    Left = 314
    Top = 8
    Width = 153
    Height = 13
    Alignment = taCenter
    AutoSize = False
    Caption = 'Surgery Date'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbComment: TLabel
    Left = 473
    Top = 8
    Width = 316
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
  object lbOther1: TLabel
    Tag = 14
    Left = 10
    Top = 288
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
  object lbOther2: TLabel
    Tag = 14
    Left = 10
    Top = 315
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
  object pnlfooter: TPanel
    Left = 0
    Top = 496
    Width = 799
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 43
    object bbtnOK: TBitBtn
      Left = 642
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 1
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 723
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
  object Edit19: TEdit
    Tag = 1
    Left = 473
    Top = 26
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object meComments: TCaptionMemo
    Left = 10
    Top = 368
    Width = 779
    Height = 117
    Align = alCustom
    Anchors = [akLeft, akTop, akRight, akBottom]
    ScrollBars = ssVertical
    TabOrder = 42
    Caption = 'Comments'
  end
  object CheckBox1: TCheckBox
    Tag = 1
    Left = 216
    Top = 28
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 0
    OnClick = CheckBoxClick
  end
  object CheckBox2: TCheckBox
    Tag = 1
    Left = 268
    Top = 28
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 1
    OnClick = CheckBoxClick
  end
  object CheckBox4: TCheckBox
    Tag = 2
    Left = 216
    Top = 55
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 4
    OnClick = CheckBoxClick
  end
  object CheckBox5: TCheckBox
    Tag = 2
    Left = 268
    Top = 55
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 5
    OnClick = CheckBoxClick
  end
  object CheckBox7: TCheckBox
    Tag = 3
    Left = 216
    Top = 82
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 8
    OnClick = CheckBoxClick
  end
  object CheckBox8: TCheckBox
    Tag = 3
    Left = 268
    Top = 82
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 9
    OnClick = CheckBoxClick
  end
  object CheckBox10: TCheckBox
    Tag = 4
    Left = 216
    Top = 109
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 12
    OnClick = CheckBoxClick
  end
  object CheckBox11: TCheckBox
    Tag = 4
    Left = 268
    Top = 109
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 13
    OnClick = CheckBoxClick
  end
  object CheckBox13: TCheckBox
    Tag = 5
    Left = 216
    Top = 136
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 16
    OnClick = CheckBoxClick
  end
  object CheckBox14: TCheckBox
    Tag = 5
    Left = 268
    Top = 136
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 17
    OnClick = CheckBoxClick
  end
  object CheckBox16: TCheckBox
    Tag = 6
    Left = 216
    Top = 163
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 20
    OnClick = CheckBoxClick
  end
  object CheckBox17: TCheckBox
    Tag = 6
    Left = 268
    Top = 163
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 21
    OnClick = CheckBoxClick
  end
  object ORDateBox1: TORDateBox
    Tag = 1
    Left = 314
    Top = 26
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 2
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object CheckBox19: TCheckBox
    Tag = 7
    Left = 216
    Top = 190
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 24
    OnClick = CheckBoxClick
  end
  object CheckBox20: TCheckBox
    Tag = 7
    Left = 268
    Top = 190
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 25
    OnClick = CheckBoxClick
  end
  object CheckBox22: TCheckBox
    Tag = 8
    Left = 216
    Top = 217
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 28
    OnClick = CheckBoxClick
  end
  object CheckBox23: TCheckBox
    Tag = 8
    Left = 268
    Top = 217
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 29
    OnClick = CheckBoxClick
  end
  object CheckBox25: TCheckBox
    Tag = 9
    Left = 216
    Top = 244
    Width = 46
    Height = 17
    Caption = 'Yes'
    TabOrder = 32
    OnClick = CheckBoxClick
  end
  object CheckBox26: TCheckBox
    Tag = 9
    Left = 268
    Top = 244
    Width = 37
    Height = 17
    Caption = 'No'
    TabOrder = 33
    OnClick = CheckBoxClick
  end
  object Edit1: TEdit
    Tag = 2
    Left = 473
    Top = 53
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object ORDateBox2: TORDateBox
    Tag = 2
    Left = 314
    Top = 53
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 6
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object Edit2: TEdit
    Tag = 3
    Left = 473
    Top = 80
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 11
  end
  object ORDateBox3: TORDateBox
    Tag = 3
    Left = 314
    Top = 80
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 10
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object Edit3: TEdit
    Tag = 4
    Left = 473
    Top = 107
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 15
  end
  object ORDateBox4: TORDateBox
    Tag = 4
    Left = 314
    Top = 107
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 14
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object Edit4: TEdit
    Tag = 5
    Left = 473
    Top = 134
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 19
  end
  object ORDateBox5: TORDateBox
    Tag = 5
    Left = 314
    Top = 134
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 18
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object Edit5: TEdit
    Tag = 6
    Left = 473
    Top = 161
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 23
  end
  object ORDateBox6: TORDateBox
    Tag = 6
    Left = 314
    Top = 161
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 22
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object Edit6: TEdit
    Tag = 7
    Left = 473
    Top = 188
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 27
  end
  object ORDateBox7: TORDateBox
    Tag = 7
    Left = 314
    Top = 188
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 26
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object Edit7: TEdit
    Tag = 8
    Left = 473
    Top = 215
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 31
  end
  object ORDateBox8: TORDateBox
    Tag = 8
    Left = 314
    Top = 215
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 30
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object Edit8: TEdit
    Tag = 9
    Left = 473
    Top = 242
    Width = 316
    Height = 21
    Enabled = False
    TabOrder = 35
  end
  object ORDateBox9: TORDateBox
    Tag = 9
    Left = 314
    Top = 242
    Width = 153
    Height = 21
    Enabled = False
    TabOrder = 34
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object pnlLabels: TPanel
    Left = 2
    Top = 16
    Width = 209
    Height = 263
    BevelOuter = bvNone
    TabOrder = 54
    object Label1: TLabel
      Tag = 1
      Left = 8
      Top = 13
      Width = 194
      Height = 13
      Caption = 'Operations and or Hospitalizations'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Tag = 2
      Left = 8
      Top = 40
      Width = 143
      Height = 13
      Caption = 'Anesthetic Complications'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Tag = 3
      Left = 8
      Top = 67
      Width = 84
      Height = 13
      Caption = 'Oophorectomy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Tag = 4
      Left = 8
      Top = 94
      Width = 98
      Height = 13
      Caption = 'Cholecystectomy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Tag = 5
      Left = 8
      Top = 121
      Width = 72
      Height = 13
      Caption = 'Laparoscopy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label10: TLabel
      Tag = 6
      Left = 8
      Top = 148
      Width = 42
      Height = 13
      Caption = 'D and C'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label11: TLabel
      Tag = 7
      Left = 8
      Top = 175
      Width = 54
      Height = 13
      Caption = 'C-Section'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label12: TLabel
      Tag = 8
      Left = 8
      Top = 202
      Width = 86
      Height = 13
      Caption = 'Appendectomy'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label6: TLabel
      Tag = 9
      Left = 8
      Top = 229
      Width = 118
      Height = 13
      Caption = 'Tonsils and Adenoids'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
  end
  object dtOther1: TORDateBox
    Tag = 14
    Left = 314
    Top = 285
    Width = 153
    Height = 21
    TabOrder = 37
    DateOnly = False
    RequireTime = False
    Caption = 'Other Surgery Date'
  end
  object edOtherComments1: TEdit
    Tag = 14
    Left = 473
    Top = 285
    Width = 316
    Height = 21
    TabOrder = 38
  end
  object edOther1: TEdit
    Tag = 14
    Left = 48
    Top = 285
    Width = 260
    Height = 21
    TabOrder = 36
  end
  object dtOther2: TORDateBox
    Tag = 14
    Left = 314
    Top = 312
    Width = 153
    Height = 21
    TabOrder = 40
    DateOnly = False
    RequireTime = False
    Caption = 'Other Surgery Date'
  end
  object edOtherComments2: TEdit
    Tag = 14
    Left = 473
    Top = 312
    Width = 316
    Height = 21
    TabOrder = 41
  end
  object edOther2: TEdit
    Tag = 14
    Left = 48
    Top = 312
    Width = 260
    Height = 21
    TabOrder = 39
  end
end
