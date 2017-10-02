unit MainU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxStatusBar, Vcl.ComCtrls, dxtree, cxSplitter, cxPC,
  dxBarBuiltInMenu, cxClasses, dxTabbedMDI, Data.DB, MemDS, DBAccess, Uni,
  Vcl.ImgList,  Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue,
  dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver,
  dxSkinOffice2010Black, dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic, dxSkinSharp,
  dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue,
  dxSkinsdxStatusBarPainter, dxSkinscxPCPainter, VirtualTable, dxmdaset, RzPanel, RzButton, System.Actions, Vcl.ActnList,
  AdvMenus, cxContainer, cxEdit, cxTextEdit, cxCheckBox, cxRadioGroup, cxLabel, AdvPanel, frxExportPDF, fs_iinterpreter,
  frxDCtrl, frxClass, frxDMPExport, frxGradient, frxCrypt, frxChBox, frxRich, frxOLE, frxCross, frxBarcode, frxDesgn,
  frxChart;

  type
  PNodeData = ^TNodeData;
  TNodeData = record
    ReportGroupID : Integer;
    ReportGroupName : string;
    ReportID : Integer;
    ReportName : string;
    IsActive : SmallInt;
   end;

type
  TMainF = class(TForm)
    StatusBar: TdxStatusBar;
    treeReport: TdxTreeView;
    splitLeft: TcxSplitter;
    qrReportGroup: TUniQuery;
    qrReportGroupReportGroupID: TIntegerField;
    qrReportGroupReportGroupName: TWideStringField;
    qrReports: TUniQuery;
    qrReportsReportID: TIntegerField;
    qrReportsReportGroupID: TIntegerField;
    qrReportsReportName: TWideStringField;
    imgTree: TcxImageList;
    pnlTree: TPanel;
    SQLTreeActions: TUniSQL;
    ilRefBookActionImages: TcxImageList;
    actlstRefBook: TActionList;
    actAddReport: TAction;
    actAddGroup: TAction;
    actEdit: TAction;
    actDelete: TAction;
    actRefreshGroup: TAction;
    RzToolbar1: TRzToolbar;
    btnAdd1: TRzToolButton;
    RzSpacer1: TRzSpacer;
    btnEdit1: TRzToolButton;
    RzSpacer2: TRzSpacer;
    btnDelete1: TRzToolButton;
    btnRefresh: TRzToolButton;
    pmAddClientsGroup: TAdvPopupMenu;
    miAddProdCat: TMenuItem;
    miAddProdCatSub: TMenuItem;
    actRights: TAction;
    pnlActions: TAdvPanel;
    cxLabel1: TcxLabel;
    rbReport: TcxRadioButton;
    rbDocument: TcxRadioButton;
    chkActive: TcxCheckBox;
    edReportName: TcxTextEdit;
    SelectForms: TcxButton;
    qForms: TUniQuery;
    mdForms: TdxMemData;
    qrReportsFormsLinkDelete: TUniQuery;
    IntegerField3: TIntegerField;
    IntegerField4: TIntegerField;
    WideStringField2: TWideStringField;
    BlobField2: TBlobField;
    ByteField3: TByteField;
    ByteField4: TByteField;
    qrReportsFormsLink: TUniQuery;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    WideStringField1: TWideStringField;
    BlobField1: TBlobField;
    ByteField1: TByteField;
    ByteField2: TByteField;
    dsReports: TUniDataSource;
    frxChartObject: TfrxChartObject;
    frxReport: TfrxReport;
    frxDesigner: TfrxDesigner;
    frxBarCodeObject: TfrxBarCodeObject;
    frxCrossObject: TfrxCrossObject;
    frxOLEObject: TfrxOLEObject;
    frxRichObject: TfrxRichObject;
    frxCheckBoxObject: TfrxCheckBoxObject;
    frxCrypt: TfrxCrypt;
    frxGradientObject: TfrxGradientObject;
    frxDotMatrixExport: TfrxDotMatrixExport;
    frxDialogControls: TfrxDialogControls;
    fsScript: TfsScript;
    frxPDFExport: TfrxPDFExport;
    qrReport: TUniQuery;
    qrReportReportID: TIntegerField;
    qrReportReportGroupID: TIntegerField;
    qrReportReportName: TWideStringField;
    qrReportReportBinary: TBlobField;
    bytfldReportsIsActive: TByteField;
    procedure treeReportClick(Sender: TObject);
    procedure qrReportGroupBeforeUpdateExecute(Sender: TDataSet;
      StatementTypes: TStatementTypes; Params: TDAParams);
    procedure FormCreate(Sender: TObject);
    procedure actAddGroupExecute(Sender: TObject);
    procedure actAddReportExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actRightsExecute(Sender: TObject);
    procedure treeReportDblClick(Sender: TObject);
    procedure frxDesignerShow(Sender: TObject);
    procedure chkActiveClick(Sender: TObject);
    procedure qrReportBeforeUpdateExecute(Sender: TDataSet; StatementTypes: TStatementTypes; Params: TDAParams);
    procedure SelectFormsClick(Sender: TObject);
    procedure edReportNamePropertiesChange(Sender: TObject);
    function frxDesignerSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
    procedure DesignerDestroy(Sender: TObject);
  private
    SelectedData: PNodeData;
    procedure LoadReportTree;
    procedure ToggleControls;

    function InsertReportGroup (ReportGroupName : string) : Boolean;
    function EditReportGroup (ReportGroupID : Integer; ReportGroupName : string) : Boolean;
    function DeleteReportGroup (ReportGroupID : Integer) : Boolean;
    function DeleteReport (ReportID : Integer) : Boolean;
    procedure LoadReport(ReportID, ReportGroupID: Integer; ReportName: String);

    //function InsertReport (ReportGroupID : Integer; ReportGroupName : string) : Boolean;
  public
    procedure ReloadTree;
  end;

