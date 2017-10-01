unit DataU;

interface

uses
  System.SysUtils, System.Classes, cxClasses, cxLookAndFeels, dxSkinsForm,
  UniProvider, SQLServerUniProvider, Data.DB, DBAccess, Uni, frxClass,
  frxDACComponents, frxUniDACComponents,  System.IniFiles, Vcl.Forms,
  cxLocalization, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue;

type
  TDataF = class(TDataModule)
    MainConnection: TUniConnection;
    SQLServerProvider: TSQLServerUniProvider;
    SkinController: TdxSkinController;
    frxDB: TfrxUniDACComponents;
    Localizer: TcxLocalizer;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataF: TDataF;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataF.DataModuleCreate(Sender: TObject);
var
  Ini : TIniFile;
begin
 if MainConnection.Connected then MainConnection.Close;
   if FileExists(ExtractFilePath(Application.ExeName)+'config.ini') then
     try
       Ini := TIniFile.Create(ExtractFilePath(Application.ExeName)+'config.ini');
       MainConnection.Server := Ini.ReadString('DB', 'server', '');
       MainConnection.Database := Ini.ReadString('DB', 'database', '');
       MainConnection.Username := Ini.ReadString('DB', 'username', '');
       MainConnection.Password := Ini.ReadString('DB', 'password', '');
       MainConnection.Connect;

       Localizer.FileName := IncludeTrailingBackslash(ExtractFilePath(Application.ExeName)) + 'RussianLng.ini';
       Localizer.Active := True;
       Localizer.Locale := 1049;
     finally
       Ini.Free;
     end;

end;

procedure TDataF.DataModuleDestroy(Sender: TObject);
begin
  if MainConnection.InTransaction then MainConnection.Rollback;
  MainConnection.Close;
end;

end.
