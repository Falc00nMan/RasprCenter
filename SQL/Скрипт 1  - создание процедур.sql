DECLARE 
   @ReferenceID INT,
   @ReferenceTableName VARCHAR(50),
   @ReferenceName VARCHAR(50),
   @browserProcName VARCHAR(50),
   @insProcName VARCHAR(50),
   @updProcName VARCHAR(50),
   @delProcName VARCHAR(50),
   @tableSysID INT,
   @keyFieldName VARCHAR(50),
   @Crs CURSOR,
   @locID INT,
   @locFieldName VARCHAR(50),
   @locTypeName VARCHAR(50),
   @locMaxlen INT,
   @locPrec INT,
   @locScale INT,
   @locIsNull INT,
   @SQLText NVARCHAR(4000),
   @FieldList NVARCHAR(4000),
   @VarList NVARCHAR(4000)


SET @ReferenceID = 15
SELECT @ReferenceTableName = ReferenceTableName
FROM sprReference (NOLOCK)
WHERE ReferenceID = @ReferenceID

--SET @ReferenceName = SUBSTRING(@ReferenceTableName,4,100)


SET @ReferenceName = @ReferenceTableName

SELECT @browserProcName = 'br_asp' + @ReferenceName,
       @insProcName = 'ins' +@ReferenceName,
       @updProcName = 'upd' +@ReferenceName,
       @delProcName = 'del' +@ReferenceName

SELECT @tableSysID = object_ID FROM sys.objects WHERE name = @ReferenceTableName AND type = 'U'


SELECT 
sc.Column_ID AS ColumnID,
sc.name AS ColumnName,
UPPER(st.name) AS TypeName,
sc.max_length,
sc.precision,
sc.scale,
sc.is_nullable
INTO #tableColumns
FROM sys.columns sc
INNER JOIN sys.types st ON st.system_type_id = sc.system_type_id AND st.user_type_id = sc.user_type_id
WHERE object_ID = @tableSysID
ORDER BY 1,2

SELECT @keyFieldName = ColumnName
FROM #tableColumns
WHERE ColumnID = 1

SET @Crs = CURSOR FOR
SELECT ColumnID, ColumnName, TypeName, max_length, precision, scale, is_nullable
FROM #tableColumns
ORDER BY ColumnID

/* ***********************************************
               Процедура удаления
*********************************************** */

SET @SQLText = '
-- ***********************************************
-- => Процедура удаления
-- ***********************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ' + @delProcName + '
  @ID INT
AS
BEGIN
SET NOCOUNT ON

BEGIN TRAN trnDelete

DELETE FROM ' + @ReferenceTableName + '
 WHERE ' + @keyFieldName + ' = @ID

COMMIT TRAN trnDelete

SET NOCOUNT OFF
END
GO

'


PRINT @SQLText

/* ***********************************************
               Процедура добавления
*********************************************** */

/* ***********************************************
               ШАПКА
*********************************************** */

SET @SQLText = '
-- ***********************************************
-- => Процедура создания
-- ***********************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ' + @insProcName 

SET @FieldList = ''
SET @VarList = ''

OPEN @Crs
FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull

WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT @locFieldName IN ('CreateUser', 'CreateDate', 'CreateHost')
	  BEGIN
        SET @SQLText = @SQLText + '
  @' + @locFieldName + ' ' + @locTypeName
		IF @locTypeName = 'varchar'
		  SET @SQLText = @SQLText + '(' + CONVERT(VARCHAR(10), @locMaxlen) + ')'
		IF @locTypeName = 'nvarchar'
		  SET @SQLText = @SQLText + '(' + CONVERT(VARCHAR(10), @locMaxlen) + ')'
		IF @locTypeName = 'numeric'
		  SET @SQLText = @SQLText + '(' + CONVERT(VARCHAR(10), @locPrec) + ', ' + CONVERT(VARCHAR(10), @locScale) + ')'
		SET @SQLText = @SQLText + ' = NULL,'

		SET @FieldList = @FieldList + @locFieldName + ', '
		SET @VarList = @VarList + '@' + @locFieldName + ', '
	  END

    FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull
  END

