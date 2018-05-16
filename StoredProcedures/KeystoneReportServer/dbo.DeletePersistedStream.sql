/****** Object:  StoredProcedure [dbo].[DeletePersistedStream]    Script Date: 5/15/2018 12:09:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE [dbo].[DeletePersistedStream]
@SessionID varchar(32),
@Index int
AS

delete from [KeystoneReportServerTempDB].dbo.PersistedStream where SessionID = @SessionID and [Index] = @Index

GO
