/****** Object:  UserDefinedFunction [dbo].[GetAllPartUDFs]    Script Date: 5/15/2018 12:15:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION GetAllPartUDFs ()
RETURNS TABLE 
AS
RETURN 
(
	SELECT
	  ID as PartID, 
	  ThisUDF.query('(local-name(.))') AS VariableName,
      ThisUDF.value('(text())[1]', 'varchar(255)') as UDFValue
	    
	FROM 
	( 
		SELECT ID,
			   Cast(UDFXML as XML) as XMLField 
		FROM Part 
		WHERE UDFXML is not NULL
	) Temp

	-- Cross Join this with a row for each ID in the UDF
	CROSS APPLY XMLField.nodes('//UDFs/*') as PartUDFs(ThisUDF)
)

GO
