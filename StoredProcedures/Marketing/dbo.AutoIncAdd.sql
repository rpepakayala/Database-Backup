/****** Object:  StoredProcedure [dbo].[AutoIncAdd]    Script Date: 5/15/2018 12:10:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.AutoIncAdd
(
	@TableName varchar(25) = NULL,
	@FieldName varchar(25) = NULL,
	@StartId int = NULL,
	@EndId int = NULL,
	@StepValue int = NULL,
	@CurrentId int = NULL
)
AS
INSERT INTO AutoInc (TableName, FieldName, StartId, EndId, StepValue, CurrentId)
 VALUES (@TableName, @FieldName, @StartId, @EndId, @StepValue, @CurrentId);


GO
