object EditReportF: TEditReportF
  Left = 0
  Top = 0
  ClientHeight = 537
  ClientWidth = 780
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlDesigner: TPanel
    Left = 0
    Top = 0
    Width = 780
    Height = 512
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlDesigner'
    ShowCaption = False
    TabOrder = 0
    ExplicitHeight = 485
  end
  object pnlactions: TPanel
    Left = 0
    Top = 512
    Width = 780
    Height = 25
    Align = alBottom
    BevelOuter = bvLowered
    Caption = 'pnlactions'
    ShowCaption = False
    TabOrder = 1
    object chkActive: TcxCheckBox
      Left = 0
      Top = 2
      Caption = #1040#1082#1090#1080#1074#1077#1085
      Properties.DisplayChecked = '1'
      Properties.DisplayUnchecked = '0'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      State = cbsGrayed
      TabOrder = 0
      Transparent = True
      OnClick = chkActiveClick
      Width = 81
    end
    object cxLabel1: TcxLabel
      Left = 80
      Top = 3
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      Transparent = True
    end
    object edReportName: TcxDBTextEdit
      Left = 132
      Top = 3
      DataBinding.DataField = 'ReportName'
      DataBinding.DataSource = dsReports
      TabOrder = 2
      Width = 409
    end
  end
  object frxDesigner: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = [drDontShowRecentFiles]
    RTLLanguage = False
    MemoParentFont = False
    OnSaveReport = frxDesignerSaveReport
    Left = 116
    Top = 128
  end
  object frxReport: TfrxReport
    Version = '5.3.1'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator, pbExportQuick]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #1055#1086' '#1091#1084#1086#1083#1095#1072#1085#1080#1102
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 42211.439516712960000000
    ReportOptions.LastChange = 42211.439516712960000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      'begin'
      ''
      'end.')
    Left = 152
    Top = 128
    Datasets = <>
    Variables = <>
    Style = <>
    object Data: TfrxDataPage
      Height = 1000.000000000000000000
      Width = 1000.000000000000000000
    end
    object Page1: TfrxReportPage
      Orientation = poLandscape
      PaperWidth = 297.000000000000000000
      PaperHeight = 210.000000000000000000
      PaperSize = 9
      LeftMargin = 10.000000000000000000
      RightMargin = 10.000000000000000000
      TopMargin = 10.000000000000000000
      BottomMargin = 10.000000000000000000
      object MasterData1: TfrxMasterData
        FillType = ftBrush
        Height = 22.677180000000000000
        Top = 18.897650000000000000
        Width = 1046.929810000000000000
        RowCount = 0
      end
    end
  end
  object qrReports: TUniQuery
    KeyFields = 'ReportID'
    SQLInsert.Strings = (
      'INSERT INTO Reports'
      '  (ReportGroupID, ReportName, ReportBinary, IsActive)'
      'VALUES'
      '  (:ReportGroupID, :ReportName, :ReportBinary, :IsActive)'
      'SET :ReportID = SCOPE_IDENTITY()')
    SQLDelete.Strings = (
      'DELETE FROM Reports'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLUpdate.Strings = (
      'UPDATE Reports'
      'SET'
      
        '  ReportGroupID = :ReportGroupID, ReportName = :ReportName, Repo' +
        'rtBinary = :ReportBinary, IsActive = :IsActive'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLLock.Strings = (
      'SELECT * FROM Reports'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLRefresh.Strings = (
      
        'SELECT ReportGroupID, ReportName, ReportBinary, IsActive FROM Re' +
        'ports'
      'WHERE'
      '  ReportID = :ReportID')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM Reports'
      ')')
    Connection = DataF.DB
    SQL.Strings = (
      'select * from Reports  where ReportID = :ReportID')
    Options.QueryRecCount = True
    Options.ReturnParams = True
    BeforeUpdateExecute = qrReportsBeforeUpdateExecute
    Left = 112
    Top = 176
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ReportID'
        Value = nil
      end>
    object qrReportsReportID: TIntegerField
      FieldName = 'ReportID'
      ReadOnly = True
      Required = True
    end
    object qrReportsReportGroupID: TIntegerField
      FieldName = 'ReportGroupID'
      Required = True
    end
    object qrReportsReportName: TWideStringField
      FieldName = 'ReportName'
      Required = True
      Size = 128
    end
    object qrReportsReportBinary: TBlobField
      FieldName = 'ReportBinary'
    end
    object qrReportsIsActive: TByteField
      FieldName = 'IsActive'
      Required = True
    end
  end
  object dsReports: TUniDataSource
    DataSet = qrReports
    Left = 144
    Top = 176
  end
  object frxChartObject: TfrxChartObject
    Left = 200
    Top = 128
  end
  object frxBarCodeObject: TfrxBarCodeObject
    Left = 236
    Top = 128
  end
  object frxOLEObject: TfrxOLEObject
    Left = 272
    Top = 124
  end
  object frxRichObject: TfrxRichObject
    Left = 312
    Top = 124
  end
  object frxCrossObject: TfrxCrossObject
    Left = 352
    Top = 128
  end
  object frxCheckBoxObject: TfrxCheckBoxObject
    Left = 388
    Top = 132
  end
  object frxGradientObject: TfrxGradientObject
    Left = 432
    Top = 132
  end
  object frxDotMatrixExport: TfrxDotMatrixExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    EscModel = 0
    GraphicFrames = False
    SaveToFile = False
    UseIniSettings = True
    Left = 476
    Top = 136
  end
  object frxDialogControls: TfrxDialogControls
    Left = 524
    Top = 136
  end
  object frxCrypt: TfrxCrypt
    Left = 444
    Top = 252
  end
  object fsScript: TfsScript
    SyntaxType = 'PascalScript'
    Left = 620
    Top = 216
  end
  object frxPDFExport: TfrxPDFExport
    UseFileCache = True
    ShowProgress = True
    OverwritePrompt = False
    DataOnly = False
    PrintOptimized = False
    Outline = False
    Background = False
    HTMLTags = True
    Quality = 95
    Transparency = False
    Author = 'FastReport'
    Subject = 'FastReport PDF export'
    ProtectionFlags = [ePrint, eModify, eCopy, eAnnot]
    HideToolbar = False
    HideMenubar = False
    HideWindowUI = False
    FitWindow = False
    CenterWindow = False
    PrintScaling = False
    PdfA = False
    Left = 628
    Top = 296
  end
end
