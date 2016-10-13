object dlgOBSpread: TdlgOBSpread
  Left = 186
  Top = 176
  ActiveControl = spnAge
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = 'OB Exam Flow Sheet'
  ClientHeight = 538
  ClientWidth = 1188
  Color = clBtnFace
  Constraints.MinHeight = 565
  Constraints.MinWidth = 990
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Icon.Data = {
    0000010001002020100000000000E80200001600000028000000200000004000
    0000010004000000000080020000000000000000000000000000000000000000
    000000008000008000000080800080000000800080008080000080808000C0C0
    C0000000FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF000000
    00000000000000000000000000000000000000B7B7B7B7B7B7B7B7B7B7B00000
    00000070000B000070000B00007000000000000FFBF0FBFF0BFFF0FFFB000000
    000000FFFFFFFFFFFFFFFFFFFFF00000000000FFFFFFFFFFFFFFFFFFFFF00000
    000000FF88888888888888888FF00000000000FFFBFFFBFFFBFFFBFFFBF00000
    000000FFFFFFFFFFFFFFFFFFFFF000000000007788888888888888888FF00000
    0000000000000000007FFFFFFFF000FBFBFBFBFBFBFBFBFBFB07FBFFFBF000BF
    BFBFBFBFBFBFBFBFBFB07FFFFFF000FBFBFBFBFBFBFBFBFBFBF088888FF0000F
    BFBFBFBFBFBFBFBFBFBF07FFFFF0000BFBFBFBFBFBFBFBFBFBFB07FFFBF00000
    BFBFBFBFBFBFBFBFBFBFB07FFFF00000FBFBFBFBFBFBFBFBFBFBF0888FF00000
    0FBFBFBFBFBFBFBFBFBFBF07FFF000000BFBFBFBFBFBFBFBFBFBFB07FBF00000
    00BFBF0000000000000FBFB07FF0000000FBFB0FFFFFFFFFFF0BFBF08FF00000
    000FBFB0F0F0F0F0FFF0BFBF07F00000000BFBF0FF0F0F0F0FF0FBFB07F00000
    0000BFBF0FFFFFFFFFFF0FBFB07000000000FBFB0000000000000BFBF0700000
    00000FBFBFBFBFBFBFBFBFBFBF00000000000BFBFBFBFBFBFBFBFBFBFB000000
    000000BF8FBF8FBF8FBF8FBF8FB0000000000000800080008000800080000000
    000000008080808080808080808000000000000008000800080008000800FFC0
    0001FF800000FF800000FF800000FF800000FF800000FF800000FF800000FF80
    0000FF800000C0000000800000008000000080000000C0000000C0000000E000
    0000E0000000F0000000F0000000F8000000F8000000FC000000FC000000FE00
    0000FE000000FF000000FF000000FF800000FF800000FFF55555FFFBBBBB}
  OldCreateOrder = False
  Position = poScreenCenter
  Scaled = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  DesignSize = (
    1188
    538)
  PixelsPerInch = 96
  TextHeight = 13
  object cbPretermLabor: TComboBox
    Left = 304
    Top = 463
    Width = 124
    Height = 21
    Align = alCustom
    Style = csDropDownList
    TabOrder = 19
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnAge: TSpinEdit
    Left = 210
    Top = 327
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 9
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object cbPresentation: TComboBox
    Left = 304
    Top = 436
    Width = 124
    Height = 21
    Align = alCustom
    Style = csDropDownList
    TabOrder = 6
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object cbFetalAct: TComboBox
    Left = 304
    Top = 327
    Width = 124
    Height = 21
    Align = alCustom
    Style = csDropDownList
    TabOrder = 2
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object cbUrineProtein: TComboBox
    Left = 304
    Top = 355
    Width = 124
    Height = 21
    Align = alCustom
    Style = csDropDownList
    TabOrder = 3
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object cbUrineGlucose: TComboBox
    Left = 304
    Top = 382
    Width = 124
    Height = 21
    Align = alCustom
    Style = csDropDownList
    TabOrder = 4
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object cbEdema: TComboBox
    Left = 304
    Top = 409
    Width = 124
    Height = 21
    Align = alCustom
    Style = csDropDownList
    TabOrder = 5
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object pnlfooter: TPanel
    Left = 0
    Top = 510
    Width = 1188
    Height = 28
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      1188
      28)
    object btnOK: TBitBtn
      Left = 1032
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&OK'
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
      TabOrder = 2
      OnClick = btnOKClick
    end
    object btnCancel: TBitBtn
      Left = 1113
      Top = 3
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = '&Cancel'
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 3
    end
    object btnAddRow: TBitBtn
      Left = 0
      Top = 3
      Width = 75
      Height = 25
      Caption = '&Add Row'
      TabOrder = 0
      OnClick = btnAddRowClick
    end
    object btnDeleteRow: TBitBtn
      Left = 81
      Top = 3
      Width = 75
      Height = 25
      Caption = 'Delete Row'
      TabOrder = 1
      OnClick = btnDeleteRowClick
    end
  end
  object spnFundalHt: TSpinEdit
    Left = 210
    Top = 355
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 7
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnWeight: TSpinEdit
    Left = 210
    Top = 383
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 8
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnDilation: TSpinEdit
    Left = 210
    Top = 411
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 10
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnEffacement: TSpinEdit
    Left = 210
    Top = 439
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 11
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnLong: TSpinEdit
    Left = 210
    Top = 467
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 12
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnSystolic: TSpinEdit
    Left = 257
    Top = 327
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 13
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnDiastolic: TSpinEdit
    Left = 257
    Top = 355
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 14
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnPain: TSpinEdit
    Left = 257
    Top = 383
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 15
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object spnFetalHeart: TSpinEdit
    Left = 257
    Top = 411
    Width = 41
    Height = 22
    Anchors = [akLeft, akTop, akRight, akBottom]
    MaxValue = 0
    MinValue = 0
    TabOrder = 16
    Value = 0
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
  end
  object dtExam: TORDateBox
    Left = 81
    Top = 327
    Width = 121
    Height = 21
    TabOrder = 17
    Text = 'Today'
    Visible = False
    OnChange = InnerControlChange
    OnExit = InnerControlExit
    DateOnly = False
    RequireTime = False
    Caption = ''
  end
  object sgStandard: TJvStringGrid
    Left = 0
    Top = 0
    Width = 1188
    Height = 510
    ParentCustomHint = False
    Align = alClient
    ColCount = 20
    DefaultColWidth = 180
    DefaultRowHeight = 21
    DoubleBuffered = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowMoving, goEditing, goTabs, goThumbTracking]
    ParentDoubleBuffered = False
    TabOrder = 0
    OnGetEditText = sgStandardGetEditText
    OnSelectCell = sgStandardSelectCell
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'MS Sans Serif'
    FixedFont.Style = [fsBold]
    OnColWidthsChanged = sgStandardColWidthsChanged
    OnVerticalScroll = sgStandardVerticalScroll
    OnHorizontalScroll = sgStandardHorizontalScroll
    ColWidths = (
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180
      180)
    RowHeights = (
      21
      21)
  end
end
