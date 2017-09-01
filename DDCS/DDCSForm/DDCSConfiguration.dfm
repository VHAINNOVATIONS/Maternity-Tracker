object fConfiguration: TfConfiguration
  Left = 0
  Top = 0
  Caption = 'Configuration and Report Item Editor'
  ClientHeight = 528
  ClientWidth = 982
  Color = clBtnFace
  Constraints.MinHeight = 555
  Constraints.MinWidth = 990
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
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
  Position = poOwnerFormCenter
  Scaled = False
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Tabs: TPageControl
    Left = 0
    Top = 0
    Width = 891
    Height = 528
    ActivePage = tabDialog
    Align = alClient
    MultiLine = True
    Style = tsButtons
    TabHeight = 30
    TabOrder = 0
    object tabDialog: TTabSheet
      Caption = 'Configuration && Reporting'
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        883
        488)
      object lvDDCSForm: TListView
        Left = 1
        Top = 3
        Width = 470
        Height = 482
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
        OnDblClick = lvDDCSFormDblClick
      end
      object pgConfigCR: TPageControl
        Left = 477
        Top = 0
        Width = 406
        Height = 488
        ActivePage = TabSheet3
        Align = alRight
        TabOrder = 1
        object TabSheet3: TTabSheet
          Caption = 'Configuration'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object meConfigValuesC: TCaptionMemo
            Left = 16
            Top = 28
            Width = 369
            Height = 185
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 1
            Caption = ''
          end
          object StaticText7: TStaticText
            Left = 16
            Top = 10
            Width = 120
            Height = 17
            Caption = 'Configuration Values'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 0
          end
          object edConfigRoutineC: TCaptionEdit
            Left = 16
            Top = 243
            Width = 369
            Height = 19
            Ctl3D = False
            ParentCtl3D = False
            TabOrder = 3
            Caption = ''
          end
          object StaticText10: TStaticText
            Left = 16
            Top = 226
            Width = 73
            Height = 17
            Caption = 'Run Routine'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 2
          end
          object StaticText11: TStaticText
            Left = 16
            Top = 282
            Width = 45
            Height = 17
            Caption = 'Dialogs'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -11
            Font.Name = 'Tahoma'
            Font.Style = [fsBold]
            ParentFont = False
            TabOrder = 4
          end
          object cklConfigDialogsC: TCaptionCheckListBox
            Left = 16
            Top = 299
            Width = 369
            Height = 139
            Ctl3D = False
            ItemHeight = 13
            ParentCtl3D = False
            TabOrder = 5
            Caption = ''
          end
        end
        object TabSheet4: TTabSheet
          Caption = 'Reporting'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object pnlReport: TPanel
            Left = -8
            Top = 0
            Width = 406
            Height = 460
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            object lbReportNotice: TStaticText
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 400
              Height = 46
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 
                'Changing the information here will override Report Item configur' +
                'ation. To restore original behavior delete the override.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TabStop = True
            end
            object lbOrder: TStaticText
              Left = 16
              Top = 81
              Width = 41
              Height = 20
              Caption = 'Order'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              TabStop = True
            end
            object lbTitle: TStaticText
              Left = 16
              Top = 156
              Width = 31
              Height = 20
              Caption = 'Title'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
            end
            object lbPrefix: TStaticText
              Left = 16
              Top = 183
              Width = 41
              Height = 20
              Caption = 'Prefix'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
            end
            object lbSuffix: TStaticText
              Left = 16
              Top = 210
              Width = 40
              Height = 20
              Caption = 'Suffix'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 8
            end
            object lbDialogReturn: TStaticText
              Left = 16
              Top = 325
              Width = 92
              Height = 20
              Caption = 'Dialog Return'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 15
            end
            object ckHideFromNoteCR: TCheckBox
              Left = 72
              Top = 269
              Width = 97
              Height = 17
              Caption = 'Hide from Note'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 11
            end
            object ckRequiredCR: TCheckBox
              Left = 225
              Top = 269
              Width = 97
              Height = 17
              Caption = 'Required'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 14
            end
            object ckDoNotSaveCR: TCheckBox
              Left = 72
              Top = 292
              Width = 132
              Height = 17
              Caption = 'Do not Save'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 12
            end
            object spOrderCR: TSpinEdit
              Left = 72
              Top = 80
              Width = 64
              Height = 19
              Ctl3D = False
              MaxValue = 0
              MinValue = 0
              ParentCtl3D = False
              TabOrder = 3
              Value = 0
            end
            object edTitleCR: TCaptionEdit
              Left = 72
              Top = 156
              Width = 313
              Height = 19
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 5
              Caption = 'Title'
            end
            object edPrefixCR: TCaptionEdit
              Left = 72
              Top = 183
              Width = 313
              Height = 19
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 7
              Caption = 'Prefix'
            end
            object edSuffixCR: TCaptionEdit
              Left = 72
              Top = 210
              Width = 313
              Height = 19
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 9
              Caption = 'Suffix'
            end
            object ckDoNotSpaceCR: TCheckBox
              Left = 72
              Top = 246
              Width = 97
              Height = 17
              Caption = 'Do not Space'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 10
            end
            object cbDialogReturnCR: TCaptionComboBox
              Left = 114
              Top = 325
              Width = 271
              Height = 21
              Style = csDropDownList
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 16
              Caption = 'Dialog Return'
            end
            object ckDoNotRestoreCR: TCheckBox
              Left = 225
              Top = 246
              Width = 120
              Height = 17
              Caption = 'Do not Restore (V)'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 13
            end
            object lbReportControlCR: TStaticText
              Left = 0
              Top = 52
              Width = 406
              Height = 4
              Align = alTop
              Alignment = taCenter
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              TabStop = True
              ExplicitWidth = 4
            end
            object edIdentifyingNameCR: TCaptionEdit
              Left = 16
              Top = 129
              Width = 369
              Height = 19
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 21
              Caption = 'Identifying Name'
            end
            object StaticText8: TStaticText
              Left = 16
              Top = 108
              Width = 113
              Height = 20
              Caption = 'Identifying Name'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 23
              TabStop = True
            end
          end
        end
      end
    end
    object tabReport: TTabSheet
      Caption = 'Dialog Editor'
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      DesignSize = (
        883
        488)
      object btnReloadDialogs: TBitBtn
        Left = 1
        Top = 3
        Width = 234
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
      object lvDialogComponent: TListView
        Left = 241
        Top = 3
        Width = 223
        Height = 482
        Anchors = [akLeft, akTop, akRight, akBottom]
        Columns = <
          item
            AutoSize = True
            Caption = 'Name'
            MinWidth = 140
          end
          item
            AutoSize = True
            Caption = 'Class'
            MinWidth = 80
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 2
        ViewStyle = vsReport
        OnColumnClick = ListColumnClick
        OnCompare = ListCompare
        OnDblClick = lvDialogComponentDblClick
      end
      object btnDialogShow: TBitBtn
        Left = 1
        Top = 460
        Width = 234
        Height = 25
        Anchors = [akLeft, akBottom]
        Caption = 'Show'
        TabOrder = 1
        OnClick = btnDialogShowClick
      end
      object lvDialog: TListView
        Left = 1
        Top = 34
        Width = 234
        Height = 420
        Anchors = [akLeft, akTop, akBottom]
        Columns = <
          item
            AutoSize = True
            Caption = 'Name'
            MinWidth = 120
          end
          item
            AutoSize = True
            Caption = 'Unit'
            MinWidth = 110
          end>
        ReadOnly = True
        RowSelect = True
        TabOrder = 3
        ViewStyle = vsReport
        OnColumnClick = ListColumnClick
        OnCompare = ListCompare
        OnDblClick = lvDialogDblClick
      end
      object pgDialogOutput: TPageControl
        Left = 464
        Top = 0
        Width = 419
        Height = 488
        ActivePage = TabSheet1
        Align = alRight
        TabOrder = 4
        object TabSheet1: TTabSheet
          Caption = 'Report Items'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object Panel1: TPanel
            Left = 5
            Top = 0
            Width = 406
            Height = 460
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 0
            object StaticText1: TStaticText
              AlignWithMargins = True
              Left = 3
              Top = 3
              Width = 400
              Height = 46
              Align = alTop
              Alignment = taCenter
              AutoSize = False
              Caption = 
                'Changing the information here will override Report Item configur' +
                'ation. To restore original behavior delete the override.'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = []
              ParentFont = False
              TabOrder = 0
              TabStop = True
            end
            object StaticText2: TStaticText
              Left = 16
              Top = 81
              Width = 41
              Height = 20
              Caption = 'Order'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 2
              TabStop = True
            end
            object StaticText3: TStaticText
              Left = 16
              Top = 156
              Width = 31
              Height = 20
              Caption = 'Title'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 4
            end
            object StaticText4: TStaticText
              Left = 16
              Top = 183
              Width = 41
              Height = 20
              Caption = 'Prefix'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 6
            end
            object StaticText5: TStaticText
              Left = 16
              Top = 210
              Width = 40
              Height = 20
              Caption = 'Suffix'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 8
            end
            object StaticText6: TStaticText
              Left = 16
              Top = 325
              Width = 92
              Height = 20
              Caption = 'Dialog Return'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 15
            end
            object ckHideFromNoteD: TCheckBox
              Left = 72
              Top = 269
              Width = 97
              Height = 17
              Caption = 'Hide from Note'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 11
            end
            object ckRequiredD: TCheckBox
              Left = 225
              Top = 269
              Width = 97
              Height = 17
              Caption = 'Required'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 14
            end
            object ckDoNotSaveD: TCheckBox
              Left = 72
              Top = 292
              Width = 132
              Height = 17
              Caption = 'Do not Save'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 12
            end
            object spOrderD: TSpinEdit
              Left = 72
              Top = 80
              Width = 64
              Height = 19
              Ctl3D = False
              MaxValue = 0
              MinValue = 0
              ParentCtl3D = False
              TabOrder = 3
              Value = 0
            end
            object edTitleD: TCaptionEdit
              Left = 72
              Top = 156
              Width = 313
              Height = 19
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 5
              Caption = 'Title'
            end
            object edPrefixD: TCaptionEdit
              Left = 72
              Top = 183
              Width = 313
              Height = 19
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 7
              Caption = 'Prefix'
            end
            object edSuffixD: TCaptionEdit
              Left = 72
              Top = 210
              Width = 313
              Height = 19
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 9
              Caption = 'Suffix'
            end
            object ckDoNotSpaceD: TCheckBox
              Left = 72
              Top = 246
              Width = 97
              Height = 17
              Caption = 'Do not Space'
              TabOrder = 10
            end
            object cbDialogReturnD: TCaptionComboBox
              Left = 114
              Top = 325
              Width = 271
              Height = 21
              Style = csDropDownList
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 16
              Caption = 'Dialog Return'
            end
            object ckDoNotRestoreD: TCheckBox
              Left = 225
              Top = 246
              Width = 120
              Height = 17
              Caption = 'Do not Restore (V)'
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 13
            end
            object lbReportControlD: TStaticText
              Left = 0
              Top = 52
              Width = 406
              Height = 4
              Align = alTop
              Alignment = taCenter
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -12
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 1
              TabStop = True
              ExplicitWidth = 4
            end
            object edIdentifyingNameD: TCaptionEdit
              Left = 16
              Top = 129
              Width = 369
              Height = 19
              Ctl3D = False
              ParentCtl3D = False
              TabOrder = 21
              Caption = 'Identifying Name'
            end
            object StaticText9: TStaticText
              Left = 16
              Top = 108
              Width = 113
              Height = 20
              Caption = 'Identifying Name'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'Tahoma'
              Font.Style = [fsBold]
              ParentFont = False
              TabOrder = 23
              TabStop = True
            end
          end
        end
        object TabSheet2: TTabSheet
          Caption = 'Output'
          ExplicitLeft = 0
          ExplicitTop = 0
          ExplicitWidth = 0
          ExplicitHeight = 0
          object meDialogOutput: TMemo
            Left = 0
            Top = 0
            Width = 411
            Height = 460
            Align = alClient
            Ctl3D = False
            ParentCtl3D = False
            ScrollBars = ssBoth
            TabOrder = 0
          end
        end
      end
    end
  end
  object pnlCommand: TPanel
    Left = 891
    Top = 0
    Width = 91
    Height = 528
    Align = alRight
    BevelKind = bkFlat
    BevelOuter = bvNone
    BorderStyle = bsSingle
    Ctl3D = False
    ParentCtl3D = False
    TabOrder = 1
    object btnSave: TBitBtn
      Left = 0
      Top = 0
      Width = 85
      Height = 25
      Align = alTop
      Caption = '&Save  '
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
      OnClick = btnSaveClick
    end
    object btnDelete: TBitBtn
      Left = 0
      Top = 50
      Width = 85
      Height = 25
      Align = alTop
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
      Top = 25
      Width = 85
      Height = 25
      Align = alTop
      Caption = 'Clear  '
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
      TabOrder = 1
      OnClick = btnClearClick
    end
    object btnClose: TBitBtn
      Left = 0
      Top = 497
      Width = 85
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
    object btnUpdate: TBitBtn
      Left = 0
      Top = 240
      Width = 85
      Height = 49
      Caption = 'Update All'
      NumGlyphs = 2
      TabOrder = 3
      OnClick = btnUpdateClick
    end
  end
end
