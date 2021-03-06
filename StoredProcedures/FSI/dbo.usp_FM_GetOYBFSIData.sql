/****** Object:  StoredProcedure [dbo].[usp_FM_GetOYBFSIData]    Script Date: 5/15/2018 12:09:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:        Alex Montminy
-- Create date: 10/08/2012
-- Description:   New Fastmail procs
-- =============================================
CREATE PROCEDURE [dbo].[usp_FM_GetOYBFSIData] 
      -- Add the parameters for the stored procedure here
AS 
    BEGIN
      -- SET NOCOUNT ON added to prevent extra result sets from
      -- interfering with SELECT statements.
        SET NOCOUNT ON;

    -- Insert statements for procedure here
      

        SELECT TOP 10000
            C.zw_franchise_id ,
            C.contactID ,
            C.first_name ,
            C.last_name ,
            C.email ,
            C.zip_code ,
            C.company ,
            C.customer_industry ,
            C.last_order_date ,
            C.average_total ,
            C.last_product_ordered ,
            C.salesperson ,
            C.pickedup_date ,
            C.pickedup_date last_modified ,
            C.subscriber_id ,
            C.LastSync2 ,
            C.OptOut2 ,
            C.Delete_Flag ,
            C.Delete_Date ,
            S.WebNumber AS StoreWebNumber ,
            S.LastSync AS StoreLastSync ,
            S.LastTransformation AS StoreLastTransformation ,
            SI.State AS StoreState ,
            SI.City AS StoreCity ,
            SI.Zip AS StoreZip ,
            SI.Address AS StoreAddress
        FROM
            dbo._ExactTarget_Integration_Contacts C
            INNER JOIN dbo._ExactTarget_Integration_Stores S ON C.zw_franchise_id = S.zw_franchise_id
            INNER JOIN dbo.[Store Information Database] SI ON C.zw_franchise_id = SI.zw_franchise_id
            --INNER JOIN ( SELECT
            --                email
            --             FROM
            --                dbo._ExactTarget_Integration_Contacts
            --             GROUP BY
            --                email
            --             HAVING
            --                COUNT(email) = 1
            --           ) AS myTable ON myTable.email = c.email
        WHERE
            C.LastSync2 < C.last_modified
            AND ( C.last_order_date = '01/01/1900'
                  OR DATEPART(yyyy, GETDATE()) - 3 <= DATEPART(yyyy,
                                                              C.last_order_date)
                )
            
            

    END

GO
