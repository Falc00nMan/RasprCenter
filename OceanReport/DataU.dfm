object DataF: TDataF
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 561
  Width = 747
  object MainConnection: TUniConnection
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
    Left = 140
    Top = 12
  end
  object frxDB: TfrxUniDACComponents
    DefaultDatabase = MainConnection
    Left = 40
    Top = 156
  end
  object Localizer: TcxLocalizer
    Left = 108
    Top = 64
  end
end
