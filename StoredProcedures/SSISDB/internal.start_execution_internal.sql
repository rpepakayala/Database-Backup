/****** Object:  StoredProcedure [internal].[start_execution_internal]    Script Date: 5/15/2018 12:13:12 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE [internal].[start_execution_internal]
	@project_id [bigint],
	@execution_id [bigint],
	@version_id [bigint],
	@use32BitRuntime [smallint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.ServerApi].[StartExecutionInternal]
GO
