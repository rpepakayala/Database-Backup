/****** Object:  View [dbo].[DocStreams]    Script Date: 5/15/2018 12:14:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE VIEW [dbo].[DocStreams]
AS
    SELECT
        *
    FROM
        AllDocStreams
    WHERE
        DeleteTransactionId = 0x

GO
