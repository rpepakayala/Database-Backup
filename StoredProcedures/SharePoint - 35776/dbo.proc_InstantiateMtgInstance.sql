/****** Object:  StoredProcedure [dbo].[proc_InstantiateMtgInstance]    Script Date: 5/15/2018 12:12:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_InstantiateMtgInstance
(
    @SiteId                 uniqueidentifier,
    @WebId                  uniqueidentifier,
    @WebUrl                 nvarchar(256) = NULL, 
    @InstanceID             int,
    @ForAttendees           bit = NULL  
)
AS
    SET NOCOUNT ON
    DECLARE @Error int
    IF (@ForAttendees IS NULL OR @ForAttendees = 0)
    BEGIN
        EXEC @Error = proc_CreateDocLibSubFoldersForMtgInst
            @SiteId,
            @WebId,
            @WebUrl,
            @InstanceID
        IF @Error <> 0
            RETURN @Error
    END
    EXEC @Error = proc_CloneSeedDataForMtgInst
        @SiteId,
        @WebId,
        @InstanceID,
        @ForAttendees
    RETURN @Error

GO
