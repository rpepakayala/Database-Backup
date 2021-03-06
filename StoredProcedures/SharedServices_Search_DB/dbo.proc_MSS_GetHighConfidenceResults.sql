/****** Object:  StoredProcedure [dbo].[proc_MSS_GetHighConfidenceResults]    Script Date: 5/15/2018 12:11:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetHighConfidenceResults
@Term NVARCHAR(100),
@Author NVARCHAR(100)  AS

    IF (len(@author)> 0 and len(@term) >0)
    BEGIN
        select docid, pid, strVal, binVal, isnull( datalength(binVal), 0 ) from mssdocprops with(nolock, index(IX_MSSDocProps)) where 
        (pid = 2 
        or pid = 6 
        or pid = 7 
        or pid = 336
        or pid = 337 
        or pid = 331 
        or pid = 332
        or pid = 333
        or pid = 334 
        or pid = 378 
        or pid = 379
        or pid = 380
        or pid = 381 
        or pid = 382 
        or pid = 383
        or pid = 384
        or pid = 385
        or pid = 386 
        or pid = 387
        or pid = 388
         ) and
         (docid in 
        (select docid from mssdocprops with(nolock) where (strval = @Term or strval = @Author)
         and pid = 335 )) order by docid
    END
    ELSE IF (len(@Term) >0)
    BEGIN
        select docid, pid, strVal, binVal, isnull( datalength(binVal), 0 )  from mssdocprops with(nolock, index(IX_MSSDocProps)) where 
        (pid = 2 
        or pid = 6 
        or pid = 7 
        or pid = 336
        or pid = 337 
        or pid = 331 
        or pid = 332
        or pid = 333
        or pid = 334
        or pid = 378 
        or pid = 379
        or pid = 380
        or pid = 381 
        or pid = 382 
        or pid = 383
        or pid = 384
        or pid = 385
        or pid = 386 
        or pid = 387
        or pid = 388 
        ) and
         (docid in 
        (select docid from mssdocprops with(nolock) where (strval = @Term)
         and pid = 335 )) order by docid
    END
    ELSE if (len(@Author) >0)
    BEGIN
        select docid, pid, strVal, binVal, isnull( datalength(binVal), 0 )  from mssdocprops with(nolock, index(IX_MSSDocProps)) where 
        (pid = 2 
        or pid = 6 
        or pid = 7 
        or pid = 336
        or pid = 337 
        or pid = 331 
        or pid = 332
        or pid = 333
        or pid = 334
        or pid = 378 
        or pid = 379
        or pid = 380
        or pid = 381 
        or pid = 382 
        or pid = 383
        or pid = 384
        or pid = 385
        or pid = 386 
        or pid = 387
        or pid = 388 
        ) and
         (docid in 
        (select docid from mssdocprops with(nolock) where (strval = @Author)
         and pid = 335 )) order by docid
    END
    ELSE
    BEGIN
        SELECT docid, pid, strVal, binVal, isnull( datalength(binVal), 0 )  from mssdocprops where docid in (null)
    END


GO
