/****** Object:  StoredProcedure [dbo].[sub_CoOpNameSelect]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE PROCEDURE sub_CoOpNameSelect 
(
@CoOpID int

)
 AS

SET NOCOUNT ON

SELECT 
	CoOpName
FROM
	CoOps
WHERE 
	CoOpID = @coOpID
GO