CLOSE @Crs
SET @SQLText = SUBSTRING(@SQLText, 1, LEN(@SQLText) - 1)

SET @SQLText = @SQLText + '
AS
BEGIN
SET NOCOUNT ON

DECLARE 
 @ID INT

'

PRINT @SQLText

/* ***********************************************
               ПРОВЕРКИ
*********************************************** */


OPEN @Crs
FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull

WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @SQLText = ''
    IF NOT @locFieldName IN ('CreateUser', 'CreateDate', 'CreateHost')
	  BEGIN
	    IF @locIsNull = 0
		  BEGIN
		    IF @locTypeName IN ('VARCHAR', 'NVARCHAR')
			  BEGIN
			    SET @SQLText = '
IF ISNULL(@' + @locFieldName + ', '') = ''
  BEGIN
    RAISERROR(''Не заполнено поле ...!'', 15, -1)
	IF @@TRANCOUNT > 0
	  ROLLBACK TRAN
	RETURN
  END
'
			  END

		    IF @locTypeName IN ('TINYINT', 'SMALLINT', 'INT', 'REAL', 'MONEY', 'FLOAT', 'BIT', 'NUMERIC', 'DECIMAL', 'SMALLMONEY', 'BIGINT')
			  BEGIN
			    SET @SQLText = '
IF ISNULL(@' + @locFieldName + ', 0) = 0
  BEGIN
    RAISERROR(''Не заполнено поле ...!'', 15, -1)
	IF @@TRANCOUNT > 0
	  ROLLBACK TRAN
	RETURN
  END
'
			  END

		    IF @locTypeName IN ('DATETIME', 'SMALLDATETIME', 'DATE', 'TIME')
			  BEGIN
			    SET @SQLText = '
IF @' + @locFieldName + ' IS NULL
  BEGIN
    RAISERROR(''Не заполнено поле ...!'', 15, -1)
	IF @@TRANCOUNT > 0
	  ROLLBACK TRAN
	RETURN
  END
'
			  END

		  END
	  END

	IF @SQLText <> ''
	  PRINT @SQLText

    FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull
  END

CLOSE @Crs

PRINT @SQLText

/* ***********************************************
               ДОБАВЛЕНИЕ ЗАПИСИ
*********************************************** */

SET @FieldList = SUBSTRING(@FieldList, 1, LEN(@FieldList) - 1)
SET @VarList = SUBSTRING(@VarList, 1, LEN(@VarList) - 1)

SET @SQLText = '
BEGIN TRAN trnInsert

INSERT INTO ' + @ReferenceTableName + '(' + @FieldList + ')
VALUES( ' + @VarList + ')

SELECT @ID = IDENT_CURRENT(''' + @ReferenceTableName + ''')
COMMIT TRAN trnInsert

SELECT @ID AS ID

SET NOCOUNT OFF
END
GO

'
PRINT @SQLText


/* ***********************************************
               Процедура изменения
*********************************************** */

/* ***********************************************
               ШАПКА
*********************************************** */

SET @SQLText = '
-- ***********************************************
-- => Процедура изменения
-- ***********************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ' + @updProcName + '
  @ID INT,'

OPEN @Crs
FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull

WHILE @@FETCH_STATUS = 0
  BEGIN
    IF NOT @locFieldName IN ('CreateUser', 'CreateDate', 'CreateHost')
	  BEGIN
        SET @SQLText = @SQLText + '
  @' + @locFieldName + ' ' + @locTypeName
		IF @locTypeName = 'varchar'
		  SET @SQLText = @SQLText + '(' + CONVERT(VARCHAR(10), @locMaxlen) + ')'
		IF @locTypeName = 'nvarchar'
		  SET @SQLText = @SQLText + '(' + CONVERT(VARCHAR(10), @locMaxlen) + ')'
		IF @locTypeName = 'numeric'
		  SET @SQLText = @SQLText + '(' + CONVERT(VARCHAR(10), @locPrec) + ', ' + CONVERT(VARCHAR(10), @locScale) + ')'
		SET @SQLText = @SQLText + ' = NULL,'
	  END

    FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull
  END

