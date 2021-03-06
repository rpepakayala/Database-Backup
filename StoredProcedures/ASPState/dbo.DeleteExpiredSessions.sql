/****** Object:  StoredProcedure [dbo].[DeleteExpiredSessions]    Script Date: 5/15/2018 12:09:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.DeleteExpiredSessions
        AS
            DECLARE @now datetime
            SET @now = GETUTCDATE()

            DELETE [ASPState].dbo.ASPStateTempSessions
            WHERE Expires < @now

            RETURN 0
GO
