/****** Object:  StoredProcedure [dbo].[proc_AddDependency]    Script Date: 5/15/2018 12:11:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_AddDependency(
    @SiteId uniqueidentifier,  
    @FullUrl nvarchar(260),
    @Level tinyint,
    @DepType tinyint,
    @DepDesc nvarchar(270))
AS
    SET NOCOUNT ON
    INSERT INTO Deps (
        SiteId,
        DeleteTransactionId,
        FullUrl,
        Level,
        DepType,
        DepDesc)
    VALUES (
        @SiteId,
        0x,
        @FullUrl,
        @Level,
        @DepType,
        @DepDesc)

GO
