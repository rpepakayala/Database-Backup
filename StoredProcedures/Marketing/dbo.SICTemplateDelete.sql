/****** Object:  StoredProcedure [dbo].[SICTemplateDelete]    Script Date: 5/15/2018 12:10:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SICTemplateDelete
(
	@Id int
)
AS
	DELETE FROM SICTemplate WHERE Id=@Id;
RETURN @@Rowcount;


GO