CLOSE @Crs
SET @SQLText = SUBSTRING(@SQLText, 1, LEN(@SQLText) - 1)

SET @SQLText = @SQLText + '
AS
BEGIN
SET NOCOUNT ON

'

PRINT @SQLText

/* ***********************************************
               ПРОВЕРКИ
*********************************************** */


OPEN @Crs
FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull

WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @SQLText = ''
    IF NOT @locFieldName IN ('CreateUser', 'CreateDate', 'CreateHost')
	  BEGIN
	    IF @locIsNull = 0
		  BEGIN
		    IF @locTypeName IN ('VARCHAR', 'NVARCHAR')
			  BEGIN
			    SET @SQLText = '
IF ISNULL(@' + @locFieldName + ', '') = ''
  BEGIN
    RAISERROR(''Не заполнено поле ...!'', 15, -1)
	IF @@TRANCOUNT > 0
	  ROLLBACK TRAN
	RETURN
  END
'
			  END

		    IF @locTypeName IN ('TINYINT', 'SMALLINT', 'INT', 'REAL', 'MONEY', 'FLOAT', 'BIT', 'NUMERIC', 'DECIMAL', 'SMALLMONEY', 'BIGINT')
			  BEGIN
			    SET @SQLText = '
IF ISNULL(@' + @locFieldName + ', 0) = 0
  BEGIN
    RAISERROR(''Не заполнено поле ...!'', 15, -1)
	IF @@TRANCOUNT > 0
	  ROLLBACK TRAN
	RETURN
  END
'
			  END

		    IF @locTypeName IN ('DATETIME', 'SMALLDATETIME', 'DATE', 'TIME')
			  BEGIN
			    SET @SQLText = '
IF @' + @locFieldName + ' IS NULL
  BEGIN
    RAISERROR(''Не заполнено поле ...!'', 15, -1)
	IF @@TRANCOUNT > 0
	  ROLLBACK TRAN
	RETURN
  END
'
			  END

		  END
	  END

	IF @SQLText <> ''
	  PRINT @SQLText

    FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull
  END

CLOSE @Crs

PRINT @SQLText

/* ***********************************************
               ИЗМЕНЕНИЕ ЗАПИСИ
*********************************************** */

SET @SQLText = '
BEGIN TRAN trnUpdate
'
PRINT @SQLText

OPEN @Crs
FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull

WHILE @@FETCH_STATUS = 0
  BEGIN
    SET @SQLText = ''
    IF NOT @locFieldName IN ('CreateUser', 'CreateDate', 'CreateHost')
	  BEGIN
		IF @locTypeName IN ('VARCHAR', 'NVARCHAR')
 		  BEGIN
			SET @SQLText = '
