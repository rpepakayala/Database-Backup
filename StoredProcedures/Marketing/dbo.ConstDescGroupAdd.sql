/****** Object:  StoredProcedure [dbo].[ConstDescGroupAdd]    Script Date: 5/15/2018 12:10:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.ConstDescGroupAdd
(
	@ConstGroupId int = NULL,
	@Description varchar(50) = NULL
)
AS
INSERT INTO ConstDescGroup (ConstGroupId, Description)
 VALUES (@ConstGroupId, @Description);


GO
