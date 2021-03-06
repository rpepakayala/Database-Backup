/****** Object:  StoredProcedure [dbo].[proc_MSS_GetVectorI4ConfigurationProperty]    Script Date: 5/15/2018 12:11:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetVectorI4ConfigurationProperty
(
    @Name nvarchar(64)
)
AS

    DECLARE @xml nvarchar(4000)
    DECLARE @list SQL_VARIANT

    EXEC proc_MSS_GetConfigurationProperty @Name, @list OUTPUT
    IF @list IS NULL
      RETURN

    SET @xml = N'<list>' + CONVERT(NVARCHAR(4000), @list) + N'</list>'

    DECLARE @ixml int
    DECLARE @returnStatus int
    EXEC @returnStatus = sp_xml_preparedocument @ixml OUTPUT, @xml
    IF @returnStatus != 0
        RETURN @returnStatus

    SELECT CAST(Value as int)
    FROM OPENXML (@ixml, '/list/item', 1)
         WITH (Value nvarchar(100) 'text()')
    UNION
    SELECT
        CAST(Value as int)
    FROM
        dbo.MSSConfiguration WITH(NOLOCK)
    WHERE
        Name = @Name

    EXEC @returnStatus = sp_xml_removedocument @ixml

   IF @@ERROR != 0
       RETURN @@ERROR


GO
