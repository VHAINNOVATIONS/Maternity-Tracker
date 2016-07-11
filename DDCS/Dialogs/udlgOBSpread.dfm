object dlgOBSpread: TdlgOBSpread
  Left = 186
  Top = 176
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = 'OB Exam Flow Sheet'
  ClientHeight = 568
  ClientWidth = 1188
  Color = clBtnFace
  Constraints.MinHeight = 565
  Constraints.MinWidth = 990
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = DialogClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblPresentation: TLabel
    Left = 707
    Top = 261
    Width = 59
    Height = 13
    Caption = 'Presentation'
  end
  object lblFetalActivity: TLabel
    Left = 247
    Top = 261
    Width = 60
    Height = 13
    Caption = 'Fetal Activity'
  end
  object lblUrineProtien: TLabel
    Left = 321
    Top = 261
    Width = 61
    Height = 13
    Caption = 'Urine Protein'
  end
  object lblUrineSugar: TLabel
    Left = 401
    Top = 261
    Width = 67
    Height = 13
    Caption = 'Urine Glucose'
  end
  object lblEdema: TLabel
    Left = 491
    Top = 261
    Width = 33
    Height = 13
    Caption = 'Edema'
  end
  object lblFetalHeart: TLabel
    Left = 574
    Top = 261
    Width = 52
    Height = 13
    Caption = 'Fetal Heart'
  end
  object lbledtAge: TLabeledEdit
    Left = 2
    Top = 277
    Width = 61
    Height = 21
    EditLabel.Width = 59
    EditLabel.Height = 13
    EditLabel.Caption = 'Age (weeks)'
    NumbersOnly = True
    TabOrder = 17
  end
  object lbledtFndHt: TLabeledEdit
    Left = 69
    Top = 277
    Width = 41
    Height = 21
    EditLabel.Width = 46
    EditLabel.Height = 13
    EditLabel.Caption = 'Fundal Ht'
    NumbersOnly = True
    TabOrder = 3
    Text = '6'
  end
  object udFundalHt: TUpDown
    Left = 110
    Top = 277
    Width = 15
    Height = 21
    Associate = lbledtFndHt
    Min = 6
    Max = 45
    Position = 6
    TabOrder = 4
    TabStop = True
  end
  object lblWt: TLabeledEdit
    Left = 131
    Top = 277
    Width = 41
    Height = 21
    EditLabel.Width = 34
    EditLabel.Height = 13
    EditLabel.Caption = 'Weight'
    NumbersOnly = True
    ReadOnly = True
    TabOrder = 5
  end
  object lblBP: TLabeledEdit
    Left = 178
    Top = 277
    Width = 63
    Height = 21
    EditLabel.Width = 14
    EditLabel.Height = 13
    EditLabel.Caption = 'BP'
    ReadOnly = True
    TabOrder = 6
  end
  object cmbPres: TComboBox
    Left = 707
    Top = 277
    Width = 124
    Height = 21
    Style = csDropDownList
    TabOrder = 15
  end
  object cmbFetAct: TComboBox
    Left = 247
    Top = 277
    Width = 68
    Height = 21
    Style = csDropDownList
    TabOrder = 7
  end
  object cmbProtein: TComboBox
    Left = 321
    Top = 277
    Width = 74
    Height = 21
    Style = csDropDownList
    TabOrder = 8
  end
  object cmbSugar: TComboBox
    Left = 401
    Top = 277
    Width = 84
    Height = 21
    Style = csDropDownList
    TabOrder = 9
  end
  object cmbEdema: TComboBox
    Left = 491
    Top = 277
    Width = 77
    Height = 21
    Style = csDropDownList
    TabOrder = 10
  end
  object cmbHeart: TComboBox
    Left = 574
    Top = 277
    Width = 64
    Height = 21
    Style = csDropDownList
    DropDownCount = 10
    TabOrder = 11
    OnChange = cmbHeartChange
    Items.Strings = (
      'No'
      'Yes - 1'
      'Yes - 2'
      'Yes - 3')
  end
  object leRate: TLabeledEdit
    Left = 644
    Top = 277
    Width = 45
    Height = 21
    EditLabel.Width = 23
    EditLabel.Height = 13
    EditLabel.Caption = 'Rate'
    TabOrder = 12
    Visible = False
  end
  object leRate2: TLabeledEdit
    Left = 644
    Top = 304
    Width = 45
    Height = 21
    EditLabel.Width = 9
    EditLabel.Height = 13
    EditLabel.Caption = ' 2'
    LabelPosition = lpRight
    TabOrder = 13
    Visible = False
  end
  object leRate3: TLabeledEdit
    Left = 644
    Top = 331
    Width = 45
    Height = 21
    EditLabel.Width = 9
    EditLabel.Height = 13
    EditLabel.Caption = ' 3'
    LabelPosition = lpRight
    TabOrder = 14
    Visible = False
  end
  object sgStandard: TJvStringGrid
    Left = 0
    Top = 0
    Width = 1188
    Height = 241
    ParentCustomHint = False
    Align = alTop
    ColCount = 13
    DefaultColWidth = 70
    DefaultRowHeight = 21
    DrawingStyle = gdsGradient
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving, goEditing, goTabs, goRowSelect, goFixedColClick]
    TabOrder = 0
    OnSelectCell = sgStandardSelectCell
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'MS Sans Serif'
    FixedFont.Style = [fsBold]
    OnCaptionClick = GridSortColumn
    ColWidths = (
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70
      70)
    RowHeights = (
      21
      21)
  end
  object cbCervical: TLabeledEdit
    Left = 837
    Top = 277
    Width = 121
    Height = 21
    EditLabel.Width = 67
    EditLabel.Height = 13
    EditLabel.Caption = 'Cervical Exam'
    TabOrder = 16
  end
  object grbxExamDate: TGroupBox
    Left = 19
    Top = 339
    Width = 153
    Height = 137
    Caption = 'Exam Date'
    TabOrder = 2
    Visible = False
    object btnDelete: TBitBtn
      Left = 9
      Top = 101
      Width = 136
      Height = 25
      Caption = 'Delete'
      TabOrder = 0
      OnClick = btnDeleteRowClick
    end
    object dtExamDate: TORDateBox
      Left = 9
      Top = 24
      Width = 136
      Height = 21
      TabOrder = 1
      Text = 'dtExamDate'
      DateOnly = False
      RequireTime = False
      Caption = ''
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 536
    Width = 1188
    Height = 32
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1188
      32)
    object bbtnOK: TBitBtn
      Left = 1032
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
      Default = True
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
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 1113
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object btnAddRow: TBitBtn
      Left = 119
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Add Row'
      TabOrder = 2
      Visible = False
      OnClick = btnAddRowClick
    end
  end
end
