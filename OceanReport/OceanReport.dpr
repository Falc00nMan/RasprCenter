program OceanReport;

uses
  Vcl.Forms,
  MainU in 'MainU.pas' {MainF},
  DataU in 'DataU.pas' {DataF: TDataModule},
  EditReportU in 'EditReportU.pas' {EditReportF},
  ReportRightsU in 'ReportRightsU.pas' {ReportRightsF};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataF, DataF);
  Application.CreateForm(TMainF, MainF);
  Application.Run;
end.
