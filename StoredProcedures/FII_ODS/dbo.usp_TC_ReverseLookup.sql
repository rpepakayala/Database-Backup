/****** Object:  StoredProcedure [dbo].[usp_TC_ReverseLookup]    Script Date: 5/15/2018 12:09:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Joshua Steward
-- Create date: 8/19/2013
-- Description:	Web/Store Number Lookup
-- =============================================
CREATE PROCEDURE usp_TC_ReverseLookup @WebNumberInput INT
AS 
    BEGIN
        SELECT
            [WebNumber] ,
            [StoreNumber] ,
            [VanityName] ,
            [Address] ,
            [CityName] ,
            [StateName] ,
            [CountryName] ,
            [Phone] ,
            [Email] ,
            [FBC]
        FROM
            [FII_ODS].[dbo].[vw_Store]
        WHERE
            WebNumber = @WebNumberInput
            OR StoreNumber = @WebNumberInput

		--GRANT EXECUTE ON  usp_TC_ReverseLookup TO [fastsigns\app_taskc_prod] 
    END

GO
