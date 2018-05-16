/****** Object:  StoredProcedure [dbo].[usp_FM_DeleteTempRow]    Script Date: 5/15/2018 12:09:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON


-- =============================================
-- Author:           <Author,,Name>
-- Create date: <Create Date,,>
-- Description:      <Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[usp_FM_DeleteTempRow]
       -- Add the parameters for the stored procedure here
    @AccountContactID NVARCHAR(MAX) ,
    @ZWID NVARCHAR(MAX)
AS
    BEGIN
       -- SET NOCOUNT ON added to prevent extra result sets from
       -- interfering with SELECT statements.
        DELETE FROM
            tempdb.dbo.FM_ToSync
        WHERE
            [AccountContactID] = @AccountContactID
            AND [zw_franchise_id] = @ZWID
       
    -- Insert statements for procedure here
       
    END





GO
