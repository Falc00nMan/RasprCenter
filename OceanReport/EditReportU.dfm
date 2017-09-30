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
    Top = 30
    Width = 780
    Height = 507
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnlDesigner'
    ParentShowHint = False
    ShowCaption = False
    ShowHint = True
    TabOrder = 0
  end
  object pnlactions: TAdvPanel
    Left = 0
    Top = 0
    Width = 780
    Height = 30
    Align = alTop
    BevelOuter = bvNone
    Color = 16643823
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clBlack
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    UseDockManager = True
    Version = '2.3.0.8'
    AutoSize.Width = False
    BorderWidth = 1
    Caption.Color = 16643823
    Caption.ColorTo = 15784647
    Caption.Font.Charset = DEFAULT_CHARSET
    Caption.Font.Color = 5978398
    Caption.Font.Height = -11
    Caption.Font.Name = 'Tahoma'
    Caption.Font.Style = []
    Caption.GradientDirection = gdVertical
    Caption.Indent = 2
    Caption.ShadeLight = 255
    CollapsColor = clNone
    CollapsDelay = 0
    ColorTo = 15784647
    ShadowColor = clBlack
    ShadowOffset = 0
    StatusBar.BorderColor = 16643823
    StatusBar.BorderStyle = bsSingle
    StatusBar.Font.Charset = DEFAULT_CHARSET
    StatusBar.Font.Color = 5978398
    StatusBar.Font.Height = -11
    StatusBar.Font.Name = 'Tahoma'
    StatusBar.Font.Style = []
    StatusBar.Color = 16643823
    StatusBar.ColorTo = 15784647
    StatusBar.GradientDirection = gdVertical
    Text = ''
    FullHeight = 30
    object cxLabel1: TcxLabel
      Left = 5
      Top = 6
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077
      Transparent = True
    end
    object rbReport: TcxRadioButton
      Left = 355
      Top = 7
      Width = 50
      Height = 17
      Caption = #1086#1090#1095#1077#1090
      TabOrder = 2
      Transparent = True
    end
    object rbDocument: TcxRadioButton
      Left = 280
      Top = 7
      Width = 70
      Height = 17
      Caption = #1076#1086#1082#1091#1084#1077#1085#1090
      Checked = True
      TabOrder = 3
      TabStop = True
      Transparent = True
    end
    object chkActive: TcxCheckBox
      Left = 420
      Top = 7
      AutoSize = False
      Caption = #1040#1082#1090#1080#1074#1077#1085
      Properties.DisplayChecked = '1'
      Properties.DisplayUnchecked = '0'
      Properties.NullStyle = nssUnchecked
      Properties.ValueChecked = '1'
      Properties.ValueUnchecked = '0'
      State = cbsChecked
      TabOrder = 4
      Transparent = True
      OnClick = chkActiveClick
      Height = 17
      Width = 73
    end
    object edReportName: TcxTextEdit
      Left = 63
      Top = 4
      Properties.OnChange = edReportNamePropertiesChange
      TabOrder = 1
      Text = #1041#1077#1079' '#1085#1072#1079#1074#1072#1085#1080#1103
      Width = 200
    end
    object cxButton1: TcxButton
      Left = 500
      Top = 4
      Width = 121
      Height = 21
      Caption = #1042#1099#1073#1088#1072#1090#1100' '#1092#1086#1088#1084#1099
      TabOrder = 5
      OnClick = cxButton1Click
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
    Left = 76
    Top = 96
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
    Left = 192
    Top = 104
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
      '  (ReportGroupID, ReportName, ReportBinary, IsActive, DocType)'
      'VALUES'
      
        '  (:ReportGroupID, :ReportName, :ReportBinary, :IsActive, :DocTy' +
        'pe)'
      'SET :ReportID = SCOPE_IDENTITY()')
    SQLDelete.Strings = (
      'DELETE FROM Reports'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLUpdate.Strings = (
      'UPDATE Reports'
      'SET'
      
        '  ReportGroupID = :ReportGroupID, ReportName = :ReportName, Repo' +
        'rtBinary = :ReportBinary, IsActive = :IsActive, DocType = :DocTy' +
        'pe'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLLock.Strings = (
      'SELECT * FROM Reports'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLRefresh.Strings = (
      
        'SELECT ReportGroupID, ReportName, ReportBinary, IsActive, DocTyp' +
        'e FROM Reports'
      'WHERE'
      '  ReportID = :ReportID')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM Reports'
      ')')
    Connection = DataF.MainConnection
    SQL.Strings = (
      'select * from Reports where ReportID = :ReportID')
    Options.QueryRecCount = True
    Options.ReturnParams = True
    BeforeUpdateExecute = qrReportsBeforeUpdateExecute
    Left = 48
    Top = 192
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
    object qrReportsDocType: TByteField
      FieldName = 'DocType'
      Required = True
    end
  end
  object dsReports: TUniDataSource
    DataSet = qrReports
    Left = 136
    Top = 216
  end
  object frxChartObject: TfrxChartObject
    Left = 216
    Top = 184
  end
  object frxBarCodeObject: TfrxBarCodeObject
    Left = 276
    Top = 48
  end
  object frxOLEObject: TfrxOLEObject
    Left = 352
    Top = 124
  end
  object frxRichObject: TfrxRichObject
    Left = 304
    Top = 196
  end
  object frxCrossObject: TfrxCrossObject
    Left = 400
    Top = 64
  end
  object frxCheckBoxObject: TfrxCheckBoxObject
    Left = 388
    Top = 204
  end
  object frxGradientObject: TfrxGradientObject
    Left = 488
    Top = 156
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
    Left = 524
    Top = 96
  end
  object frxDialogControls: TfrxDialogControls
    Left = 588
    Top = 112
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
  object qrReportsFormsLink: TUniQuery
    KeyFields = 'ReportID'
    SQLInsert.Strings = (
      'INSERT INTO Reports'
      '  (ReportGroupID, ReportName, ReportBinary, IsActive, DocType)'
      'VALUES'
      
        '  (:ReportGroupID, :ReportName, :ReportBinary, :IsActive, :DocTy' +
        'pe)'
      'SET :ReportID = SCOPE_IDENTITY()')
    SQLDelete.Strings = (
      'DELETE FROM Reports'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLUpdate.Strings = (
      'UPDATE Reports'
      'SET'
      
        '  ReportGroupID = :ReportGroupID, ReportName = :ReportName, Repo' +
        'rtBinary = :ReportBinary, IsActive = :IsActive, DocType = :DocTy' +
        'pe'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLLock.Strings = (
      'SELECT * FROM Reports'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLRefresh.Strings = (
      
        'SELECT ReportGroupID, ReportName, ReportBinary, IsActive, DocTyp' +
        'e FROM Reports'
      'WHERE'
      '  ReportID = :ReportID')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM Reports'
      ')')
    Connection = DataF.MainConnection
    SQL.Strings = (
      'INSERT INTO ReportsFormsLinks (ReportID, FormID)'
      'VALUES (:ReportID, :FormID)')
    Options.QueryRecCount = True
    Options.ReturnParams = True
    BeforeUpdateExecute = qrReportsBeforeUpdateExecute
    Left = 48
    Top = 280
    ParamData = <
      item
        DataType = ftUnknown
        Name = 'ReportID'
        Value = nil
      end
      item
        DataType = ftInteger
        Name = 'FormID'
        ParamType = ptInput
        Value = nil
      end>
    object IntegerField1: TIntegerField
      FieldName = 'ReportID'
      ReadOnly = True
      Required = True
    end
    object IntegerField2: TIntegerField
      FieldName = 'ReportGroupID'
      Required = True
    end
    object WideStringField1: TWideStringField
      FieldName = 'ReportName'
      Required = True
      Size = 128
    end
    object BlobField1: TBlobField
      FieldName = 'ReportBinary'
    end
    object ByteField1: TByteField
      FieldName = 'IsActive'
      Required = True
    end
    object ByteField2: TByteField
      FieldName = 'DocType'
      Required = True
    end
  end
  object mdForms: TdxMemData
    Indexes = <>
    SortOptions = []
    Left = 128
    Top = 368
  end
  object qForms: TUniQuery
    Connection = DataF.MainConnection
    SQL.Strings = (
      
        'select FormID, FormName, ClassName, Cast(CASE WHEN FormSelected ' +
        'IS NULL THEN 0 ELSE 1 END as tinyint) FormSelected From ('
      'select s.*, l.FormID FormSelected from sprForms s'
      
        'left join ReportsFormsLinks l on l.FormID = s.FormID and l.Repor' +
        'tID = IsNull(:ReportID, l.ReportID)) q'
      'order by FormName')
    Left = 42
    Top = 373
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ReportID'
        ParamType = ptInput
        Value = nil
      end>
  end
  object qrReportsFormsLinkDelete: TUniQuery
    KeyFields = 'ReportID'
    SQLInsert.Strings = (
      'INSERT INTO Reports'
      '  (ReportGroupID, ReportName, ReportBinary, IsActive, DocType)'
      'VALUES'
      
        '  (:ReportGroupID, :ReportName, :ReportBinary, :IsActive, :DocTy' +
        'pe)'
      'SET :ReportID = SCOPE_IDENTITY()')
    SQLDelete.Strings = (
      'DELETE FROM Reports'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLUpdate.Strings = (
      'UPDATE Reports'
      'SET'
      
        '  ReportGroupID = :ReportGroupID, ReportName = :ReportName, Repo' +
        'rtBinary = :ReportBinary, IsActive = :IsActive, DocType = :DocTy' +
        'pe'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLLock.Strings = (
      'SELECT * FROM Reports'
      'WITH (UPDLOCK, ROWLOCK, HOLDLOCK)'
      'WHERE'
      '  ReportID = :Old_ReportID')
    SQLRefresh.Strings = (
      
        'SELECT ReportGroupID, ReportName, ReportBinary, IsActive, DocTyp' +
        'e FROM Reports'
      'WHERE'
      '  ReportID = :ReportID')
    SQLRecCount.Strings = (
      'SET :PCOUNT = (SELECT COUNT(*) FROM Reports'
      ')')
    Connection = DataF.MainConnection
    SQL.Strings = (
      'DELETE FROM ReportsFormsLinks WHERE ReportID = :ReportID')
    Options.QueryRecCount = True
    Options.ReturnParams = True
    BeforeUpdateExecute = qrReportsBeforeUpdateExecute
    Left = 128
    Top = 280
    ParamData = <
      item
        DataType = ftInteger
        Name = 'ReportID'
        ParamType = ptInput
        Value = nil
      end>
    object IntegerField3: TIntegerField
      FieldName = 'ReportID'
      ReadOnly = True
      Required = True
    end
    object IntegerField4: TIntegerField
      FieldName = 'ReportGroupID'
      Required = True
    end
    object WideStringField2: TWideStringField
      FieldName = 'ReportName'
      Required = True
      Size = 128
    end
    object BlobField2: TBlobField
      FieldName = 'ReportBinary'
    end
    object ByteField3: TByteField
      FieldName = 'IsActive'
      Required = True
    end
    object ByteField4: TByteField
      FieldName = 'DocType'
      Required = True
    end
  end
end