UPDATE ' + @ReferenceTableName + '
 SET ' + @locFieldName + ' = @' + @locFieldName + '
 WHERE ' + @keyFieldName + ' = @ID
   AND ISNULL(' + @locFieldName + ', '''') <> ISNULL(@' + @locFieldName + ', '''')
'
		  END

		IF @locTypeName IN ('TINYINT', 'SMALLINT', 'INT', 'REAL', 'MONEY', 'FLOAT', 'BIT', 'NUMERIC', 'DECIMAL', 'SMALLMONEY', 'BIGINT')
		  BEGIN
			SET @SQLText = '
UPDATE ' + @ReferenceTableName + '
 SET ' + @locFieldName + ' = @' + @locFieldName + '
 WHERE ' + @keyFieldName + ' = @ID
   AND ISNULL(' + @locFieldName + ', 0) <> ISNULL(@' + @locFieldName + ', ' + 
      CASE WHEN @locTypeName = 'TINYINT' AND @locIsNull = 0 THEN '1' ELSE '0' END + ')
'
		  END

		IF @locTypeName IN ('DATETIME', 'SMALLDATETIME', 'DATE', 'TIME')
		  BEGIN
			SET @SQLText = '
UPDATE ' + @ReferenceTableName + '
 SET ' + @locFieldName + ' = @' + @locFieldName + '
 WHERE ' + @keyFieldName + ' = @ID
   AND ( ((' + @locFieldName + ' IS NULL ) AND (NOT @' + @locFieldName + ' IS NULL)) OR
         ((NOT ' + @locFieldName + ' IS NULL ) AND (NOT @' + @locFieldName + ' IS NULL) AND (' + @locFieldName + '<>@' + @locFieldName + '))
	   )
'
		  END

	  END

	IF @SQLText <> ''
	  PRINT @SQLText

    FETCH NEXT FROM @Crs INTO @locID, @locFieldName, @locTypeName, @locMaxlen, @locPrec, @locScale, @locIsNull
  END

CLOSE @Crs

SET @SQLText = '
COMMIT TRAN trnUpdate

SET NOCOUNT OFF
END
GO

'
PRINT @SQLText

/* ***********************************************
               Процедура браузера
*********************************************** */


SET @SQLText = '
-- ***********************************************
-- => Процедура удаления
-- ***********************************************
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE ' + @browserProcName + '
AS
BEGIN
SET NOCOUNT ON

SELECT ' + @FieldList + ' 
FROM ' + @ReferenceTableName + ' t (NOLOCK)
ORDER BY ' + @keyFieldName + '

SET NOCOUNT OFF
END
GO

'

PRINT @SQLText


UPDATE sprReference
  SET BrowserProcName = @browserProcName
  WHERE ReferenceID = @ReferenceID
    AND BrowserProcName IS NULL

UPDATE sprReference
  SET InsertProcName = @insProcName
  WHERE ReferenceID = @ReferenceID
    AND InsertProcName IS NULL

UPDATE sprReference
  SET UpdateProcName = @updProcName
  WHERE ReferenceID = @ReferenceID
    AND UpdateProcName IS NULL

UPDATE sprReference
  SET DeleteProcName = @delProcName
  WHERE ReferenceID = @ReferenceID
    AND DeleteProcName IS NULL


INSERT INTO sprReferenceField(ReferenceID, RefFieldName, IsRequired, IsKeyField, IsUpdatedField, ControlTypeID, DefaultValue)
SELECT @ReferenceID, ColumnName, 
  CASE WHEN is_nullable = 1 THEN 0 ELSE 1 END, 
  CASE WHEN ColumnID = 1 THEN 1 ELSE 0 END,
  1,
  ft.ControlTypeID,
  CASE WHEN tc.ColumnName = 'IsActive' THEN 1 ELSE 0 END
FROM #tableColumns tc
LEFT JOIN sprReferenceFieldTypes ft ON ft.TypeName = tc.TypeName

UPDATE sprReferenceField
SET RefFieldRUSName = 'Кто создал'
WHERE ReferenceID = @ReferenceID
  AND RefFieldName = 'CreateUser'

UPDATE sprReferenceField
SET RefFieldRUSName = 'Хост'
WHERE ReferenceID = @ReferenceID
  AND RefFieldName = 'CreateHost'

UPDATE sprReferenceField
SET RefFieldRUSName = 'Дата и время создания'
WHERE ReferenceID = @ReferenceID
  AND RefFieldName = 'CreateDate'

UPDATE sprReferenceField
SET RefFieldRUSName = 'Флаг активности'
WHERE ReferenceID = @ReferenceID
  AND RefFieldName = 'IsActive'

UPDATE sprReferenceField
SET RefFieldRUSName = 'ИД', IsRequired = 0
WHERE ReferenceID = @ReferenceID
  AND RefFieldName LIKE '%ID'
  

DEALLOCATE @Crs
DROP TABLE #tableColumns

