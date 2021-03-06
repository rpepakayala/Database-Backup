/****** Object:  UserDefinedFunction [dbo].[TaxItemsTable]    Script Date: 5/15/2018 12:15:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION TaxItemsTable (	
	-- Add the parameters for the function here
	@list ntext
)
RETURNS @MyTable TABLE (TransHeaderID int, TransDetailID int , TaxAccountID int, TaxName varchar(50), TaxRate float, TaxAmount float )
AS
BEGIN 
	declare @TaxItemsXML varchar(4000);
	declare @startpos int;
	declare @endpos int;
	declare @i int;
	declare @j int;
	declare @maxItems int;
	declare @strlen int;
	declare @rowcount int;
	declare @TaxAccountID varchar(50); -- Int;
	declare @TaxName varchar(50);
	declare @TaxRate varchar(50); -- Float;
	declare @TaxAmount varchar(50); -- Float;
	declare @TransHeaderID int;
	declare @TransDetailID int;
	declare @PrevTransDetailID int;
	declare @TransHeaderIDTable table (listpos int, THID int);
	declare @TaxItemXMLTable table(TransHeaderID int, TransDetailID int, TaxItems VarChar(4000))

	-- inserts all of the TransheaderID's into a temptable with a sequential index
	insert into @TransHeaderIDTable (listpos, THID) select listpos, number from iter_intlist_to_table (@list);

    -- inserts All the detail Items into a temp table 
	insert into @TaxItemXMLTable (TransHeaderID, TransDetailID, TaxItems) 
			select TransHeaderID as TransHeaderID, TransDetail.ID as TransDetailID, Convert(Varchar(4000),TaxItems) as TaxItems 
			from TransDetail where TransHeaderID in (select THID from @TransHeaderIDTable);

	-- gets the remaining taxItem from transheader
	insert into @TaxItemXMLTable (TransHeaderID, TransDetailID, TaxItems) 
			select TransHeader.ID as TransHeaderID, 0 TransDetailID, Convert(Varchar(4000),TaxItems) as TaxItems 
			from TransHeader where TransHeader.ID in (select THID from @TransHeaderIDTable);


   
    --initialize the outer loop
	set @j=1;
	set @maxItems = (select count(listpos) from @TransHeaderIDTable);

	-- go through the loop for each TH in the TH temp table
   while @j <= @maxItems
   begin
	-- select the first TH
	select @TransHeaderID = THID from @TransHeaderIDTable where listpos=@j;

	-- Prime with 0 to get the TH Taxes
	select @TransDetailID = Min(TransDetailID), @TaxItemsXML = TaxItems, @TransHeaderID=TransHeaderID from @TaxItemXMLTable where TransDetailID =0 and TransHeaderID=@TransHeaderID
			group by TaxItems, TransHeaderID
	
        -- Inserts parsed XML into return table
        insert into @MyTable
        SELECT 
                TempTransHeader.TransHeaderID
              , TempTransHeader.TransDetailID
              , TempTransHeader.TaxAccountID
              , TaxAccount.AccountName AS TaxName
        
              , CAST( CASE 
                       WHEN CharIndex(',', TempTransHeader.TaxRateStr) > 0 THEN Replace(TempTransHeader.TaxRateStr, ',', '.')
                       ELSE TempTransHeader.TaxRateStr
                       END AS float) AS TaxRate
        
              , CAST( CASE 
                       WHEN CharIndex(',', TempTransHeader.TaxAmountStr) > 0 THEN Replace(TempTransHeader.TaxAmountStr, ',', '.')
                       ELSE TempTransHeader.TaxAmountStr
                       END AS float) AS TaxAmount
        FROM
        (  SELECT 
                TransHeaderID
              , TransDetailID
              , ThisTax.value('(TaxAccountID/text())[1]'          , 'varchar(50)') AS TaxAccountIDStr
              , ThisTax.value('(TaxRate/text())[1]'               , 'varchar(50)') AS TaxRateStr
              , ThisTax.value('(TaxAmount/text())[1]'             , 'varchar(50)') AS TaxAmountStr
        
              , CAST( Substring(ThisTax.value('(TaxAccountID/text())[1]', 'varchar(50)')
                                , 2
                                , charindex(',', ThisTax.value('(TaxAccountID/text())[1]', 'varchar(50)') )-2 ) AS int ) AS TaxAccountID
          FROM
          (
            SELECT  
                    ID AS TransHeaderID
                  , 0 AS TransDetailID
                  , CAST( TaxItems AS XML ) AS XMLField
            FROM TransHeader
            WHERE ID = @TransHeaderID
          ) AS TempTH
          CROSS APPLY XMLField.nodes('//Taxes/Tax') AS Taxes(ThisTax)
        )  AS TempTransHeader
        LEFT OUTER JOIN GLAccount As TaxAccount ON TaxAccount.ID = TempTransHeader.TaxAccountID
        
        UNION ALL
        
        SELECT 
                TempLineItem.TransHeaderID
              , TempLineItem.TransDetailID
              , TaxAccountID
              , TaxAccount.AccountName AS TaxName
        
              , CAST( CASE 
                       WHEN CharIndex(',', TempLineItem.TaxRateStr) > 0 THEN Replace(TempLineItem.TaxRateStr, ',', '.')
                       ELSE TempLineItem.TaxRateStr
                       END AS float) AS TaxRate
        
              , CAST( CASE 
                       WHEN CharIndex(',', TempLineItem.TaxAmountStr) > 0 THEN Replace(TempLineItem.TaxAmountStr, ',', '.')
                       ELSE TempLineItem.TaxAmountStr
                       END AS float) AS TaxAmount
        FROM
        (  SELECT 
                TransHeaderID
              , TransDetailID
              , ThisTax.value('(TaxAccountID/text())[1]'          , 'varchar(50)') AS TaxAccountIDStr
              , ThisTax.value('(TaxRate/text())[1]'               , 'varchar(50)') AS TaxRateStr
              , ThisTax.value('(TaxAmount/text())[1]'             , 'varchar(50)') AS TaxAmountStr
        
              , CAST( Substring(ThisTax.value('(TaxAccountID/text())[1]', 'varchar(50)')
                                , 2
                                , charindex(',', ThisTax.value('(TaxAccountID/text())[1]', 'varchar(50)') )-2 ) AS int ) AS TaxAccountID
          FROM
          (
            SELECT  
                    TransHeaderID
                  , ID AS TransDetailID
                  , CAST( TaxItems AS XML ) AS XMLField
            FROM TransDetail
            WHERE TransHeaderID = @TransHeaderID
          ) AS TempLI
          CROSS APPLY XMLField.nodes('//Taxes/Tax') AS Taxes(ThisTax)
        ) AS TempLineItem
          LEFT OUTER JOIN GLAccount As TaxAccount ON TaxAccount.ID = TempLineItem.TaxAccountID

	
	set @j = @j + 1;
   end
	RETURN 
END

GO
