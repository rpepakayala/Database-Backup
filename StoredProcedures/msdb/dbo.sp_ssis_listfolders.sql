/****** Object:  StoredProcedure [dbo].[sp_ssis_listfolders]    Script Date: 5/15/2018 12:10:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[sp_ssis_listfolders]
  @parentfolderid uniqueidentifier = NULL
AS
  SELECT
   folderid,
   parentfolderid,
   foldername
  FROM
      sysssispackagefolders
  WHERE
      [parentfolderid] = @parentfolderid OR 
      (@parentfolderid IS NULL AND [parentfolderid] IS NULL)
  ORDER BY 
      foldername

GO
