object fVitals: TfVitals
  Left = 0
  Top = 0
  Width = 541
  Height = 272
  TabOrder = 0
  object fVitalsControl: TPageControl
    Left = 0
    Top = 0
    Width = 541
    Height = 272
    ActivePage = PageMain
    Align = alClient
    MultiLine = True
    TabOrder = 0
    TabPosition = tpRight
    object PageMain: TTabSheet
      Caption = 'Vitals'
      DesignSize = (
        513
        264)
      object FAge: TStaticText
        Left = 32
        Top = 24
        Width = 30
        Height = 17
        Caption = 'Age: '
        TabOrder = 1
        TabStop = True
      end
      object FSex: TStaticText
        Left = 32
        Top = 47
        Width = 29
        Height = 17
        Caption = 'Sex: '
        TabOrder = 2
        TabStop = True
      end
      object FBMI: TStaticText
        Left = 32
        Top = 70
        Width = 29
        Height = 17
        Caption = 'BMI: '
        TabOrder = 3
        TabStop = True
      end
      object FTemps: TEdit
        Left = 77
        Top = 103
        Width = 73
        Height = 21
        ReadOnly = True
        TabOrder = 4
      end
      object FHeights: TEdit
        Left = 77
        Top = 154
        Width = 73
        Height = 21
        ReadOnly = True
        TabOrder = 5
      end
      object FWeights: TEdit
        Left = 77
        Top = 205
        Width = 73
        Height = 21
        ReadOnly = True
        TabOrder = 6
      end
      object FTempdt: TStaticText
        Left = 77
        Top = 131
        Width = 4
        Height = 4
        TabOrder = 7
        TabStop = True
      end
      object FHeightdt: TStaticText
        Left = 77
        Top = 182
        Width = 4
        Height = 4
        TabOrder = 8
        TabStop = True
      end
      object FWeightdt: TStaticText
        Left = 77
        Top = 233
        Width = 4
        Height = 4
        TabOrder = 9
        TabStop = True
      end
      object FTempl: TStaticText
        Left = 32
        Top = 105
        Width = 34
        Height = 17
        Caption = 'Temp:'
        TabOrder = 10
        TabStop = True
      end
      object FHeightl: TStaticText
        Left = 32
        Top = 157
        Width = 39
        Height = 17
        Caption = 'Height:'
        TabOrder = 11
        TabStop = True
      end
      object FWeightl: TStaticText
        Left = 32
        Top = 208
        Width = 42
        Height = 17
        Caption = 'Weight:'
        TabOrder = 12
        TabStop = True
      end
      object FTempe: TEdit
        Left = 156
        Top = 103
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 13
      end
      object FHeighte: TEdit
        Left = 156
        Top = 154
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 14
      end
      object FWeighte: TEdit
        Left = 156
        Top = 205
        Width = 49
        Height = 21
        ReadOnly = True
        TabOrder = 15
      end
      object FPulses: TEdit
        Left = 264
        Top = 103
        Width = 73
        Height = 21
        ReadOnly = True
        TabOrder = 16
      end
      object FPulsedt: TStaticText
        Left = 264
        Top = 131
        Width = 4
        Height = 4
        TabOrder = 17
        TabStop = True
      end
      object FPulsel: TStaticText
        Left = 225
        Top = 105
        Width = 33
        Height = 17
        Caption = 'Pulse:'
        TabOrder = 18
        TabStop = True
      end
      object FResps: TEdit
        Left = 264
        Top = 154
        Width = 73
        Height = 21
        ReadOnly = True
        TabOrder = 19
      end
      object FRespl: TStaticText
        Left = 225
        Top = 157
        Width = 32
        Height = 17
        Caption = 'Resp:'
        TabOrder = 20
        TabStop = True
      end
      object FRespdt: TStaticText
        Left = 264
        Top = 182
        Width = 4
        Height = 4
        TabOrder = 21
        TabStop = True
      end
      object FPains: TEdit
        Left = 264
        Top = 205
        Width = 73
        Height = 21
        ReadOnly = True
        TabOrder = 22
      end
      object FPainl: TStaticText
        Left = 225
        Top = 208
        Width = 28
        Height = 17
        Caption = 'Pain:'
        TabOrder = 23
        TabStop = True
      end
      object FPaindt: TStaticText
        Left = 264
        Top = 233
        Width = 4
        Height = 4
        TabOrder = 24
        TabStop = True
      end
      object FSystolics: TEdit
        Left = 416
        Top = 103
        Width = 73
        Height = 21
        ReadOnly = True
        TabOrder = 25
      end
      object FSystolicl: TStaticText
        Left = 366
        Top = 105
        Width = 44
        Height = 17
        Caption = 'Systolic:'
        TabOrder = 26
        TabStop = True
      end
      object FSystolicdt: TStaticText
        Left = 416
        Top = 131
        Width = 4
        Height = 4
        TabOrder = 27
        TabStop = True
      end
      object FDiastolics: TEdit
        Left = 416
        Top = 154
        Width = 73
        Height = 21
        ReadOnly = True
        TabOrder = 28
      end
      object FDiastolicl: TStaticText
        Left = 366
        Top = 157
        Width = 47
        Height = 17
        Caption = 'Diastolic:'
        TabOrder = 29
        TabStop = True
      end
      object FDiastolicdt: TStaticText
        Left = 416
        Top = 182
        Width = 4
        Height = 4
        TabOrder = 30
        TabStop = True
      end
      object StaticText1: TStaticText
        Left = 432
        Top = 14
        Width = 58
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'Vitals'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -19
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 0
      end
    end
    object PageEDD: TTabSheet
      Caption = 'EDD'
      ImageIndex = 1
      OnShow = PageEDDShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
    object PageLMP: TTabSheet
      Caption = 'LMP'
      ImageIndex = 2
      OnShow = PageLMPShow
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
    end
  end
end
