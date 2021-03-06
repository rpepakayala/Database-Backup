/****** Object:  StoredProcedure [dbo].[proc_MSS_UpdateCacheInformation]    Script Date: 5/15/2018 12:11:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_UpdateCacheInformation
 AS

SET NOCOUNT ON

DECLARE @LastError int

SELECT LastUpdate
From dbo.MSSLocationSystem

IF @@Rowcount = 0
BEGIN

   INSERT INTO  dbo.MSSLocationSystem
      (LastUpdate,UseCrawlProxy)
   VALUES
       (0, 0)

   SELECT @LastError = @@ERROR
   IF @LastError <> 0
    BEGIN
       RETURN @LastError
    END

END
ELSE
BEGIN

   UPDATE dbo.MSSLocationSystem
   SET LastUpdate = LastUpdate + 1

   SELECT @LastError = @@ERROR
   IF @LastError <> 0
    BEGIN
       RETURN @LastError
    END

END

RETURN 0

GO
