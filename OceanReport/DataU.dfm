object DataF: TDataF
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 561
  Width = 747
  object DB: TUniConnection
    ProviderName = 'SQL Server'
    Database = 'RasprCenter2017'
    Username = 'eugene'
    Server = 'localhost'
    Connected = True
    LoginPrompt = False
    Left = 36
    Top = 20
    EncryptedPassword = '9CFF9AFF91FF9AFF94FF8CFF8EFF9CFF9AFF9CFF94FF9DFF8DFF'
  end
  object SQLServerProvider: TSQLServerUniProvider
    Left = 36
    Top = 84
  end
  object SkinController: TdxSkinController
    Kind = lfStandard
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
