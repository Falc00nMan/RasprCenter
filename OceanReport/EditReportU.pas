unit EditReportU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDesgn, Vcl.ExtCtrls,
  Vcl.Menus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxCheckBox, Data.DB, MemDS, DBAccess, Uni, cxLabel,
  cxTextEdit, cxDBEdit, frxExportPDF, fs_iinterpreter, frxCrypt, frxDCtrl,
  frxDMPExport, frxGradient, frxChBox, frxCross, frxRich, frxOLE, frxBarcode,
  frxChart, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom,
  dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver,
  dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008,
  dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  Vcl.StdCtrls, cxRadioGroup, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit, cxDBLookupComboBox, AdvPanel,
  cxCheckComboBox, cxDBCheckComboBox, cxButtons, cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxNavigator,
  cxDBData, cxGridCustomTableView, cxGridTableView, cxGridDBTableView, cxClasses, cxGridCustomView, cxGrid,
  cxDBExtLookupComboBox, VirtualTable, dxmdaset;

type
  TEditReportF = class(TForm)
    frxDesigner: TfrxDesigner;
    frxReport: TfrxReport;
    pnlDesigner: TPanel;
    qrReports: TUniQuery;
    qrReportsReportID: TIntegerField;
    qrReportsReportGroupID: TIntegerField;
    qrReportsReportName: TWideStringField;
    qrReportsReportBinary: TBlobField;
    qrReportsIsActive: TByteField;
    dsReports: TUniDataSource;
    frxChartObject: TfrxChartObject;
    frxBarCodeObject: TfrxBarCodeObject;
    frxOLEObject: TfrxOLEObject;
    frxRichObject: TfrxRichObject;
    frxCrossObject: TfrxCrossObject;
    frxCheckBoxObject: TfrxCheckBoxObject;
    frxGradientObject: TfrxGradientObject;
    frxDotMatrixExport: TfrxDotMatrixExport;
    frxDialogControls: TfrxDialogControls;
    frxCrypt: TfrxCrypt;
    fsScript: TfsScript;
    frxPDFExport: TfrxPDFExport;
    pnlactions: TAdvPanel;
    cxLabel1: TcxLabel;
    rbReport: TcxRadioButton;
    rbDocument: TcxRadioButton;
    chkActive: TcxCheckBox;
    edReportName: TcxTextEdit;
    qrReportsDocType: TByteField;
    qrReportsFormsLink: TUniQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    WideStringField1: TWideStringField;
    BlobField1: TBlobField;
    ByteField1: TByteField;
    ByteField2: TByteField;
    cxButton1: TcxButton;
    mdForms: TdxMemData;
    qForms: TUniQuery;
    qrReportsFormsLinkDelete: TUniQuery;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    WideStringField2: TWideStringField;
    BlobField2: TBlobField;
    ByteField3: TByteField;
    ByteField4: TByteField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure qrReportsBeforeUpdateExecute(Sender: TDataSet;
      StatementTypes: TStatementTypes; Params: TDAParams);
    function frxDesignerSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
    procedure chkActiveClick(Sender: TObject);
    procedure edReportNamePropertiesChange(Sender: TObject);
    procedure cxButton1Click(Sender: TObject);
  private
    ReportID : Integer;
    ReportGroupID : Integer;

    procedure LoadReport;
  public
    constructor Create(const V: Variant); reintroduce;
  end;

var
  EditReportF: TEditReportF;

function ShowEditReport(const V: Variant): Variant;

implementation

{$R *.dfm}

uses DataU, MainU, SelectFormU;

function ShowEditReport(const V: Variant): Variant;
begin
  Result := Null;
  try
      //EditReportF := TEditReportF.Create(V);
      with TEditReportF.Create(V) do
      begin
        FormStyle := fsMDIChild;
        WindowState := wsMaximized;
        Show;
      end;
  except
    //if Assigned(EditReportF) then FreeAndNil(EditReportF);
    Raise;
  end;
end;

procedure TEditReportF.qrReportsBeforeUpdateExecute(Sender: TDataSet;
  StatementTypes: TStatementTypes; Params: TDAParams);
begin
  if stInsert in StatementTypes then Params.ParamByName('ReportID').ParamType := ptInputOutput;
end;

procedure TEditReportF.chkActiveClick(Sender: TObject);
begin
  frxReport.Report.Designer.Modified := True;
end;

constructor TEditReportF.Create(const V: Variant);
begin
  ReportID := (v[0]);
  ReportGroupID := v[1];

  inherited Create(Application);
  Caption := VarToStr(v[2]);
  edReportName.Text := Caption;
end;

procedure TEditReportF.cxButton1Click(Sender: TObject);
begin
  Application.CreateForm(TSelectForm, SelectForm);
  mdForms.First;
  SelectForm.dsForms.DataSet := mdForms;
  SelectForm.ShowModal;
  FreeAndNil(SelectForm);
end;

procedure TEditReportF.edReportNamePropertiesChange(Sender: TObject);
begin
  Caption := edReportName.Text;
end;

procedure TEditReportF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frxReport.Designer.Modified := False;
  frxReport.Designer.Close;
  Action := caFree;
end;

procedure TEditReportF.FormCreate(Sender: TObject);
begin
  LoadReport;
end;

function TEditReportF.frxDesignerSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
var
  Stream : TMemoryStream;