var
  MainF: TMainF;

implementation

{$R *.dfm}

uses DataU, ReportRightsU, SelectFormU;

procedure TMainF.ReloadTree;
begin
  LoadReportTree;
end;

procedure TMainF.SelectFormsClick(Sender: TObject);
begin
  Application.CreateForm(TSelectForm, SelectForm);
  mdForms.First;
  SelectForm.dsForms.DataSet := mdForms;
  SelectForm.ShowModal;
  FreeAndNil(SelectForm);
  frxReport.Designer.Modified := True;
end;

procedure TMainF.ToggleControls;
begin
  actDelete.Enabled := (SelectedData.ReportGroupID <> 0) or (SelectedData.ReportID <> 0);
  actEdit.Enabled := (SelectedData.ReportGroupID <> 0) or (SelectedData.ReportID <> 0);
  actRights.Enabled := SelectedData.ReportID <> 0;
  actAddReport.Enabled := (SelectedData.ReportGroupID <> 0) and (SelectedData.ReportID = 0);
end;

function TMainF.InsertReportGroup (ReportGroupName : string) : Boolean;
begin
  Result := False;
  SQLTreeActions.SQL.Text := 'INSERT INTO ReportGroup (ReportGroupName) VALUES (:ReportGroupName)';
  SQLTreeActions.ParamByName('ReportGroupName').AsString := ReportGroupName;
  SQLTreeActions.Execute;
  Result := True;
end;

function TMainF.EditReportGroup(ReportGroupID : Integer; ReportGroupName : string) : Boolean;
begin
  Result := False;
  SQLTreeActions.SQL.Text := 'UPDATE ReportGroup SET ReportGroupName = :ReportGroupName WHERE ReportGroupID = :ReportGroupID';
  SQLTreeActions.ParamByName('ReportGroupID').AsInteger := ReportGroupID;
  SQLTreeActions.ParamByName('ReportGroupName').AsString := ReportGroupName;
  SQLTreeActions.Execute;
  Result := True;
end;

procedure TMainF.edReportNamePropertiesChange(Sender: TObject);
begin
  frxReport.FileName := edReportName.Text;
  frxReport.ReportOptions.Name := edReportName.Text;
  if frxReport.Designer <> nil then
    frxReport.Designer.Caption := edReportName.Text;
end;

function TMainF.DeleteReportGroup (ReportGroupID : Integer) : Boolean;
begin
  Result := False;
  SQLTreeActions.SQL.Text := 'DELETE FROM ReportGroup WHERE ReportGroupID = :ReportGroupID';
  SQLTreeActions.ParamByName('ReportGroupID').AsInteger := ReportGroupID;
  SQLTreeActions.Execute;
  Result := True;
end;

function TMainF.DeleteReport (ReportID : Integer) : Boolean;
begin
  Result := False;
  SQLTreeActions.SQL.Text := 'DELETE FROM Reports WHERE ReportID = :ReportID';
  SQLTreeActions.ParamByName('ReportID').AsInteger := ReportID;
  SQLTreeActions.Execute;
  Result := True;
end;

procedure TMainF.actAddGroupExecute(Sender: TObject);
var
  s : string;
