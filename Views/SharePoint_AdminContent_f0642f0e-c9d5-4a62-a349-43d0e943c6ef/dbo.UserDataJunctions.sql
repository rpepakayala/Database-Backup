/****** Object:  View [dbo].[UserDataJunctions]    Script Date: 5/15/2018 12:14:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[UserDataJunctions]
AS
    SELECT
        *
    FROM
        AllUserDataJunctions
    WHERE
        tp_IsCurrentVersion = CONVERT(bit,1)
      AND
        tp_CalculatedVersion = 0
      AND
        tp_DeleteTransactionId = 0x

GO
