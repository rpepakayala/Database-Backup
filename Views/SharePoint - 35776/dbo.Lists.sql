/****** Object:  View [dbo].[Lists]    Script Date: 5/15/2018 12:14:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[Lists]
AS
    SELECT
        *
    FROM
        AllLists
    WHERE
        tp_DeleteTransactionId = 0x

GO
