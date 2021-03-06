/****** Object:  StoredProcedure [dbo].[sp_ssis_listpackages]    Script Date: 5/15/2018 12:10:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[sp_ssis_listpackages]
  @folderid uniqueidentifier
AS
  SELECT
      name,
      id,
      description,
      createdate,
      folderid,
      datalength(packagedata),
      vermajor,
      verminor,
      verbuild,
      vercomments,
      verid
  FROM
      sysssispackages
  WHERE
      [folderid] = @folderid
  ORDER BY
      name

GO
