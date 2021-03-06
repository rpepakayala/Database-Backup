/****** Object:  StoredProcedure [dbo].[proc_MSS_DeleteConfigurationProperty]    Script Date: 5/15/2018 12:13:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_DeleteConfigurationProperty
(
    @Name nvarchar(64)
)
AS
BEGIN TRANSACTION
IF NOT EXISTS (SELECT * FROM dbo.MSSConfiguration Where @Name = Name)
    return 0
DELETE 
    dbo.MSSConfiguration
WHERE
    Name = @Name
COMMIT TRANSACTION
return 0

GO
