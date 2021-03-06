/****** Object:  StoredProcedure [dbo].[SP_TC_EnableFastMailLoginScreen]    Script Date: 5/15/2018 12:09:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:        Alex Montminy 
-- Create date: 1/11/2013
-- Description:   None Given... TAF
-- =============================================
CREATE PROCEDURE [dbo].[SP_TC_EnableFastMailLoginScreen]
      -- Add the parameters for the stored procedure here
    @WebNumber INT
AS 
    BEGIN

        DECLARE @StoreNumber INT;
--check alpine for store number
        IF EXISTS ( SELECT
                        StoreNumber
                    FROM
                        [Alpine].dbo.[COR_STORES]
                    WHERE
                        webnumber = @WebNumber ) 
            BEGIN
                SET @StoreNumber = ( SELECT
                                        StoreNumber
                                     FROM
                                        [Alpine].dbo.[COR_STORES]
                                     WHERE
                                        webnumber = @WebNumber
                                   )
            END
        ELSE 
            BEGIN 
                SELECT
                    'Error: WebNumber ' + CAST(@WebNumber AS NVARCHAR(30))
                    + ' Not Found in [Alpine].dbo.[COR_STORES] '
                RETURN 
            END
      --never execute no matter what
      -- using Store NUmber does this exists in FII
      --if so update
        IF EXISTS ( SELECT
                        *
                    FROM
                        FIISecurity.dbo.sec_StoreSubscription
                    WHERE
                        store_number = @StoreNumber
                        AND application_id = 1 ) 
            BEGIN
                UPDATE
                    FIISecurity.dbo.sec_StoreSubscription
                SET 
                    state_id = 3       -- subscribed
                WHERE
                    store_number = @StoreNumber
                    AND application_id = 1 -- FastMail
       
                SELECT
                    'StoreNumber ' + CAST(@StoreNumber AS NVARCHAR(30))
                    + ' Has been unpdated in FIISecurity.dbo.sec_StoreSubscription '
                RETURN;
            END
        ELSE 
            BEGIN 
                INSERT  INTO FIISecurity.dbo.sec_StoreSubscription
                        ( store_number ,
                          state_id ,
                          date_transition ,
                          application_id
                        )
                VALUES
                        ( @StoreNumber ,
                          3 ,
                          GETDATE() ,
                          1
                        )
            -- storenumber for web number 227, for example
                  -- state_id; 1 is not subscribed and 3 is subscribed
                --date_transition – enter current date
                  --application_id ; 1 = FastMail
                SELECT
                    'StoreNumber ' + CAST(@StoreNumber AS NVARCHAR(30))
                    + ' Has been inserted into FIISecurity.dbo.sec_StoreSubscription '
                RETURN;
            END
      

    END


GO
