unit EditReportU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, amFunc, frxClass, frxDesgn, Vcl.ExtCtrls,
  Vcl.Menus, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, cxCheckBox, Data.DB, MemDS, DBAccess, Uni, cxLabel,
  cxTextEdit, cxDBEdit, frxExportPDF, fs_iinterpreter, frxCrypt, frxDCtrl,
  frxDMPExport, frxGradient, frxChBox, frxCross, frxRich, frxOLE, frxBarcode,
  frxChart;

type
  TEditReportF = class(TForm)
    frxDesigner: TfrxDesigner;
    frxReport: TfrxReport;
    pnlDesigner: TPanel;
    pnlactions: TPanel;
    chkActive: TcxCheckBox;
    qrReports: TUniQuery;
    qrReportsReportID: TIntegerField;
    qrReportsReportGroupID: TIntegerField;
    qrReportsReportName: TWideStringField;
    qrReportsReportBinary: TBlobField;
    qrReportsIsActive: TByteField;
    cxLabel1: TcxLabel;
    edReportName: TcxDBTextEdit;
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure qrReportsBeforeUpdateExecute(Sender: TDataSet;
      StatementTypes: TStatementTypes; Params: TDAParams);
    function frxDesignerSaveReport(Report: TfrxReport;
      SaveAs: Boolean): Boolean;
    procedure chkActiveClick(Sender: TObject);
  private
    ReportID : Integer;
    ReportGroupID : Integer;
    ReportName : string;

    procedure LoadReport;
  public
    function ShowEditReport(const V: Variant): Variant;
    constructor Create(const V: Variant); reintroduce;
  end;

  TEditReportF_Normal = class(TEditReportF);


var
  EditReportF: TEditReportF;

implementation

{$R *.dfm}

uses DataU, MainU;


function TEditReportF.ShowEditReport(const V: Variant): Variant;
var
  F: TEditReportF_Normal;
begin
  F := Nil;
  Result := Null;
    try
//      F := TEditReportF_Normal(FindForm(TEditReportF_Normal));
//      if not Assigned(f) then
//      begin
        F := TEditReportF_Normal.Create(V);
        with F do
        begin
          FormStyle := fsMDIChild;
          WindowState := wsMaximized;
          Show;
        end;
    //  end;
//      else
//      begin
//        F.Close;
//        F := TOrderResultF_Normal.Create(V);
//        with F do
//        begin
//          FormStyle := fsMDIChild;
//          WindowState := wsMaximized;
//          Show;
//        end;
//      end;
    except
      if Assigned(f) then FreeAndNil(f);
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
  ReportID := Var2Int(v[0]);
  ReportGroupID := Var2Int(v[1]);
  ReportName := Var2String(v[2]);

  inherited Create(Application);
end;

procedure TEditReportF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  frxReport.Designer.Modified := False;
  frxReport.Designer.Close;
  Action := caFree;
end;

procedure TEditReportF.FormCreate(Sender: TObject);
begin
  Caption := ReportName;
  LoadReport;
end;

function TEditReportF.frxDesignerSaveReport(Report: TfrxReport;
  SaveAs: Boolean): Boolean;
var
  Stream : TMemoryStream;
begin
  Stream := TMemoryStream.Create;

  if qrReports.IsEmpty then
  begin
    qrReports.Append;
    //frxReport.Report.ReportOptions.Name := ReportName;
    frxReport.FileName := ReportName;
    frxReport.SaveToStream(Stream);
    Stream.Position := 0;
    qrReportsReportBinary.LoadFromStream(Stream);
    qrReports['ReportGroupID'] := ReportGroupID;
    qrReports['ReportName']  := ReportName;
    qrReports['IsActive'] := chkActive.EditingValue;
    qrReports.Post;
    edReportName.Visible := True;
    cxLabel1.Visible := True;
    chkActive.EditValue := qrReports['IsActive'];
  end else
  begin
    qrReports.Edit;
    frxReport.SaveToStream(Stream);
    qrReportsReportBinary.LoadFromStream(Stream);
    qrReports['IsActive'] := chkActive.EditingValue;
    qrReports.Post;
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
    edReportName.Visible := False;
    cxLabel1.Visible := False;
  end else
  begin
    qrReportsReportBinary.SaveToStream(Stream);
    Stream.Position := 0;
    frxReport.LoadFromStream(Stream);
    chkActive.EditValue := Var2Int(qrReports['IsActive']);
  end;


  frxReport.EngineOptions.DestroyForms := False;
  // set the custom preview
  //frxReport.Preview := frxPreview1;
  // display the designer
  frxReport.DesignReportInPanel(pnlDesigner);
  Designer := TfrxDesignerForm(frxReport.Designer);

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

end;

end.
