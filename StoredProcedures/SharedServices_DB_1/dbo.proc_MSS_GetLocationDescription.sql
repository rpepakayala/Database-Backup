/****** Object:  StoredProcedure [dbo].[proc_MSS_GetLocationDescription]    Script Date: 5/15/2018 12:11:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetLocationDescription(
    @LocationId int)
 AS

SET NOCOUNT ON

DECLARE @LastError int

BEGIN
    SELECT LocationId, Xml
    FROM dbo.MSSLocationXml
    WHERE LocationId = @LocationId

    SELECT @LastError = @@ERROR
    IF @LastError <> 0
    BEGIN 
        RETURN @LastError
    END

    RETURN 0
END

RETURN 0

GO
