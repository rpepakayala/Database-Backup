/****** Object:  StoredProcedure [dbo].[proc_MSS_DeleteAuthorityPage]    Script Date: 5/15/2018 12:11:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_DeleteAuthorityPage(
		@Url NVARCHAR(2048) )
AS
	DELETE dbo.MSSClickDistanceSeeds where DisplayUrl = @Url

GO