begin
  Stream := TMemoryStream.Create;

  if qrReports.IsEmpty then
  begin
    qrReports.Append;
    //frxReport.Report.ReportOptions.Name := ReportName;
    frxReport.FileName := edReportName.Text;
    frxReport.SaveToStream(Stream);
    Stream.Position := 0;
    qrReportsReportBinary.LoadFromStream(Stream);
    qrReports['ReportGroupID'] := ReportGroupID;
    qrReports['ReportName'] := edReportName.Text;
    qrReports['IsActive'] := chkActive.EditingValue;
    if rbReport.Checked then
      qrReports['DocType'] := 1
    else
      qrReports['DocType'] := 2;

    qrReports.Post;
    chkActive.EditValue := qrReports['IsActive'];
    ReportID := qrReports['ReportID'];
  end else
  begin
    qrReports.Edit;
    frxReport.SaveToStream(Stream);
    qrReportsReportBinary.LoadFromStream(Stream);
    qrReports['ReportName'] := edReportName.Text;
    if rbDocument.Checked then
      qrReports['DocType'] := 1
    else
      qrReports['DocType'] := 2;
    qrReports['IsActive'] := chkActive.EditingValue;
    qrReports.Post;
  end;

  qrReportsFormsLinkDelete.ParamByName('ReportID').AsInteger := ReportID;
  qrReportsFormsLinkDelete.ExecSQL;

  mdForms.First;
  while not mdForms.Eof do
  begin
    if mdForms.FieldByName('FormSelected').Value = 1 then
    begin
      qrReportsFormsLink.ParamByName('ReportID').Value := ReportID;
      qrReportsFormsLink.ParamByName('FormID').Value := mdForms.FieldByName('FormID').Value;
      qrReportsFormsLink.ExecSQL;
    end;
    mdForms.Next;
  end;

  Stream.Free;
  MessageBox(handle,PChar('Отчет сохранен.'+#13#10), PChar('Информация'), MB_OK+MB_DEFBUTTON1+MB_DEFBUTTON2+MB_ICONINFORMATION);
  MainF.ReloadTree;
end;

procedure TEditReportF.LoadReport;
var
  Designer: TfrxDesignerForm;
  Stream : TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  if qrReports.Active then qrReports.Close;
  qrReports.ParamByName('ReportID').AsInteger := ReportID;
  qrReports.Open;

  if qrReports.IsEmpty then
  begin
    chkActive.EditValue := 1;
    chkActive.Checked := True;
  end else
  begin
    qrReportsReportBinary.SaveToStream(Stream);
    Stream.Position := 0;
    frxReport.LoadFromStream(Stream);
    chkActive.EditValue := (qrReports['IsActive']);
    rbReport.Checked := (qrReports['DocType'] = 2);
  end;

  frxReport.EngineOptions.DestroyForms := False;
  // set the custom preview
  //frxReport.Preview := frxPreview1;
  // display the designer
  frxReport.DesignReportInPanel(pnlDesigner);
  Designer := TfrxDesignerForm(frxReport.Designer);

  frxReport.Designer.Modified := True;

  // assign FR actions to our menu items
  {NewMI.Action := Designer.NewItemCmd;
  NewReportMI.Action := Designer.NewReportCmd;
  NewPageMI.Action := Designer.NewPageCmd;
  NewDialogMI.Action := Designer.NewDialogCmd;
  OpenMI.Action := Designer.OpenCmd;
  SaveMI.Action := Designer.SaveCmd;
  SaveasMI.Action := Designer.SaveAsCmd;
  PreviewMI.Action := Designer.PreviewCmd;
  PageSettingsMI.Action := Designer.PageSettingsCmd;

  UndoMI.Action := Designer.UndoCmd;
  RedoMI.Action := Designer.RedoCmd;
  CutMI.Action := Designer.CutCmd;
  CopyMI.Action := Designer.CopyCmd;
  PasteMI.Action := Designer.PasteCmd;
  DeleteMI.Action := Designer.DeleteCmd;
  DeletePageMI.Action := Designer.DeletePageCmd;
  SelectAllMI.Action := Designer.SelectAllCmd;
  GroupMI.Action := Designer.GroupCmd;
  UngroupMI.Action := Designer.UngroupCmd;
  EditMI.Action := Designer.EditCmd;
  FindMI.Action := Designer.FindCmd;
  ReplaceMI.Action := Designer.ReplaceCmd;
  FindNextMI.Action := Designer.FindNextCmd;
  BringtoFrontMI.Action := Designer.BringToFrontCmd;
  SendtoBackMI.Action := Designer.SendToBackCmd;

  DataMI.Action := Designer.ReportDataCmd;
  VariablesMI.Action := Designer.VariablesCmd;
  StylesMI.Action := Designer.ReportStylesCmd;
  ReportOptionsMI.Action := Designer.ReportOptionsCmd;

  ToolbarsMI.Action := Designer.ToolbarsCmd;
  StandardMI.Action := Designer.StandardTBCmd;
  TextMI.Action := Designer.TextTBCmd;
  FrameMI.Action := Designer.FrameTBCmd;
  AlignmentPaletteMI.Action := Designer.AlignTBCmd;
  ObjectInspectorMI.Action := Designer.InspectorTBCmd;
  DataTreeMI.Action := Designer.DataTreeTBCmd;
  ReportTreeMI.Action := Designer.ReportTreeTBCmd;
  RulersMI.Action := Designer.ShowRulersCmd;
  GuidesMI.Action := Designer.ShowGuidesCmd;
  DeleteGuidesMI.Action := Designer.DeleteGuidesCmd;
  OptionsMI.Action := Designer.OptionsCmd;

  HelpContentsMI.Action := Designer.HelpContentsCmd;
  AboutFastReportMI.Action := Designer.AboutCmd; }

  Stream.Free;

  if ReportId = 0 then
    qForms.ParamByName('ReportID').Clear
  else
    qForms.ParamByName('ReportID').Value := ReportID;
  qForms.Open;
  mdForms.CopyFromDataSet(qForms);
  mdForms.Open;
  qForms.Close;
end;

end.
