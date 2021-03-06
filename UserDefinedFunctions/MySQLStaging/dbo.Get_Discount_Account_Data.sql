/****** Object:  UserDefinedFunction [dbo].[Get_Discount_Account_Data]    Script Date: 5/15/2018 12:15:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		SMT
-- Description:	Grabs a list of discounts for the account.  
--     Depending on the data, all discounts will be returned
--	   or just the active ones
-- =============================================
CREATE FUNCTION Get_Discount_Account_Data
    (
      -- Add the parameters for the function here
      @account_id VARCHAR(32) ,
-- 	Add the usages if passed.  Also, since the usages are passed only on the
--   job side, also filter for date ranges
      @usages VARCHAR(32) = ''
    )
RETURNS TABLE
AS
RETURN
    SELECT
        da.discount_id ,
        account_id ,
        discount_usage_id ,
        franchise_id ,
        discount_type_id ,
        name ,
        value ,
        quantity ,
        effective_on ,
        expires_on ,
        corporate_id
    FROM
        discount_accounts da
        JOIN discounts d ON da.discount_id = d.discount_id
    WHERE
        account_id = @account_id
        AND ( ( LEN(@usages) = 0 )
              OR ( discount_usage_id IN ( @usages )
                   AND d.effective_on IS NULL
                   OR d.effective_on <= GETDATE()
                   AND d.expires_on IS NULL
                   OR d.expires_on >= GETDATE()
                 )
            )

GO
