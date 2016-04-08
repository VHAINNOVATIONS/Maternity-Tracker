object DDCSFormConfig: TDDCSFormConfig
  Left = 0
  Top = 0
  Caption = 'Configuration and Report Item Editor'
  ClientHeight = 556
  ClientWidth = 911
  Color = clBtnFace
  Constraints.MinHeight = 555
  Constraints.MinWidth = 860
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Tabs: TPageControl
    Left = 0
    Top = 0
    Width = 820
    Height = 556
    ActivePage = tabConfig
    Align = alClient
    MultiLine = True
    Style = tsButtons
    TabHeight = 30
    TabOrder = 0
    object tabConfig: TTabSheet
      Caption = 'Configuration'
      DesignSize = (
        812
        516)
      object lvConfig: TListView
        Left = 1
        Top = 3
        Width = 320
        Height = 479
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            AutoSize = True
            Caption = 'Name'
            MinWidth = 150
          end
          item
            Caption = 'Class'
            MinWidth = 80
            Width = 80
          end
          item
            Caption = 'Page'
            MaxWidth = 50
            MinWidth = 50
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = ListColumnClick
        OnCompare = ListCompare
        OnDblClick = lvConfigDblClick
      end
      object btnUpdateConfig: TBitBtn
        Left = 1
        Top = 488
        Width = 130
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Update VistA'
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
        TabOrder = 1
        OnClick = btnUpdateConfigClick
      end
      object pnlConfig: TPanel
        Left = 327
        Top = 0
        Width = 485
        Height = 516
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 2
      end
    end
    object tabDialog: TTabSheet
      Caption = 'Report Items'
      ImageIndex = 1
      DesignSize = (
        812
        516)
      object lvReportItems: TListView
        Left = 1
        Top = 3
        Width = 399
        Height = 510
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            AutoSize = True
            Caption = 'Name'
            MinWidth = 150
          end
          item
            AutoSize = True
            Caption = 'Class'
            MinWidth = 80
          end
          item
            AutoSize = True
            Caption = 'Page'
            MinWidth = 50
          end
          item
            AutoSize = True
            Caption = 'Required'
            MinWidth = 60
          end
          item
            AutoSize = True
            Caption = 'Order'
            MinWidth = 50
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 0
        ViewStyle = vsReport
        OnColumnClick = ListColumnClick
        OnCompare = ListCompare
        OnDblClick = lvReportItemsDblClick
      end
      object pnlReport: TPanel
        Left = 406
        Top = 0
        Width = 406
        Height = 516
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
        object lbReportNotice: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 400
          Height = 32
          Align = alTop
          Alignment = taCenter
          Caption = 
            'Changing the information here will override Report Item configur' +
            'ation. To restore original behavior delete the override.'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          WordWrap = True
          ExplicitWidth = 357
        end
        object lbOrder: TLabel
          Left = 16
          Top = 67
          Width = 37
          Height = 16
          Caption = 'Order'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbTitle: TLabel
          Left = 16
          Top = 95
          Width = 27
          Height = 16
          Caption = 'Title'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbPrefix: TLabel
          Left = 16
          Top = 122
          Width = 37
          Height = 16
          Caption = 'Prefix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbSuffix: TLabel
          Left = 16
          Top = 149
          Width = 36
          Height = 16
          Caption = 'Suffix'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object lbDialogReturn: TLabel
          Left = 16
          Top = 305
          Width = 88
          Height = 16
          Caption = 'Dialog Return'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object ckHideFromNote: TCheckBox
          Left = 89
          Top = 218
          Width = 97
          Height = 17
          Caption = 'Hide From Note'
          TabOrder = 5
        end
        object ckRequired: TCheckBox
          Left = 89
          Top = 264
          Width = 97
          Height = 17
          Caption = 'Required'
          TabOrder = 7
        end
        object ckDoNotSave: TCheckBox
          Left = 89
          Top = 241
          Width = 132
          Height = 17
          Caption = 'Do Not Save'
          TabOrder = 6
        end
        object spOrder: TSpinEdit
          Left = 89
          Top = 66
          Width = 64
          Height = 22
          MaxValue = 0
          MinValue = 0
          TabOrder = 0
          Value = 0
        end
        object edTitle: TEdit
          Left = 89
          Top = 94
          Width = 288
          Height = 21
          TabOrder = 1
        end
        object edPrefix: TEdit
          Left = 89
          Top = 121
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object edSuffix: TEdit
          Left = 89
          Top = 148
          Width = 121
          Height = 21
          TabOrder = 3
        end
        object ckDoNotSpace: TCheckBox
          Left = 89
          Top = 195
          Width = 97
          Height = 17
          Caption = 'Do Not Space'
          TabOrder = 4
        end
        object cbDialogReturn: TComboBox
          Left = 129
          Top = 304
          Width = 145
          Height = 21
          Style = csDropDownList
          TabOrder = 8
        end
      end
    end
    object tabReport: TTabSheet
      Caption = 'Dialog Editor'
      ImageIndex = 2
      DesignSize = (
        812
        516)
      object btnReloadDialogs: TBitBtn
        Left = 1
        Top = 3
        Width = 186
        Height = 25
        Caption = 'Reload Dialogs from DLL'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        OnClick = ReloadDialogs
      end
      object btnUpdateDialogs: TBitBtn
        Left = 57
        Top = 488
        Width = 129
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Update VistA'
        Default = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'Tahoma'
        Font.Style = []
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
        ParentFont = False
        TabOrder = 3
        OnClick = btnUpdateDialogsClick
      end
      object lsDialog: TListBox
        Left = 0
        Top = 34
        Width = 186
        Height = 448
        Anchors = [akLeft, akTop, akBottom]
        ItemHeight = 13
        TabOrder = 1
        OnDblClick = lsDialogDblClick
      end
      object lvDialogComponent: TListView
        Left = 192
        Top = 3
        Width = 234
        Height = 510
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            AutoSize = True
            Caption = 'Name'
            MinWidth = 150
          end
          item
            AutoSize = True
            Caption = 'Class'
            MaxWidth = 80
            MinWidth = 80
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 4
        ViewStyle = vsReport
        OnColumnClick = ListColumnClick
        OnCompare = ListCompare
        OnDblClick = lvDialogComponentDblClick
      end
      object btnDialogShow: TBitBtn
        Left = 1
        Top = 488
        Width = 50
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Show'
        TabOrder = 2
        OnClick = btnDialogShowClick
      end
      object pnlDialog: TPanel
        Left = 432
        Top = 0
        Width = 380
        Height = 516
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 5
      end
    end
  end
  object pnlCommand: TPanel
    Left = 820
    Top = 0
    Width = 91
    Height = 556
    Align = alRight
    BevelKind = bkFlat
    BevelOuter = bvNone
    BorderStyle = bsSingle
    TabOrder = 1
    object btnCancel: TBitBtn
      Left = 0
      Top = 25
      Width = 83
      Height = 25
      Align = alTop
      Cancel = True
      Caption = '&Cancel'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnSave: TBitBtn
      Left = 0
      Top = 0
      Width = 83
      Height = 25
      Align = alTop
      Caption = '&Save'
      Enabled = False
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
    object btnDelete: TBitBtn
      Left = 0
      Top = 157
      Width = 83
      Height = 25
      Caption = 'Delete'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 2
      OnClick = btnDeleteClick
    end
    object btnClear: TBitBtn
      Left = 0
      Top = 131
      Width = 83
      Height = 25
      Caption = 'Clear'
      Enabled = False
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        333333333333333333333333000033338833333333333333333F333333333333
        0000333911833333983333333388F333333F3333000033391118333911833333
        38F38F333F88F33300003339111183911118333338F338F3F8338F3300003333
        911118111118333338F3338F833338F3000033333911111111833333338F3338
        3333F8330000333333911111183333333338F333333F83330000333333311111
        8333333333338F3333383333000033333339111183333333333338F333833333
        00003333339111118333333333333833338F3333000033333911181118333333
        33338333338F333300003333911183911183333333383338F338F33300003333
        9118333911183333338F33838F338F33000033333913333391113333338FF833
        38F338F300003333333333333919333333388333338FFF830000333333333333
        3333333333333333333888330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnClearClick
    end
    object btnClose: TBitBtn
      Left = 0
      Top = 523
      Width = 83
      Height = 25
      Align = alBottom
      Cancel = True
      Caption = 'Close'
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
        3333333333333FFFFF333333000033333388888833333333333F888888FFF333
        000033338811111188333333338833FFF388FF33000033381119999111833333
        38F338888F338FF30000339119933331111833338F388333383338F300003391
        13333381111833338F8F3333833F38F3000039118333381119118338F38F3338
        33F8F38F000039183333811193918338F8F333833F838F8F0000391833381119
        33918338F8F33833F8338F8F000039183381119333918338F8F3833F83338F8F
        000039183811193333918338F8F833F83333838F000039118111933339118338
        F3833F83333833830000339111193333391833338F33F8333FF838F300003391
        11833338111833338F338FFFF883F83300003339111888811183333338FF3888
        83FF83330000333399111111993333333388FFFFFF8833330000333333999999
        3333333333338888883333330000333333333333333333333333333333333333
        0000}
      NumGlyphs = 2
      TabOrder = 4
      OnClick = btnCloseClick
    end
  end
end
