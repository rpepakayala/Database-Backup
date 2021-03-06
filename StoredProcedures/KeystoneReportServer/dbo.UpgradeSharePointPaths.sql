/****** Object:  StoredProcedure [dbo].[UpgradeSharePointPaths]    Script Date: 5/15/2018 12:10:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROC [dbo].[UpgradeSharePointPaths]
    @OldPrefix nvarchar(440),
    @NewPrefix nvarchar(440),
    @PrefixLen int 

AS
BEGIN
UPDATE [Catalog]
  SET [Path] = @NewPrefix + SUBSTRING([Path], @PrefixLen, 5000)
  WHERE [Path] like @OldPrefix escape '*';
END

GO
