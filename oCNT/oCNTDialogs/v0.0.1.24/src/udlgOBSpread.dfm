object dlgOBSpread: TdlgOBSpread
  Left = 186
  Top = 176
  BorderIcons = []
  Caption = 'OB Exam Flow Sheet'
  ClientHeight = 565
  ClientWidth = 990
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
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    990
    565)
  PixelsPerInch = 96
  TextHeight = 13
  object pgcOBFlow: TPageControl
    Left = 0
    Top = 0
    Width = 990
    Height = 565
    ActivePage = tsDiabetic
    Align = alClient
    TabOrder = 0
    OnChange = pgcOBFlowChange
    object tsStandard: TTabSheet
      Caption = 'Exam'
      object lblPresentation: TLabel
        Left = 715
        Top = 205
        Width = 59
        Height = 13
        Caption = 'Presentation'
      end
      object lblFetalActivity: TLabel
        Left = 255
        Top = 205
        Width = 60
        Height = 13
        Caption = 'Fetal Activity'
      end
      object lblUrineProtien: TLabel
        Left = 329
        Top = 205
        Width = 61
        Height = 13
        Caption = 'Urine Protein'
      end
      object lblUrineSugar: TLabel
        Left = 409
        Top = 205
        Width = 67
        Height = 13
        Caption = 'Urine Glucose'
      end
      object lblEdema: TLabel
        Left = 499
        Top = 205
        Width = 33
        Height = 13
        Caption = 'Edema'
      end
      object lblFetalHeart: TLabel
        Left = 582
        Top = 205
        Width = 52
        Height = 13
        Caption = 'Fetal Heart'
      end
      object lbledtAge: TLabeledEdit
        Left = 10
        Top = 221
        Width = 61
        Height = 21
        EditLabel.Width = 59
        EditLabel.Height = 13
        EditLabel.Caption = 'Age (weeks)'
        NumbersOnly = True
        TabOrder = 2
      end
      object lbledtFndHt: TLabeledEdit
        Left = 77
        Top = 221
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
        Left = 118
        Top = 221
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
        Left = 139
        Top = 221
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
        Left = 186
        Top = 221
        Width = 63
        Height = 21
        EditLabel.Width = 14
        EditLabel.Height = 13
        EditLabel.Caption = 'BP'
        ReadOnly = True
        TabOrder = 6
      end
      object cmbPres: TComboBox
        Left = 715
        Top = 221
        Width = 124
        Height = 21
        Style = csDropDownList
        TabOrder = 15
      end
      object cmbFetAct: TComboBox
        Left = 255
        Top = 221
        Width = 68
        Height = 21
        Style = csDropDownList
        TabOrder = 7
      end
      object cmbProtein: TComboBox
        Left = 329
        Top = 221
        Width = 74
        Height = 21
        Style = csDropDownList
        TabOrder = 8
      end
      object cmbSugar: TComboBox
        Left = 409
        Top = 221
        Width = 84
        Height = 21
        Style = csDropDownList
        TabOrder = 9
      end
      object cmbEdema: TComboBox
        Left = 499
        Top = 221
        Width = 77
        Height = 21
        Style = csDropDownList
        TabOrder = 10
      end
      object cmbHeart: TComboBox
        Left = 582
        Top = 221
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
        Left = 652
        Top = 221
        Width = 45
        Height = 21
        EditLabel.Width = 23
        EditLabel.Height = 13
        EditLabel.Caption = 'Rate'
        TabOrder = 12
        Visible = False
      end
      object leRate2: TLabeledEdit
        Left = 652
        Top = 248
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
        Left = 652
        Top = 275
        Width = 45
        Height = 21
        EditLabel.Width = 9
        EditLabel.Height = 13
        EditLabel.Caption = ' 3'
        LabelPosition = lpRight
        TabOrder = 14
        Visible = False
      end
      object rdgrbxStandardExamDate: TRadioGroup
        Left = 10
        Top = 254
        Width = 99
        Height = 137
        Caption = 'Exam Date'
        Items.Strings = (
          'Today'
          'Yesterday'
          '2 Days Ago'
          '3 Days Ago'
          '4 Days Ago')
        TabOrder = 1
        TabStop = True
        OnClick = rdgrbxStandardExamDateClick
      end
      object sgStandard: TJvStringGrid
        Left = 0
        Top = 0
        Width = 982
        Height = 185
        Align = alTop
        ColCount = 13
        DefaultColWidth = 70
        DefaultRowHeight = 21
        DrawingStyle = gdsGradient
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving, goColMoving, goTabs, goRowSelect, goFixedColClick]
        TabOrder = 0
        OnSelectCell = sgStandardSelectCell
        Alignment = taLeftJustify
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = [fsBold]
        OnCaptionClick = GridSortColumn
      end
      object btnCustAdd: TButton
        Left = 163
        Top = 291
        Width = 121
        Height = 25
        Caption = 'Add Custom Column'
        TabOrder = 17
        Visible = False
        OnClick = btnCustAddClick
      end
      object custCol1: TLabeledEdit
        Tag = 1
        Left = 163
        Top = 351
        Width = 121
        Height = 21
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'Column Name:'
        TabOrder = 18
        Visible = False
      end
      object custVal1: TEdit
        Tag = 1
        Left = 163
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 19
        Visible = False
      end
      object custCol2: TLabeledEdit
        Tag = 2
        Left = 290
        Top = 351
        Width = 121
        Height = 21
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'Column Name:'
        TabOrder = 20
        Visible = False
      end
      object custVal2: TEdit
        Tag = 2
        Left = 290
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 21
        Visible = False
      end
      object custCol3: TLabeledEdit
        Tag = 3
        Left = 417
        Top = 351
        Width = 121
        Height = 21
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'Column Name:'
        TabOrder = 22
        Visible = False
      end
      object custVal3: TEdit
        Tag = 3
        Left = 417
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 23
        Visible = False
      end
      object custCol4: TLabeledEdit
        Tag = 4
        Left = 544
        Top = 351
        Width = 121
        Height = 21
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'Column Name:'
        TabOrder = 24
        Visible = False
      end
      object custVal4: TEdit
        Tag = 4
        Left = 544
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 25
        Visible = False
      end
      object custCol5: TLabeledEdit
        Tag = 5
        Left = 671
        Top = 351
        Width = 121
        Height = 21
        EditLabel.Width = 69
        EditLabel.Height = 13
        EditLabel.Caption = 'Column Name:'
        TabOrder = 26
        Visible = False
      end
      object custVal5: TEdit
        Tag = 5
        Left = 671
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 27
        Visible = False
      end
      object cbCervical: TLabeledEdit
        Left = 845
        Top = 221
        Width = 121
        Height = 21
        EditLabel.Width = 67
        EditLabel.Height = 13
        EditLabel.Caption = 'Cervical Exam'
        TabOrder = 16
      end
    end
    object tsDiabetic: TTabSheet
      Caption = 'Diabetic'
      ImageIndex = 1
      DesignSize = (
        982
        537)
      object lblDiet: TLabel
        Left = 367
        Top = 208
        Width = 51
        Height = 13
        Caption = 'Diet (kcal):'
      end
      object lblControl: TLabel
        Left = 438
        Top = 208
        Width = 36
        Height = 13
        Caption = 'Control:'
      end
      object lblAvgNumReadPerDay: TLabel
        Left = 179
        Top = 208
        Width = 85
        Height = 13
        Caption = 'Avg # Read/Day:'
      end
      object gbxMeds: TGroupBox
        Left = 123
        Top = 251
        Width = 836
        Height = 215
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Treatment Regimen:'
        TabOrder = 7
        DesignSize = (
          836
          215)
        object lblDrug: TLabel
          Left = 11
          Top = 24
          Width = 26
          Height = 13
          Caption = 'Drug:'
        end
        object jvspnbtnDosage: TJvSpinButton
          Left = 53
          Top = 83
          Width = 15
          Height = 21
          ButtonStyle = sbsClassic
          OnBottomClick = jvspnbtnDosageBottomClick
          OnTopClick = jvspnbtnDosageTopClick
        end
        object lblUnits: TLabel
          Left = 11
          Top = 110
          Width = 27
          Height = 13
          Caption = 'Units:'
        end
        object lblDispenceTime: TLabel
          Left = 11
          Top = 153
          Width = 73
          Height = 13
          Caption = 'Dispense Time:'
        end
        object cbxDrug: TComboBox
          Left = 11
          Top = 40
          Width = 166
          Height = 21
          TabOrder = 0
        end
        object lbledtDosage: TLabeledEdit
          Left = 11
          Top = 83
          Width = 41
          Height = 21
          EditLabel.Width = 40
          EditLabel.Height = 13
          EditLabel.Caption = 'Dosage:'
          TabOrder = 1
        end
        object cbxUnits: TComboBox
          Left = 11
          Top = 126
          Width = 59
          Height = 21
          TabOrder = 2
        end
        object btnAddDrug: TBitBtn
          Left = 197
          Top = 40
          Width = 75
          Height = 25
          Caption = 'Add'
          TabOrder = 4
          OnClick = btnAddDrugClick
        end
        object btnDeleteDrug: TBitBtn
          Left = 197
          Top = 88
          Width = 75
          Height = 25
          Caption = 'Delete'
          TabOrder = 5
          OnClick = btnDeleteDrugClick
        end
        object sgDrug: TJvStringGrid
          Left = 289
          Top = 24
          Width = 533
          Height = 172
          Anchors = [akLeft, akTop, akRight]
          ColCount = 4
          DefaultColWidth = 70
          DefaultRowHeight = 21
          DrawingStyle = gdsGradient
          FixedCols = 0
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goTabs, goRowSelect]
          TabOrder = 6
          OnSelectCell = sgDrugSelectCell
          Alignment = taLeftJustify
          FixedFont.Charset = DEFAULT_CHARSET
          FixedFont.Color = clWindowText
          FixedFont.Height = -11
          FixedFont.Name = 'MS Sans Serif'
          FixedFont.Style = [fsBold]
        end
        object cbxDispenceTime: TDateTimePicker
          Left = 11
          Top = 170
          Width = 115
          Height = 21
          Date = 41884.000000000000000000
          Time = 41884.000000000000000000
          DateMode = dmUpDown
          Kind = dtkTime
          TabOrder = 3
        end
      end
      object leAvgFBS: TLabeledEdit
        Left = 123
        Top = 224
        Width = 50
        Height = 21
        EditLabel.Width = 48
        EditLabel.Height = 13
        EditLabel.Caption = 'Avg. FBS:'
        NumbersOnly = True
        TabOrder = 2
      end
      object leAvgPostPrandial: TLabeledEdit
        Left = 270
        Top = 224
        Width = 91
        Height = 21
        EditLabel.Width = 90
        EditLabel.Height = 13
        EditLabel.Caption = 'Avg. Post Prandial:'
        NumbersOnly = True
        TabOrder = 4
      end
      object cbxDiet: TComboBox
        Left = 367
        Top = 224
        Width = 65
        Height = 21
        TabOrder = 5
      end
      object cbxControl: TComboBox
        Left = 438
        Top = 224
        Width = 70
        Height = 21
        Style = csDropDownList
        TabOrder = 6
      end
      object cbxAvgNumReadPerDay: TEdit
        Left = 179
        Top = 224
        Width = 85
        Height = 21
        NumbersOnly = True
        TabOrder = 3
      end
      object rdgrbxDiabeticExamDate: TRadioGroup
        Left = 10
        Top = 209
        Width = 99
        Height = 137
        Caption = 'Exam Date'
        Items.Strings = (
          'Today'
          'Yesterday'
          '2 Days Ago'
          '3 Days Ago'
          '4 Days Ago')
        TabOrder = 1
        TabStop = True
        OnClick = rdgrbxDiabeticExamDateClick
      end
      object sgDiabetic: TJvStringGrid
        Left = 0
        Top = 0
        Width = 982
        Height = 193
        Align = alTop
        ColCount = 6
        DefaultColWidth = 70
        DefaultRowHeight = 21
        DrawingStyle = gdsGradient
        RowCount = 2
        Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goRowSizing, goColSizing, goRowMoving, goTabs, goRowSelect]
        TabOrder = 0
        OnSelectCell = sgDiabeticSelectCell
        Alignment = taLeftJustify
        FixedFont.Charset = DEFAULT_CHARSET
        FixedFont.Color = clWindowText
        FixedFont.Height = -11
        FixedFont.Name = 'MS Sans Serif'
        FixedFont.Style = [fsBold]
        OnCaptionClick = GridSortColumn
      end
    end
  end
  object btnClose: TBitBtn
    Left = 902
    Top = 531
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Close'
    Glyph.Data = {
      36030000424D3603000000000000360000002800000010000000100000000100
      18000000000000030000120B0000120B00000000000000000000FF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
      FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFBB4200
      BB4200BB4200BB4200BB4200BB4200BB4200BB4200BB4200BB4200BB4200BB42
      00FF00FFFF00FFFF00FFFF00FFBB4200FFFFFFFFFFFAFFFAEAFFEFD7FFE7C7FF
      E1B8FFDAADFFD9A9FFD8A7FFEAC2BB4200FF00FFFF00FFFF00FFFF00FFBB4200
      FFFFFFFFF6EFFEF0E2FFEAD1FEE2C4FEDAB4FED3A5FECE9CFECA95FFDAABBB42
      00FF00FFFF00FFFF00FFFF00FFBB4200FFFFFFFFFEFBFFF8F2FFF2E5FFEBD5FF
      E3C5FFDCB6FFD4A9FFCE9CFFDCACBB4200FF00FFFF00FFFF00FFFF00FFBB4200
      FFFFFFFFFFFFFFFFFEFFFAF4FFF3E7FEEBD8FFE5C9FEDDB8FED5AAFFE1B5BB42
      00FF00FFFF00FFFF00FFFF00FFBB4200FFFFFFFFFFFFFFFFFFFFFFFEFFFBF6FE
      F3E7FEEED9FFE6CAFEDDBAFFE7C4BB4200FF00FFFF00FFFF00FFFF00FFBB4200
      FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBF7FFF4EA000D66FEE5CAFFEFD7BB42
      00000D66FF00FFFF00FFFF00FFBB4200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
      FFFF000D66123BFF000D66FFFFFF000D66001EFF000D66FF00FFFF00FFBB4200
      E9A362E69C59E69C59E69C59E69C59E69C59E69D59000D66153DFF000D66072B
      FF000D66FF00FFFF00FFFF00FFFF00FFBB4100BB4200BB4200BB4200BB4200BB
      4200BB4200BB4200000D661841FF000D66FF00FFFF00FFFF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000D662A56FF000D661A44
      FF000D66FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FF000D66315EFF000D66FF00FF000D661D47FF000D66FF00FFFF00FFFF00FF
      FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF000D66FF00FFFF00FFFF00
      FF000D66FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
      00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
    ModalResult = 2
    TabOrder = 2
    OnClick = btnCloseClick
  end
  object BitBtn1: TBitBtn
    Left = 821
    Top = 531
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&OK'
    Kind = bkOK
    NumGlyphs = 2
    TabOrder = 3
    OnClick = BitBtn1Click
  end
  object btnEditMode: TBitBtn
    Left = 12
    Top = 531
    Width = 113
    Height = 25
    Anchors = [akLeft, akBottom]
    Caption = 'Enable Edit Mode'
    TabOrder = 4
    OnClick = btnEditModeClick
  end
  object btnSave: TBitBtn
    Left = 610
    Top = 531
    Width = 151
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = '&Save to Flow Sheet'
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
    TabOrder = 1
    OnClick = btnSaveClick
  end
  object grbxExamDate: TGroupBox
    Left = 8
    Top = 315
    Width = 114
    Height = 137
    Caption = 'Exam Date'
    TabOrder = 5
    Visible = False
    object dtpicrExamDate: TDateTimePicker
      Left = 9
      Top = 22
      Width = 96
      Height = 21
      Date = 39638.590256053240000000
      Time = 39638.590256053240000000
      TabOrder = 0
    end
    object btnEdit: TBitBtn
      Left = 9
      Top = 101
      Width = 80
      Height = 25
      Caption = 'Edit'
      TabOrder = 1
      TabStop = False
      Visible = False
      OnClick = btnEditClick
    end
    object btnDelete: TBitBtn
      Left = 9
      Top = 101
      Width = 96
      Height = 25
      Caption = 'Delete'
      TabOrder = 2
      OnClick = btnDeleteRowClick
    end
  end
end
