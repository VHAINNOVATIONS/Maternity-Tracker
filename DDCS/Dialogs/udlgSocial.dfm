object dlgSocial: TdlgSocial
  Left = 327
  Top = 340
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Social History'
  ClientHeight = 665
  ClientWidth = 694
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
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 636
    Width = 694
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      694
      29)
    object bbtnOK: TBitBtn
      Left = 537
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 618
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object pgBody: TPageControl
    Left = 0
    Top = 0
    Width = 694
    Height = 636
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'Lifestyle'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbEducation: TLabel
        Left = 12
        Top = 578
        Width = 149
        Height = 14
        Caption = 'Highest level of education?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbLengthMilitary: TLabel
        Left = 12
        Top = 549
        Width = 166
        Height = 14
        Caption = 'Length of time in the military?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbBranch: TLabel
        Left = 12
        Top = 521
        Width = 103
        Height = 14
        Caption = 'Branch of service?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbLifeOther: TLabel
        Left = 12
        Top = 410
        Width = 31
        Height = 14
        Caption = 'Other'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Tag = 7
        Left = 393
        Top = 224
        Width = 53
        Height = 14
        Caption = 'per week'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edEducationComment: TEdit
        Left = 288
        Top = 575
        Width = 387
        Height = 22
        TabOrder = 59
      end
      object edLengthMilitaryComment: TEdit
        Left = 288
        Top = 546
        Width = 387
        Height = 22
        TabOrder = 57
      end
      object edBranch: TEdit
        Left = 121
        Top = 518
        Width = 554
        Height = 22
        TabOrder = 55
      end
      object pnllabels1: TPanel
        Left = 8
        Top = 4
        Width = 146
        Height = 400
        BevelOuter = bvNone
        TabOrder = 0
        object Label4: TLabel
          Tag = 2
          Left = 4
          Top = 47
          Width = 79
          Height = 14
          Caption = 'Seat belt use?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Tag = 1
          Left = 4
          Top = 11
          Width = 132
          Height = 28
          Caption = 'Health hazards at home or work?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label6: TLabel
          Tag = 3
          Left = 4
          Top = 75
          Width = 124
          Height = 28
          Caption = 'Dietary restrictions or limitations?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ShowAccelChar = False
          WordWrap = True
        end
        object Label26: TLabel
          Tag = 4
          Left = 4
          Top = 108
          Width = 94
          Height = 14
          Caption = 'Folic acid intake?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label27: TLabel
          Tag = 5
          Left = 4
          Top = 136
          Width = 88
          Height = 14
          Caption = 'Calcium intake?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label30: TLabel
          Tag = 6
          Left = 4
          Top = 164
          Width = 90
          Height = 14
          Caption = 'Caffeine intake?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label31: TLabel
          Tag = 7
          Left = 4
          Top = 220
          Width = 54
          Height = 14
          Caption = 'Exercise?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label32: TLabel
          Tag = 8
          Left = 4
          Top = 248
          Width = 117
          Height = 14
          Caption = 'Currently employed?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label33: TLabel
          Tag = 9
          Left = 4
          Top = 276
          Width = 126
          Height = 28
          Caption = 'Post-Traumatic Stress Disorder?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label34: TLabel
          Tag = 10
          Left = 4
          Top = 312
          Width = 50
          Height = 14
          Caption = 'Combat?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label35: TLabel
          Tag = 11
          Left = 4
          Top = 340
          Width = 120
          Height = 28
          Caption = 'Any known traumatic brain injuries?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
        object Label1: TLabel
          Tag = 12
          Left = 4
          Top = 376
          Width = 90
          Height = 14
          Caption = 'Toxic Exposure?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Tag = 13
          Left = 4
          Top = 192
          Width = 28
          Height = 14
          Caption = 'Diet?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object CheckBox1: TCheckBox
        Tag = 1
        Left = 172
        Top = 15
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = CheckClick1
      end
      object CheckBox2: TCheckBox
        Tag = 1
        Left = 218
        Top = 15
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = CheckClick1
      end
      object CheckBox3: TCheckBox
        Tag = 1
        Left = 264
        Top = 15
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 3
        OnClick = CheckClick1
      end
      object CheckBox4: TCheckBox
        Tag = 2
        Left = 172
        Top = 51
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = CheckClick1
      end
      object CheckBox5: TCheckBox
        Tag = 2
        Left = 218
        Top = 51
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = CheckClick1
      end
      object CheckBox6: TCheckBox
        Tag = 2
        Left = 264
        Top = 51
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 7
        OnClick = CheckClick1
      end
      object CheckBox9: TCheckBox
        Tag = 3
        Left = 172
        Top = 79
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = CheckClick1
      end
      object CheckBox10: TCheckBox
        Tag = 3
        Left = 218
        Top = 79
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = CheckClick1
      end
      object CheckBox11: TCheckBox
        Tag = 3
        Left = 264
        Top = 79
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 11
        OnClick = CheckClick1
      end
      object CheckBox12: TCheckBox
        Tag = 4
        Left = 172
        Top = 112
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = CheckClick1
      end
      object CheckBox13: TCheckBox
        Tag = 4
        Left = 218
        Top = 112
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        OnClick = CheckClick1
      end
      object CheckBox14: TCheckBox
        Tag = 4
        Left = 264
        Top = 112
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 15
        OnClick = CheckClick1
      end
      object CheckBox15: TCheckBox
        Tag = 5
        Left = 172
        Top = 140
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = CheckClick1
      end
      object CheckBox16: TCheckBox
        Tag = 5
        Left = 218
        Top = 140
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        OnClick = CheckClick1
      end
      object CheckBox21: TCheckBox
        Tag = 5
        Left = 264
        Top = 140
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 19
        OnClick = CheckClick1
      end
      object CheckBox22: TCheckBox
        Tag = 6
        Left = 172
        Top = 168
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
        OnClick = CheckClick1
      end
      object CheckBox23: TCheckBox
        Tag = 6
        Left = 218
        Top = 168
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
        OnClick = CheckClick1
      end
      object CheckBox24: TCheckBox
        Tag = 6
        Left = 264
        Top = 168
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 23
        OnClick = CheckClick1
      end
      object CheckBox18: TCheckBox
        Tag = 13
        Left = 172
        Top = 196
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        OnClick = CheckClick1
      end
      object CheckBox19: TCheckBox
        Tag = 13
        Left = 218
        Top = 196
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
        OnClick = CheckClick1
      end
      object CheckBox20: TCheckBox
        Tag = 13
        Left = 264
        Top = 196
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 27
        OnClick = CheckClick1
      end
      object CheckBox25: TCheckBox
        Tag = 7
        Left = 172
        Top = 224
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 29
        OnClick = CheckClick1
      end
      object CheckBox26: TCheckBox
        Tag = 7
        Left = 218
        Top = 224
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 30
        OnClick = CheckClick1
      end
      object CheckBox27: TCheckBox
        Tag = 7
        Left = 264
        Top = 224
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 31
        OnClick = CheckClick1
      end
      object CheckBox28: TCheckBox
        Tag = 8
        Left = 172
        Top = 252
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 34
        OnClick = CheckClick1
      end
      object CheckBox29: TCheckBox
        Tag = 8
        Left = 218
        Top = 252
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 35
        OnClick = CheckClick1
      end
      object CheckBox30: TCheckBox
        Tag = 8
        Left = 264
        Top = 252
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 36
        OnClick = CheckClick1
      end
      object CheckBox31: TCheckBox
        Tag = 9
        Left = 172
        Top = 280
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 38
        OnClick = CheckClick1
      end
      object CheckBox32: TCheckBox
        Tag = 9
        Left = 218
        Top = 280
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 39
        OnClick = CheckClick1
      end
      object CheckBox33: TCheckBox
        Tag = 9
        Left = 264
        Top = 280
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 40
        OnClick = CheckClick1
      end
      object CheckBox34: TCheckBox
        Tag = 10
        Left = 172
        Top = 316
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 42
        OnClick = CheckClick1
      end
      object CheckBox35: TCheckBox
        Tag = 10
        Left = 218
        Top = 316
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 43
        OnClick = CheckClick1
      end
      object CheckBox36: TCheckBox
        Tag = 10
        Left = 264
        Top = 316
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 44
        OnClick = CheckClick1
      end
      object CheckBox37: TCheckBox
        Tag = 11
        Left = 172
        Top = 344
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 46
        OnClick = CheckClick1
      end
      object CheckBox38: TCheckBox
        Tag = 11
        Left = 218
        Top = 344
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 47
        OnClick = CheckClick1
      end
      object CheckBox39: TCheckBox
        Tag = 11
        Left = 264
        Top = 344
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 48
        OnClick = CheckClick1
      end
      object Edit1: TEdit
        Tag = 1
        Left = 338
        Top = 12
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 4
      end
      object Edit2: TEdit
        Tag = 2
        Left = 338
        Top = 48
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 8
      end
      object Edit3: TEdit
        Tag = 3
        Left = 338
        Top = 76
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 12
      end
      object Edit4: TEdit
        Tag = 4
        Left = 338
        Top = 109
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 16
      end
      object Edit5: TEdit
        Tag = 5
        Left = 338
        Top = 137
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 20
      end
      object Edit6: TEdit
        Tag = 6
        Left = 338
        Top = 165
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 24
      end
      object edExercise: TEdit
        Tag = 7
        Left = 452
        Top = 221
        Width = 223
        Height = 22
        Enabled = False
        TabOrder = 33
      end
      object edEmployed: TEdit
        Tag = 8
        Left = 338
        Top = 249
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 37
      end
      object Edit9: TEdit
        Tag = 9
        Left = 338
        Top = 277
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 41
      end
      object Edit10: TEdit
        Tag = 10
        Left = 338
        Top = 313
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 45
      end
      object Edit11: TEdit
        Tag = 11
        Left = 338
        Top = 341
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 49
      end
      object CheckBox7: TCheckBox
        Tag = 12
        Left = 172
        Top = 380
        Width = 40
        Height = 17
        Caption = 'Yes'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 50
        OnClick = CheckClick1
      end
      object CheckBox8: TCheckBox
        Tag = 12
        Left = 218
        Top = 380
        Width = 40
        Height = 17
        Caption = 'No'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 51
        OnClick = CheckClick1
      end
      object CheckBox17: TCheckBox
        Tag = 12
        Left = 264
        Top = 380
        Width = 71
        Height = 17
        Caption = 'Unknown'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 52
        OnClick = CheckClick1
      end
      object edToxic: TEdit
        Tag = 12
        Left = 338
        Top = 377
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 53
      end
      object edDiet: TEdit
        Tag = 13
        Left = 338
        Top = 193
        Width = 337
        Height = 22
        Enabled = False
        TabOrder = 28
      end
      object meLifeOther: TCaptionMemo
        Left = 11
        Top = 428
        Width = 664
        Height = 84
        ScrollBars = ssVertical
        TabOrder = 54
        Caption = 'Other'
      end
      object Panel1: TPanel
        Left = 184
        Top = 543
        Width = 90
        Height = 27
        BevelOuter = bvNone
        TabOrder = 56
        object lbLengthMilitaryYrs: TLabel
          Left = 70
          Top = 5
          Width = 16
          Height = 14
          Caption = 'yrs'
        end
        object spnLengthMilitary: TSpinEdit
          Left = 2
          Top = 2
          Width = 62
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinCheck
        end
      end
      object Panel2: TPanel
        Left = 184
        Top = 572
        Width = 90
        Height = 27
        BevelOuter = bvNone
        TabOrder = 58
        object lbEducationYrs: TLabel
          Left = 70
          Top = 5
          Width = 16
          Height = 14
          Caption = 'yrs'
        end
        object spnEducation: TSpinEdit
          Left = 2
          Top = 2
          Width = 62
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
          OnChange = SpinCheck
        end
      end
      object spnExercise: TSpinEdit
        Tag = 7
        Left = 338
        Top = 221
        Width = 49
        Height = 23
        Enabled = False
        MaxValue = 0
        MinValue = 0
        TabOrder = 32
        Value = 0
        OnChange = SpinCheck
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Relationship && Sexual History'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbViolence: TLabel
        Left = 12
        Top = 81
        Width = 131
        Height = 14
        Caption = 'Interpersonal violence?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
        Layout = tlCenter
      end
      object lbSexPartner: TLabel
        Left = 11
        Top = 114
        Width = 292
        Height = 14
        Caption = 'Have you had more than one sexual partner in the last year?'
        Color = clBtnFace
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object lbSexConcerns: TLabel
        Left = 11
        Top = 170
        Width = 391
        Height = 14
        Caption = 
          'Do you have any sexual concerns you would like to address with y' +
          'our provider?'
        Color = clBtnFace
        ParentColor = False
        Transparent = False
        Layout = tlCenter
      end
      object lbBirthControl: TLabel
        Left = 12
        Top = 15
        Width = 205
        Height = 14
        Caption = 'Most recent method of birth control?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbSexTrauma: TLabel
        Left = 12
        Top = 53
        Width = 128
        Height = 14
        Caption = 'Military sexual trauma?'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edViolence: TEdit
        Left = 333
        Top = 78
        Width = 342
        Height = 22
        Enabled = False
        TabOrder = 8
      end
      object ckViolenceNo: TCheckBox
        Tag = 26
        Left = 205
        Top = 80
        Width = 46
        Height = 18
        Hint = 'Smoke: NO'
        Caption = 'No'
        TabOrder = 6
        OnClick = CheckClick2
      end
      object ckViolenceYes: TCheckBox
        Tag = 25
        Left = 153
        Top = 81
        Width = 46
        Height = 17
        Caption = 'Yes'
        TabOrder = 5
        OnClick = CheckClick2
      end
      object edBirthControl: TEdit
        Left = 223
        Top = 12
        Width = 452
        Height = 22
        TabOrder = 0
      end
      object ckSexTraumaYes: TCheckBox
        Tag = 23
        Left = 153
        Top = 53
        Width = 46
        Height = 17
        Caption = 'Yes'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 1
        OnClick = CheckClick2
      end
      object ckSexTraumaNo: TCheckBox
        Tag = 24
        Left = 205
        Top = 53
        Width = 46
        Height = 17
        Caption = 'No'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 2
        OnClick = CheckClick2
      end
      object edSexTrauma: TEdit
        Left = 333
        Top = 50
        Width = 342
        Height = 22
        Enabled = False
        TabOrder = 4
      end
      object ckSexPartnerYes: TCheckBox
        Tag = 27
        Left = 11
        Top = 134
        Width = 46
        Height = 17
        Caption = 'Yes'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 9
        OnClick = CheckClick2
      end
      object ckSexPartnerNo: TCheckBox
        Tag = 28
        Left = 63
        Top = 134
        Width = 46
        Height = 17
        Hint = 'Smoke: NO'
        Caption = 'No'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 10
        OnClick = CheckClick2
      end
      object edSexPartner: TEdit
        Left = 115
        Top = 131
        Width = 560
        Height = 22
        Enabled = False
        TabOrder = 11
      end
      object ckSexConcernsYes: TCheckBox
        Tag = 29
        Left = 11
        Top = 190
        Width = 46
        Height = 17
        Caption = 'Yes'
        TabOrder = 12
        OnClick = CheckClick2
      end
      object ckSexConcernsNo: TCheckBox
        Tag = 30
        Left = 63
        Top = 190
        Width = 46
        Height = 17
        Hint = 'Smoke: NO'
        Caption = 'No'
        TabOrder = 13
        OnClick = CheckClick2
      end
      object edSexConcerns: TEdit
        Left = 115
        Top = 187
        Width = 560
        Height = 22
        Enabled = False
        TabOrder = 14
      end
      object ckSexTraumaUnknown: TCheckBox
        Tag = 24
        Left = 257
        Top = 53
        Width = 70
        Height = 17
        Caption = 'Unknown'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 3
        OnClick = CheckClick2
      end
      object ckViolenceUnknown: TCheckBox
        Tag = 24
        Left = 257
        Top = 81
        Width = 70
        Height = 17
        Caption = 'Unknown'
        Color = clBtnFace
        ParentColor = False
        TabOrder = 7
        OnClick = CheckClick2
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Tobacco'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object pnlMaster: TPanel
        Left = 0
        Top = 41
        Width = 686
        Height = 316
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lbSmoke: TLabel
          Left = 12
          Top = 72
          Width = 46
          Height = 14
          Caption = 'Smokes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbChew: TLabel
          Left = 348
          Top = 72
          Width = 39
          Height = 14
          Caption = 'Chews'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbSecond: TLabel
          Left = 12
          Top = 16
          Width = 254
          Height = 14
          Caption = 'Environmental and or second hand exposure?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbSecondExpose: TLabel
          Left = 12
          Top = 36
          Width = 195
          Height = 14
          Caption = 'How many hours per day exposed?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ckChewYes: TCheckBox
          Tag = 1
          Left = 393
          Top = 72
          Width = 46
          Height = 17
          Caption = 'Yes'
          TabOrder = 6
          OnClick = ChewClick
        end
        object ckSmokeYes: TCheckBox
          Tag = 2
          Left = 64
          Top = 72
          Width = 46
          Height = 17
          Caption = 'Yes'
          TabOrder = 3
          OnClick = SmokeClick
        end
        object ckSecondYes: TCheckBox
          Left = 272
          Top = 15
          Width = 46
          Height = 17
          Caption = 'Yes'
          TabOrder = 0
          OnClick = SecondClick
        end
        object ckSmokeNo: TCheckBox
          Left = 116
          Top = 72
          Width = 46
          Height = 17
          Caption = 'No'
          Checked = True
          State = cbChecked
          TabOrder = 4
          OnClick = SmokeClick
        end
        object ckChewNo: TCheckBox
          Left = 445
          Top = 72
          Width = 46
          Height = 17
          Hint = 'Chew: NO'
          Caption = 'No'
          Checked = True
          State = cbChecked
          TabOrder = 7
          OnClick = ChewClick
        end
        object ckSecondNo: TCheckBox
          Left = 324
          Top = 15
          Width = 46
          Height = 17
          Caption = 'No'
          TabOrder = 1
          OnClick = SecondClick
        end
        object pnlSmoke: TPanel
          Left = 12
          Top = 95
          Width = 330
          Height = 206
          BevelOuter = bvNone
          TabOrder = 5
          Visible = False
          object gbCig: TGroupBox
            Left = 9
            Top = 8
            Width = 312
            Height = 59
            Caption = 'Cigarettes'
            TabOrder = 0
            TabStop = True
            DesignSize = (
              312
              59)
            object lbCig: TLabel
              Left = 227
              Top = 0
              Width = 86
              Height = 14
              Anchors = [akLeft, akBottom]
              Caption = 'Pack Year History'
            end
            object pnlCigSub: TPanel
              Left = 172
              Top = 18
              Width = 112
              Height = 34
              BevelOuter = bvNone
              TabOrder = 1
              object lbCigYrs: TLabel
                Left = 66
                Top = 6
                Width = 41
                Height = 14
                Caption = 'per year'
              end
              object spnCigYrs: TSpinEdit
                Left = 11
                Top = 3
                Width = 49
                Height = 23
                MaxValue = 0
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = SpinCheck
              end
            end
            object Panel7: TPanel
              Left = 5
              Top = 18
              Width = 164
              Height = 29
              BevelOuter = bvNone
              TabOrder = 0
              object lbCigDay: TLabel
                Left = 4
                Top = 6
                Width = 102
                Height = 14
                Caption = 'Cigarettes per day'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object spnCigDay: TSpinEdit
                Left = 112
                Top = 3
                Width = 49
                Height = 23
                MaxValue = 0
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = CigDay
              end
            end
          end
          object gbCigar: TGroupBox
            Left = 9
            Top = 73
            Width = 312
            Height = 59
            Caption = 'Cigars'
            TabOrder = 1
            TabStop = True
            object lbCigar: TLabel
              Left = 227
              Top = 0
              Width = 86
              Height = 14
              Caption = 'Pack Year History'
            end
            object pnlCigarSub: TPanel
              Left = 172
              Top = 18
              Width = 112
              Height = 34
              BevelOuter = bvNone
              TabOrder = 1
              object lbCigarYrs: TLabel
                Left = 66
                Top = 6
                Width = 41
                Height = 14
                Caption = 'per year'
              end
              object spnCigarYrs: TSpinEdit
                Left = 11
                Top = 3
                Width = 49
                Height = 23
                MaxValue = 0
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = SpinCheck
              end
            end
            object Panel6: TPanel
              Left = 19
              Top = 15
              Width = 150
              Height = 35
              BevelOuter = bvNone
              TabOrder = 0
              object lbCigarDay: TLabel
                Left = 12
                Top = 12
                Width = 80
                Height = 14
                Caption = 'Cigars per day'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clWindowText
                Font.Height = -11
                Font.Name = 'Arial'
                Font.Style = [fsBold]
                ParentFont = False
              end
              object spnCigarDay: TSpinEdit
                Left = 98
                Top = 6
                Width = 49
                Height = 23
                MaxValue = 0
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = CigarDay
              end
            end
          end
          object gbPipe: TGroupBox
            Left = 9
            Top = 137
            Width = 312
            Height = 59
            Caption = 'Pipe'
            TabOrder = 2
            TabStop = True
            object lbPipeDay: TLabel
              Left = 33
              Top = 24
              Width = 78
              Height = 14
              Caption = 'Bowls per day'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -11
              Font.Name = 'Arial'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object lbPipe: TLabel
              Left = 219
              Top = 0
              Width = 94
              Height = 14
              Caption = 'Bowls Year History'
            end
            object pnlPipeSub: TPanel
              Left = 172
              Top = 18
              Width = 110
              Height = 34
              BevelOuter = bvNone
              TabOrder = 1
              object lbPipeYrs: TLabel
                Left = 66
                Top = 6
                Width = 41
                Height = 14
                Caption = 'per year'
              end
              object spnPipeYrs: TSpinEdit
                Left = 11
                Top = 3
                Width = 49
                Height = 23
                MaxValue = 0
                MinValue = 0
                TabOrder = 0
                Value = 0
                OnChange = SpinCheck
              end
            end
            object spnPipeDay: TSpinEdit
              Left = 117
              Top = 21
              Width = 49
              Height = 23
              MaxValue = 0
              MinValue = 0
              TabOrder = 0
              Value = 0
              OnChange = PipeDay
            end
          end
        end
        object pnlChew: TPanel
          Left = 348
          Top = 95
          Width = 330
          Height = 206
          BevelOuter = bvNone
          TabOrder = 8
          Visible = False
          object lbChewDay: TLabel
            Left = 28
            Top = 23
            Width = 116
            Height = 14
            Caption = 'How much each day?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbChewYears: TLabel
            Left = 52
            Top = 52
            Width = 92
            Height = 14
            Caption = 'Number of Years'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbChewEpisode: TLabel
            Left = 9
            Top = 81
            Width = 135
            Height = 14
            Caption = 'How long each episode?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edChewEpisode: TEdit
            Left = 150
            Top = 78
            Width = 158
            Height = 22
            TabOrder = 2
          end
          object spnChewDay: TSpinEdit
            Left = 150
            Top = 20
            Width = 49
            Height = 23
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 0
            OnChange = SpinCheck
          end
          object spnChewYears: TSpinEdit
            Left = 150
            Top = 49
            Width = 49
            Height = 23
            MaxValue = 0
            MinValue = 0
            TabOrder = 1
            Value = 0
            OnChange = SpinCheck
          end
        end
        object spnSecondExpose: TSpinEdit
          Left = 213
          Top = 33
          Width = 49
          Height = 23
          MaxValue = 0
          MinValue = 0
          TabOrder = 2
          Value = 0
          OnChange = SpinCheck
        end
      end
      object pnlTobaccoQuit: TPanel
        Left = 0
        Top = 357
        Width = 686
        Height = 250
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
        object lbQuitTobacco: TLabel
          Left = 199
          Top = 13
          Width = 137
          Height = 14
          Caption = 'Describe Quitting History'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbQuitDateTobacco: TLabel
          Left = 12
          Top = 13
          Width = 49
          Height = 14
          Caption = 'Date Quit'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object edQuitCommentsTobacco: TEdit
          Left = 199
          Top = 31
          Width = 469
          Height = 22
          TabOrder = 1
        end
        object dtQuitTobacco: TORDateBox
          Left = 12
          Top = 31
          Width = 181
          Height = 22
          TabOrder = 0
          DateOnly = False
          RequireTime = False
          Caption = ''
        end
      end
      object Panel3: TPanel
        Left = 0
        Top = 0
        Width = 686
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        object ckMaster: TCheckBox
          Tag = 1
          Left = 12
          Top = 12
          Width = 450
          Height = 17
          Caption = 
            'Patient currently does not use tobacco products and is not expos' +
            'ed to tobacco products.'
          Color = clBtnFace
          ParentColor = False
          TabOrder = 0
          OnClick = MasterClick
        end
      end
    end
    object TabSheet4: TTabSheet
      Caption = 'Alcohol && Drugs'
      ImageIndex = 3
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object gbAlcohol: TGroupBox
        Left = 0
        Top = 0
        Width = 686
        Height = 281
        Align = alTop
        Caption = 'Alcohol'
        TabOrder = 0
        object pnlAlcohol: TPanel
          Left = 2
          Top = 53
          Width = 682
          Height = 112
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          Visible = False
          object lbWineOften: TLabel
            Left = 240
            Top = 20
            Width = 63
            Height = 14
            Caption = 'How often?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbBeerOften: TLabel
            Left = 240
            Top = 48
            Width = 63
            Height = 14
            Caption = 'How often?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbSpiritOften: TLabel
            Left = 240
            Top = 76
            Width = 63
            Height = 14
            Caption = 'How often?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbWine: TLabel
            Left = 23
            Top = 20
            Width = 128
            Height = 14
            Caption = 'How much wine (6 oz)?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbBeer: TLabel
            Left = 12
            Top = 48
            Width = 139
            Height = 14
            Caption = 'How many beers (12 oz)?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbSpirit: TLabel
            Left = 15
            Top = 76
            Width = 136
            Height = 14
            Caption = 'How many spirits (1 oz)?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbBeer: TComboBox
            Left = 309
            Top = 45
            Width = 117
            Height = 22
            TabOrder = 3
          end
          object cbSpirit: TComboBox
            Left = 309
            Top = 73
            Width = 117
            Height = 22
            TabOrder = 5
          end
          object cbWine: TComboBox
            Left = 309
            Top = 17
            Width = 117
            Height = 22
            TabOrder = 1
          end
          object spnWine: TSpinEdit
            Left = 157
            Top = 17
            Width = 66
            Height = 23
            MaxValue = 0
            MinValue = 0
            TabOrder = 0
            Value = 0
            OnChange = SpinCheck
          end
          object spnBeer: TSpinEdit
            Left = 157
            Top = 45
            Width = 66
            Height = 23
            MaxValue = 0
            MinValue = 0
            TabOrder = 2
            Value = 0
            OnChange = SpinCheck
          end
          object spnSpirit: TSpinEdit
            Left = 157
            Top = 73
            Width = 66
            Height = 23
            MaxValue = 0
            MinValue = 0
            TabOrder = 4
            Value = 0
            OnChange = SpinCheck
          end
        end
        object pnlAlcoholQuit: TPanel
          Left = 2
          Top = 165
          Width = 682
          Height = 114
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 2
          object lbAlcoholQuit: TLabel
            Left = 199
            Top = 6
            Width = 137
            Height = 14
            Caption = 'Describe Quitting History'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbAlcoholQuitDate: TLabel
            Left = 12
            Top = 6
            Width = 49
            Height = 14
            Caption = 'Date Quit'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edAlcoholQuitComments: TEdit
            Left = 199
            Top = 24
            Width = 469
            Height = 22
            TabOrder = 0
          end
          object dtAlcoholQuit: TORDateBox
            Left = 12
            Top = 24
            Width = 181
            Height = 22
            TabOrder = 1
            DateOnly = False
            RequireTime = False
            Caption = ''
          end
        end
        object Panel4: TPanel
          Left = 2
          Top = 16
          Width = 682
          Height = 37
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lbAlcohol: TLabel
            Left = 12
            Top = 13
            Width = 175
            Height = 14
            Caption = 'Does patient currently drink alcohol?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object ckAlcoholYes: TCheckBox
            Left = 196
            Top = 13
            Width = 46
            Height = 17
            Hint = 'Does patient current drink? YES'
            Caption = 'Yes'
            TabOrder = 0
            OnClick = AlcoholClick
          end
          object ckAlcoholNo: TCheckBox
            Left = 248
            Top = 13
            Width = 46
            Height = 17
            Hint = 'Does patient current drink? NO'
            Caption = 'No'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = AlcoholClick
          end
        end
      end
      object gb5: TGroupBox
        Left = 0
        Top = 281
        Width = 686
        Height = 326
        Align = alClient
        Caption = 'Drugs'
        TabOrder = 1
        object pnlDrugs: TPanel
          Left = 2
          Top = 57
          Width = 682
          Height = 140
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 1
          Visible = False
          object lbNarcotics: TLabel
            Left = 38
            Top = 12
            Width = 51
            Height = 14
            Caption = 'Narcotics'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbStimulants: TLabel
            Left = 30
            Top = 40
            Width = 59
            Height = 14
            Caption = 'Stimulants'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbOther: TLabel
            Left = 58
            Top = 96
            Width = 31
            Height = 14
            Caption = 'Other'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbNarcoticsRoute: TLabel
            Left = 265
            Top = 12
            Width = 32
            Height = 14
            Caption = 'Route'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbStimulantsRoute: TLabel
            Left = 265
            Top = 40
            Width = 32
            Height = 14
            Caption = 'Route'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbHallucinRoute: TLabel
            Left = 265
            Top = 69
            Width = 32
            Height = 14
            Caption = 'Route'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbOtherRoute: TLabel
            Left = 265
            Top = 96
            Width = 32
            Height = 14
            Caption = 'Route'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbHullucin: TLabel
            Left = 12
            Top = 69
            Width = 77
            Height = 14
            Caption = 'Hallucinogens'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbNarcoticsFreq: TLabel
            Left = 430
            Top = 12
            Width = 58
            Height = 14
            Caption = 'Frequency'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbStimulantsFreq: TLabel
            Left = 430
            Top = 40
            Width = 58
            Height = 14
            Caption = 'Frequency'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbHallucinFreq: TLabel
            Left = 430
            Top = 69
            Width = 58
            Height = 14
            Caption = 'Frequency'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbOtherFreq: TLabel
            Left = 430
            Top = 96
            Width = 58
            Height = 14
            Caption = 'Frequency'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object cbHallucin: TComboBox
            Left = 95
            Top = 65
            Width = 156
            Height = 22
            Hint = 'Hallucinogens'
            TabOrder = 6
          end
          object cbNarcotics: TComboBox
            Left = 95
            Top = 9
            Width = 156
            Height = 22
            Hint = 'Narcotics'
            TabOrder = 0
          end
          object cbOther: TComboBox
            Left = 95
            Top = 93
            Width = 156
            Height = 22
            Hint = 'Other'
            TabOrder = 9
          end
          object cbHallucinRoute: TComboBox
            Left = 303
            Top = 65
            Width = 115
            Height = 22
            TabOrder = 7
          end
          object cbNarcoticsRoute: TComboBox
            Left = 303
            Top = 9
            Width = 115
            Height = 22
            TabOrder = 1
          end
          object cbOtherRoute: TComboBox
            Left = 303
            Top = 93
            Width = 115
            Height = 22
            TabOrder = 10
          end
          object cbStimulantsRoute: TComboBox
            Left = 303
            Top = 37
            Width = 115
            Height = 22
            TabOrder = 4
          end
          object cbStimulants: TComboBox
            Left = 95
            Top = 37
            Width = 156
            Height = 22
            Hint = 'Stimulants'
            TabOrder = 3
          end
          object edNarcoticsFreq: TEdit
            Left = 494
            Top = 9
            Width = 121
            Height = 22
            TabOrder = 2
          end
          object edStimulantsFreq: TEdit
            Left = 494
            Top = 37
            Width = 121
            Height = 22
            TabOrder = 5
          end
          object edHallucinFreq: TEdit
            Left = 494
            Top = 65
            Width = 121
            Height = 22
            TabOrder = 8
          end
          object edOtherFreq: TEdit
            Left = 494
            Top = 93
            Width = 121
            Height = 22
            TabOrder = 11
          end
        end
        object pnlDrugsQuit: TPanel
          Left = 2
          Top = 197
          Width = 682
          Height = 127
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 2
          object lbDrugsQuit: TLabel
            Left = 199
            Top = 6
            Width = 137
            Height = 14
            Caption = 'Describe Quitting History'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object lbDrugsQuitDate: TLabel
            Left = 12
            Top = 6
            Width = 49
            Height = 14
            Caption = 'Date Quit'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object edDrugsQuitComments: TEdit
            Left = 199
            Top = 24
            Width = 469
            Height = 22
            TabOrder = 1
          end
          object dtDrugsQuit: TORDateBox
            Left = 12
            Top = 24
            Width = 181
            Height = 22
            TabOrder = 0
            DateOnly = False
            RequireTime = False
            Caption = ''
          end
        end
        object Panel5: TPanel
          Left = 2
          Top = 16
          Width = 682
          Height = 41
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lbDrugs: TLabel
            Left = 12
            Top = 13
            Width = 343
            Height = 14
            Caption = 
              'Does patient currently use recreational or non-prescribed substa' +
              'nces?'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Arial'
            Font.Style = []
            ParentFont = False
          end
          object ckDrugsYes: TCheckBox
            Left = 361
            Top = 13
            Width = 46
            Height = 17
            Hint = 
              'Does patient currently use recreational or non-prescribed substa' +
              'nces? YES'
            Caption = 'Yes'
            TabOrder = 0
            OnClick = DrugsClick
          end
          object ckDrugsNo: TCheckBox
            Left = 413
            Top = 13
            Width = 46
            Height = 17
            Hint = 
              'Does patient currently use recreational or non-prescribed substa' +
              'nces? NO'
            Caption = 'No'
            Checked = True
            State = cbChecked
            TabOrder = 1
            OnClick = DrugsClick
          end
        end
      end
    end
  end
end
