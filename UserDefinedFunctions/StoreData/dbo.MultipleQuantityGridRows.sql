/****** Object:  UserDefinedFunction [dbo].[MultipleQuantityGridRows]    Script Date: 5/15/2018 12:15:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION MultipleQuantityGridRows (@TransDetailID INT)

RETURNS TABLE

RETURN
SELECT
  ThisRow.value('Quantity[1]', 'FLOAT') AS Quantity,
  ThisRow.value('C01Price[1]', 'FLOAT') AS Column01Price,
  ThisRow.value('C01UnitPrice[1]', 'FLOAT') AS Column01UnitPrice,
  ThisRow.value('C01Cost[1]', 'FLOAT') AS Column01Cost,
  ThisRow.value('C01UnitCost[1]', 'FLOAT') AS Column01UnitCost,
  ThisRow.value('C01Margin[1]', 'FLOAT') AS Column01Margin,
  ThisRow.value('C01UnitMargin[1]', 'FLOAT') AS Column01UnitMargin,
  ThisRow.value('C01PercentMargin[1]', 'FLOAT') AS Column01PercentMargin,
  
  ThisRow.value('C02Price[1]', 'FLOAT') AS Column02Price,
  ThisRow.value('C02UnitPrice[1]', 'FLOAT') AS Column02UnitPrice,
  ThisRow.value('C02Cost[1]', 'FLOAT') AS Column02Cost,
  ThisRow.value('C02UnitCost[1]', 'FLOAT') AS Column02UnitCost,
  ThisRow.value('C02Margin[1]', 'FLOAT') AS Column02Margin,
  ThisRow.value('C02UnitMargin[1]', 'FLOAT') AS Column02UnitMargin,
  ThisRow.value('C02PercentMargin[1]', 'FLOAT') AS Column02PercentMargin,

  ThisRow.value('C03Price[1]', 'FLOAT') AS Column03Price,
  ThisRow.value('C03UnitPrice[1]', 'FLOAT') AS Column03UnitPrice,
  ThisRow.value('C03Cost[1]', 'FLOAT') AS Column03Cost,
  ThisRow.value('C03UnitCost[1]', 'FLOAT') AS Column03UnitCost,
  ThisRow.value('C03Margin[1]', 'FLOAT') AS Column03Margin,
  ThisRow.value('C03UnitMargin[1]', 'FLOAT') AS Column03UnitMargin,
  ThisRow.value('C03PercentMargin[1]', 'FLOAT') AS Column03PercentMargin,

  ThisRow.value('C04Price[1]', 'FLOAT') AS Column04Price,
  ThisRow.value('C04UnitPrice[1]', 'FLOAT') AS Column04UnitPrice,
  ThisRow.value('C04Cost[1]', 'FLOAT') AS Column04Cost,
  ThisRow.value('C04UnitCost[1]', 'FLOAT') AS Column04UnitCost,
  ThisRow.value('C04Margin[1]', 'FLOAT') AS Column04Margin,
  ThisRow.value('C04UnitMargin[1]', 'FLOAT') AS Column04UnitMargin,
  ThisRow.value('C04PercentMargin[1]', 'FLOAT') AS Column04PercentMargin,

  ThisRow.value('C05Price[1]', 'FLOAT') AS Column05Price,
  ThisRow.value('C05UnitPrice[1]', 'FLOAT') AS Column05UnitPrice,
  ThisRow.value('C05Cost[1]', 'FLOAT') AS Column05Cost,
  ThisRow.value('C05UnitCost[1]', 'FLOAT') AS Column05UnitCost,
  ThisRow.value('C05Margin[1]', 'FLOAT') AS Column05Margin,
  ThisRow.value('C05UnitMargin[1]', 'FLOAT') AS Column05UnitMargin,
  ThisRow.value('C05PercentMargin[1]', 'FLOAT') AS Column05PercentMargin,

  ThisRow.value('C06Price[1]', 'FLOAT') AS Column06Price,
  ThisRow.value('C06UnitPrice[1]', 'FLOAT') AS Column06UnitPrice,
  ThisRow.value('C06Cost[1]', 'FLOAT') AS Column06Cost,
  ThisRow.value('C06UnitCost[1]', 'FLOAT') AS Column06UnitCost,
  ThisRow.value('C06Margin[1]', 'FLOAT') AS Column06Margin,
  ThisRow.value('C06UnitMargin[1]', 'FLOAT') AS Column06UnitMargin,
  ThisRow.value('C06PercentMargin[1]', 'FLOAT') AS Column06PercentMargin,

  ThisRow.query('(node())') AS RowNode
  
FROM TransDetail
CROSS APPLY MultipleQuantityGridXML.nodes('//MultipleQuantityGrid/Rows/Row') AS GridRows(ThisRow)

WHERE ID = @TransDetailID

GO
