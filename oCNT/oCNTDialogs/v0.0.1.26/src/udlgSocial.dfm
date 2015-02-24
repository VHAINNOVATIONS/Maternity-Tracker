object dlgSocial: TdlgSocial
  Left = 327
  Top = 340
  BorderStyle = bsDialog
  ClientHeight = 610
  ClientWidth = 632
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
    Width = 632
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
      Width = 116
      Height = 20
      Caption = 'Social  History'
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
    Top = 581
    Width = 632
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object bbtnOK: TBitBtn
      Left = 474
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 555
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 33
    Width = 632
    Height = 548
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = 'Lifestyle'
      ImageIndex = 2
      object gb1: TGroupBox
        Left = 0
        Top = 0
        Width = 624
        Height = 246
        Align = alTop
        Caption = 'LIFESTYLE'
        TabOrder = 0
        object Label26: TLabel
          Left = 13
          Top = 19
          Width = 359
          Height = 22
          AutoSize = False
          Caption = 'Health Hazards at home/work?'
          Color = clMoneyGreen
          Constraints.MinWidth = 337
          ParentColor = False
          Transparent = False
          Layout = tlCenter
        end
        object Label27: TLabel
          Left = 13
          Top = 49
          Width = 70
          Height = 14
          Caption = 'Seat Belt use?'
        end
        object Label30: TLabel
          Left = 13
          Top = 74
          Width = 377
          Height = 22
          AutoSize = False
          Caption = 'Dietary Restrictions or Limitations?'
          Color = clMoneyGreen
          Constraints.MinWidth = 337
          ParentColor = False
          Transparent = False
          Layout = tlCenter
        end
        object Label31: TLabel
          Left = 13
          Top = 105
          Width = 83
          Height = 14
          Caption = 'Folic Acid intake?'
        end
        object Label32: TLabel
          Left = 13
          Top = 129
          Width = 357
          Height = 22
          AutoSize = False
          Caption = 'Calcium intake?'
          Color = clMoneyGreen
          Constraints.MinWidth = 337
          ParentColor = False
          Transparent = False
          Layout = tlCenter
        end
        object Label33: TLabel
          Left = 13
          Top = 161
          Width = 63
          Height = 14
          Caption = 'Regular diet?'
          Transparent = True
        end
        object Label34: TLabel
          Left = 13
          Top = 186
          Width = 357
          Height = 22
          AutoSize = False
          Caption = 'Caffeine intake?'
          Color = clMoneyGreen
          Constraints.MinWidth = 337
          ParentColor = False
          Transparent = False
          Layout = tlCenter
        end
        object cb3: TCheckBox
          Tag = 3
          Left = 190
          Top = 22
          Width = 46
          Height = 17
          Caption = 'YES'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 0
          OnClick = cb1Click
        end
        object cb4: TCheckBox
          Tag = 4
          Left = 243
          Top = 22
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 1
          OnClick = cb1Click
        end
        object cb5: TCheckBox
          Tag = 5
          Left = 190
          Top = 49
          Width = 46
          Height = 17
          Caption = 'YES'
          TabOrder = 3
          OnClick = cb5Click
        end
        object cb6: TCheckBox
          Tag = 6
          Left = 243
          Top = 49
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          TabOrder = 4
          OnClick = cb5Click
        end
        object cb9: TCheckBox
          Tag = 9
          Left = 190
          Top = 77
          Width = 47
          Height = 17
          Caption = 'YES'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 6
          OnClick = cb1Click
        end
        object cb10: TCheckBox
          Tag = 10
          Left = 243
          Top = 77
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 7
          OnClick = cb1Click
        end
        object le2: TLabeledEdit
          Left = 351
          Top = 19
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 2
        end
        object le3: TLabeledEdit
          Left = 351
          Top = 74
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 8
        end
        object cb11: TCheckBox
          Tag = 11
          Left = 190
          Top = 105
          Width = 48
          Height = 17
          Caption = 'YES'
          TabOrder = 9
          OnClick = cb1Click
        end
        object cb12: TCheckBox
          Tag = 12
          Left = 243
          Top = 105
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          TabOrder = 10
          OnClick = cb1Click
        end
        object cb13: TCheckBox
          Tag = 13
          Left = 190
          Top = 133
          Width = 47
          Height = 17
          Caption = 'YES'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 12
          OnClick = cb1Click
        end
        object cb14: TCheckBox
          Tag = 14
          Left = 243
          Top = 133
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 13
          OnClick = cb1Click
        end
        object cb15: TCheckBox
          Tag = 15
          Left = 190
          Top = 161
          Width = 47
          Height = 17
          Caption = 'YES'
          TabOrder = 15
          OnClick = cb1Click
        end
        object cb16: TCheckBox
          Tag = 16
          Left = 243
          Top = 161
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          TabOrder = 16
          OnClick = cb1Click
        end
        object cb17: TCheckBox
          Tag = 17
          Left = 190
          Top = 189
          Width = 47
          Height = 17
          Caption = 'YES'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 18
          OnClick = cb1Click
        end
        object cb18: TCheckBox
          Tag = 18
          Left = 243
          Top = 189
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 19
          OnClick = cb1Click
        end
        object leOther: TLabeledEdit
          Left = 47
          Top = 213
          Width = 562
          Height = 22
          EditLabel.Width = 30
          EditLabel.Height = 14
          EditLabel.Caption = 'Other:'
          LabelPosition = lpLeft
          TabOrder = 21
        end
        object le6: TLabeledEdit
          Left = 351
          Top = 158
          Width = 259
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clBtnFace
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 17
        end
        object LabeledEdit7: TLabeledEdit
          Left = 351
          Top = 46
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clBtnFace
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object LabeledEdit8: TLabeledEdit
          Left = 351
          Top = 102
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clBtnFace
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 11
        end
        object LabeledEdit9: TLabeledEdit
          Left = 351
          Top = 130
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 14
        end
        object LabeledEdit10: TLabeledEdit
          Left = 351
          Top = 186
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 20
        end
      end
      object gbRelation: TGroupBox
        Left = 0
        Top = 246
        Width = 624
        Height = 273
        Align = alClient
        Caption = 'RELATIONSHIP / SEXUAL HISTORY'
        TabOrder = 1
        object Label37: TLabel
          Left = 13
          Top = 153
          Width = 598
          Height = 42
          AutoSize = False
          Color = clMoneyGreen
          ParentColor = False
          Transparent = False
        end
        object Label36: TLabel
          Left = 13
          Top = 25
          Width = 524
          Height = 22
          AutoSize = False
          Color = clMoneyGreen
          ParentColor = False
          Transparent = False
        end
        object Label4: TLabel
          Left = 13
          Top = 98
          Width = 346
          Height = 22
          AutoSize = False
          Caption = 'Do you have sex with men?'
          Color = clMoneyGreen
          ParentColor = False
          Transparent = False
          Layout = tlCenter
        end
        object Label5: TLabel
          Left = 13
          Top = 129
          Width = 151
          Height = 14
          Caption = 'Do you have sex with women?'
        end
        object Label6: TLabel
          Left = 13
          Top = 157
          Width = 274
          Height = 14
          Caption = 'Are you satisfied with your current sexual experiences?'
          Color = clMoneyGreen
          ParentColor = False
          Transparent = False
        end
        object Label25: TLabel
          Left = 13
          Top = 204
          Width = 114
          Height = 14
          Caption = 'Interpersonal Violence?'
        end
        object Label24: TLabel
          Left = 13
          Top = 229
          Width = 357
          Height = 22
          AutoSize = False
          Caption = 'Military Sexual Trauma?'
          Color = clMoneyGreen
          ParentColor = False
          Transparent = False
          Layout = tlCenter
        end
        object Label35: TLabel
          Left = 13
          Top = 52
          Width = 296
          Height = 14
          Caption = 'Change in or more than one sexual partner in last 12 months?'
        end
        object LabeledEdit1: TLabeledEdit
          Left = 166
          Top = 25
          Width = 30
          Height = 22
          EditLabel.Width = 150
          EditLabel.Height = 14
          EditLabel.Caption = 'Age at first sexual encounter:  '
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 0
          Text = '0'
        end
        object UpDown1: TUpDown
          Left = 196
          Top = 25
          Width = 16
          Height = 22
          Associate = LabeledEdit1
          TabOrder = 1
          TabStop = True
        end
        object CheckBox2: TCheckBox
          Tag = 2
          Left = 243
          Top = 101
          Width = 41
          Height = 17
          Caption = 'NO'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 7
          OnClick = CheckBox1Click
        end
        object CheckBox1: TCheckBox
          Tag = 1
          Left = 190
          Top = 101
          Width = 44
          Height = 17
          Caption = 'YES'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 6
          OnClick = CheckBox1Click
        end
        object CheckBox4: TCheckBox
          Tag = 4
          Left = 243
          Top = 129
          Width = 41
          Height = 17
          Caption = 'NO'
          TabOrder = 10
          OnClick = CheckBox1Click
        end
        object CheckBox3: TCheckBox
          Tag = 3
          Left = 190
          Top = 129
          Width = 44
          Height = 17
          Caption = 'YES'
          TabOrder = 9
          OnClick = CheckBox1Click
        end
        object CheckBox6: TCheckBox
          Tag = 6
          Left = 243
          Top = 176
          Width = 41
          Height = 17
          Caption = 'NO'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 13
          OnClick = CheckBox1Click
        end
        object CheckBox5: TCheckBox
          Tag = 5
          Left = 190
          Top = 176
          Width = 44
          Height = 17
          Caption = 'YES'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 12
          OnClick = CheckBox1Click
        end
        object le1: TLabeledEdit
          Left = 351
          Top = 201
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clBtnFace
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 17
        end
        object cb2: TCheckBox
          Tag = 2
          Left = 243
          Top = 204
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          TabOrder = 16
          OnClick = cb1Click
        end
        object cb1: TCheckBox
          Tag = 1
          Left = 190
          Top = 204
          Width = 46
          Height = 17
          Caption = 'YES'
          TabOrder = 15
          OnClick = cb1Click
        end
        object edtBirthControl: TLabeledEdit
          Left = 424
          Top = 25
          Width = 185
          Height = 22
          EditLabel.Width = 173
          EditLabel.Height = 14
          EditLabel.Caption = 'Most Recent Method of Birth Control'
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 2
        end
        object LabeledEdit2: TLabeledEdit
          Left = 351
          Top = 173
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 14
        end
        object CheckBox7: TCheckBox
          Left = 190
          Top = 232
          Width = 49
          Height = 17
          Caption = 'YES'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 18
        end
        object CheckBox8: TCheckBox
          Left = 243
          Top = 232
          Width = 41
          Height = 17
          Caption = 'NO'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 19
        end
        object CheckBox9: TCheckBox
          Left = 190
          Top = 73
          Width = 49
          Height = 17
          Caption = 'YES'
          TabOrder = 3
        end
        object CheckBox10: TCheckBox
          Left = 243
          Top = 73
          Width = 41
          Height = 17
          Caption = 'NO'
          TabOrder = 4
        end
        object LabeledEdit11: TLabeledEdit
          Left = 351
          Top = 229
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 20
        end
        object LabeledEdit12: TLabeledEdit
          Left = 351
          Top = 70
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          LabelPosition = lpLeft
          TabOrder = 5
        end
        object LabeledEdit13: TLabeledEdit
          Left = 351
          Top = 98
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          EditLabel.Color = clMoneyGreen
          EditLabel.ParentColor = False
          LabelPosition = lpLeft
          TabOrder = 8
        end
        object LabeledEdit14: TLabeledEdit
          Left = 351
          Top = 126
          Width = 258
          Height = 22
          EditLabel.Width = 53
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments:'
          LabelPosition = lpLeft
          TabOrder = 11
        end
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Tobacco'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 511
      object gb3: TGroupBox
        Left = 0
        Top = 0
        Width = 624
        Height = 519
        Align = alClient
        Caption = 'TOBACCO USE'
        TabOrder = 0
        ExplicitHeight = 511
        object sbtnGetDate1: TSpeedButton
          Tag = 1
          Left = 316
          Top = 314
          Width = 25
          Height = 25
          Hint = 'Pick Date From Calendar'
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
          OnClick = sbtnGetDate1Click
        end
        object Label10: TLabel
          Left = 16
          Top = 48
          Width = 39
          Height = 14
          Caption = 'Smoke'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object label11: TLabel
          Left = 318
          Top = 48
          Width = 32
          Height = 14
          Caption = 'Chew'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Left = 16
          Top = 256
          Width = 153
          Height = 14
          Caption = 'Environmental/Second hand'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbnosmoke: TCheckBox
          Tag = 1
          Left = 16
          Top = 23
          Width = 450
          Height = 17
          Caption = 
            'Patient currently does not use tobacco products and is not expos' +
            'ed to tobacco products.'
          Color = clMoneyGreen
          ParentColor = False
          TabOrder = 0
          OnClick = cbnosmokeClick
        end
        object cbchew: TCheckBox
          Tag = 1
          Left = 364
          Top = 47
          Width = 50
          Height = 17
          Caption = 'YES'
          TabOrder = 6
          OnClick = cbchewClick
        end
        object gbcigarette: TGroupBox
          Left = 16
          Top = 70
          Width = 265
          Height = 54
          Caption = 'CIGARETTES'
          TabOrder = 3
          Visible = False
          object Label28: TLabel
            Left = 128
            Top = 17
            Width = 51
            Height = 14
            Caption = '# of Years'
          end
          object Label29: TLabel
            Left = 9
            Top = 17
            Width = 50
            Height = 14
            Caption = 'Packs/day'
          end
          object lblcigarette: TLabel
            Left = 9
            Top = 35
            Width = 84
            Height = 14
            Caption = 'Pack year history'
            Visible = False
          end
          object eddays: TEdit
            Left = 71
            Top = 13
            Width = 49
            Height = 22
            TabOrder = 0
          end
          object edyears: TEdit
            Left = 182
            Top = 13
            Width = 49
            Height = 22
            TabOrder = 1
            OnChange = edyearsChange
          end
        end
        object cbsmoke: TCheckBox
          Tag = 2
          Left = 65
          Top = 47
          Width = 50
          Height = 17
          Caption = 'YES'
          TabOrder = 1
          OnClick = cbsmokeClick
        end
        object ledtobacco: TLabeledEdit
          Left = 350
          Top = 316
          Width = 256
          Height = 22
          EditLabel.Width = 50
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments'
          EditLabel.Color = clBtnFace
          EditLabel.ParentColor = False
          TabOrder = 14
        end
        object gbcigar: TGroupBox
          Left = 16
          Top = 129
          Width = 265
          Height = 54
          Caption = 'CIGARS'
          TabOrder = 4
          Visible = False
          object Label1: TLabel
            Left = 128
            Top = 15
            Width = 51
            Height = 14
            Caption = '# of Years'
          end
          object Label7: TLabel
            Left = 9
            Top = 15
            Width = 50
            Height = 14
            Caption = 'Packs/day'
          end
          object lblcigar: TLabel
            Left = 9
            Top = 35
            Width = 84
            Height = 14
            Caption = 'Pack year history'
          end
          object eddays1: TEdit
            Left = 71
            Top = 11
            Width = 49
            Height = 22
            TabOrder = 0
            OnChange = eddays1Change
          end
          object edyears1: TEdit
            Left = 182
            Top = 11
            Width = 49
            Height = 22
            TabOrder = 1
            OnChange = eddays1Change
          end
        end
        object gbchew: TGroupBox
          Left = 318
          Top = 70
          Width = 288
          Height = 100
          TabOrder = 8
          Visible = False
          object ledchewday: TLabeledEdit
            Left = 123
            Top = 13
            Width = 141
            Height = 22
            EditLabel.Width = 100
            EditLabel.Height = 14
            EditLabel.Caption = 'How much each day'
            LabelPosition = lpLeft
            TabOrder = 0
          end
          object ledchewyears: TLabeledEdit
            Left = 123
            Top = 41
            Width = 141
            Height = 22
            EditLabel.Width = 51
            EditLabel.Height = 14
            EditLabel.Caption = '# of Years'
            LabelPosition = lpLeft
            TabOrder = 1
          end
          object ledepisode: TLabeledEdit
            Left = 123
            Top = 69
            Width = 140
            Height = 22
            EditLabel.Width = 114
            EditLabel.Height = 14
            EditLabel.Caption = 'How long each episode'
            LabelPosition = lpLeft
            TabOrder = 2
          end
        end
        object gbpipe: TGroupBox
          Left = 16
          Top = 188
          Width = 265
          Height = 54
          Caption = 'PIPE'
          TabOrder = 5
          Visible = False
          object Label8: TLabel
            Left = 128
            Top = 15
            Width = 51
            Height = 14
            Caption = '# of Years'
          end
          object Label9: TLabel
            Left = 9
            Top = 15
            Width = 52
            Height = 14
            Caption = 'Bowls/day'
          end
          object lblpipe: TLabel
            Left = 9
            Top = 35
            Width = 92
            Height = 14
            Caption = 'Bowls year history'
          end
          object eddays2: TEdit
            Left = 71
            Top = 11
            Width = 49
            Height = 22
            TabOrder = 0
            OnChange = eddays2Change
          end
          object edyears2: TEdit
            Left = 182
            Top = 11
            Width = 49
            Height = 22
            TabOrder = 1
            OnChange = eddays2Change
          end
        end
        object cbsecond: TCheckBox
          Left = 181
          Top = 255
          Width = 50
          Height = 17
          Hint = 'Environmental/Second hand: YES'
          Caption = 'YES'
          TabOrder = 9
          OnClick = cbsecondClick
        end
        object cbno1: TCheckBox
          Left = 122
          Top = 47
          Width = 50
          Height = 17
          Hint = 'Smoke: NO'
          Caption = 'NO'
          TabOrder = 2
          OnClick = cbno1Click
        end
        object cbno2: TCheckBox
          Left = 419
          Top = 47
          Width = 50
          Height = 17
          Hint = 'Chew: NO'
          Caption = 'NO'
          TabOrder = 7
          OnClick = cbno2Click
        end
        object cbno3: TCheckBox
          Left = 235
          Top = 255
          Width = 50
          Height = 17
          Hint = 'Environmental/Second hand: NO'
          Caption = 'NO'
          TabOrder = 10
          OnClick = cbno3Click
        end
        object ledquit: TLabeledEdit
          Left = 16
          Top = 316
          Width = 190
          Height = 22
          EditLabel.Width = 119
          EditLabel.Height = 14
          EditLabel.Caption = 'Describe Quitting History'
          TabOrder = 12
        end
        object leddate: TLabeledEdit
          Left = 212
          Top = 316
          Width = 104
          Height = 22
          EditLabel.Width = 44
          EditLabel.Height = 14
          EditLabel.Caption = 'Date Quit'
          TabOrder = 13
        end
        object ledsecond: TLabeledEdit
          Left = 481
          Top = 253
          Width = 125
          Height = 22
          EditLabel.Width = 174
          EditLabel.Height = 14
          EditLabel.Caption = 'How many hours per day exposed?'
          LabelPosition = lpLeft
          TabOrder = 11
          Visible = False
        end
      end
    end
    object TabSheet3: TTabSheet
      Caption = 'Alcohol - Drugs'
      ImageIndex = 2
      object gb4: TGroupBox
        Left = 0
        Top = 0
        Width = 624
        Height = 168
        Align = alTop
        Caption = 'ALCOHOL'
        TabOrder = 0
        object Label2: TLabel
          Left = 14
          Top = 22
          Width = 167
          Height = 14
          Caption = 'Does patient current drink alcohol?'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = []
          ParentFont = False
        end
        object SpeedButton1: TSpeedButton
          Tag = 2
          Left = 310
          Top = 131
          Width = 25
          Height = 25
          Hint = 'Pick Date From Calendar'
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
          OnClick = sbtnGetDate1Click
        end
        object cbalcoholyes: TCheckBox
          Left = 23
          Top = 38
          Width = 50
          Height = 17
          Hint = 'Does patient current drink? YES'
          Caption = 'YES'
          TabOrder = 0
          OnClick = cbalcoholyesClick
        end
        object cbalcoholno: TCheckBox
          Left = 75
          Top = 38
          Width = 38
          Height = 17
          Hint = 'Does patient current drink? NO'
          Caption = 'NO'
          TabOrder = 1
          OnClick = cbalcoholnoClick
        end
        object ledalcohol: TLabeledEdit
          Left = 342
          Top = 134
          Width = 260
          Height = 22
          EditLabel.Width = 50
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments'
          EditLabel.Color = clBtnFace
          EditLabel.ParentColor = False
          TabOrder = 5
        end
        object gbalcohol: TGroupBox
          Left = 206
          Top = 18
          Width = 396
          Height = 97
          TabOrder = 2
          Visible = False
          object Label13: TLabel
            Left = 230
            Top = 20
            Width = 57
            Height = 14
            Caption = 'How often?'
          end
          object Label14: TLabel
            Left = 230
            Top = 44
            Width = 57
            Height = 14
            Caption = 'How often?'
          end
          object Label15: TLabel
            Left = 230
            Top = 70
            Width = 57
            Height = 14
            Caption = 'How often?'
          end
          object ledwine: TLabeledEdit
            Left = 136
            Top = 16
            Width = 78
            Height = 22
            EditLabel.Width = 123
            EditLabel.Height = 14
            EditLabel.Caption = 'How many wines (6 oz)?'
            LabelPosition = lpLeft
            TabOrder = 0
          end
          object cobwine: TComboBox
            Left = 293
            Top = 16
            Width = 93
            Height = 22
            TabOrder = 1
          end
          object ledbeer: TLabeledEdit
            Left = 136
            Top = 41
            Width = 78
            Height = 22
            EditLabel.Width = 127
            EditLabel.Height = 14
            EditLabel.Caption = 'How many beers (12 oz)?'
            LabelPosition = lpLeft
            TabOrder = 2
          end
          object cobbeer: TComboBox
            Left = 293
            Top = 41
            Width = 93
            Height = 22
            TabOrder = 3
          end
          object ledspirits: TLabeledEdit
            Left = 136
            Top = 66
            Width = 78
            Height = 22
            EditLabel.Width = 122
            EditLabel.Height = 14
            EditLabel.Caption = 'How many spirits (1 oz)?'
            LabelPosition = lpLeft
            TabOrder = 4
          end
          object cobspirits: TComboBox
            Left = 293
            Top = 66
            Width = 93
            Height = 22
            TabOrder = 5
          end
        end
        object ledquitalcohol: TLabeledEdit
          Left = 14
          Top = 134
          Width = 183
          Height = 22
          EditLabel.Width = 119
          EditLabel.Height = 14
          EditLabel.Caption = 'Describe Quitting History'
          TabOrder = 3
        end
        object leddatealcohol: TLabeledEdit
          Left = 206
          Top = 134
          Width = 104
          Height = 22
          EditLabel.Width = 44
          EditLabel.Height = 14
          EditLabel.Caption = 'Date Quit'
          TabOrder = 4
        end
      end
      object gb5: TGroupBox
        Left = 0
        Top = 168
        Width = 624
        Height = 351
        Align = alClient
        Caption = 'DRUGS'
        TabOrder = 1
        object Label3: TLabel
          Left = 14
          Top = 25
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
        object SpeedButton2: TSpeedButton
          Tag = 3
          Left = 310
          Top = 205
          Width = 25
          Height = 25
          Hint = 'Pick Date From Calendar'
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
          OnClick = sbtnGetDate1Click
        end
        object cbdrugsyes: TCheckBox
          Left = 374
          Top = 25
          Width = 50
          Height = 17
          Hint = 
            'Does patient currently use recreational or non-prescribed substa' +
            'nces? YES'
          Caption = 'YES'
          TabOrder = 0
          OnClick = cbdrugsyesClick
        end
        object cbdrugsno: TCheckBox
          Left = 427
          Top = 25
          Width = 38
          Height = 17
          Hint = 
            'Does patient currently use recreational or non-prescribed substa' +
            'nces? NO'
          Caption = 'NO'
          TabOrder = 1
          OnClick = cbdrugsnoClick
        end
        object ledquitdrugs: TLabeledEdit
          Left = 14
          Top = 207
          Width = 183
          Height = 22
          EditLabel.Width = 119
          EditLabel.Height = 14
          EditLabel.Caption = 'Describe Quitting History'
          TabOrder = 3
        end
        object leddatedrugs: TLabeledEdit
          Left = 206
          Top = 207
          Width = 104
          Height = 22
          EditLabel.Width = 44
          EditLabel.Height = 14
          EditLabel.Caption = 'Date Quit'
          TabOrder = 4
        end
        object leddrugs: TLabeledEdit
          Left = 342
          Top = 207
          Width = 260
          Height = 22
          EditLabel.Width = 50
          EditLabel.Height = 14
          EditLabel.Caption = 'Comments'
          EditLabel.Color = clBtnFace
          EditLabel.ParentColor = False
          TabOrder = 5
        end
        object gbdrugs: TGroupBox
          Left = 14
          Top = 43
          Width = 588
          Height = 134
          TabOrder = 2
          Visible = False
          object Label16: TLabel
            Left = 29
            Top = 20
            Width = 46
            Height = 14
            Caption = 'Narcotics'
          end
          object Label17: TLabel
            Left = 26
            Top = 47
            Width = 49
            Height = 14
            Caption = 'Stimulants'
          end
          object Label18: TLabel
            Left = 48
            Top = 103
            Width = 27
            Height = 14
            Caption = 'Other'
          end
          object Label19: TLabel
            Left = 243
            Top = 20
            Width = 28
            Height = 14
            Caption = 'Route'
          end
          object Label20: TLabel
            Left = 243
            Top = 47
            Width = 28
            Height = 14
            Caption = 'Route'
          end
          object Label21: TLabel
            Left = 243
            Top = 76
            Width = 28
            Height = 14
            Caption = 'Route'
          end
          object Label22: TLabel
            Left = 243
            Top = 103
            Width = 28
            Height = 14
            Caption = 'Route'
          end
          object Label23: TLabel
            Left = 8
            Top = 76
            Width = 67
            Height = 14
            Caption = 'Hallucinogens'
          end
          object cobStim: TComboBox
            Left = 81
            Top = 44
            Width = 156
            Height = 22
            Hint = 'Stimulants'
            TabOrder = 3
          end
          object cobOther: TComboBox
            Left = 81
            Top = 100
            Width = 156
            Height = 22
            Hint = 'Other'
            TabOrder = 9
          end
          object cobRnarc: TComboBox
            Left = 284
            Top = 16
            Width = 115
            Height = 22
            TabOrder = 1
          end
          object cobRStim: TComboBox
            Left = 284
            Top = 44
            Width = 115
            Height = 22
            TabOrder = 4
          end
          object cobRother: TComboBox
            Left = 284
            Top = 100
            Width = 115
            Height = 22
            TabOrder = 10
          end
          object cobHall: TComboBox
            Left = 81
            Top = 72
            Width = 156
            Height = 22
            Hint = 'Hallucinogens'
            TabOrder = 6
          end
          object cobRHall: TComboBox
            Left = 284
            Top = 72
            Width = 115
            Height = 22
            TabOrder = 7
          end
          object cobnarc: TComboBox
            Left = 81
            Top = 16
            Width = 156
            Height = 22
            Hint = 'Narcotics'
            TabOrder = 0
            OnDropDown = AdvComboBoxDropDown
          end
          object LabeledEdit3: TLabeledEdit
            Left = 468
            Top = 16
            Width = 110
            Height = 22
            EditLabel.Width = 52
            EditLabel.Height = 14
            EditLabel.Caption = 'Frequency'
            LabelPosition = lpLeft
            TabOrder = 2
          end
          object LabeledEdit4: TLabeledEdit
            Left = 468
            Top = 44
            Width = 110
            Height = 22
            EditLabel.Width = 52
            EditLabel.Height = 14
            EditLabel.Caption = 'Frequency'
            LabelPosition = lpLeft
            TabOrder = 5
          end
          object LabeledEdit5: TLabeledEdit
            Left = 468
            Top = 72
            Width = 110
            Height = 22
            EditLabel.Width = 52
            EditLabel.Height = 14
            EditLabel.Caption = 'Frequency'
            LabelPosition = lpLeft
            TabOrder = 8
          end
          object LabeledEdit6: TLabeledEdit
            Left = 468
            Top = 100
            Width = 110
            Height = 22
            EditLabel.Width = 52
            EditLabel.Height = 14
            EditLabel.Caption = 'Frequency'
            LabelPosition = lpLeft
            TabOrder = 11
          end
        end
      end
    end
  end
end
