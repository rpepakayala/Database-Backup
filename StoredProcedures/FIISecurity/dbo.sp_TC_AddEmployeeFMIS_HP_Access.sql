/****** Object:  StoredProcedure [dbo].[sp_TC_AddEmployeeFMIS_HP_Access]    Script Date: 5/15/2018 12:09:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:        Alex Montminy
-- Create date: 1/11/2013
-- Description: Gives New employee access to FMIS home Page 
-- 1/19/2013 I added a check in cast the username already exists
-- =============================================
CREATE PROCEDURE [dbo].[sp_TC_AddEmployeeFMIS_HP_Access] 
      -- Gives New employee access to FMIS home Page 
    @userName NVARCHAR(100)
  , @firstName NVARCHAR(100)
  , @lastName NVARCHAR(100)
  , @email NVARCHAR(100)
AS 
    BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
        SET NOCOUNT ON;

    -- Insert statements for procedure here
        
        if Exists(Select * from  sec_AuthenticatedUsers where username = @userName)
        begin
        SELECT  'user ' + @userName
                + ' already exists in sec_AuthenticatedUsers'
                return;
        end
        INSERT  INTO sec_AuthenticatedUsers
                ( username
                , user_type
                , first_name
                , last_name
                , email
                )
        VALUES  ( @userName
                , 3
                , @firstName
                , @lastName
                , @email
                )
        SELECT  'user ' + @userName
                + ' has been inserted into sec_AuthenticatedUsers'
        RETURN
    END

GO
