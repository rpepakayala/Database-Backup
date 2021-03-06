/****** Object:  StoredProcedure [dbo].[proc_MSS_DeleteConfigurationProperties]    Script Date: 5/15/2018 12:13:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_DeleteConfigurationProperties
(
    @Pattern nvarchar(64),
    @PropertiesToKeep nvarchar(1024)
)
AS
BEGIN TRANSACTION
DELETE 
    dbo.MSSConfiguration
WHERE
    Name LIKE @Pattern AND
    (PATINDEX(N'%,' + Name + N',%', @PropertiesToKeep) = 0
     OR @PropertiesToKeep IS NULL)
COMMIT TRANSACTION
return 0

GO
