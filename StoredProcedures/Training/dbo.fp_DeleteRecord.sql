/****** Object:  StoredProcedure [dbo].[fp_DeleteRecord]    Script Date: 5/15/2018 12:13:19 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE fp_DeleteRecord 
(   @ID int   )

AS

DELETE FROM FP_Info
WHERE ID = @ID
GO
