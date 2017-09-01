object DDCSQuestionGrid: TDDCSQuestionGrid
  Left = 0
  Top = 0
  Width = 747
  Height = 293
  Align = alClient
  AutoSize = True
  Color = clWindow
  Ctl3D = False
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  ParentColor = False
  ParentCtl3D = False
  ParentFont = False
  TabOrder = 0
  OnResize = FrameResize
  ExplicitWidth = 443
  DesignSize = (
    747
    293)
  object StringGrid: TJvStringGrid
    Left = 0
    Top = 0
    Width = 747
    Height = 293
    ParentCustomHint = False
    Align = alClient
    BevelEdges = []
    BevelInner = bvNone
    BevelOuter = bvNone
    ColCount = 6
    DefaultColWidth = 180
    DefaultRowHeight = 21
    DoubleBuffered = False
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goDrawFocusSelected, goColSizing, goRowMoving, goTabs, goThumbTracking]
    ParentDoubleBuffered = False
    TabOrder = 0
    OnDrawCell = StringGridDrawCell
    OnGetEditText = StringGridGetEditText
    OnKeyPress = StringGridKeyPress
    OnMouseDown = StringGridMouseDown
    OnSelectCell = StringGridSelectCell
    Alignment = taLeftJustify
    FixedFont.Charset = DEFAULT_CHARSET
    FixedFont.Color = clWindowText
    FixedFont.Height = -11
    FixedFont.Name = 'MS Sans Serif'
    FixedFont.Style = [fsBold]
    OnColWidthsChanged = StringGridColWidthsChanged
    OnVerticalScroll = StringGridVerticalScroll
    OnHorizontalScroll = StringGridHorizontalScroll
    ExplicitWidth = 443
    ColWidths = (
      67
      180
      180
      180
      67
      64)
    RowHeights = (
      21
      21)
  end
  object pnlKey: TPanel
    Left = 3
    Top = 264
    Width = 741
    Height = 26
    Alignment = taLeftJustify
    Anchors = [akLeft, akRight, akBottom]
    BevelOuter = bvNone
    Caption = '     UK: Unknown     |     NA: Not Applicable '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
  end
end
