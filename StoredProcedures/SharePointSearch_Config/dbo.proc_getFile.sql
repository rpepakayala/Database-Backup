/****** Object:  StoredProcedure [dbo].[proc_getFile]    Script Date: 5/15/2018 12:13:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_getFile
(
    @ObjectId uniqueidentifier
) AS
    SET NOCOUNT ON
    SELECT
        FileImage
    FROM
        Binaries
    WHERE
        ObjectId = @ObjectId

GO
