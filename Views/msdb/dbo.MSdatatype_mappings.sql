/****** Object:  View [dbo].[MSdatatype_mappings]    Script Date: 5/15/2018 12:14:05 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE VIEW dbo.MSdatatype_mappings (dbms_name, sql_type, dest_type, dest_prec, dest_create_params, dest_nullable) AS SELECT destination_dbms, source_type, destination_type, case when (destination_createparams & 1) = 1 then destination_precision else destination_length end, destination_createparams, destination_nullable FROM sys.fn_helpdatatypemap(N'MSSQLSERVER', '%', '%', '%', '%', '%', 0)
GO
