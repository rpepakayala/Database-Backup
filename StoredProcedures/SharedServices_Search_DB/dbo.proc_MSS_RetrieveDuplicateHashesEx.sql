/****** Object:  StoredProcedure [dbo].[proc_MSS_RetrieveDuplicateHashesEx]    Script Date: 5/15/2018 12:11:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_RetrieveDuplicateHashesEx
@docids NVARCHAR(2048) 
AS

    DECLARE @sqlStmt NVARCHAR(4000)
    SET @sqlStmt=N'SELECT s.DocId, s.HashVal FROM dbo.MSSDuplicateHashes AS s with(nolock) where docid in (' +  @docids + ');'
    exec sp_executesql @sqlStmt

GO
