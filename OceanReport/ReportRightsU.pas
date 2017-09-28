unit ReportRightsU;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, MemDS, DBAccess, Uni,
  cxGraphics, cxLookAndFeels, cxLookAndFeelPainters, Vcl.Menus, cxControls,
  cxStyles, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit, cxNavigator,
  cxDBData, cxCheckBox, cxGridCustomTableView, cxGridTableView,
  cxGridDBTableView, cxGridLevel, cxClasses, cxGridCustomView, cxGrid,
  Vcl.StdCtrls, cxButtons, Vcl.ExtCtrls, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel,
  dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide, dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky,
  dxSkinMcSkin, dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black, dxSkinOffice2007Blue,
  dxSkinOffice2007Green, dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinPumpkin,
  dxSkinSeven, dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters, dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, dxSkinscxPCPainter;

type
  TReportRightsF = class(TForm)
    qrReportRights: TUniQuery;
    qrReportRightsname: TWideStringField;
    qrReportRightsIsActive: TByteField;
    dsReportRights: TUniDataSource;
    pnlBottom: TPanel;
    btnCancel: TcxButton;
    btnOk: TcxButton;
    grReportRights: TcxGrid;
    grReportRightsDBTableView1: TcxGridDBTableView;
    tblReportRights: TcxGridLevel;
    grReportRightsDBTableView1name: TcxGridDBColumn;
    grReportRightsDBTableView1IsActive: TcxGridDBColumn;
    ReportRightsTransaction: TUniTransaction;
    SQLReportRights: TUniSQL;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure qrReportRightsAfterPost(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    ReportID : Integer;
    procedure LoadReportRigts;
    procedure SetReportRigts;

  public
    function EditReportRights(const V: Variant): Variant;
    constructor Create(const V: Variant); reintroduce;
  end;

  TReportRightsF_Normal = class(TReportRightsF);

var
  ReportRightsF: TReportRightsF;

implementation

{$R *.dfm}

uses DataU;

function TReportRightsF.EditReportRights(const V: Variant): Variant;
var
  F: TReportRightsF_Normal;
begin
  F := Nil;
  Result := Null;
    try
      if not Assigned(f) then
      begin
        F := TReportRightsF_Normal.Create(v);
        with F do
        begin
          Result := ShowModal;
        end;
      end else
      begin
        F.BringToFront;
      end;
    except
      if Assigned(f) then FreeAndNil(f);
      Raise;
    end;
end;

procedure TReportRightsF.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TReportRightsF.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if ModalResult = mrOk then
  begin
    if ReportRightsTransaction.Active then ReportRightsTransaction.Commit;
  end else
  begin
    if ReportRightsTransaction.Active then ReportRightsTransaction.Rollback;
  end;
end;

procedure TReportRightsF.FormCreate(Sender: TObject);
begin
  LoadReportRigts;
  if ReportRightsTransaction.Active then ReportRightsTransaction.Rollback;
  ReportRightsTransaction.StartTransaction;
end;

procedure TReportRightsF.FormDestroy(Sender: TObject);
begin
  if ReportRightsTransaction.Active then ReportRightsTransaction.Rollback;
end;

procedure TReportRightsF.LoadReportRigts;
begin
  if qrReportRights.Active then qrReportRights.Close;
  qrReportRights.ParamByName('ReportID').AsInteger := ReportID;
  qrReportRights.Open;
end;

procedure TReportRightsF.qrReportRightsAfterPost(DataSet: TDataSet);
begin
  SetReportRigts;
end;

procedure TReportRightsF.SetReportRigts;
begin
  SQLReportRights.SQL.Text := 'IF NOT EXISTS(SELECT SQLUserName FROM ReportRights) BEGIN '+
    'INSERT INTO ReportRights(ReportID, SQLUserName) VALUES (:ReportID, :SQLUserName) END';
  SQLReportRights.ParamByName('ReportID').AsInteger := ReportID;
  SQLReportRights.ParamByName('SQLUserName').AsString := VarToStr(qrReportRights['name']);
  SQLReportRights.Execute;

  SQLReportRights.SQL.Text := 'UPDATE ReportRights SET IsActive = :IsActive WHERE SQLUserName = :SQLUserName';
  SQLReportRights.ParamByName('IsActive').AsInteger := (qrReportRights['IsActive']);
  SQLReportRights.ParamByName('SQLUserName').AsString := VarToStr(qrReportRights['name']);
  SQLReportRights.Execute;
end;


constructor TReportRightsF.Create(const V: Variant);
begin
  ReportID := (v);
  inherited Create(Application);
end;

end.
