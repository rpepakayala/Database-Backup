/****** Object:  UserDefinedFunction [internal].[get_execution_perf_counters]    Script Date: 5/15/2018 12:15:13 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE FUNCTION [internal].[get_execution_perf_counters](@execution_id [bigint], @execution_guid [uniqueidentifier])
RETURNS  TABLE (
	[execution_id] [bigint] NULL,
	[counter_name] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[counter_value] [bigint] NULL
) WITH EXECUTE AS CALLER
AS 
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.ExecPerfCounterApi].[GetExecPerfCounters]
GO
