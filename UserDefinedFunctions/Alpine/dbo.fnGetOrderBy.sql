/****** Object:  UserDefinedFunction [dbo].[fnGetOrderBy]    Script Date: 5/15/2018 12:14:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:		Matthew Wear
-- Create date: 8/28/2006
-- 
-- =============================================
CREATE FUNCTION [dbo].[fnGetOrderBy]()
RETURNS varchar(MAX)
AS
BEGIN
	RETURN ' ORDER BY cs.StoreNumber,srp.EndDate '
END




GO
