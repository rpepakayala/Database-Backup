/****** Object:  StoredProcedure [dbo].[FII_Subscription]    Script Date: 5/15/2018 12:11:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC FII_Subscription
(@Email varchar(1000))
AS 
DECLARE @Subscriptions TABLE
    (
      Report_OID UNIQUEIDENTIFIER ,
      ToList VARCHAR(8000) ,
      CCList VARCHAR(8000) ,
      BCCList VARCHAR(8000) ,
      SubjectLine VARCHAR(8000)
    )
DECLARE @ExtensionSettings XML
DECLARE @Report_OID UNIQUEIDENTIFIER
DECLARE @idoc INT
DECLARE SubscriptionList CURSOR
FOR
    SELECT
        Report_OID ,
        ExtensionSettings
    FROM
        Subscriptions
OPEN SubscriptionList
FETCH NEXT     FROM SubscriptionList INTO @Report_OID, @ExtensionSettings
WHILE ( @@FETCH_STATUS = 0 )
    BEGIN
        EXEC sp_xml_preparedocument
            @idoc OUTPUT ,
            @ExtensionSettings
        INSERT  INTO @Subscriptions
                SELECT
                    @Report_OID ,
                    [TO] ,
                    [CC] ,
                    [BCC] ,
                    [Subject]
                FROM
                    ( SELECT
                        *
                      FROM
                        OPENXML (@idoc, '/ParameterValues/ParameterValue')
                    WITH (Name NVARCHAR(1000) 'Name',
                        Value NVARCHAR(1000) 'Value')
                    ) AS SourceTable PIVOT
        ( MAX(value) FOR [Name] IN ( [TO], [BCC], [CC], [Subject] ) ) AS pivottable
        EXEC sp_xml_removedocument
            @idoc
        FETCH NEXT  FROM SubscriptionList INTO @Report_OID, @ExtensionSettings

    END
CLOSE SubscriptionList
DEALLOCATE SubscriptionList

SELECT
    c.Path ,
    c.Name ,
    s.ToList ,
    s.CCList ,
    s.BCCList ,
    s.SubjectLine
FROM
    Catalog c
    INNER JOIN @Subscriptions s ON c.ItemID = s.Report_OID
WHERE
    ToList LIKE '%'+@Email+'%'
    OR CCList LIKE '%'+@Email+'%'
	OR BCCList LIKE '%'+@Email+'%'
ORDER BY
    [Path] ,
    Name

GRANT EXECUTE ON FII_Subscription TO fsreport_user  
GO
