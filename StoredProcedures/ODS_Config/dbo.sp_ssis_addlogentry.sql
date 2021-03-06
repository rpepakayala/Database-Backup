/****** Object:  StoredProcedure [dbo].[sp_ssis_addlogentry]    Script Date: 5/15/2018 12:11:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
Source : Pragmatic Works - BI xPress Auditing Framework 59
Created On : 2/19/2016
Purpose : 
    - This stored proc is called by native SSIS Log Provider For SQL Server 2008. It will log log entry to SSISDataFlowExecutionLog table and later on will be used by DataFlow monitoring
*/
CREATE PROCEDURE [dbo].[sp_ssis_addlogentry]
(
      @event sysname
    , @computer nvarchar(128)
    , @operator nvarchar(128)
    , @source nvarchar(1024)
    , @sourceid uniqueidentifier
    , @executionid uniqueidentifier
    , @starttime datetime
    , @endtime datetime
    , @datacode int
    , @databytes image
    , @message nvarchar(2048)
)
AS  
BEGIN
    SET NOCOUNT ON

    INSERT INTO [SSISDataFlowExecutionLog] ([event], [computer], [operator], [source], [sourceid], [executionid], [starttime], [endtime], [datacode], [databytes], [message])
    VALUES (@event, @computer, @operator, @source, @sourceid, @executionid, @starttime, @endtime, @datacode, @databytes, @message)
    
    RETURN 0
END

GO
