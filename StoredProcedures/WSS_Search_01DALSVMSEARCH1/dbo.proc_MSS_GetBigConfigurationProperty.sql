/****** Object:  StoredProcedure [dbo].[proc_MSS_GetBigConfigurationProperty]    Script Date: 5/15/2018 12:13:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetBigConfigurationProperty
(
    @Name nvarchar(64)
)
AS
    SELECT
         DATALENGTH(BigValue), BigValue
    FROM
        dbo.MSSConfiguration WITH(NOLOCK)
    WHERE
        Name = @Name

GO
