object dlgPhysicalExam: TdlgPhysicalExam
  Tag = 1
  Left = 212
  Top = 164
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = 'Physical Exam'
  ClientHeight = 417
  ClientWidth = 797
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Arial'
  Font.Style = [fsBold]
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object pnlfooter: TPanel
    Tag = 19641
    Left = 0
    Top = 388
    Width = 797
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object btnOK: TBitBtn
      Left = 640
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Caption = 'OK'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333333333333330000333333333333333333333333F33333333333
        00003333344333333333333333388F3333333333000033334224333333333333
        338338F3333333330000333422224333333333333833338F3333333300003342
        222224333333333383333338F3333333000034222A22224333333338F338F333
        8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
        33333338F83338F338F33333000033A33333A222433333338333338F338F3333
        0000333333333A222433333333333338F338F33300003333333333A222433333
        333333338F338F33000033333333333A222433333333333338F338F300003333
        33333333A222433333333333338F338F00003333333333333A22433333333333
        3338F38F000033333333333333A223333333333333338F830000333333333333
        333A333333333333333338330000333333333333333333333333333333333333
        0000}
      ModalResult = 1
      NumGlyphs = 2
      TabOrder = 1
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 721
      Top = 3
      Width = 75
      Height = 25
      Align = alCustom
      Anchors = [akTop, akRight]
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 2
    end
    object btnNorm: TBitBtn
      Left = 2
      Top = 3
      Width = 96
      Height = 25
      Align = alCustom
      Caption = 'Normal for all'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = [fsUnderline]
      NumGlyphs = 2
      ParentFont = False
      TabOrder = 0
      OnClick = btnNormClick
    end
  end
  object pgBody: TPageControl
    Left = 0
    Top = 0
    Width = 797
    Height = 388
    ActivePage = TabSheet1
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Arial'
    Font.Style = []
    MultiLine = True
    ParentFont = False
    TabOrder = 0
    TabPosition = tpRight
    object TabSheet1: TTabSheet
      Caption = 'Page 1'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Arial'
      Font.Style = []
      ParentFont = False
      object lbComment: TLabel
        Left = 406
        Top = 8
        Width = 350
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
      object lbTreatment: TLabel
        Left = 279
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
      object ORDateBox7: TORDateBox
        Tag = 7
        Left = 279
        Top = 164
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 27
        DateOnly = False
        RequireTime = False
        Caption = 'Neck treatment date'
      end
      object Edit14: TEdit
        Tag = 14
        Left = 406
        Top = 325
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 56
        OnEnter = EditReadMe
      end
      object ORDateBox14: TORDateBox
        Tag = 14
        Left = 279
        Top = 325
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 55
        DateOnly = False
        RequireTime = False
        Caption = 'Integumentary treatment date'
      end
      object ORDateBox9: TORDateBox
        Tag = 9
        Left = 279
        Top = 210
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 35
        DateOnly = False
        RequireTime = False
        Caption = 'Thorax and or Lungs treatment date'
      end
      object ORDateBox8: TORDateBox
        Tag = 8
        Left = 279
        Top = 187
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 31
        DateOnly = False
        RequireTime = False
        Caption = 'Breasts treatment date'
      end
      object ORDateBox6: TORDateBox
        Tag = 6
        Left = 279
        Top = 141
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 23
        DateOnly = False
        RequireTime = False
        Caption = 'Endocrine treatment date'
      end
      object ORDateBox5: TORDateBox
        Tag = 5
        Left = 279
        Top = 118
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 19
        DateOnly = False
        RequireTime = False
        Caption = 'Teeth treatment date'
      end
      object ORDateBox4: TORDateBox
        Tag = 4
        Left = 279
        Top = 95
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 15
        DateOnly = False
        RequireTime = False
        Caption = 'Fundi treatment date'
      end
      object ORDateBox3: TORDateBox
        Tag = 3
        Left = 279
        Top = 72
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 11
        DateOnly = False
        RequireTime = False
        Caption = 'Mouth treatment date'
      end
      object ORDateBox2: TORDateBox
        Tag = 2
        Left = 279
        Top = 49
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 7
        DateOnly = False
        RequireTime = False
        Caption = 'Psych treatment date'
      end
      object ORDateBox13: TORDateBox
        Tag = 13
        Left = 279
        Top = 302
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 51
        DateOnly = False
        RequireTime = False
        Caption = 'Musculoskeletal treatment date'
      end
      object ORDateBox12: TORDateBox
        Tag = 12
        Left = 279
        Top = 279
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 47
        DateOnly = False
        RequireTime = False
        Caption = 'Abdomen treatment date'
      end
      object ORDateBox11: TORDateBox
        Tag = 11
        Left = 279
        Top = 256
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 43
        DateOnly = False
        RequireTime = False
        Caption = 'Cardiovascular treatment date'
      end
      object ORDateBox10: TORDateBox
        Tag = 10
        Left = 279
        Top = 233
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 39
        DateOnly = False
        RequireTime = False
        Caption = 'Heart treatment date'
      end
      object ORDateBox1: TORDateBox
        Tag = 1
        Left = 279
        Top = 26
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 3
        DateOnly = False
        RequireTime = False
        Caption = 'General treatment date'
      end
      object Edit9: TEdit
        Tag = 9
        Left = 406
        Top = 210
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 36
        OnEnter = EditReadMe
      end
      object Edit8: TEdit
        Tag = 8
        Left = 406
        Top = 187
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 32
        OnEnter = EditReadMe
      end
      object Edit7: TEdit
        Tag = 7
        Left = 406
        Top = 164
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 28
        OnEnter = EditReadMe
      end
      object Edit6: TEdit
        Tag = 6
        Left = 406
        Top = 141
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 24
        OnEnter = EditReadMe
      end
      object Edit5: TEdit
        Tag = 5
        Left = 406
        Top = 118
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 20
        OnEnter = EditReadMe
      end
      object Edit4: TEdit
        Tag = 4
        Left = 406
        Top = 95
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 16
        OnEnter = EditReadMe
      end
      object Edit3: TEdit
        Tag = 3
        Left = 406
        Top = 72
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 12
        OnEnter = EditReadMe
      end
      object Edit2: TEdit
        Tag = 2
        Left = 406
        Top = 49
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 8
        OnEnter = EditReadMe
      end
      object Edit13: TEdit
        Tag = 13
        Left = 406
        Top = 302
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 52
        OnEnter = EditReadMe
      end
      object Edit12: TEdit
        Tag = 12
        Left = 406
        Top = 279
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 48
        OnEnter = EditReadMe
      end
      object Edit11: TEdit
        Tag = 11
        Left = 406
        Top = 256
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 44
        OnEnter = EditReadMe
      end
      object Edit10: TEdit
        Tag = 10
        Left = 406
        Top = 233
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 40
        OnEnter = EditReadMe
      end
      object Edit1: TEdit
        Tag = 1
        Left = 406
        Top = 26
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 4
        OnEnter = EditReadMe
      end
      object CheckBox1: TCheckBox
        Tag = 1
        Left = 140
        Top = 29
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = CheckBoxClick
      end
      object CheckBox2: TCheckBox
        Tag = 1
        Left = 202
        Top = 29
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = CheckBoxClick
      end
      object CheckBox4: TCheckBox
        Tag = 2
        Left = 140
        Top = 52
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = CheckBoxClick
      end
      object CheckBox5: TCheckBox
        Tag = 2
        Left = 202
        Top = 52
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = CheckBoxClick
      end
      object CheckBox7: TCheckBox
        Tag = 3
        Left = 140
        Top = 75
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = CheckBoxClick
      end
      object CheckBox8: TCheckBox
        Tag = 3
        Left = 202
        Top = 75
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = CheckBoxClick
      end
      object CheckBox10: TCheckBox
        Tag = 4
        Left = 140
        Top = 98
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = CheckBoxClick
      end
      object CheckBox11: TCheckBox
        Tag = 4
        Left = 202
        Top = 98
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        OnClick = CheckBoxClick
      end
      object CheckBox13: TCheckBox
        Tag = 5
        Left = 140
        Top = 121
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = CheckBoxClick
      end
      object CheckBox14: TCheckBox
        Tag = 5
        Left = 202
        Top = 121
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        OnClick = CheckBoxClick
      end
      object CheckBox16: TCheckBox
        Tag = 6
        Left = 140
        Top = 144
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
        OnClick = CheckBoxClick
      end
      object CheckBox17: TCheckBox
        Tag = 6
        Left = 202
        Top = 144
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
        OnClick = CheckBoxClick
      end
      object CheckBox19: TCheckBox
        Tag = 7
        Left = 140
        Top = 167
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        OnClick = CheckBoxClick
      end
      object CheckBox20: TCheckBox
        Tag = 7
        Left = 202
        Top = 167
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
        OnClick = CheckBoxClick
      end
      object CheckBox22: TCheckBox
        Tag = 8
        Left = 140
        Top = 190
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 29
        OnClick = CheckBoxClick
      end
      object CheckBox23: TCheckBox
        Tag = 8
        Left = 202
        Top = 190
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 30
        OnClick = CheckBoxClick
      end
      object CheckBox25: TCheckBox
        Tag = 9
        Left = 140
        Top = 213
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 33
        OnClick = CheckBoxClick
      end
      object CheckBox26: TCheckBox
        Tag = 9
        Left = 202
        Top = 213
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 34
        OnClick = CheckBoxClick
      end
      object CheckBox28: TCheckBox
        Tag = 10
        Left = 140
        Top = 236
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 37
        OnClick = CheckBoxClick
      end
      object CheckBox29: TCheckBox
        Tag = 10
        Left = 202
        Top = 236
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 38
        OnClick = CheckBoxClick
      end
      object CheckBox31: TCheckBox
        Tag = 11
        Left = 140
        Top = 259
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 41
        OnClick = CheckBoxClick
      end
      object CheckBox32: TCheckBox
        Tag = 11
        Left = 202
        Top = 259
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 42
        OnClick = CheckBoxClick
      end
      object CheckBox34: TCheckBox
        Tag = 12
        Left = 140
        Top = 282
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 45
        OnClick = CheckBoxClick
      end
      object CheckBox35: TCheckBox
        Tag = 12
        Left = 202
        Top = 282
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 46
        OnClick = CheckBoxClick
      end
      object CheckBox37: TCheckBox
        Tag = 13
        Left = 140
        Top = 305
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 49
        OnClick = CheckBoxClick
      end
      object CheckBox38: TCheckBox
        Tag = 13
        Left = 202
        Top = 305
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 50
        OnClick = CheckBoxClick
      end
      object CheckBox40: TCheckBox
        Tag = 14
        Left = 140
        Top = 328
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 53
        OnClick = CheckBoxClick
      end
      object CheckBox41: TCheckBox
        Tag = 14
        Left = 202
        Top = 328
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 54
        OnClick = CheckBoxClick
      end
      object CheckBox3: TCheckBox
        Tag = 15
        Left = 140
        Top = 351
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 57
        OnClick = CheckBoxClick
      end
      object CheckBox6: TCheckBox
        Tag = 15
        Left = 202
        Top = 351
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 58
        OnClick = CheckBoxClick
      end
      object pnllabels1: TPanel
        Left = 7
        Top = 18
        Width = 123
        Height = 359
        BevelOuter = bvNone
        TabOrder = 0
        object Label2: TLabel
          Tag = 2
          Left = 4
          Top = 34
          Width = 33
          Height = 14
          Caption = 'Psych'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label1: TLabel
          Tag = 1
          Left = 4
          Top = 11
          Width = 43
          Height = 14
          Caption = 'General'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label3: TLabel
          Tag = 3
          Left = 4
          Top = 57
          Width = 35
          Height = 14
          Caption = 'Mouth'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ShowAccelChar = False
        end
        object Label4: TLabel
          Tag = 4
          Left = 4
          Top = 80
          Width = 30
          Height = 14
          Caption = 'Fundi'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label5: TLabel
          Tag = 5
          Left = 4
          Top = 103
          Width = 31
          Height = 14
          Caption = 'Teeth'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label6: TLabel
          Tag = 6
          Left = 4
          Top = 126
          Width = 55
          Height = 14
          Caption = 'Endocrine'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label7: TLabel
          Tag = 7
          Left = 4
          Top = 149
          Width = 27
          Height = 14
          Caption = 'Neck'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label8: TLabel
          Tag = 8
          Left = 4
          Top = 172
          Width = 43
          Height = 14
          Caption = 'Breasts'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label9: TLabel
          Tag = 9
          Left = 4
          Top = 195
          Width = 114
          Height = 14
          Caption = 'Thorax and or Lungs'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label10: TLabel
          Tag = 10
          Left = 4
          Top = 218
          Width = 29
          Height = 14
          Caption = 'Heart'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label11: TLabel
          Tag = 11
          Left = 4
          Top = 241
          Width = 82
          Height = 14
          Caption = 'Cardiovascular'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label12: TLabel
          Tag = 12
          Left = 4
          Top = 264
          Width = 54
          Height = 14
          Caption = 'Abdomen'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label13: TLabel
          Tag = 13
          Left = 4
          Top = 287
          Width = 91
          Height = 14
          Caption = 'Musculoskeletal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label14: TLabel
          Tag = 14
          Left = 4
          Top = 310
          Width = 81
          Height = 14
          Caption = 'Integumentary'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label15: TLabel
          Tag = 15
          Left = 4
          Top = 333
          Width = 63
          Height = 14
          Caption = 'Extremities'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object Edit19: TEdit
        Tag = 15
        Left = 406
        Top = 348
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 60
        OnEnter = EditReadMe
      end
      object ORDateBox15: TORDateBox
        Tag = 15
        Left = 279
        Top = 348
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 59
        DateOnly = False
        RequireTime = False
        Caption = 'Integumentary treatment date'
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Page 2'
      object Label31: TLabel
        Left = 279
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
      object Label32: TLabel
        Left = 406
        Top = 8
        Width = 350
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
      object lbOther: TLabel
        Tag = 14
        Left = 11
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
      object CheckBox9: TCheckBox
        Tag = 18
        Left = 202
        Top = 75
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 10
        OnClick = CheckBoxClick
      end
      object pnllabels2: TPanel
        Left = 7
        Top = 18
        Width = 114
        Height = 297
        BevelOuter = bvNone
        TabOrder = 0
        object Label16: TLabel
          Tag = 17
          Left = 4
          Top = 34
          Width = 76
          Height = 14
          Caption = 'Lymph Nodes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label17: TLabel
          Tag = 16
          Left = 4
          Top = 11
          Width = 24
          Height = 14
          Caption = 'Ears'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label18: TLabel
          Tag = 18
          Left = 4
          Top = 57
          Width = 26
          Height = 14
          Caption = 'Eyes'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          ShowAccelChar = False
        end
        object Label19: TLabel
          Tag = 19
          Left = 4
          Top = 80
          Width = 27
          Height = 14
          Caption = 'Head'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label20: TLabel
          Tag = 20
          Left = 4
          Top = 103
          Width = 26
          Height = 14
          Caption = 'Back'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label21: TLabel
          Tag = 21
          Left = 4
          Top = 126
          Width = 58
          Height = 14
          Caption = 'Chest Wall'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label22: TLabel
          Tag = 22
          Left = 4
          Top = 149
          Width = 64
          Height = 14
          Caption = 'Respiratory'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label23: TLabel
          Tag = 23
          Left = 4
          Top = 172
          Width = 45
          Height = 14
          Caption = 'Vessels'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label24: TLabel
          Tag = 24
          Left = 4
          Top = 195
          Width = 59
          Height = 14
          Caption = 'Neurologic'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label25: TLabel
          Tag = 25
          Left = 4
          Top = 218
          Width = 47
          Height = 14
          Caption = 'Genitalia'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label26: TLabel
          Tag = 26
          Left = 4
          Top = 241
          Width = 42
          Height = 14
          Caption = 'Rectum'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label27: TLabel
          Tag = 27
          Left = 4
          Top = 264
          Width = 99
          Height = 28
          Caption = 'Visible Implanted Medical Devices'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Arial'
          Font.Style = [fsBold]
          ParentFont = False
          WordWrap = True
        end
      end
      object CheckBox12: TCheckBox
        Tag = 16
        Left = 140
        Top = 29
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 1
        OnClick = CheckBoxClick
      end
      object CheckBox15: TCheckBox
        Tag = 16
        Left = 202
        Top = 29
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 2
        OnClick = CheckBoxClick
      end
      object CheckBox18: TCheckBox
        Tag = 17
        Left = 140
        Top = 52
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        OnClick = CheckBoxClick
      end
      object CheckBox21: TCheckBox
        Tag = 17
        Left = 202
        Top = 52
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 6
        OnClick = CheckBoxClick
      end
      object CheckBox24: TCheckBox
        Tag = 18
        Left = 140
        Top = 75
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 9
        OnClick = CheckBoxClick
      end
      object CheckBox27: TCheckBox
        Tag = 19
        Left = 140
        Top = 98
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 13
        OnClick = CheckBoxClick
      end
      object CheckBox30: TCheckBox
        Tag = 19
        Left = 202
        Top = 98
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 14
        OnClick = CheckBoxClick
      end
      object CheckBox33: TCheckBox
        Tag = 20
        Left = 140
        Top = 121
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 17
        OnClick = CheckBoxClick
      end
      object CheckBox36: TCheckBox
        Tag = 20
        Left = 202
        Top = 121
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 18
        OnClick = CheckBoxClick
      end
      object CheckBox39: TCheckBox
        Tag = 21
        Left = 140
        Top = 144
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 21
        OnClick = CheckBoxClick
      end
      object CheckBox42: TCheckBox
        Tag = 21
        Left = 202
        Top = 144
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 22
        OnClick = CheckBoxClick
      end
      object CheckBox43: TCheckBox
        Tag = 22
        Left = 140
        Top = 167
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 25
        OnClick = CheckBoxClick
      end
      object CheckBox44: TCheckBox
        Tag = 22
        Left = 202
        Top = 167
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 26
        OnClick = CheckBoxClick
      end
      object CheckBox45: TCheckBox
        Tag = 23
        Left = 140
        Top = 190
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 29
        OnClick = CheckBoxClick
      end
      object CheckBox46: TCheckBox
        Tag = 23
        Left = 202
        Top = 190
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 30
        OnClick = CheckBoxClick
      end
      object CheckBox47: TCheckBox
        Tag = 24
        Left = 140
        Top = 213
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 33
        OnClick = CheckBoxClick
      end
      object CheckBox48: TCheckBox
        Tag = 24
        Left = 202
        Top = 213
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 34
        OnClick = CheckBoxClick
      end
      object CheckBox49: TCheckBox
        Tag = 25
        Left = 140
        Top = 236
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 37
        OnClick = CheckBoxClick
      end
      object CheckBox50: TCheckBox
        Tag = 25
        Left = 202
        Top = 236
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 38
        OnClick = CheckBoxClick
      end
      object CheckBox51: TCheckBox
        Tag = 26
        Left = 140
        Top = 259
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 41
        OnClick = CheckBoxClick
      end
      object CheckBox52: TCheckBox
        Tag = 26
        Left = 202
        Top = 259
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 42
        OnClick = CheckBoxClick
      end
      object CheckBox53: TCheckBox
        Tag = 27
        Left = 140
        Top = 282
        Width = 57
        Height = 17
        Caption = 'Normal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 45
        OnClick = CheckBoxClick
      end
      object CheckBox54: TCheckBox
        Tag = 27
        Left = 202
        Top = 282
        Width = 70
        Height = 17
        Caption = 'Abnormal'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Arial'
        Font.Style = []
        ParentFont = False
        TabOrder = 46
        OnClick = CheckBoxClick
      end
      object Edit15: TEdit
        Tag = 16
        Left = 406
        Top = 26
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 4
        OnEnter = EditReadMe
      end
      object Edit16: TEdit
        Tag = 25
        Left = 406
        Top = 233
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 40
        OnEnter = EditReadMe
      end
      object Edit17: TEdit
        Tag = 26
        Left = 406
        Top = 256
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 44
        OnEnter = EditReadMe
      end
      object Edit18: TEdit
        Tag = 27
        Left = 406
        Top = 279
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 48
        OnEnter = EditReadMe
      end
      object Edit20: TEdit
        Tag = 17
        Left = 406
        Top = 49
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 8
        OnEnter = EditReadMe
      end
      object Edit21: TEdit
        Tag = 18
        Left = 406
        Top = 72
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 12
        OnEnter = EditReadMe
      end
      object Edit22: TEdit
        Tag = 19
        Left = 406
        Top = 95
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 16
        OnEnter = EditReadMe
      end
      object Edit23: TEdit
        Tag = 20
        Left = 406
        Top = 118
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 20
        OnEnter = EditReadMe
      end
      object Edit24: TEdit
        Tag = 21
        Left = 406
        Top = 141
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 24
        OnEnter = EditReadMe
      end
      object Edit25: TEdit
        Tag = 22
        Left = 406
        Top = 164
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 28
        OnEnter = EditReadMe
      end
      object Edit26: TEdit
        Tag = 23
        Left = 406
        Top = 187
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 32
        OnEnter = EditReadMe
      end
      object Edit27: TEdit
        Tag = 24
        Left = 406
        Top = 210
        Width = 350
        Height = 22
        Enabled = False
        TabOrder = 36
        OnEnter = EditReadMe
      end
      object ORDateBox16: TORDateBox
        Tag = 16
        Left = 279
        Top = 26
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 3
        DateOnly = False
        RequireTime = False
        Caption = 'Ears treatment date'
      end
      object ORDateBox17: TORDateBox
        Tag = 25
        Left = 279
        Top = 233
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 39
        DateOnly = False
        RequireTime = False
        Caption = 'Genitalia treatment date'
      end
      object ORDateBox18: TORDateBox
        Tag = 26
        Left = 279
        Top = 256
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 43
        DateOnly = False
        RequireTime = False
        Caption = 'Rectum treatment date'
      end
      object ORDateBox19: TORDateBox
        Tag = 27
        Left = 279
        Top = 279
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 47
        DateOnly = False
        RequireTime = False
        Caption = 'Visible Implanted Medical Devices treatment date'
      end
      object ORDateBox21: TORDateBox
        Tag = 17
        Left = 279
        Top = 49
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 7
        DateOnly = False
        RequireTime = False
        Caption = 'Lymph Nodes treatment date'
      end
      object ORDateBox22: TORDateBox
        Tag = 18
        Left = 279
        Top = 72
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 11
        DateOnly = False
        RequireTime = False
        Caption = 'Eyes treatment date'
      end
      object ORDateBox23: TORDateBox
        Tag = 19
        Left = 279
        Top = 95
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 15
        DateOnly = False
        RequireTime = False
        Caption = 'Head treatment date'
      end
      object ORDateBox24: TORDateBox
        Tag = 20
        Left = 279
        Top = 118
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 19
        DateOnly = False
        RequireTime = False
        Caption = 'Back treatment date'
      end
      object ORDateBox25: TORDateBox
        Tag = 21
        Left = 279
        Top = 141
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 23
        DateOnly = False
        RequireTime = False
        Caption = 'Chest Wall treatment date'
      end
      object ORDateBox26: TORDateBox
        Tag = 23
        Left = 279
        Top = 187
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 31
        DateOnly = False
        RequireTime = False
        Caption = 'Vessels treatment date'
      end
      object ORDateBox27: TORDateBox
        Tag = 24
        Left = 279
        Top = 210
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 35
        DateOnly = False
        RequireTime = False
        Caption = 'Neurologic treatment date'
      end
      object ORDateBox29: TORDateBox
        Tag = 22
        Left = 279
        Top = 164
        Width = 121
        Height = 22
        Enabled = False
        TabOrder = 27
        DateOnly = False
        RequireTime = False
        Caption = 'Respiratory treatment date'
      end
      object dtOther: TORDateBox
        Left = 279
        Top = 325
        Width = 121
        Height = 22
        TabOrder = 50
        DateOnly = False
        RequireTime = False
        Caption = 'Other treatment date'
      end
      object edOtherComments: TEdit
        Left = 406
        Top = 325
        Width = 350
        Height = 22
        TabOrder = 51
      end
      object edOther: TEdit
        Left = 54
        Top = 325
        Width = 219
        Height = 22
        TabOrder = 49
      end
    end
  end
end
