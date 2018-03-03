object TenderForm: TTenderForm
  Left = 0
  Top = 0
  HorzScrollBar.Style = ssFlat
  HorzScrollBar.Visible = False
  Caption = 'TenderForm'
  ClientHeight = 306
  ClientWidth = 724
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = mm
  OldCreateOrder = False
  OnCreate = FormCreate
  OnResize = FormResize
  PixelsPerInch = 96
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 724
    Height = 306
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitHeight = 254
    object ListTable: TStringGrid
      Left = 1
      Top = 1
      Width = 722
      Height = 198
      Align = alClient
      ColCount = 1
      Ctl3D = False
      DrawingStyle = gdsClassic
      FixedColor = clTeal
      FixedCols = 0
      GradientEndColor = clTeal
      GradientStartColor = clTeal
      GridLineWidth = 2
      ParentCtl3D = False
      TabOrder = 0
      OnDrawCell = ListTableDrawCell
      OnMouseUp = ListTableMouseUp
      ExplicitHeight = 187
      ColWidths = (
        64)
      RowHeights = (
        24
        24
        24
        24
        24)
    end
    object pnlBottom: TPanel
      Left = 1
      Top = 240
      Width = 722
      Height = 65
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'pnlBottom'
      Color = clInfoBk
      Ctl3D = True
      ParentBackground = False
      ParentCtl3D = False
      ShowCaption = False
      TabOrder = 1
      ExplicitTop = 188
      object btnAdd: TButton
        Left = 0
        Top = 0
        Width = 722
        Height = 65
        Align = alClient
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100
        DoubleBuffered = False
        ParentDoubleBuffered = False
        TabOrder = 0
        OnClick = btnAddClick
      end
    end
    object pnlEditOn: TPanel
      Left = 1
      Top = 199
      Width = 722
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 
        #1056#1077#1078#1080#1084' '#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1103' '#1072#1082#1090#1080#1074#1080#1088#1086#1074#1072#1085'. '#1063#1090#1086#1073#1099' '#1086#1090#1088#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086#1083#1077' - '#1087 +
        #1088#1086#1089#1090#1086' '#1082#1083#1080#1082#1085#1080#1090#1077' '#1087#1086' '#1085#1077#1084#1091'. '#1042#1089#1077' '#1073#1077#1079#1091#1084#1085#1086' '#1087#1088#1086#1089#1090#1086'!'
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentBackground = False
      ParentFont = False
      TabOrder = 2
      Visible = False
      ExplicitLeft = 320
      ExplicitTop = 141
      ExplicitWidth = 185
    end
  end
  object mm: TMainMenu
    Left = 352
    Top = 64
    object mnFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object mniSaveAll: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100' '#1074#1089#1077
        OnClick = mniSaveAllClick
      end
    end
    object mnLists: TMenuItem
      Caption = #1057#1087#1080#1089#1082#1080
      object mniObjList: TMenuItem
        Caption = #1054#1073#1098#1077#1082#1090#1099
        OnClick = mniObjListClick
      end
      object mniContrList: TMenuItem
        Caption = #1055#1086#1076#1088#1103#1076#1095#1080#1082#1080
        OnClick = mniContrListClick
      end
      object mniWorkersList: TMenuItem
        Caption = #1056#1072#1073#1086#1095#1080#1077
        OnClick = mniWorkersListClick
      end
    end
    object mniTender: TMenuItem
      Caption = #1058#1077#1085#1076#1077#1088
      object mnNewTender: TMenuItem
        Caption = #1053#1086#1074#1099#1081' '#1090#1077#1085#1076#1077#1088
        OnClick = mnNewTenderClick
      end
    end
    object mnEdit: TMenuItem
      Caption = #1056#1077#1076#1072#1082#1090#1080#1088#1086#1074#1072#1085#1080#1077
      object mniEditOn: TMenuItem
        Caption = #1042#1082#1083#1102#1095#1080#1090#1100
        RadioItem = True
        OnClick = mniEditOnClick
      end
      object mniEditOff: TMenuItem
        Caption = #1042#1099#1082#1083#1102#1095#1080#1090#1100
        Checked = True
        RadioItem = True
        OnClick = mniEditOffClick
      end
    end
    object mnSearch: TMenuItem
      Caption = #1055#1086#1080#1089#1082
      object mniSearchObj: TMenuItem
        Caption = #1054#1073#1098#1077#1082#1090#1099
        OnClick = mniSearchObjClick
      end
      object mniSearchContr: TMenuItem
        Caption = #1055#1086#1076#1088#1103#1076#1095#1080#1082#1080
        OnClick = mniSearchContrClick
      end
      object mniSearchWorkers: TMenuItem
        Caption = #1056#1072#1073#1086#1095#1080#1077
        OnClick = mniSearchWorkersClick
      end
    end
  end
  object tmrEditMode: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrEditModeTimer
    Left = 528
    Top = 32
  end
end
