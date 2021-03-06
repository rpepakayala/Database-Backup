/****** Object:  StoredProcedure [dbo].[fsi_get_gauge_metrics]    Script Date: 5/15/2018 12:09:43 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE  PROCEDURE dbo.fsi_get_gauge_metrics(@Sales int, @YS int OUTPUT, @YE int OUTPUT, @RS int OUTPUT, @RE int OUTPUT, @GS int OUTPUT, @GE int  OUTPUT)
 AS

IF @SALES = 0 SET @SALES = 100000 ELSE SET @Sales = ROUND((@Sales*1.25),-1)

SET @YS = (@SALES*.56)
SET @YE = (@SALES*.85)
SET @RS = 0
SET @RE = (@SALES*.55)
SET @GS = (@SALES*.86)
SET @GE = (@SALES*1)
GO
