/****** Object:  StoredProcedure [dbo].[AutoIncDelete]    Script Date: 5/15/2018 12:10:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.AutoIncDelete
(
	@TableName varchar(25),
	@FieldName varchar(25)
)
AS
	DELETE FROM AutoInc WHERE TableName=@TableName AND FieldName=@FieldName;
RETURN @@Rowcount;


GO
