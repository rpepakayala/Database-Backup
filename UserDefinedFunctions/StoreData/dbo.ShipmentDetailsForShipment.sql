/****** Object:  UserDefinedFunction [dbo].[ShipmentDetailsForShipment]    Script Date: 5/15/2018 12:15:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION ShipmentDetailsForShipment (@ShipmentID int, @TransHeaderID int)
RETURNS TABLE AS RETURN
(
	SELECT ShipTable.ShipmentID * 100000 + TD.LineItemIndex ID, CAST(-1 AS INT) StoreID, CAST(10701 AS INT) ClassTypeID,
		   ShipTable.ModifiedByUser, ShipTable.ModifiedByComputer, ShipTable.ModifiedDate,
		   CAST(0 AS INT) SeqID, CAST(1 AS BIT) IsSystem, CAST(1 AS BIT) IsActive, 
		   ShipTable.ShipmentID, ShipTable.TransHeaderID, ShipTable.TransDetailID, 
		   ShipTable.Quantity QtyInShipment
	FROM   ( SELECT ShipmentXML.ID AS ShipmentID, TransHeaderID, 
					ModifiedByUser, ModifiedByComputer, ModifiedDate,
					CAST( SUBSTRING(ShipmentItem.value('(LineItemID/text())[1]', 'varchar(MAX)'), 2, PATINDEX('%,%', ShipmentItem.value('(LineItemID/text())[1]', 'varchar(MAX)')) - 2) AS INT) TransDetailID,
                    ShipmentItem.value('(Quantity/text())[1]', 'FLOAT') AS Quantity
			 FROM   ( SELECT ID, ModifiedByUser, ModifiedByComputer, ModifiedDate, ShipmentNumber, TransHeaderID, CAST(ShipLineItemsXML AS XML) ItemsXML
					  FROM   Shipments
					  WHERE  ( @ShipmentID = -1 or ID = @ShipmentID ) AND ( @TransHeaderID = -1 or TransHeaderID = @TransHeaderID ) ) ShipmentXML
					CROSS APPLY ItemsXML.nodes('//LineItem') AS VARIABLES(ShipmentItem)) ShipTable
		   JOIN TransHeader TH ON TH.ID = ShipTable.TransHeaderID
		   JOIN TransDetail TD ON TD.ID = ShipTable.TransDetailID
)

GO
