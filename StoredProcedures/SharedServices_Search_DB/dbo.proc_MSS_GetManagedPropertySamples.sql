/****** Object:  StoredProcedure [dbo].[proc_MSS_GetManagedPropertySamples]    Script Date: 5/15/2018 12:11:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE dbo.proc_MSS_GetManagedPropertySamples
@PID int,
@SampleCount int
AS
        set RowCount @SampleCount
	    SELECT
            DP2.strVal + ISNULL(cast(cast(DP2.binVal as varbinary(4000)) AS nvarchar(2000)), '')            
	    FROM 
            dbo.MSSDocProps as DP
        INNER JOIN 
            dbo.MSSDocProps as DP2
            on DP2.Docid = DP.Docid
	    WHERE
	        DP.PID             = @PID
            AND DP2.Pid        = 7
        ORDER BY DP2.strVal
        set RowCount 0

GO
