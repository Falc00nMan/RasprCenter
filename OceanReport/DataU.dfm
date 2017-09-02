object DataF: TDataF
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 561
  Width = 747
  object DB: TUniConnection
    ProviderName = 'SQL Server'
    Database = 'OceanProject'
    Username = 'bdenisov'
    Server = '192.168.199.212'
    LoginPrompt = False
    Left = 36
    Top = 20
    EncryptedPassword = 'B5FF94FF8BFF87FF8DFF99FFCCFFDCFF'
  end
  object SQLServerProvider: TSQLServerUniProvider
    Left = 36
    Top = 84
  end
  object SkinController: TdxSkinController
    Kind = lfStandard
    NativeStyle = True
    SkinName = 'Office2013White'
    UseSkins = False
    Left = 252
    Top = 28
  end
  object frxDB: TfrxUniDACComponents
    DefaultDatabase = DB
    Left = 40
    Top = 156
  end
  object Localizer: TcxLocalizer
    Left = 252
    Top = 80
  end
end
