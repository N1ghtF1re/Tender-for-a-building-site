object TenderForm: TTenderForm
  Left = 0
  Top = 0
  HorzScrollBar.Style = ssFlat
  HorzScrollBar.Visible = False
  Caption = 'TenderForm'
  ClientHeight = 394
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
    Height = 394
    Align = alClient
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    ExplicitLeft = 544
    ExplicitTop = 216
    ExplicitWidth = 185
    ExplicitHeight = 41
    object ListTable: TStringGrid
      Left = 1
      Top = 1
      Width = 722
      Height = 392
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
      OnMouseUp = ListTableMouseUp
      RowHeights = (
        24
        24
        24
        24
        24)
    end
  end
  object mm: TMainMenu
    Left = 352
    Top = 64
    object mnFile: TMenuItem
      Caption = #1060#1072#1081#1083
    end
    object mnLists: TMenuItem
      Caption = #1057#1087#1080#1089#1082#1080
      object mnObjList: TMenuItem
        Caption = #1054#1073#1098#1077#1082#1090#1099
        OnClick = mnObjListClick
      end
      object mnContrList: TMenuItem
        Caption = #1055#1086#1076#1088#1103#1076#1095#1080#1082#1080
        OnClick = mnContrListClick
      end
      object mnWorkersList: TMenuItem
        Caption = #1056#1072#1073#1086#1095#1080#1077
        OnClick = mnWorkersListClick
      end
    end
    object mnTender: TMenuItem
      Caption = #1058#1077#1085#1076#1077#1088
      object mnNewTender: TMenuItem
        Caption = #1053#1086#1074#1099#1081' '#1090#1077#1085#1076#1077#1088
        OnClick = mnNewTenderClick
      end
    end
  end
end
