/****** Object:  StoredProcedure [dbo].[proc_MSS_GetCrawledPropertySamplesByPropertyID]    Script Date: 5/15/2018 12:13:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_GetCrawledPropertySamplesByPropertyID
@CrawledPropertyId  int,        
@SampleCount        int
AS
        set RowCount @SampleCount
	    SELECT
           ( DP.strVal + ISNULL(cast(cast(DP.binVal as varbinary(4000)) AS nvarchar(2000)), '') ) as 'SampleURL'
	    FROM 
            dbo.MSSDocProps as DP	        
        INNER JOIN 
            dbo.MSSCrawledPropSamples as CPS
            on CPS.Docid = DP.Docid
	    WHERE
	        CPS.CrawledPropertyId = @CrawledPropertyId
            AND DP.Pid          = 7
        ORDER BY DP.strVal
        set RowCount 0

GO
