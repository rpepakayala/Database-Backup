/****** Object:  StoredProcedure [dbo].[el_GetResourceInfo]    Script Date: 5/15/2018 12:13:18 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE el_GetResourceInfo 
(   @ID int   )

AS

SELECT *
FROM Resources
WHERE ID = @ID

GO
