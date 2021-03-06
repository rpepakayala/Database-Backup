/****** Object:  StoredProcedure [internal].[validate_project_internal]    Script Date: 5/15/2018 12:13:13 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE [internal].[validate_project_internal]
	@project_id [bigint],
	@version_id [bigint],
	@validation_id [bigint],
	@environment_scope [nchar](1),
	@use32bitruntime [smallint]
WITH EXECUTE AS CALLER
AS
EXTERNAL NAME [ISSERVER].[Microsoft.SqlServer.IntegrationServices.Server.ServerApi].[ValidateProjectInternal]
GO
