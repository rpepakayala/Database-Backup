/****** Object:  View [dbo].[UserDataVersioned]    Script Date: 5/15/2018 12:14:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[UserDataVersioned]
AS
    SELECT
        *
    FROM
        AllUserData
    WHERE
        tp_DeleteTransactionId = 0x

GO
