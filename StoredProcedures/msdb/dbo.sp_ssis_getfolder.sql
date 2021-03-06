/****** Object:  StoredProcedure [dbo].[sp_ssis_getfolder]    Script Date: 5/15/2018 12:10:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[sp_ssis_getfolder]
  @name sysname,
  @parentfolderid uniqueidentifier
AS
  SELECT
   folder.folderid,
   folder.foldername,
   folder.parentfolderid,
   parent.foldername
  FROM
      sysssispackagefolders folder 
  LEFT OUTER JOIN 
      sysssispackagefolders parent
  ON
      folder.parentfolderid = parent.folderid
  WHERE
      folder.foldername = @name AND
      (folder.parentfolderid = @parentfolderid OR 
      (@parentfolderid IS NULL AND folder.parentfolderid IS NULL))

GO
