/****** Object:  StoredProcedure [dbo].[SystemDefaultsDelete]    Script Date: 5/15/2018 12:10:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.SystemDefaultsDelete
(
	@SystemDefaultsId int
)
AS
	DELETE FROM SystemDefaults WHERE SystemDefaultsId=@SystemDefaultsId;
RETURN @@Rowcount;


GO
