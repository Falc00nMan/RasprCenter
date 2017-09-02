unit MainU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxStatusBar, Vcl.ComCtrls, dxtree, cxSplitter, cxPC,
  dxBarBuiltInMenu, cxClasses, dxTabbedMDI, Data.DB, MemDS, DBAccess, Uni,
  Vcl.ImgList, amFunc, Vcl.Menus, Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, cmInputStringU;

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
    MDIManager: TdxTabbedMDIManager;
    qrReportGroup: TUniQuery;
    qrReportGroupReportGroupID: TIntegerField;
    qrReportGroupReportGroupName: TWideStringField;
    qrReports: TUniQuery;
    qrReportsReportID: TIntegerField;
    qrReportsReportGroupID: TIntegerField;
    qrReportsReportName: TWideStringField;
    qrReportsReportBinary: TBlobField;
    qrReportsIsActive: TByteField;
    imgTree: TcxImageList;
    pnlTree: TPanel;
    pnlTreeActions: TPanel;
    btnAdd: TcxButton;
    btnEdit: TcxButton;
    btnDelete: TcxButton;
    btnRights: TcxButton;
    pmAdd: TPopupMenu;
    N1: TMenuItem;
    SQLTreeActions: TUniSQL;
    procedure treeReportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure qrReportGroupBeforeUpdateExecute(Sender: TDataSet;
      StatementTypes: TStatementTypes; Params: TDAParams);
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnRightsClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    SelectedData: PNodeData;
    procedure CloseChildrens;
    procedure LoadReportTree;
    procedure ToggleControls;

    function InsertReportGroup (ReportGroupName : string) : Boolean;
    function EditReportGroup (ReportGroupID : Integer; ReportGroupName : string) : Boolean;
    function DeleteReportGroup (ReportGroupID : Integer) : Boolean;
    function DeleteReport (ReportID : Integer) : Boolean;



    //function InsertReport (ReportGroupID : Integer; ReportGroupName : string) : Boolean;
  public
    procedure ReloadTree;
  end;

var
  MainF: TMainF;

implementation

{$R *.dfm}

uses DataU, EditReportU, ReportRightsU;

procedure TMainF.ReloadTree;
begin
  LoadReportTree;
end;

procedure TMainF.ToggleControls;
begin
  btnDelete.Enabled := (SelectedData.ReportGroupID <> 0) or (SelectedData.ReportID <> 0);
  btnEdit.Enabled := (SelectedData.ReportGroupID <> 0) or (SelectedData.ReportID <> 0);
  btnRights.Enabled := SelectedData.ReportID <> 0;
  N1.Enabled := (SelectedData.ReportGroupID <> 0) and (SelectedData.ReportID = 0);
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


procedure TMainF.btnAddClick(Sender: TObject);
var
  s : string;
begin
  if InputString(s, 'Добавить группу', 'Введите название', '', false, false ) =  mrOk then
  begin
    if InsertReportGroup(s) then LoadReportTree;
  end;
end;

procedure TMainF.btnDeleteClick(Sender: TObject);
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
  end;
end;

procedure TMainF.btnEditClick(Sender: TObject);
var
  s : string;
begin
  if SelectedData.ReportID = 0 then
  begin
    s := SelectedData.ReportGroupName;
    if InputString(s, 'Редактировать группу', 'Введите название', '', false, false ) =  mrOk then
    begin
      if EditReportGroup(SelectedData.ReportGroupID,  s) then LoadReportTree;
    end;
  end else
  begin
    EditReportF.ShowEditReport(VarArrayOf([SelectedData.ReportID, SelectedData.ReportGroupID, SelectedData.ReportName ]));
  end;

end;

procedure TMainF.btnRightsClick(Sender: TObject);
begin
  ReportRightsF.EditReportRights(SelectedData.ReportID);
end;

procedure TMainF.CloseChildrens;
var
  i : Integer;
begin
  for i := 0 to MDIChildCount-1 do
    MDIChildren[i].Close;
end;

procedure TMainF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  CloseChildrens;
end;

procedure TMainF.FormCreate(Sender: TObject);
begin
  LoadReportTree;
end;

procedure TMainF.qrReportGroupBeforeUpdateExecute(Sender: TDataSet;
  StatementTypes: TStatementTypes; Params: TDAParams);
begin
  if stInsert in StatementTypes then Params.ParamByName('ReportGroupID').ParamType := ptInputOutput;
end;

procedure TMainF.treeReportClick(Sender: TObject);
begin
  SelectedData := treeReport.Selected.Data;
  ToggleControls;
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
        ANodeData^.ReportGroupID:= Var2Int(qrReportGroup['ReportGroupID']);
        ANodeData^.ReportGroupName := Var2String(qrReportGroup['ReportGroupName']);
        ANodeData^.ReportID := 0;
        ANodeData^.ReportName := '';
        ANodeData^.IsActive := 0;
        ANode := treeReport.Items.AddChildObject(nil, ANodeData^.ReportGroupName, ANodeData);
        ANode.StateIndex := 1;

        if qrReports.Active then qrReports.Close;
        qrReports.ParamByName('ReportGroupID').AsInteger := Var2Int(qrReportGroup['ReportGroupID']);
        qrReports.Open;
        while not qrReports.Eof  do
        begin
          New(BNodeData);
          BNodeData^.ReportGroupID :=  Var2Int(qrReports['ReportGroupID']);
          BNodeData^.ReportGroupName := '';
          BNodeData^.ReportID := Var2Int(qrReports['ReportID']);
          BNodeData^.ReportName := Var2String(qrReports['ReportName']);
          BNodeData^.IsActive :=  Var2Int(qrReports['IsActive']);
          BNode := treeReport.Items.AddChildObject(ANode, BNodeData^.ReportName, BNodeData);
          if  Var2Int(qrReports['IsActive']) = 1 then BNode.StateIndex := 2 else BNode.StateIndex := 3;
          qrReports.Next;
        end;
      qrReportGroup.Next;
    end;

  finally
    treeReport.Items.EndUpdate;
    treeReport.FullExpand;
  end;
end;



procedure TMainF.N1Click(Sender: TObject);
var
  s : string;
begin
  if InputString(s, 'Добавить отчет', 'Введите название', '', false, false ) =  mrOk then
  begin
    EditReportF.ShowEditReport(VarArrayOf([0, SelectedData.ReportGroupID, s ]));
  end;
end;

end.
