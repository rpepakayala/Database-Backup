/****** Object:  StoredProcedure [dbo].[GetNameById]    Script Date: 5/15/2018 12:09:59 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[GetNameById]
@ItemID uniqueidentifier
AS
SELECT Path
FROM Catalog
WHERE ItemID = @ItemID

GO
