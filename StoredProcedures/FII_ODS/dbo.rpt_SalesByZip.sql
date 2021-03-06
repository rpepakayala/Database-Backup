/****** Object:  StoredProcedure [dbo].[rpt_SalesByZip]    Script Date: 5/15/2018 12:09:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[rpt_SalesByZip]
    (
      @CountryName VARCHAR(50)='USA',
      @FranchiseID VARCHAR(7)=NULL,		
      @StartDate DATETIME = NULL,
      @EndDate DATETIME = NULL
    )
AS 

    SET NOCOUNT ON
					
IF @CountryName IS NULL 
    BEGIN	    
        SET @CountryName ='USA'
    END
    	
IF @StartDate IS NULL 
    BEGIN	    
        SET @StartDate =DATEADD(yy, -1, GETDATE())
    END
    
IF @EndDate IS NULL 
    BEGIN	    
        SET @EndDate =DATEADD(dd, -1, GETDATE())
    END
 	 								  

SELECT   od.ZW_Franchise_ID AS 'Web Number'	
      , Contact.ZipDim.ZipName AS 'Zip Code'
      , SUM(od.salessubtotal) as 'Sales Subtotal'
FROM      Orders.OrderHeaderFact od
         JOIN Contact.CustomerFact cf ON od.CustomerID = cf.CustomerID
                                             AND od.ZW_Franchise_ID = cf.ZW_Franchise_ID 
         JOIN Contact.ZipDim ON cf.ZipKey = Contact.ZipDim.ZipKey
WHERE    
        od.PickedUpDate BETWEEN @StartDate  AND  @EndDate           
        AND	1=case	
					when (@FranchiseID is null) then 1 
						else	
							case 
								when ( od.[ZW_Franchise_ID] = @FranchiseID) then 1	else 0
							end 
					end		
GROUP BY  od.ZW_Franchise_ID
      , Contact.ZipDim.ZipName
ORDER BY  2
		

GO
