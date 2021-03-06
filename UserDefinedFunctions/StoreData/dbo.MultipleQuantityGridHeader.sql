/****** Object:  UserDefinedFunction [dbo].[MultipleQuantityGridHeader]    Script Date: 5/15/2018 12:15:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION MultipleQuantityGridHeader (@TransDetailID INT)

RETURNS TABLE

RETURN

SELECT   CAST( SUBSTRING( QuantityVariableID, 2, PATINDEX('%,%', T.QuantityVariableID)-2 ) AS INT ) QuantityVariableID,
         QuantityVariableName,  QuantityCount,
         CAST( SUBSTRING( ColumnVariableID, 2, PATINDEX('%,%', T.ColumnVariableID)-2 ) AS INT ) ColumnVariableID,
         ColumnVariableName, ColumnCount,
         ColumnValue01, ColumnValue02, ColumnValue03, ColumnValue04, ColumnValue05, ColumnValue06,
         DisplayType, DisplayTypeName, HeaderNode
FROM  ( SELECT MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/QuantityVariableID)[1]', 'VARCHAR(MAX)') AS QuantityVariableID,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/QuantityVariableName)[1]', 'VARCHAR(MAX)') AS QuantityVariableName,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/QuantityCount)[1]', 'INT') AS QuantityCount,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnVariableID)[1]', 'VARCHAR(MAX)') AS ColumnVariableID,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnVariableName)[1]', 'VARCHAR(MAX)') AS ColumnVariableName,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnCount)[1]', 'INT') AS ColumnCount,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnValue01)[1]', 'VARCHAR(MAX)') AS ColumnValue01,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnValue02)[1]', 'VARCHAR(MAX)') AS ColumnValue02,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnValue03)[1]', 'VARCHAR(MAX)') AS ColumnValue03,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnValue04)[1]', 'VARCHAR(MAX)') AS ColumnValue04,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnValue05)[1]', 'VARCHAR(MAX)') AS ColumnValue05,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/ColumnValue06)[1]', 'VARCHAR(MAX)') AS ColumnValue06,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/DisplayType)[1]', 'INT') AS DisplayType,
               MultipleQuantityGridXML.value('(//MultipleQuantityGrid/Header/DisplayTypeName)[1]', 'VARCHAR(MAX)') AS DisplayTypeName,
               MultipleQuantityGridXML.query('(//MultipleQuantityGrid/Header/node())') AS HeaderNode
  
        FROM TransDetail
        WHERE ID = @TransDetailID ) T

GO
