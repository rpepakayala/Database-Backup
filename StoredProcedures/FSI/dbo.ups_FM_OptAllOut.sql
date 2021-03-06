/****** Object:  StoredProcedure [dbo].[ups_FM_OptAllOut]    Script Date: 5/15/2018 12:09:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:        Alex Montminy
-- Create date: 2/01/2013
-- Description: Sets the optOut2 Field to True for All in both the FSI and CONtrol Databases 
-- Used for clearing test data and should not be used after implementation
-- =============================================
create PROCEDURE ups_FM_OptAllOut
      -- Add the parameters for the stored procedure here

AS
BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
      SET NOCOUNT ON;

    -- Insert statements for procedure here
update dbo._ExactTarget_Integration_Contacts 
set OptOut2 = 01/01/1901

update [Control].dbo.AccountContact
set OptOut2 = 01/01/1901
END

GO
