/****** Object:  StoredProcedure [dbo].[el_modules]    Script Date: 5/15/2018 12:13:19 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE el_modules 
(	@ID int		)

AS

SELECT *
FROM eLearningModules
WHERE ID = @ID
GO
