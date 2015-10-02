object dlgEstDelivDate: TdlgEstDelivDate
  Left = 303
  Top = 171
  BorderStyle = bsDialog
  ClientHeight = 397
  ClientWidth = 658
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnCreate = FormCreate
  OnShow = FormShow
  DesignSize = (
    658
    397)
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 658
    Height = 30
    Align = alTop
    Color = clWhite
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clGray
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    object lbltitle: TLabel
      Left = 4
      Top = 4
      Width = 194
      Height = 20
      Caption = 'Estimated Delivery Date'
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
    Top = 368
    Width = 658
    Height = 29
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 5
    object bbtnOK: TBitBtn
      Left = 500
      Top = 2
      Width = 75
      Height = 25
      Kind = bkOK
      NumGlyphs = 2
      TabOrder = 0
      OnClick = bbtnOKClick
    end
    object bbtnCancel: TBitBtn
      Left = 581
      Top = 2
      Width = 75
      Height = 25
      Kind = bkCancel
      NumGlyphs = 2
      TabOrder = 1
    end
  end
  object EDDGrid: TGridPanel
    Left = 10
    Top = 67
    Width = 632
    Height = 289
    Anchors = [akLeft, akTop, akRight, akBottom]
    BevelOuter = bvNone
    ColumnCollection = <
      item
        SizeStyle = ssAbsolute
        Value = 150.000000000000000000
      end
      item
        Value = 27.325016587741300000
      end
      item
        Value = 10.182254772595770000
      end
      item
        Value = 10.078233029364070000
      end
      item
        Value = 32.055131976864300000
      end
      item
        Value = 20.359363633434560000
      end>
    ControlCollection = <
      item
        Column = 1
        Control = dtLMP
        Row = 1
      end
      item
        Column = 2
        Control = edtWeekLMP
        Row = 1
      end
      item
        Column = 3
        Control = edtDayLMP
        Row = 1
      end
      item
        Column = 4
        Control = edtEDDLMP
        Row = 1
      end
      item
        Column = 0
        Control = lblLMP
        Row = 1
      end
      item
        Column = 0
        Control = lblECD
        Row = 2
      end
      item
        Column = 0
        Control = lblUltra
        Row = 3
      end
      item
        Column = 1
        Control = dtECD
        Row = 2
      end
      item
        Column = 2
        Control = edtWeekECD
        Row = 2
      end
      item
        Column = 3
        Control = edtDayECD
        Row = 2
      end
      item
        Column = 4
        Control = edtEDDECD
        Row = 2
      end
      item
        Column = 0
        Control = lblEmbryo
        Row = 4
      end
      item
        Column = 1
        Control = dtUltra
        Row = 3
      end
      item
        Column = 2
        Control = spnWeekUltra
        Row = 3
      end
      item
        Column = 3
        Control = spnDayUltra
        Row = 3
      end
      item
        Column = 4
        Control = edtEDDUltra
        Row = 3
      end
      item
        Column = 1
        Control = dtEmbryo
        Row = 4
      end
      item
        Column = 2
        Control = edtWeekEmbryo
        Row = 4
      end
      item
        Column = 3
        Control = edtDayEmbryo
        Row = 4
      end
      item
        Column = 4
        Control = edtEDDEmbryo
        Row = 4
      end
      item
        Column = 0
        Control = lblUnknown
        Row = 6
      end
      item
        Column = 1
        Control = dtOther
        Row = 5
      end
      item
        Column = 2
        Control = spnWeekOther
        Row = 5
      end
      item
        Column = 3
        Control = spnDayOther
        Row = 5
      end
      item
        Column = 4
        Control = edtEDDOther
        Row = 5
      end
      item
        Column = 0
        Control = lblOther
        Row = 5
      end
      item
        Column = 0
        Control = Label6
        Row = 0
      end
      item
        Column = 1
        Control = Label7
        Row = 0
      end
      item
        Column = 2
        ColumnSpan = 2
        Control = Label8
        Row = 0
      end
      item
        Column = 4
        Control = Label10
        Row = 0
      end
      item
        Column = 5
        Control = Label9
        Row = 0
      end
      item
        Column = 5
        Control = ckFinalEDDLMP
        Row = 1
      end
      item
        Column = 5
        Control = ckFinalEDDECD
        Row = 2
      end
      item
        Column = 5
        Control = ckFinalEDDUltra
        Row = 3
      end
      item
        Column = 5
        Control = ckFinalEDDEmbryo
        Row = 4
      end
      item
        Column = 5
        Control = ckFinalEDDOther
        Row = 5
      end
      item
        Column = 5
        Control = ckFinalEDDUnknown
        Row = 6
      end
      item
        Column = 4
        Control = dtEDDUnknown
        Row = 6
      end>
    ExpandStyle = emAddColumns
    RowCollection = <
      item
        Value = 14.279327102523720000
      end
      item
        Value = 14.327356831229780000
      end
      item
        Value = 14.258276649000580000
      end
      item
        Value = 14.241672209497000000
      end
      item
        Value = 14.383561643835620000
      end
      item
        Value = 14.277379956570730000
      end
      item
        Value = 14.232425607342590000
      end>
    TabOrder = 4
    OnResize = EDDGridResize
    DesignSize = (
      632
      289)
    object dtLMP: TDateTimePicker
      Left = 165
      Top = 51
      Width = 100
      Height = 21
      Anchors = []
      Date = 41898.498752974530000000
      Time = 41898.498752974530000000
      TabOrder = 0
      OnChange = dtLMPChange
    end
    object edtWeekLMP: TEdit
      Left = 281
      Top = 51
      Width = 49
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 1
    end
    object edtDayLMP: TEdit
      Left = 330
      Top = 51
      Width = 48
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 2
    end
    object edtEDDLMP: TEdit
      Left = 403
      Top = 51
      Width = 103
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 3
    end
    object lblLMP: TLabel
      Left = 0
      Top = 41
      Width = 150
      Height = 41
      Align = alClient
      Caption = 'Last Menstrual Period'
      Layout = tlCenter
      ExplicitWidth = 102
      ExplicitHeight = 13
    end
    object lblECD: TLabel
      Left = 0
      Top = 82
      Width = 150
      Height = 41
      Align = alClient
      Caption = 'Estimated Conception Date'
      Layout = tlCenter
      ExplicitWidth = 129
      ExplicitHeight = 13
    end
    object lblUltra: TLabel
      Left = 0
      Top = 123
      Width = 150
      Height = 41
      Align = alClient
      Caption = 'Ultrasound'
      Layout = tlCenter
      ExplicitWidth = 51
      ExplicitHeight = 13
    end
    object dtECD: TDateTimePicker
      Left = 165
      Top = 92
      Width = 100
      Height = 21
      Anchors = []
      Date = 41898.599563668990000000
      Time = 41898.599563668990000000
      TabOrder = 5
      OnChange = dtECDChange
    end
    object edtWeekECD: TEdit
      Left = 281
      Top = 92
      Width = 49
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 6
    end
    object edtDayECD: TEdit
      Left = 330
      Top = 92
      Width = 48
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 7
    end
    object edtEDDECD: TEdit
      Left = 403
      Top = 92
      Width = 103
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 8
    end
    object lblEmbryo: TLabel
      Left = 0
      Top = 164
      Width = 150
      Height = 41
      Align = alClient
      Caption = 'Embryo Transfer'
      Layout = tlCenter
      ExplicitWidth = 77
      ExplicitHeight = 13
    end
    object dtUltra: TDateTimePicker
      Left = 165
      Top = 133
      Width = 100
      Height = 21
      Anchors = []
      Date = 41898.600130277780000000
      Time = 41898.600130277780000000
      TabOrder = 10
      OnChange = dtUltraChange
    end
    object spnWeekUltra: TSpinEdit
      Left = 281
      Top = 132
      Width = 49
      Height = 22
      Anchors = []
      MaxValue = 0
      MinValue = 0
      TabOrder = 11
      Value = 0
      OnChange = spnWeekUltraChange
    end
    object spnDayUltra: TSpinEdit
      Left = 330
      Top = 132
      Width = 48
      Height = 22
      Anchors = []
      MaxValue = 0
      MinValue = 0
      TabOrder = 12
      Value = 0
      OnChange = spnDayUltraChange
    end
    object edtEDDUltra: TEdit
      Left = 403
      Top = 133
      Width = 103
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 13
    end
    object dtEmbryo: TDateTimePicker
      Left = 165
      Top = 174
      Width = 100
      Height = 21
      Anchors = []
      Date = 41898.600587314820000000
      Time = 41898.600587314820000000
      TabOrder = 15
      OnChange = dtEmbryoChange
    end
    object edtWeekEmbryo: TEdit
      Left = 281
      Top = 174
      Width = 49
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 16
    end
    object edtDayEmbryo: TEdit
      Left = 330
      Top = 174
      Width = 48
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 17
    end
    object edtEDDEmbryo: TEdit
      Left = 403
      Top = 174
      Width = 103
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 18
    end
    object lblUnknown: TLabel
      Left = 0
      Top = 246
      Width = 150
      Height = 43
      Align = alClient
      Caption = 'Unknown'
      Layout = tlCenter
      ExplicitWidth = 46
      ExplicitHeight = 13
    end
    object dtOther: TDateTimePicker
      Left = 165
      Top = 215
      Width = 100
      Height = 21
      Anchors = []
      Date = 41898.601366504630000000
      Time = 41898.601366504630000000
      TabOrder = 21
      OnChange = dtOtherChange
    end
    object spnWeekOther: TSpinEdit
      Left = 281
      Top = 214
      Width = 49
      Height = 22
      Anchors = []
      MaxValue = 0
      MinValue = 0
      TabOrder = 22
      Value = 0
      OnChange = spnWeekOtherChange
    end
    object spnDayOther: TSpinEdit
      Left = 330
      Top = 214
      Width = 48
      Height = 22
      Anchors = []
      MaxValue = 0
      MinValue = 0
      TabOrder = 23
      Value = 0
      OnChange = spnDayOtherChange
    end
    object edtEDDOther: TEdit
      Left = 403
      Top = 215
      Width = 103
      Height = 21
      Anchors = []
      Color = clSilver
      Enabled = False
      ReadOnly = True
      TabOrder = 24
    end
    object lblOther: TEdit
      Left = 0
      Top = 215
      Width = 149
      Height = 21
      Anchors = []
      TabOrder = 20
      Text = 'Enter Other Criteria'
      OnMouseEnter = lblOtherMouseEnter
    end
    object Label6: TLabel
      Left = 39
      Top = 14
      Width = 71
      Height = 13
      Anchors = []
      Caption = 'EDD Criteria'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 46
      ExplicitTop = 7
    end
    object Label7: TLabel
      Left = 183
      Top = 14
      Width = 65
      Height = 13
      Anchors = []
      Caption = 'Event Date'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 173
      ExplicitTop = 7
    end
    object Label8: TLabel
      Left = 281
      Top = 0
      Width = 97
      Height = 41
      Align = alClient
      Caption = 'Gestational Age'#13#10'Weeks   Days'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      Layout = tlCenter
      ExplicitWidth = 91
      ExplicitHeight = 26
    end
    object Label10: TLabel
      Left = 441
      Top = 14
      Width = 27
      Height = 13
      Anchors = []
      Caption = 'EDD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 490
      ExplicitTop = 7
    end
    object Label9: TLabel
      Left = 553
      Top = 14
      Width = 58
      Height = 13
      Anchors = []
      Caption = 'Final EDD'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 558
      ExplicitTop = 13
    end
    object ckFinalEDDLMP: TCheckBox
      Tag = 9
      Left = 572
      Top = 53
      Width = 19
      Height = 17
      Hint = 'IsFinal'
      Anchors = []
      TabOrder = 4
      OnClick = IsFinalEDDClick
    end
    object ckFinalEDDECD: TCheckBox
      Tag = 9
      Left = 572
      Top = 94
      Width = 20
      Height = 17
      Hint = 'IsFinal'
      Anchors = []
      TabOrder = 9
      OnClick = IsFinalEDDClick
    end
    object ckFinalEDDUltra: TCheckBox
      Tag = 9
      Left = 573
      Top = 135
      Width = 18
      Height = 17
      Hint = 'IsFinal'
      Anchors = []
      TabOrder = 14
      OnClick = IsFinalEDDClick
    end
    object ckFinalEDDEmbryo: TCheckBox
      Tag = 9
      Left = 572
      Top = 176
      Width = 19
      Height = 17
      Hint = 'IsFinal'
      Anchors = []
      TabOrder = 19
      OnClick = IsFinalEDDClick
    end
    object ckFinalEDDOther: TCheckBox
      Tag = 9
      Left = 572
      Top = 217
      Width = 20
      Height = 17
      Hint = 'IsFinal'
      Anchors = []
      TabOrder = 25
      OnClick = IsFinalEDDClick
    end
    object ckFinalEDDUnknown: TCheckBox
      Tag = 9
      Left = 573
      Top = 259
      Width = 18
      Height = 17
      Hint = 'IsFinal'
      Anchors = []
      TabOrder = 27
      OnClick = IsFinalEDDClick
    end
    object dtEDDUnknown: TDateTimePicker
      Left = 403
      Top = 257
      Width = 104
      Height = 21
      Anchors = []
      Date = 41898.630100775470000000
      Time = 41898.630100775470000000
      TabOrder = 26
    end
  end
  object spnTransferDay: TSpinEdit
    Left = 97
    Top = 242
    Width = 63
    Height = 22
    Increment = 2
    MaxValue = 5
    MinValue = 3
    TabOrder = 6
    Value = 3
    OnChange = spnTransferDayChange
  end
  object edtCurrentEDD: TEdit
    Left = 521
    Top = 39
    Width = 121
    Height = 21
    Anchors = [akTop, akRight]
    Color = clSilver
    Enabled = False
    ReadOnly = True
    TabOrder = 3
  end
  object StaticText1: TStaticText
    Left = 436
    Top = 41
    Width = 79
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Current EDD:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    TabStop = True
  end
  object btnHistory: TButton
    Left = 10
    Top = 37
    Width = 75
    Height = 25
    Caption = 'History'
    TabOrder = 0
  end
end
