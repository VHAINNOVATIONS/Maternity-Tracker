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
      object FAge: TStaticText
        Left = 40
        Top = 26
        Width = 35
        Height = 20
        Caption = 'Age:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object FSex: TStaticText
        Left = 43
        Top = 52
        Width = 32
        Height = 20
        Caption = 'Sex:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object FBMI: TStaticText
        Left = 42
        Top = 80
        Width = 33
        Height = 20
        Caption = 'BMI:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object FTemps: TCaptionEdit
        Left = 77
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 7
        Caption = 'Temperature in Fahrenheit'
      end
      object FHeights: TCaptionEdit
        Left = 77
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 11
        Caption = 'Height in Inches'
      end
      object FWeights: TCaptionEdit
        Left = 77
        Top = 261
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 15
        Caption = 'Weight in Pounds'
      end
      object FTempdt: TStaticText
        Left = 77
        Top = 143
        Width = 4
        Height = 4
        TabOrder = 9
        TabStop = True
      end
      object FHeightdt: TStaticText
        Left = 77
        Top = 214
        Width = 4
        Height = 4
        TabOrder = 13
        TabStop = True
      end
      object FWeightdt: TStaticText
        Left = 77
        Top = 288
        Width = 4
        Height = 4
        TabOrder = 17
        TabStop = True
      end
      object FTempl: TStaticText
        Left = 36
        Top = 120
        Width = 36
        Height = 17
        Caption = 'Temp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
      end
      object FHeightl: TStaticText
        Left = 31
        Top = 191
        Width = 41
        Height = 17
        Caption = 'Height'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 10
      end
      object FWeightl: TStaticText
        Left = 28
        Top = 265
        Width = 44
        Height = 17
        Caption = 'Weight'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
      end
      object FTempe: TCaptionEdit
        Left = 183
        Top = 116
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 8
        Caption = 'Temperature in Celsius'
      end
      object FHeighte: TCaptionEdit
        Left = 183
        Top = 187
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 12
        Caption = 'Height in Centimeters'
      end
      object FWeighte: TCaptionEdit
        Left = 183
        Top = 261
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 16
        Caption = 'Weight in Kilograms'
      end
      object FPulses: TCaptionEdit
        Left = 298
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 19
        Caption = 'Pulse'
      end
      object FPulsedt: TStaticText
        Left = 298
        Top = 143
        Width = 4
        Height = 4
        TabOrder = 20
        TabStop = True
      end
      object FPulsel: TStaticText
        Left = 259
        Top = 120
        Width = 34
        Height = 17
        Caption = 'Pulse'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 18
      end
      object FResps: TCaptionEdit
        Left = 298
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 22
        Caption = 'Respiration'
      end
      object FRespl: TStaticText
        Left = 261
        Top = 191
        Width = 32
        Height = 17
        Caption = 'Resp'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 21
      end
      object FRespdt: TStaticText
        Left = 298
        Top = 214
        Width = 4
        Height = 4
        TabOrder = 23
        TabStop = True
      end
      object FPains: TCaptionEdit
        Left = 298
        Top = 261
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 25
        Caption = 'Pain'
      end
      object FPainl: TStaticText
        Left = 265
        Top = 265
        Width = 28
        Height = 17
        Caption = 'Pain'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 24
      end
      object FPaindt: TStaticText
        Left = 298
        Top = 288
        Width = 4
        Height = 4
        TabOrder = 26
        TabStop = True
      end
      object FSystolics: TCaptionEdit
        Left = 487
        Top = 116
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 28
        Caption = 'Blood Pressure Systolic'
      end
      object FSystolicl: TStaticText
        Left = 434
        Top = 120
        Width = 48
        Height = 17
        Caption = 'Systolic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 27
      end
      object FSystolicdt: TStaticText
        Left = 487
        Top = 143
        Width = 4
        Height = 4
        TabOrder = 29
        TabStop = True
      end
      object FDiastolics: TCaptionEdit
        Left = 487
        Top = 187
        Width = 103
        Height = 21
        ReadOnly = True
        TabOrder = 31
        Caption = 'Blood Pressure Diastolic'
      end
      object FDiastolicl: TStaticText
        Left = 430
        Top = 191
        Width = 52
        Height = 17
        Caption = 'Diastolic'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 30
      end
      object FDiastolicdt: TStaticText
        Left = 487
        Top = 214
        Width = 4
        Height = 4
        TabOrder = 32
        TabStop = True
      end
      object FAgeValue: TStaticText
        Left = 77
        Top = 29
        Width = 4
        Height = 4
        TabOrder = 1
        TabStop = True
      end
      object FSexValue: TStaticText
        Left = 77
        Top = 55
        Width = 4
        Height = 4
        TabOrder = 3
        TabStop = True
      end
      object FBMIValue: TStaticText
        Left = 77
        Top = 83
        Width = 4
        Height = 4
        TabOrder = 5
        TabStop = True
      end
    end
    object PageEDD: TTabSheet
      Caption = 'Estimated Delivery Date'
      ImageIndex = 1
      DesignSize = (
        670
        370)
      object Label14: TStaticText
        Left = 10
        Top = 18
        Width = 144
        Height = 17
        Caption = 'Gestational Age Today is'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object Label15: TStaticText
        Left = 555
        Top = 18
        Width = 20
        Height = 17
        Anchors = [akTop, akRight]
        Caption = 'GA'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object StaticText2: TStaticText
        Left = 372
        Top = 18
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
      end
      object edtCurrentEDD: TCaptionEdit
        Left = 435
        Top = 15
        Width = 103
        Height = 21
        Anchors = [akTop, akRight]
        Color = clSilver
        ReadOnly = True
        TabOrder = 3
        Caption = 'Final Estimated Delivery Date'
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
        TabOrder = 6
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
        object edtEDDLMP: TCaptionEdit
          Left = 403
          Top = 51
          Width = 103
          Height = 21
          Anchors = []
          Color = clSilver
          ReadOnly = True
          TabOrder = 1
          Caption = 'Last Menstrual Period Estimated Delivery Date'
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
        object edtEDDECD: TCaptionEdit
          Left = 403
          Top = 92
          Width = 103
          Height = 21
          Anchors = []
          Color = clSilver
          ReadOnly = True
          TabOrder = 4
          Caption = 'Estimated Conception Date Estimated Delivery Date'
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
        object edtEDDUltra: TCaptionEdit
          Left = 403
          Top = 133
          Width = 103
          Height = 21
          Anchors = []
          Color = clSilver
          ReadOnly = True
          TabOrder = 9
          Caption = 'Ultrasound Estimated Delivery Date'
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
        object edtEDDEmbryo: TCaptionEdit
          Left = 403
          Top = 174
          Width = 103
          Height = 21
          Anchors = []
          Color = clSilver
          ReadOnly = True
          TabOrder = 13
          Caption = 'Embryo Transfer Estimated Delivery Date'
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
          Caption = 'Entrer Other Criteria Event Date'
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
        object edtEDDOther: TCaptionEdit
          Left = 403
          Top = 215
          Width = 103
          Height = 21
          Anchors = []
          Color = clSilver
          ReadOnly = True
          TabOrder = 19
          Caption = 'Enter Other Criteria Estimated Delivery Date'
        end
        object lblOther: TCaptionEdit
          Left = 0
          Top = 215
          Width = 149
          Height = 21
          Anchors = []
          TabOrder = 15
          Text = 'Enter Other Criteria'
          OnChange = lblOtherChange
          OnExit = lblOtherExit
          OnMouseEnter = lblOtherMouseEnter
          Caption = 'Enter Other Criteria'
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
            Caption = 'Embryo Transfer'
            Layout = tlCenter
            ExplicitWidth = 80
            ExplicitHeight = 13
          end
          object cbTransferDay: TCaptionComboBox
            Left = 89
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
      object edtFinalGA: TCaptionEdit
        Left = 159
        Top = 15
        Width = 65
        Height = 21
        Color = clSilver
        ReadOnly = True
        TabOrder = 1
        Caption = 'Gestational Age Today is'
      end
      object edtEDDGA: TCaptionEdit
        Left = 577
        Top = 15
        Width = 65
        Height = 21
        Anchors = [akTop, akRight]
        Color = clSilver
        ReadOnly = True
        TabOrder = 5
        Caption = 'Gestational Age'
      end
    end
    object PageLMP: TTabSheet
      Caption = 'Menstrual History'
      ImageIndex = 2
      object Label7: TStaticText
        Left = 278
        Top = 137
        Width = 299
        Height = 17
        Caption = 'What type(s) of contraception were you using most recently?'
        TabOrder = 23
      end
      object Label6: TStaticText
        Left = 278
        Top = 199
        Width = 65
        Height = 17
        Caption = 'Comments'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 25
      end
      object Label8: TStaticText
        Left = 333
        Top = 72
        Width = 53
        Height = 17
        Caption = 'Duration'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 17
        TabStop = True
      end
      object Label5: TStaticText
        Left = 284
        Top = 105
        Width = 102
        Height = 17
        Caption = 'On Contraception'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 20
        TabStop = True
      end
      object Label4: TStaticText
        Left = 337
        Top = 40
        Width = 49
        Height = 17
        Caption = 'Amount'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 14
        TabStop = True
      end
      object Label3: TStaticText
        Left = 90
        Top = 254
        Width = 99
        Height = 17
        Caption = '(Fill in age of onset)'
        TabOrder = 11
      end
      object Label2: TStaticText
        Left = 90
        Top = 194
        Width = 72
        Height = 17
        Caption = '(Fill in # days)'
        TabOrder = 8
      end
      object Label1: TStaticText
        Left = 34
        Top = 125
        Width = 47
        Height = 17
        Caption = 'Menses'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
        TabStop = True
      end
      object edtContraceptionType: TCaptionComboBox
        Left = 278
        Top = 156
        Width = 358
        Height = 21
        Style = csDropDownList
        TabOrder = 24
        Caption = 
          'What type or types of contraception were you using most recently' +
          '?'
      end
      object ckMensesYes: TCheckBox
        Tag = 1
        Left = 90
        Top = 125
        Width = 63
        Height = 17
        Caption = 'Normal'
        TabOrder = 4
        OnClick = ToggleCheckBoxes
      end
      object ckDurationYes: TCheckBox
        Tag = 7
        Left = 401
        Top = 72
        Width = 64
        Height = 17
        Caption = 'Normal'
        TabOrder = 18
        OnClick = ToggleCheckBoxes
      end
      object ckAmountYes: TCheckBox
        Tag = 3
        Left = 401
        Top = 40
        Width = 63
        Height = 17
        Caption = 'Normal'
        TabOrder = 15
        OnClick = ToggleCheckBoxes
      end
      object memLMP: TCaptionMemo
        Left = 278
        Top = 214
        Width = 358
        Height = 131
        ScrollBars = ssVertical
        TabOrder = 26
        Caption = 'Comments'
      end
      object ckDurationNo: TCheckBox
        Tag = 8
        Left = 474
        Top = 72
        Width = 82
        Height = 17
        Caption = 'Abnormal'
        TabOrder = 19
        OnClick = ToggleCheckBoxes
      end
      object ckContraceptionNo: TCheckBox
        Tag = 6
        Left = 474
        Top = 104
        Width = 37
        Height = 17
        Caption = 'No'
        TabOrder = 22
        OnClick = ToggleCheckBoxes
      end
      object ckContraceptionYes: TCheckBox
        Tag = 5
        Left = 401
        Top = 104
        Width = 52
        Height = 17
        Caption = 'Yes'
        TabOrder = 21
        OnClick = ToggleCheckBoxes
      end
      object ckAmountNo: TCheckBox
        Tag = 4
        Left = 474
        Top = 40
        Width = 82
        Height = 17
        Caption = 'Abnormal'
        TabOrder = 16
        OnClick = ToggleCheckBoxes
      end
      object edtMenarche: TCaptionEdit
        Left = 90
        Top = 231
        Width = 136
        Height = 21
        TabOrder = 10
        Caption = 'Menarche as age of onset'
      end
      object edtFrequency: TCaptionEdit
        Left = 90
        Top = 171
        Width = 136
        Height = 21
        TabOrder = 7
        Caption = 'Frequency in number of days'
      end
      object ckMensesNo: TCheckBox
        Tag = 2
        Left = 158
        Top = 125
        Width = 68
        Height = 17
        Caption = 'Abnormal'
        TabOrder = 5
        OnClick = ToggleCheckBoxes
      end
      object ck_LMPQualifier: TCheckBox
        Left = 22
        Top = 83
        Width = 97
        Height = 17
        Caption = 'Approximate'
        TabOrder = 2
      end
      object edthcg: TORDateBox
        Left = 90
        Top = 289
        Width = 136
        Height = 21
        TabOrder = 13
        DateOnly = False
        RequireTime = False
        Caption = 'Human Chorionic Gonadotropin'
      end
      object StaticText1: TStaticText
        Left = 46
        Top = 293
        Width = 35
        Height = 17
        Caption = 'hCG+'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 12
      end
      object StaticText3: TStaticText
        Left = 22
        Top = 40
        Width = 127
        Height = 17
        Caption = 'Last Menstrual Period'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
      object StaticText4: TStaticText
        Left = 18
        Top = 175
        Width = 63
        Height = 17
        Caption = 'Frequency'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 6
      end
      object StaticText5: TStaticText
        Left = 21
        Top = 235
        Width = 60
        Height = 17
        Caption = 'Menarche'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 9
      end
      object edtLMP: TORDateBox
        Left = 22
        Top = 56
        Width = 204
        Height = 21
        TabOrder = 1
        OnChange = edtLMPChange
        DateOnly = True
        RequireTime = False
        Caption = 'Last Menstrual Period'
      end
    end
  end
end