begin
  if InputQuery('Добавить группу', 'Введите название', s) and InsertReportGroup(s) then
    LoadReportTree;
end;

procedure TMainF.actAddReportExecute(Sender: TObject);
begin
  if SelectedData <> nil then
    LoadReport(0, SelectedData.ReportGroupID, 'Без названия');
end;

procedure TMainF.actDeleteExecute(Sender: TObject);
begin
  if SelectedData.ReportID = 0 then
  begin
    if MessageBox(handle,PChar('Вы действительно хотите удалить группу'+#13#10 + SelectedData.ReportGroupName), PChar('Подтвердите'), MB_YESNO+MB_DEFBUTTON2+MB_ICONQUESTION) = ID_YES  then
    begin
      if DeleteReportGroup(SelectedData.ReportGroupID) then LoadReportTree;
    end;
  end else
  begin
    if MessageBox(handle,PChar('Вы действительно хотите удалить отчет'+#13#10 + SelectedData.ReportName), PChar('Подтвердите'), MB_YESNO+MB_DEFBUTTON2+MB_ICONQUESTION) = ID_YES  then
    begin
      if DeleteReport(SelectedData.ReportID) then LoadReportTree;
    end;
  end;end;

procedure TMainF.actEditExecute(Sender: TObject);
var
  s : string;
begin
  if SelectedData.ReportID = 0 then
  begin
    s := SelectedData.ReportGroupName;
    if InputQuery('Редактировать группу', 'Введите название', s) then
    begin
      if EditReportGroup(SelectedData.ReportGroupID,  s) then LoadReportTree;
    end;
  end else
  begin
    LoadReport(SelectedData.ReportID, SelectedData.ReportGroupID, SelectedData.ReportName);
  end;
end;

procedure TMainF.actRightsExecute(Sender: TObject);
begin
  ReportRightsF.EditReportRights(SelectedData.ReportID);
end;

procedure TMainF.chkActiveClick(Sender: TObject);
begin
  if frxReport.Report.Designer <> nil then
    frxReport.Report.Designer.Modified := True;
end;

procedure TMainF.FormCreate(Sender: TObject);
begin
  LoadReportTree;
end;

procedure TMainF.DesignerDestroy(Sender: TObject);
begin
  pnlActions.Visible := False;
  pnlActions.Parent := Self;
  MainF.ReloadTree;
end;

function TMainF.frxDesignerSaveReport(Report: TfrxReport; SaveAs: Boolean): Boolean;
var
  Stream : TMemoryStream;
begin
  Stream := TMemoryStream.Create;

  if qrReport.IsEmpty then
  begin
    qrReport.Append;
    //frxReport.Report.ReportOptions.Name := ReportName;
    frxReport.FileName := edReportName.Text;
    frxReport.SaveToStream(Stream);
    Stream.Position := 0;
    qrReportReportBinary.LoadFromStream(Stream);
    qrReport['ReportGroupID'] := SelectedData.ReportGroupID;
    qrReport['ReportName'] := edReportName.Text;
    qrReport['IsActive'] := chkActive.EditingValue;
    if rbReport.Checked then
      qrReport['DocType'] := 1
    else
      qrReport['DocType'] := 2;

    qrReport.Post;
    chkActive.EditValue := qrReport['IsActive'];
    SelectedData.ReportID := qrReport['ReportID'];
  end else
  begin
    qrReport.Edit;
    frxReport.SaveToStream(Stream);
    qrReportReportBinary.LoadFromStream(Stream);
    qrReport['ReportName'] := edReportName.Text;
    if rbDocument.Checked then
      qrReport['DocType'] := 1
    else
      qrReport['DocType'] := 2;
    qrReport['IsActive'] := chkActive.EditingValue;
    qrReport.Post;
  end;

  qrReportsFormsLinkDelete.ParamByName('ReportID').AsInteger := SelectedData.ReportID;
  qrReportsFormsLinkDelete.ExecSQL;

  mdForms.First;
  while not mdForms.Eof do
  begin
    if mdForms.FieldByName('FormSelected').Value = 1 then
    begin
      qrReportsFormsLink.ParamByName('ReportID').Value := SelectedData.ReportID;
      qrReportsFormsLink.ParamByName('FormID').Value := mdForms.FieldByName('FormID').Value;
      qrReportsFormsLink.ExecSQL;
    end;
    mdForms.Next;
  end;

  Stream.Free;
  MessageBox(handle,PChar('Отчет сохранен.'+#13#10), PChar('Информация'), MB_OK+MB_DEFBUTTON1+MB_DEFBUTTON2+MB_ICONINFORMATION);

  frxReport.Designer.Modified := False;
end;

procedure TMainF.frxDesignerShow(Sender: TObject);
begin
  pnlActions.Parent := TfrxDesignerForm(frxReport.Designer);
  pnlActions.Visible := True;
  frxReport.Designer.Modified := True;
  frxReport.Designer.Caption := edReportName.Text;
  frxReport.Designer.OnDestroy := DesignerDestroy;
end;

procedure TMainF.qrReportBeforeUpdateExecute(Sender: TDataSet; StatementTypes: TStatementTypes; Params: TDAParams);
begin
  if stInsert in StatementTypes then
    Params.ParamByName('ReportID').ParamType := ptInputOutput;
end;

procedure TMainF.qrReportGroupBeforeUpdateExecute(Sender: TDataSet;
  StatementTypes: TStatementTypes; Params: TDAParams);
begin
  if stInsert in StatementTypes then
    Params.ParamByName('ReportGroupID').ParamType := ptInputOutput;
end;

procedure TMainF.treeReportClick(Sender: TObject);
begin
  SelectedData := treeReport.Selected.Data;
  ToggleControls;
end;

procedure TMainF.treeReportDblClick(Sender: TObject);
begin
  actEditExecute(nil);
end;

procedure TMainF.LoadReportTree;
var
  Anode, Bnode : TTreeNode;
  ANodeData, BNodeData: PNodeData;
  i : Integer;
begin
  try
    treeReport.Items.BeginUpdate;
    treeReport.Items.Clear;

    if qrReportGroup.Active then  qrReportGroup.Close;
    qrReportGroup.Open;

    while not qrReportGroup.Eof do
    begin
        New(ANodeData);
        ANodeData^.ReportGroupID:= (qrReportGroup['ReportGroupID']);
        ANodeData^.ReportGroupName := VarToStr(qrReportGroup['ReportGroupName']);
        ANodeData^.ReportID := 0;
        ANodeData^.ReportName := '';
        ANodeData^.IsActive := 0;
        ANode := treeReport.Items.AddChildObject(nil, ANodeData^.ReportGroupName, ANodeData);
        ANode.StateIndex := 1;

        if qrReports.Active then qrReports.Close;
        qrReports.ParamByName('ReportGroupID').AsInteger := (qrReportGroup['ReportGroupID']);
        qrReports.Open;
        while not qrReports.Eof  do
        begin
          New(BNodeData);
          BNodeData^.ReportGroupID :=  (qrReports['ReportGroupID']);
          BNodeData^.ReportGroupName := '';
          BNodeData^.ReportID := (qrReports['ReportID']);
          BNodeData^.ReportName := VarToStr(qrReports['ReportName']);
          BNodeData^.IsActive :=  (qrReports['IsActive']);
          BNode := treeReport.Items.AddChildObject(ANode, BNodeData^.ReportName, BNodeData);
          if (qrReports['IsActive']) = 1 then BNode.StateIndex := 2 else BNode.StateIndex := 3;
          qrReports.Next;
        end;
      qrReportGroup.Next;
    end;

  finally
    treeReport.Items.EndUpdate;
    treeReport.FullExpand;
    if treeReport.Items.Count > 0 then
    begin
      treeReport.Items.GetFirstNode.Selected := True;
      treeReportClick(treeReport);
    end;
  end;
end;

procedure TMainF.LoadReport(ReportID, ReportGroupID: Integer; ReportName: String);
var
  Designer: TfrxDesignerForm;
  Stream : TMemoryStream;
begin
  Stream := TMemoryStream.Create;
  if qrReport.Active then qrReport.Close;
  qrReport.ParamByName('ReportID').AsInteger := ReportID;
  qrReport.Open;

  if qrReport.IsEmpty then
  begin
    chkActive.EditValue := 1;
    chkActive.Checked := True;
  end else
  begin
    qrReportReportBinary.SaveToStream(Stream);
    Stream.Position := 0;
    frxReport.LoadFromStream(Stream);
    chkActive.EditValue := (qrReport['IsActive']);
    rbReport.Checked := (qrReport['DocType'] = 2);
  end;

  Stream.Free;

  if ReportId = 0 then
    qForms.ParamByName('ReportID').Clear
  else
    qForms.ParamByName('ReportID').Value := ReportID;
  qForms.Open;
  mdForms.CopyFromDataSet(qForms);
  mdForms.Open;
  qForms.Close;

  frxReport.EngineOptions.DestroyForms := False;

  edReportName.Text := ReportName;
  frxReport.DesignReport(True, False);

end;


end.
