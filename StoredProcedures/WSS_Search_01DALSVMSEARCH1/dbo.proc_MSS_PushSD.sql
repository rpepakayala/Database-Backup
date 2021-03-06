/****** Object:  StoredProcedure [dbo].[proc_MSS_PushSD]    Script Date: 5/15/2018 12:13:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_PushSD
        @sd image, @sdCheckSum INT, @type INT, @sdid INT OUTPUT
AS
BEGIN TRANSACTION
    INSERT INTO MSSSecurityDescriptors ( SD, SDHash, Type)
        VALUES( @sd, @sdCheckSum, @type )
    SET @sdid = SCOPE_IDENTITY()
    COMMIT TRANSACTION
    RETURN
    SET ANSI_NULLS ON

GO
