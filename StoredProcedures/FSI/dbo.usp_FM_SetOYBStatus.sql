/****** Object:  StoredProcedure [dbo].[usp_FM_SetOYBStatus]    Script Date: 5/15/2018 12:09:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:        <Alex Montminy>
-- Create date: <02/04/2013>
-- Description:   <Sets the OYB Status of a single store>
-- =============================================
CREATE PROCEDURE [dbo].[usp_FM_SetOYBStatus] 
      -- Add the parameters for the stored procedure here
    @ZW_ID NVARCHAR(MAX) ,
    @IsOYB BIT
AS 
    BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
        SET NOCOUNT ON;

    -- Insert statements for procedure here
        UPDATE
            dbo.FM_OYBStatus
        SET 
            IsOYB = @ISOYB
        WHERE
            ZW_ID = @ZW_ID
    END


GO
