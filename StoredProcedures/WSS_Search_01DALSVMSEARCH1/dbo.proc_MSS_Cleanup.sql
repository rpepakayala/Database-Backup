/****** Object:  StoredProcedure [dbo].[proc_MSS_Cleanup]    Script Date: 5/15/2018 12:13:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_Cleanup
AS
    DELETE dbo.MSSCrawledPropSamples
     WHERE MSSCrawledPropSamples.docid not in
       (SELECT cu.docid from dbo.msscrawlurl cu
        WHERE  cu.docid = MSSCrawledPropSamples.docid
          AND  cu.AccessHash = MSSCrawledPropSamples.AccessHash)
    TRUNCATE table dbo.MSScrawledPropSamplesCleanup
    INSERT into dbo.MSScrawledPropSamplesCleanup
    SELECT crawledPropertyId, count(*)
        FROM   dbo.msscrawledPropSamples
        GROUP BY crawledPropertyId
        ORDER BY crawledPropertyId
    DELETE dbo.MSSChangeLogCookies 
        WHERE DATEDIFF(dd, UpdateTime, getdate()) >= 14 
    TRUNCATE TABLE dbo.MSSCrawlURLLog 
    DELETE dbo.MSSCrawlDeletedURL
        WHERE DATEDIFF(dd, LogTime, getdate()) >= 14 

GO
