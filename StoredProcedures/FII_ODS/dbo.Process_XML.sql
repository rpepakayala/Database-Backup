/****** Object:  StoredProcedure [dbo].[Process_XML]    Script Date: 5/15/2018 12:09:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROC Process_XML (@mxmlData VARCHAR(MAX),@DetailKey int)
AS
DECLARE @xmlData XML
SET @xmlData = @mxmlData --CONVERT(VARCHAR(MAX),@vxmlData)
INSERT INTO ORDERS.ModifierXML (DetailKey,ID,OrderDetailID,AVID,OrderID,Answer,Price,PriceOverridden,CalcPrice,XMLLineNumber)
SELECT
    @DetailKey AS DetailKey,* ,
    ROW_NUMBER() OVER ( ORDER BY OrderDetailID ) AS XMLLineNumber
FROM
    ( SELECT 
        ref.value('ID[1]', 'int') AS ID ,
        ref.value('OrderDetailID[1]', 'int') AS OrderDetailID ,
        ref.value('AVID[1]', 'int') AS AVID ,
        ref.value('OrderID[1]', 'int') AS OrderID ,
        ref.value('Answer[1]', 'int') AS Answer ,
        ref.value('Price[1]', 'money') AS Price ,
        ref.value('PriceOverridden[1]', 'int') AS PriceOverridden ,
        ref.value('CalcPrice[1]', 'int') AS CalcPrice
      FROM
        @xmlData.nodes('/Modifiers/Modifier') xmlData ( ref )
    ) AS T
GO
