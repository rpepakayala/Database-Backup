/****** Object:  View [dbo].[UserDataJunctionsVersioned]    Script Date: 5/15/2018 12:14:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[UserDataJunctionsVersioned]
AS
    SELECT
        *
    FROM
        AllUserDataJunctions
    WHERE
        tp_DeleteTransactionId = 0x

GO
