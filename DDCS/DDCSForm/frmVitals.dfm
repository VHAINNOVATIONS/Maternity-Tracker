object DDCSVitals: TDDCSVitals
  Left = 0
  Top = 0
  Width = 698
  Height = 378
  DoubleBuffered = True
  ParentDoubleBuffered = False
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
    OnChange = fVitalsControlChange
    object PageMain: TTabSheet
      Caption = 'Vitals'
      object FTempdt: TLabel
        Left = 92
        Top = 143
        Width = 3
        Height = 13
      end
      object FHeightdt: TLabel
        Left = 92
        Top = 214
        Width = 3
        Height = 13
      end
      object FWeightdt: TLabel
        Left = 92
        Top = 285
        Width = 3
        Height = 13
      end
      object FTempl: TLabel
        Left = 12
        Top = 120
        Width = 75
        Height = 13
        Caption = 'Temperature'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FHeightl: TLabel
        Left = 50
        Top = 191
        Width = 37
        Height = 13
        Caption = 'Height'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FWeightl: TLabel
        Left = 47
        Top = 262
        Width = 40
        Height = 13
        Caption = 'Weight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FPulsedt: TLabel
        Left = 336
        Top = 143
        Width = 3
        Height = 13
      end
      object FPulsel: TLabel
        Left = 301
        Top = 120
        Width = 30
        Height = 13
        Caption = 'Pulse'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FRespl: TLabel
        Left = 266
        Top = 191
        Width = 65
        Height = 13
        Caption = 'Respiration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FRespdt: TLabel
        Left = 336
        Top = 214
        Width = 3
        Height = 13
      end
      object FPainl: TLabel
        Left = 307
        Top = 262
        Width = 24
        Height = 13
        Caption = 'Pain'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FPaindt: TLabel
        Left = 336
        Top = 285
        Width = 3
        Height = 13
      end
      object FSystolicl: TLabel
        Left = 457
        Top = 120
        Width = 44
        Height = 13
        Caption = 'Systolic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FSystolicdt: TLabel
        Left = 506
        Top = 143
        Width = 3
        Height = 13
      end
      object FDiastolicl: TLabel
        Left = 453
        Top = 191
        Width = 48
        Height = 13
        Caption = 'Diastolic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object FDiastolicdt: TLabel
        Left = 506
        Top = 214
        Width = 3
        Height = 13
      end
      object FTemps: TEdit
        Left = 92
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 1
      end
      object FHeights: TEdit
        Left = 92
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 3
      end
      object FWeights: TEdit
        Left = 92
        Top = 258
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 5
      end
      object FTempe: TEdit
        Left = 201
        Top = 116
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 2
      end
      object FHeighte: TEdit
        Left = 201
        Top = 187
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 4
      end
      object FWeighte: TEdit
        Left = 201
        Top = 258
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 6
      end
      object FPulses: TEdit
        Left = 336
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 7
      end
      object FResps: TEdit
        Left = 336
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 8
      end
      object FPains: TEdit
        Left = 336
        Top = 258
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 9
      end
      object FSystolics: TEdit
        Left = 506
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 10
      end
      object FDiastolics: TEdit
        Left = 506
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 11
      end
      object Panel2: TPanel
        Left = 9
        Top = 8
        Width = 238
        Height = 96
        BevelOuter = bvNone
        TabOrder = 0
        object FAge: TLabel
          Left = 21
          Top = 13
          Width = 31
          Height = 16
          Caption = 'Age:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object FSex: TLabel
          Left = 24
          Top = 39
          Width = 28
          Height = 16
          Caption = 'Sex:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object FBMI: TLabel
          Left = 23
          Top = 65
          Width = 29
          Height = 16
          Caption = 'BMI:'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object FAgeValue: TStaticText
          Left = 58
          Top = 16
          Width = 4
          Height = 4
          TabOrder = 0
          TabStop = True
        end
        object FSexValue: TStaticText
          Left = 58
          Top = 42
          Width = 4
          Height = 4
          TabOrder = 1
          TabStop = True
        end
        object FBMIValue: TStaticText
          Left = 58
          Top = 68
          Width = 4
          Height = 4
          TabOrder = 2
          TabStop = True
        end
      end
    end
    object PageEDD: TTabSheet
      Caption = 'Estimated Delivery Date'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        670
        370)
      object Label14: TLabel
        Left = 10
        Top = 18
        Width = 140
        Height = 13
        Caption = 'Gestational Age Today is'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label15: TLabel
        Left = 555
        Top = 18
        Width = 16
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'GA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbFinalEDD: TLabel
        Left = 372
        Top = 18
        Width = 58
        Height = 13
        Anchors = [akTop, akRight]
        Caption = 'Final EDD'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object edtCurrentEDD: TEdit
        Left = 435
        Top = 15
        Width = 103
        Height = 21
        Anchors = [akTop, akRight]
        Color = clSilver
        ReadOnly = True
        TabOrder = 1
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
          end
          item
            Column = 2
            Row = 1
          end
          item
            Column = 3
            Row = 1
          end
          item
            Column = 2
            Row = 2
          end
          item
            Column = 3
            Row = 2
          end
          item
            Column = 2
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
        TabOrder = 3
        DesignSize = (
          632
          289)
        object dtLMP: TORDateBox
          Left = 165
          Top = 51
          Width = 100
          Height = 21
          Anchors = []
          TabOrder = 0
          Text = 'Today'
          OnChange = dtLMPChange
          DateOnly = True
          RequireTime = False
          Caption = 'Last Menstrual Period Event Date'
        end
        object edtEDDLMP: TEdit
          Left = 403
          Top = 51
          Width = 103
          Height = 21
          Anchors = []
          Color = clSilver
          ReadOnly = True
          TabOrder = 1
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
        object dtECD: TORDateBox
          Left = 165
          Top = 92
          Width = 100
          Height = 21
          Anchors = []
          TabOrder = 3
          Text = 'Today'
          OnChange = dtECDChange
          DateOnly = True
          RequireTime = False
          Caption = 'Estimated Conception Date Event Date'
        end
        object edtEDDECD: TEdit
          Left = 403
          Top = 92
          Width = 103
          Height = 21
          Anchors = []
          Color = clSilver
          ReadOnly = True
          TabOrder = 4
        end
        object dtUltra: TORDateBox
          Left = 165
          Top = 133
          Width = 100
          Height = 21
          Anchors = []
          TabOrder = 6
          Text = 'Today'
          OnChange = dtUltraChange
          DateOnly = True
          RequireTime = False
          Caption = 'Ultrasound Event Date'
        end
        object spnWeekUltra: TSpinEdit
          Left = 281
          Top = 132
          Width = 49
          Height = 22
          Anchors = []
          MaxValue = 0
          MinValue = 0
          TabOrder = 7
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
          TabOrder = 8
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
          ReadOnly = True
          TabOrder = 9
        end
        object dtEmbryo: TORDateBox
          Left = 165
          Top = 174
          Width = 100
          Height = 21
          Anchors = []
          TabOrder = 12
          Text = 'Today'
          OnChange = dtEmbryoChange
          DateOnly = True
          RequireTime = False
          Caption = 'Embryo Transfer Event Date'
        end
        object edtEDDEmbryo: TEdit
          Left = 403
          Top = 174
          Width = 103
          Height = 21
          Anchors = []
          Color = clSilver
          ReadOnly = True
          TabOrder = 13
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
        object dtOther: TORDateBox
          Left = 165
          Top = 215
          Width = 100
          Height = 21
          Anchors = []
          TabOrder = 16
          Text = 'Today'
          OnChange = dtOtherChange
          DateOnly = True
          RequireTime = False
          Caption = 'Other Criteria Event Date'
        end
        object spnWeekOther: TSpinEdit
          Left = 281
          Top = 214
          Width = 49
          Height = 22
          Anchors = []
          MaxValue = 0
          MinValue = 0
          TabOrder = 17
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
          TabOrder = 18
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
          ReadOnly = True
          TabOrder = 19
        end
        object lblOther: TEdit
          Left = 0
          Top = 215
          Width = 149
          Height = 21
          Anchors = []
          MaxLength = 75
          TabOrder = 15
          Text = 'Other Criteria'
          OnChange = lblOtherChange
          OnExit = lblOtherExit
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
          ExplicitLeft = 38
          ExplicitTop = 12
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
          ExplicitLeft = 181
          ExplicitTop = 12
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
          ExplicitLeft = 440
          ExplicitTop = 12
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
          ExplicitLeft = 551
          ExplicitTop = 12
        end
        object ckFinalEDDLMP: TCheckBox
          Tag = 9
          Left = 572
          Top = 53
          Width = 19
          Height = 17
          Hint = 'IsFinal'
          Anchors = []
          TabOrder = 2
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
          TabOrder = 5
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
          TabOrder = 10
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
          TabOrder = 14
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
          TabOrder = 20
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
          TabOrder = 22
          OnClick = IsFinalEDDClick
        end
        object dtEDDUnknown: TORDateBox
          Left = 403
          Top = 257
          Width = 104
          Height = 21
          Anchors = []
          TabOrder = 21
          OnChange = dtEDDUnknownChange
          DateOnly = True
          RequireTime = False
          Caption = 'Unknown Estimated Delivery Date'
        end
        object Panel1: TPanel
          Left = 0
          Top = 164
          Width = 150
          Height = 41
          Anchors = []
          BevelOuter = bvNone
          TabOrder = 11
          object lblEmbryo: TLabel
            Left = 0
            Top = 0
            Width = 150
            Height = 41
            Align = alClient
            Caption = '                     Embryo Transfer'
            Layout = tlCenter
            ExplicitWidth = 143
            ExplicitHeight = 13
          end
          object cbTransferDay: TCaptionComboBox
            Left = 0
            Top = 10
            Width = 60
            Height = 21
            Style = csDropDownList
            DropDownCount = 3
            TabOrder = 0
            OnChange = spnTransferDayChange
            Items.Strings = (
              '3'
              '3-5'
              '5')
            Caption = 'Embryo Transfer Blastocyst Transfer'
          end
        end
      end
      object edtFinalGA: TEdit
        Left = 157
        Top = 15
        Width = 65
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 0
      end
      object edtEDDGA: TEdit
        Left = 577
        Top = 15
        Width = 65
        Height = 21
        Anchors = [akTop, akRight]
        Color = clSilver
        ReadOnly = True
        TabOrder = 2
      end
    end
    object PageLMP: TTabSheet
      Caption = 'Menstrual History'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label7: TLabel
        Left = 309
        Top = 127
        Width = 295
        Height = 13
        Caption = 'What type(s) of contraception were you using most recently?'
      end
      object Label6: TLabel
        Left = 309
        Top = 179
        Width = 61
        Height = 13
        Caption = 'Comments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label5: TLabel
        Left = 406
        Top = 71
        Width = 98
        Height = 13
        Caption = 'On Contraception'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbLMP: TLabel
        Left = 18
        Top = 18
        Width = 123
        Height = 13
        Caption = 'Last Menstrual Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label1: TLabel
        Left = 309
        Top = 98
        Width = 195
        Height = 13
        Caption = 'On Birth Control Pills at Conception'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbHCG: TLabel
        Left = 426
        Top = 38
        Width = 31
        Height = 13
        Caption = 'hCG+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object lbMenarche: TLabel
        Left = 39
        Top = 298
        Width = 56
        Height = 13
        Caption = 'Menarche'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object Label3: TLabel
        Left = 175
        Top = 298
        Width = 64
        Height = 13
        Caption = 'Age of Onset'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object edtContraceptionType: TCaptionComboBox
        Left = 309
        Top = 144
        Width = 339
        Height = 21
        Style = csDropDownList
        TabOrder = 9
        Caption = 
          'What type or types of contraception were you using most recently' +
          '?'
      end
      object memLMP: TCaptionMemo
        Left = 309
        Top = 196
        Width = 339
        Height = 121
        ScrollBars = ssVertical
        TabOrder = 10
        Caption = 'Comments'
      end
      object ckContraceptionNo: TCheckBox
        Tag = 6
        Left = 586
        Top = 70
        Width = 37
        Height = 17
        Caption = 'No'
        TabOrder = 6
        OnClick = ToggleCheckBoxes
      end
      object ckContraceptionYes: TCheckBox
        Tag = 5
        Left = 521
        Top = 70
        Width = 52
        Height = 17
        Caption = 'Yes'
        TabOrder = 5
        OnClick = ToggleCheckBoxes
      end
      object ckLMPQualifier: TCheckBox
        Left = 209
        Top = 37
        Width = 80
        Height = 17
        Caption = 'Approximate'
        TabOrder = 1
      end
      object edtLMP: TORDateBox
        Left = 18
        Top = 35
        Width = 185
        Height = 21
        TabOrder = 0
        OnChange = edtLMPChange
        DateOnly = True
        RequireTime = False
        Caption = 'Last Menstrual Period'
      end
      object gbMenses: TGroupBox
        Left = 18
        Top = 71
        Width = 271
        Height = 199
        Caption = 'Menses'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
        object lbMonthly: TLabel
          Left = 20
          Top = 55
          Width = 46
          Height = 13
          Caption = 'Monthly'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbFrequency: TLabel
          Left = 17
          Top = 143
          Width = 153
          Height = 13
          Caption = 'Duration of Flow Frequency'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object Label2: TLabel
          Left = 108
          Top = 163
          Width = 35
          Height = 13
          Caption = '# Days'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 152
          Top = 55
          Width = 35
          Height = 13
          Caption = '# Days'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
        end
        object ckMensesYes: TCheckBox
          Tag = 1
          Left = 49
          Top = 22
          Width = 63
          Height = 17
          Caption = 'Normal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = ToggleCheckBoxes
        end
        object ckMensesNo: TCheckBox
          Tag = 2
          Left = 137
          Top = 22
          Width = 80
          Height = 17
          Caption = 'Abnormal'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = ToggleCheckBoxes
        end
        object spnMonthly: TSpinEdit
          Left = 78
          Top = 52
          Width = 68
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 2
          Value = 0
          OnChange = spincheck
        end
        object spnFreq: TSpinEdit
          Left = 34
          Top = 160
          Width = 68
          Height = 22
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          MaxValue = 0
          MinValue = 0
          ParentFont = False
          TabOrder = 4
          Value = 0
          OnChange = spincheck
        end
        object Panel3: TPanel
          Left = 11
          Top = 78
          Width = 251
          Height = 62
          BevelOuter = bvNone
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 3
          object Label4: TLabel
            Left = 10
            Top = 11
            Width = 45
            Height = 13
            Caption = 'Amount'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object Label8: TLabel
            Left = 6
            Top = 36
            Width = 49
            Height = 13
            Caption = 'Duration'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
          end
          object ckAmountNo: TCheckBox
            Tag = 4
            Left = 149
            Top = 10
            Width = 66
            Height = 17
            Caption = 'Abnormal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 1
            OnClick = ToggleCheckBoxes
          end
          object ckAmountYes: TCheckBox
            Tag = 3
            Left = 67
            Top = 10
            Width = 61
            Height = 17
            Caption = 'Normal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 0
            OnClick = ToggleCheckBoxes
          end
          object ckDurationNo: TCheckBox
            Tag = 8
            Left = 149
            Top = 35
            Width = 66
            Height = 17
            Caption = 'Abnormal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = ToggleCheckBoxes
          end
          object ckDurationYes: TCheckBox
            Tag = 7
            Left = 67
            Top = 35
            Width = 61
            Height = 17
            Caption = 'Normal'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentFont = False
            TabOrder = 2
            OnClick = ToggleCheckBoxes
          end
        end
      end
      object ckBirthPillsYes: TCheckBox
        Tag = 9
        Left = 521
        Top = 97
        Width = 52
        Height = 17
        Caption = 'Yes'
        TabOrder = 7
        OnClick = ToggleCheckBoxes
      end
      object ckBirthPillsNo: TCheckBox
        Tag = 10
        Left = 586
        Top = 97
        Width = 37
        Height = 17
        Caption = 'No'
        TabOrder = 8
        OnClick = ToggleCheckBoxes
      end
      object edthcg: TORDateBox
        Left = 463
        Top = 35
        Width = 185
        Height = 21
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 4
        DateOnly = False
        RequireTime = False
        Caption = 'Human Chorionic Gonadotropin'
      end
      object spnMenarche: TSpinEdit
        Left = 101
        Top = 295
        Width = 68
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        MaxValue = 0
        MinValue = 0
        ParentFont = False
        TabOrder = 3
        Value = 0
        OnChange = spincheck
      end
    end
  end
end
