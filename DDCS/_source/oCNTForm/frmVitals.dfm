object fVitals: TfVitals
  Left = 0
  Top = 0
  Width = 698
  Height = 378
  TabOrder = 0
  object fVitalsControl: TPageControl
    Left = 0
    Top = 0
    Width = 698
    Height = 378
    ActivePage = PageMain
    Align = alClient
    MultiLine = True
    TabOrder = 0
    TabPosition = tpRight
    object PageMain: TTabSheet
      Caption = 'Vitals'
      object FAge: TStaticText
        Left = 32
        Top = 24
        Width = 39
        Height = 20
        Caption = 'Age: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
        TabStop = True
      end
      object FSex: TStaticText
        Left = 32
        Top = 52
        Width = 36
        Height = 20
        Caption = 'Sex: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = True
      end
      object FBMI: TStaticText
        Left = 32
        Top = 80
        Width = 37
        Height = 20
        Caption = 'BMI: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        TabStop = True
      end
      object FTemps: TEdit
        Left = 77
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 4
      end
      object FHeights: TEdit
        Left = 77
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 14
      end
      object FWeights: TEdit
        Left = 77
        Top = 261
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 24
      end
      object FTempdt: TStaticText
        Left = 77
        Top = 143
        Width = 4
        Height = 4
        TabOrder = 6
        TabStop = True
      end
      object FHeightdt: TStaticText
        Left = 77
        Top = 214
        Width = 4
        Height = 4
        TabOrder = 16
        TabStop = True
      end
      object FWeightdt: TStaticText
        Left = 77
        Top = 288
        Width = 4
        Height = 4
        TabOrder = 26
        TabStop = True
      end
      object FTempl: TStaticText
        Left = 34
        Top = 119
        Width = 34
        Height = 17
        Caption = 'Temp:'
        TabOrder = 3
        TabStop = True
      end
      object FHeightl: TStaticText
        Left = 34
        Top = 191
        Width = 39
        Height = 17
        Caption = 'Height:'
        TabOrder = 13
        TabStop = True
      end
      object FWeightl: TStaticText
        Left = 34
        Top = 265
        Width = 42
        Height = 17
        Caption = 'Weight:'
        TabOrder = 23
        TabStop = True
      end
      object FTempe: TEdit
        Left = 183
        Top = 116
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 5
      end
      object FHeighte: TEdit
        Left = 183
        Top = 187
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 15
      end
      object FWeighte: TEdit
        Left = 183
        Top = 261
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 25
      end
      object FPulses: TEdit
        Left = 298
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 8
      end
      object FPulsedt: TStaticText
        Left = 298
        Top = 143
        Width = 4
        Height = 4
        TabOrder = 9
        TabStop = True
      end
      object FPulsel: TStaticText
        Left = 264
        Top = 120
        Width = 33
        Height = 17
        Caption = 'Pulse:'
        TabOrder = 7
        TabStop = True
      end
      object FResps: TEdit
        Left = 298
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 18
      end
      object FRespl: TStaticText
        Left = 264
        Top = 191
        Width = 32
        Height = 17
        Caption = 'Resp:'
        TabOrder = 17
        TabStop = True
      end
      object FRespdt: TStaticText
        Left = 298
        Top = 214
        Width = 4
        Height = 4
        TabOrder = 19
        TabStop = True
      end
      object FPains: TEdit
        Left = 298
        Top = 261
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 28
      end
      object FPainl: TStaticText
        Left = 264
        Top = 265
        Width = 28
        Height = 17
        Caption = 'Pain:'
        TabOrder = 27
        TabStop = True
      end
      object FPaindt: TStaticText
        Left = 298
        Top = 288
        Width = 4
        Height = 4
        TabOrder = 29
        TabStop = True
      end
      object FSystolics: TEdit
        Left = 487
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 11
      end
      object FSystolicl: TStaticText
        Left = 434
        Top = 120
        Width = 44
        Height = 17
        Caption = 'Systolic:'
        TabOrder = 10
        TabStop = True
      end
      object FSystolicdt: TStaticText
        Left = 487
        Top = 143
        Width = 4
        Height = 4
        TabOrder = 12
        TabStop = True
      end
      object FDiastolics: TEdit
        Left = 487
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 21
      end
      object FDiastolicl: TStaticText
        Left = 434
        Top = 191
        Width = 47
        Height = 17
        Caption = 'Diastolic:'
        TabOrder = 20
        TabStop = True
      end
      object FDiastolicdt: TStaticText
        Left = 487
        Top = 214
        Width = 4
        Height = 4
        TabOrder = 22
        TabStop = True
      end
    end
    object PageEDD: TTabSheet
      Caption = 'Estimated Delivery Date'
      ImageIndex = 1
      DesignSize = (
        670
        370)
      object Label14: TLabel
        Left = 284
        Top = 18
        Width = 62
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Current GA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Button1: TButton
        Left = 10
        Top = 13
        Width = 75
        Height = 25
        Caption = 'History'
        TabOrder = 0
        Visible = False
      end
      object StaticText2: TStaticText
        Left = 456
        Top = 19
        Width = 61
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'Final EDD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        TabStop = True
      end
      object edtCurrentEDD: TEdit
        Left = 521
        Top = 15
        Width = 121
        Height = 21
        Anchors = [akTop, akRight]
        Color = clSilver
        Enabled = False
        ReadOnly = True
        TabOrder = 3
      end
      object EDDGrid: TGridPanel
        Left = 10
        Top = 59
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
            Control = Label9
            Row = 0
          end
          item
            Column = 1
            Control = Label10
            Row = 0
          end
          item
            Column = 2
            ColumnSpan = 2
            Control = Label11
            Row = 0
          end
          item
            Column = 4
            Control = Label12
            Row = 0
          end
          item
            Column = 5
            Control = Label13
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
          end
          item
            Column = 0
            Control = Panel1
            Row = 4
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
          ExplicitWidth = 103
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
          ExplicitWidth = 130
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
          ExplicitWidth = 52
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
          TabOrder = 16
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
          TabOrder = 17
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
          TabOrder = 18
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
          TabOrder = 19
        end
        object lblUnknown: TLabel
          Left = 0
          Top = 246
          Width = 150
          Height = 43
          Align = alClient
          Caption = 'Unknown'
          Layout = tlCenter
          ExplicitWidth = 44
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
          TabOrder = 22
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
          TabOrder = 23
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
          TabOrder = 24
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
          TabOrder = 25
        end
        object lblOther: TEdit
          Left = 0
          Top = 215
          Width = 149
          Height = 21
          Anchors = []
          TabOrder = 21
          Text = 'Enter Other Criteria'
          OnMouseEnter = lblOtherMouseEnter
        end
        object Label9: TLabel
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
        object Label10: TLabel
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
        object Label11: TLabel
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
        object Label12: TLabel
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
        object Label13: TLabel
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
          TabOrder = 20
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
          TabOrder = 26
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
          TabOrder = 28
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
          TabOrder = 27
          OnChange = dtEDDUnknownChange
        end
        object Panel1: TPanel
          Left = 0
          Top = 164
          Width = 150
          Height = 41
          Anchors = []
          BevelOuter = bvNone
          TabOrder = 15
          object lblEmbryo: TLabel
            Left = 0
            Top = 0
            Width = 150
            Height = 41
            Align = alClient
            Caption = 'Embryo Transfer'
            Layout = tlCenter
            ExplicitWidth = 80
            ExplicitHeight = 13
          end
          object spnTransferDay: TSpinEdit
            Left = 87
            Top = 10
            Width = 63
            Height = 22
            Increment = 2
            MaxValue = 5
            MinValue = 3
            TabOrder = 0
            Value = 3
            OnChange = spnTransferDayChange
          end
        end
      end
      object edtFinalGA: TEdit
        Left = 355
        Top = 15
        Width = 65
        Height = 21
        Anchors = [akTop, akRight]
        Color = clSilver
        Enabled = False
        TabOrder = 1
      end
    end
    object PageLMP: TTabSheet
      Caption = 'Menstrual History'
      ImageIndex = 2
      object Label7: TLabel
        Left = 278
        Top = 137
        Width = 295
        Height = 13
        Caption = 'What type(s) of contraception were you using most recently?'
      end
      object Label6: TLabel
        Left = 278
        Top = 195
        Width = 54
        Height = 13
        Caption = 'Comments:'
      end
      object Label8: TLabel
        Left = 278
        Top = 73
        Width = 45
        Height = 13
        Caption = 'Duration:'
      end
      object SpeedButton1: TSpeedButton
        Tag = 2
        Left = 201
        Top = 273
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
      object Label5: TLabel
        Left = 278
        Top = 105
        Width = 89
        Height = 13
        Caption = 'On Contraception:'
      end
      object Label4: TLabel
        Left = 278
        Top = 41
        Width = 41
        Height = 13
        Caption = 'Amount:'
      end
      object Label3: TLabel
        Left = 80
        Top = 241
        Width = 95
        Height = 13
        Caption = '(Fill in age of onset)'
      end
      object Label2: TLabel
        Left = 80
        Top = 178
        Width = 68
        Height = 13
        Caption = '(Fill in # days)'
      end
      object sbtnGetDate1: TSpeedButton
        Tag = 1
        Left = 201
        Top = 53
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
      object Label1: TLabel
        Left = 31
        Top = 116
        Width = 43
        Height = 13
        Caption = 'Menses: '
      end
      object btnHistory: TButton
        Left = 15
        Top = 12
        Width = 75
        Height = 25
        Caption = 'History'
        TabOrder = 15
        Visible = False
      end
      object edtContraceptionType: TComboBox
        Left = 278
        Top = 156
        Width = 358
        Height = 21
        Style = csDropDownList
        TabOrder = 13
      end
      object ckMensesYes: TCheckBox
        Tag = 1
        Left = 80
        Top = 115
        Width = 63
        Height = 17
        Caption = 'Normal'
        TabOrder = 2
        OnClick = ckMensesYesClick
      end
      object ckDurationYes: TCheckBox
        Tag = 7
        Left = 393
        Top = 72
        Width = 64
        Height = 17
        Caption = 'Normal'
        TabOrder = 9
        OnClick = ckMensesYesClick
      end
      object ckAmountYes: TCheckBox
        Tag = 3
        Left = 393
        Top = 40
        Width = 63
        Height = 17
        Caption = 'Normal'
        TabOrder = 7
        OnClick = ckMensesYesClick
      end
      object memLMP: TMemo
        Left = 275
        Top = 214
        Width = 358
        Height = 131
        ScrollBars = ssVertical
        TabOrder = 14
      end
      object ckDurationNo: TCheckBox
        Tag = 8
        Left = 483
        Top = 72
        Width = 82
        Height = 17
        Caption = 'Abnormal'
        TabOrder = 10
        OnClick = ckMensesYesClick
      end
      object edthcg: TLabeledEdit
        Left = 80
        Top = 277
        Width = 115
        Height = 21
        EditLabel.Width = 28
        EditLabel.Height = 13
        EditLabel.Caption = 'hCG+'
        LabelPosition = lpLeft
        TabOrder = 6
      end
      object ckContraceptionNo: TCheckBox
        Tag = 6
        Left = 483
        Top = 104
        Width = 37
        Height = 17
        Caption = 'No'
        TabOrder = 12
        OnClick = ckMensesYesClick
      end
      object ckContraceptionYes: TCheckBox
        Tag = 5
        Left = 393
        Top = 104
        Width = 52
        Height = 17
        Caption = 'Yes'
        TabOrder = 11
        OnClick = ckMensesYesClick
      end
      object ckAmountNo: TCheckBox
        Tag = 4
        Left = 483
        Top = 40
        Width = 82
        Height = 17
        Caption = 'Abnormal'
        TabOrder = 8
        OnClick = ckMensesYesClick
      end
      object edtMenarche: TLabeledEdit
        Left = 80
        Top = 214
        Width = 115
        Height = 21
        EditLabel.Width = 51
        EditLabel.Height = 13
        EditLabel.Caption = 'Menarche:'
        LabelPosition = lpLeft
        TabOrder = 5
      end
      object edtFrequency: TLabeledEdit
        Left = 80
        Top = 152
        Width = 115
        Height = 21
        EditLabel.Width = 55
        EditLabel.Height = 13
        EditLabel.Caption = 'Frequency:'
        LabelPosition = lpLeft
        TabOrder = 4
      end
      object ckMensesNo: TCheckBox
        Tag = 2
        Left = 149
        Top = 115
        Width = 75
        Height = 17
        Caption = 'Abnormal'
        TabOrder = 3
        OnClick = ckMensesYesClick
      end
      object edtLMP: TLabeledEdit
        Left = 80
        Top = 57
        Width = 115
        Height = 21
        EditLabel.Width = 23
        EditLabel.Height = 13
        EditLabel.Caption = 'LMP:'
        LabelPosition = lpLeft
        TabOrder = 0
        OnChange = edtLMPChange
      end
      object ck_LMPQualifier: TCheckBox
        Left = 80
        Top = 84
        Width = 97
        Height = 17
        Caption = 'Approximate'
        TabOrder = 1
      end
    end
  end
end
