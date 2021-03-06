/****** Object:  StoredProcedure [dbo].[proc_SetSiteFlags]    Script Date: 5/15/2018 12:12:20 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SetSiteFlags(
    @SiteId uniqueidentifier,
    @bitsToSet int,
    @bitMask int)
AS
    SET NOCOUNT ON
    UPDATE
        Sites
    SET 
        BitFlags = (BitFlags & (@bitMask ^ 0xFFFFFFFF)) |
        (@bitsToSet & @bitMask)
    WHERE 
        Id = @SiteId
    IF (@@ROWCOUNT <> 1)
    BEGIN
        RETURN 3
    END
    EXEC proc_LogChange @SiteId, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        8192,  8, NULL
    RETURN 0

GO
