/****** Object:  StoredProcedure [dbo].[SubsidyDtlDelete]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SubsidyDtlDelete
(
	@SubDId int
)
AS
	DELETE FROM SubsidyDtl WHERE SubDId=@SubDId;
RETURN @@Rowcount;


GO
