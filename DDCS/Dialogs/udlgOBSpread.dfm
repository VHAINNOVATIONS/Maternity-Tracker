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
  object pgcOBFlow: TPageControl
    Left = 0
    Top = 0
    Width = 1188
    Height = 531
    ActivePage = tsStandard
    Align = alClient
    TabOrder = 0
    OnChange = pgcOBFlowChange
    ExplicitHeight = 528
    object tsStandard: TTabSheet
      Caption = 'Exam'
      ExplicitHeight = 500
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
        Left = 13
        Top = 254
        Width = 108
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
        Width = 1180
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
      object btnCustAdd: TButton
        Left = 216
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
        Left = 216
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
        Left = 216
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 19
        Visible = False
      end
      object custCol2: TLabeledEdit
        Tag = 2
        Left = 343
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
        Left = 343
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 21
        Visible = False
      end
      object custCol3: TLabeledEdit
        Tag = 3
        Left = 470
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
        Left = 470
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 23
        Visible = False
      end
      object custCol4: TLabeledEdit
        Tag = 4
        Left = 597
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
        Left = 597
        Top = 378
        Width = 121
        Height = 21
        TabOrder = 25
        Visible = False
      end
      object custCol5: TLabeledEdit
        Tag = 5
        Left = 724
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
        Left = 724
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
        1180
        503)
      object lblDiet: TLabel
        Left = 423
        Top = 208
        Width = 51
        Height = 13
        Caption = 'Diet (kcal):'
      end
      object lblControl: TLabel
        Left = 519
        Top = 208
        Width = 36
        Height = 13
        Caption = 'Control:'
      end
      object lblAvgNumReadPerDay: TLabel
        Left = 235
        Top = 208
        Width = 85
        Height = 13
        Caption = 'Avg # Read/Day:'
      end
      object gbxMeds: TGroupBox
        Left = 179
        Top = 251
        Width = 978
        Height = 210
        Anchors = [akLeft, akTop, akRight, akBottom]
        Caption = 'Treatment Regimen:'
        TabOrder = 7
        DesignSize = (
          978
          210)
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
          Left = 296
          Top = 24
          Width = 668
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
          ColWidths = (
            70
            70
            70
            70)
          RowHeights = (
            21
            21)
        end
        object cbxDispenceTime: TDateTimePicker
          Left = 11
          Top = 170
          Width = 115
          Height = 21
          Date = 41884.000000000000000000
          Format = 'HH:mm'
          Time = 41884.000000000000000000
          DateMode = dmUpDown
          Kind = dtkTime
          TabOrder = 3
        end
      end
      object leAvgFBS: TLabeledEdit
        Left = 179
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
        Left = 326
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
        Left = 423
        Top = 224
        Width = 90
        Height = 21
        TabOrder = 5
      end
      object cbxControl: TComboBox
        Left = 519
        Top = 224
        Width = 115
        Height = 21
        Style = csDropDownList
        TabOrder = 6
      end
      object cbxAvgNumReadPerDay: TEdit
        Left = 235
        Top = 224
        Width = 85
        Height = 21
        NumbersOnly = True
        TabOrder = 3
      end
      object rdgrbxDiabeticExamDate: TRadioGroup
        Left = 13
        Top = 209
        Width = 108
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
        Width = 1180
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
        ColWidths = (
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
    end
  end
  object grbxExamDate: TGroupBox
    Left = 8
    Top = 315
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
    object dtpicrExamDate: TDateTimePicker
      Left = 9
      Top = 22
      Width = 136
      Height = 21
      Date = 42248.571360243050000000
      Format = 'MM/dd/yyyy'
      Time = 42248.571360243050000000
      TabOrder = 1
    end
    object dtpicrExamTime: TDateTimePicker
      Left = 9
      Top = 49
      Width = 136
      Height = 21
      Date = 42248.000000000000000000
      Format = 'HH:mm'
      Time = 42248.000000000000000000
      DateMode = dmUpDown
      Kind = dtkTime
      TabOrder = 2
    end
  end
  object Panel2: TPanel
    Tag = 19641
    Left = 0
    Top = 531
    Width = 1188
    Height = 37
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 528
    DesignSize = (
      1188
      37)
    object bbtnOK: TBitBtn
      Left = 1026
      Top = 6
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
      Left = 1107
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
    object btnEditMode: TBitBtn
      Left = 7
      Top = 6
      Width = 113
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = 'Enable Edit Mode'
      TabOrder = 2
      OnClick = btnEditModeClick
    end
    object btnAddRow: TBitBtn
      Left = 126
      Top = 6
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = '&Add Row'
      TabOrder = 3
      Visible = False
      OnClick = btnAddRowClick
    end
  end
end
