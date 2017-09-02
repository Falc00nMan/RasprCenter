USE Tempdb
GO

DECLARE 
  @ReferenceID INT,
  @BrowserProcName NVARCHAR(100)

SET @ReferenceID = 14
SELECT @BrowserProcName = BrowserProcName
FROM RasprCenter2017..sprReference r
WHERE r.ReferenceID = @ReferenceID

if object_id('tempdb..#c', 'U') is not null
 drop table #c;

select top (0) * into #c from INFORMATION_SCHEMA.COLUMNS;

declare @s nvarchar(max), @p nvarchar(max);

--select @p = N' ' + stuff((select N', null' from sys.parameters where object_id = object_id(N'dbo.spTest') for xml path(''), type).value('.', 'nvarchar(max)'), 1, 2, '');
select @s = N'select * into #t from openrowset(''SQLNCLI'', ''Server=.' + 
            isnull(N'\' + cast(serverproperty('InstanceName') as sysname), N'') +
            N';Trusted_Connection=yes;Database=' + db_name() + ''', ''set fmtonly on; exec RasprCenter2017.dbo.' + @BrowserProcName + --isnull(@p, N'') +
            '''); insert into #c select * from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = object_name(object_id(''#t''));' 
--print @S
exec(@s);

select * from #c;



insert into RasprCenter2017..sprreferenceBrowser(ReferenceID, browserfieldname, PositionOrder, ColumnTypeID, Width, IsKeyField, IsVisible, IsVisibleForCustomization, HaveFilter)
select @ReferenceID, COLUMN_NAME, ORDINAL_POSITION, ft.ControlTypeID, 100, 
CASE WHEN c.ORDINAL_POSITION = 1 THEN 1 ELSE 0 END,
1,1, 1
from #c c
LEFT JOIN RasprCenter2017..sprReferenceFieldTypes ft ON ft.TypeName = c.DATA_TYPE
order by ORDINAL_POSITION


UPDATE RasprCenter2017..sprreferenceBrowser
SET BrowserFieldRUSName = 'Кто создал', IsVisible = 0
WHERE ReferenceID = @ReferenceID
  AND BrowserFieldName = 'CreateUser'

UPDATE RasprCenter2017..sprreferenceBrowser
SET BrowserFieldRUSName = 'Хост', IsVisible = 0
WHERE ReferenceID = @ReferenceID
  AND BrowserFieldName = 'CreateHost'

UPDATE RasprCenter2017..sprreferenceBrowser
SET BrowserFieldRUSName = 'Дата и время создания', IsVisible = 0
WHERE ReferenceID = @ReferenceID
  AND BrowserFieldName = 'CreateDate'

UPDATE RasprCenter2017..sprreferenceBrowser
SET BrowserFieldRUSName = 'Флаг активности'
WHERE ReferenceID = @ReferenceID
  AND BrowserFieldName = 'IsActive'

UPDATE RasprCenter2017..sprreferenceBrowser
SET BrowserFieldRUSName = 'ИД', IsVisible = 0
WHERE ReferenceID = @ReferenceID
  AND BrowserFieldName LIKE '%ID'

DROP TABLE #c
