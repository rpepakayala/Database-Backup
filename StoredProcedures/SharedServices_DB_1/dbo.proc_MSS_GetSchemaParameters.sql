/****** Object:  StoredProcedure [dbo].[proc_MSS_GetSchemaParameters]    Script Date: 5/15/2018 12:11:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetSchemaParameters
AS
select ParamName, IsString, strValue, fltValue from MSSSchemaParameters

GO
