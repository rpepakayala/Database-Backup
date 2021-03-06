/****** Object:  StoredProcedure [dbo].[proc_MSS_GetHostID]    Script Date: 5/15/2018 12:13:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetHostID
@HostName nvarchar(1000),
@HostID int OUTPUT
AS
    SET NOCOUNT ON  
    SET @HostID = NULL
    SELECT @HostID = HostID FROM MSSCrawlHostList WHERE HostName = @HostName
    BEGIN
        IF @HostID IS NULL
        BEGIN
            --select again with TABLOCKX
            SELECT @HostID = HostID FROM MSSCrawlHostList WITH(TABLOCKX) WHERE HostName = @HostName
            IF @HostID IS NULL
            BEGIN
                INSERT INTO MSSCrawlHostList (HostName) VALUES (@HostName)
                SET @HostID  = @@IDENTITY
            END
        END
    END

GO
