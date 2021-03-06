/****** Object:  StoredProcedure [dbo].[proc_SecSetUserAccountDirectoryPath]    Script Date: 5/15/2018 12:12:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_SecSetUserAccountDirectoryPath(
	@SiteId uniqueidentifier,
	@Restriction nvarchar(512))
AS
    SET NOCOUNT ON
    UPDATE
        Sites
    SET
        UserAccountDirectoryPath = @Restriction,
        BitFlags = CASE WHEN @Restriction IS NULL THEN (BitFlags & (~524288)) ELSE (BitFlags | 524288) END
    FROM
        Sites
    WHERE
        Id = @SiteId
    EXEC proc_LogChange @SiteId, NULL, NULL, NULL, NULL, NULL, NULL, NULL,
        8192,  8, NULL
    RETURN 0    

GO
