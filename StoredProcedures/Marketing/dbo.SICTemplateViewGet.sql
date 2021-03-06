/****** Object:  StoredProcedure [dbo].[SICTemplateViewGet]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF

CREATE  PROCEDURE dbo.SICTemplateViewGet
(
	@TemplateId int = null
)
AS
set NoCount ON
DECLARE @idoc int
DECLARE @XML1 varchar(7500), @XML2 varchar(7500), @XML3 varchar(7500), @XML4 varchar(7500), @XML5 varchar(7500), @XML6 varchar(7500),
	@XML7 varchar(7500), @XML8 varchar(7500), @XML9 varchar(7500), @XML10 varchar(7500), @XML11 varchar(7500), @XML12 varchar(7500), 
	@XML13 varchar(7500), @XML14 varchar(7500), @XML15 varchar(7500), @XML16 varchar(7500),	@XML17 varchar(7500), @XML18 varchar(7500),
	 @XML19 varchar(7500), @XML20 varchar(7500),
	@XML21 varchar(7500), @XML22 varchar(7500), @XML23 varchar(7500), @XML24 varchar(7500), @XML25 varchar(7500), @XML26 varchar(7500),
	@XML27 varchar(7500), @XML28 varchar(7500), @XML29 varchar(7500), @XML30 varchar(7500), @XML31 varchar(7500), @XML32 varchar(7500), 
	@XML33 varchar(7500), @XML34 varchar(7500), @XML35 varchar(7500), @XML36 varchar(7500),	@XML37 varchar(7500), @XML38 varchar(7500),
	 @XML39 varchar(7500), @XML40 varchar(7500),
	@XML41 varchar(7500), @XML42 varchar(7500), @XML43 varchar(7500), @XML44 varchar(7500), @XML45 varchar(7500), @XML46 varchar(7500),
	@XML47 varchar(7500), @XML48 varchar(7500), @XML49 varchar(7500), @XML50 varchar(7500), @XML51 varchar(7500), @XML52 varchar(7500), 
	@XML53 varchar(7500), @XML54 varchar(7500), @XML55 varchar(7500), @XML56 varchar(7500),	@XML57 varchar(7500), @XML58 varchar(7500),
	 @XML59 varchar(7500), @XML60 varchar(7500)
SELECT @XML1 = REPLACE(SUBSTRING( SICCodes, (0*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML2 = REPLACE(SUBSTRING( SICCodes, (1*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML3 = REPLACE(SUBSTRING( SICCodes, (2*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML4 = REPLACE(SUBSTRING( SICCodes, (3*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML5 = REPLACE(SUBSTRING( SICCodes, (4*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML6 = REPLACE(SUBSTRING( SICCodes, (5*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML7 = REPLACE(SUBSTRING( SICCodes, (6*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML8 = REPLACE(SUBSTRING( SICCodes, (7*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML9 = REPLACE(SUBSTRING( SICCodes, (8*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML10 = REPLACE(SUBSTRING( SICCodes, (9*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML11 = REPLACE(SUBSTRING( SICCodes, (10*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML12 = REPLACE(SUBSTRING( SICCodes, (11*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML13 = REPLACE(SUBSTRING( SICCodes, (12*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML14 = REPLACE(SUBSTRING( SICCodes, (13*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML15 = REPLACE(SUBSTRING( SICCodes, (14*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML16 = REPLACE(SUBSTRING( SICCodes, (15*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML17 = REPLACE(SUBSTRING( SICCodes, (16*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML18 = REPLACE(SUBSTRING( SICCodes, (17*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML19 = REPLACE(SUBSTRING( SICCodes, (18*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML20 = REPLACE(SUBSTRING( SICCodes, (19*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML21 = REPLACE(SUBSTRING( SICCodes, (20*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML22 = REPLACE(SUBSTRING( SICCodes, (21*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML23 = REPLACE(SUBSTRING( SICCodes, (22*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML24 = REPLACE(SUBSTRING( SICCodes, (23*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML25 = REPLACE(SUBSTRING( SICCodes, (24*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML26 = REPLACE(SUBSTRING( SICCodes, (25*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML27 = REPLACE(SUBSTRING( SICCodes, (26*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML28 = REPLACE(SUBSTRING( SICCodes, (27*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML29 = REPLACE(SUBSTRING( SICCodes, (28*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML30 = REPLACE(SUBSTRING( SICCodes, (29*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML31 = REPLACE(SUBSTRING( SICCodes, (30*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML32 = REPLACE(SUBSTRING( SICCodes, (31*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML33 = REPLACE(SUBSTRING( SICCodes, (32*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML34 = REPLACE(SUBSTRING( SICCodes, (33*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML35 = REPLACE(SUBSTRING( SICCodes, (34*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML36 = REPLACE(SUBSTRING( SICCodes, (35*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML37 = REPLACE(SUBSTRING( SICCodes, (36*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML38 = REPLACE(SUBSTRING( SICCodes, (37*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML39 = REPLACE(SUBSTRING( SICCodes, (38*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML40 = REPLACE(SUBSTRING( SICCodes, (39*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML41 = REPLACE(SUBSTRING( SICCodes, (40*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML42 = REPLACE(SUBSTRING( SICCodes, (41*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML43 = REPLACE(SUBSTRING( SICCodes, (42*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML44 = REPLACE(SUBSTRING( SICCodes, (43*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML45 = REPLACE(SUBSTRING( SICCodes, (44*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML46 = REPLACE(SUBSTRING( SICCodes, (45*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML47 = REPLACE(SUBSTRING( SICCodes, (46*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML48 = REPLACE(SUBSTRING( SICCodes, (47*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML49 = REPLACE(SUBSTRING( SICCodes, (48*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML50 = REPLACE(SUBSTRING( SICCodes, (49*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML51 = REPLACE(SUBSTRING( SICCodes, (50*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML52 = REPLACE(SUBSTRING( SICCodes, (51*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML53 = REPLACE(SUBSTRING( SICCodes, (52*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML54 = REPLACE(SUBSTRING( SICCodes, (53*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML55 = REPLACE(SUBSTRING( SICCodes, (54*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML56 = REPLACE(SUBSTRING( SICCodes, (55*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML57 = REPLACE(SUBSTRING( SICCodes, (56*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML58 = REPLACE(SUBSTRING( SICCodes, (57*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML59 = REPLACE(SUBSTRING( SICCodes, (58*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) ),
	@XML60 = REPLACE(SUBSTRING( SICCodes, (59*7500) + 1, 7500 ), CHAR(39), CHAR(39)+CHAR(39) )
FROM	sictemplate 
WHERE 	[id] = @TemplateId;
EXEC(
'DECLARE @Handle int
EXEC sp_xml_preparedocument @Handle OUT, ''' + @XML1 + @XML2 + @XML3 + @XML4 + @XML5 + @XML6 + @XML7 + @XML8+ @XML9 + @XML10 + 
	@XML11 + @XML12 + @XML13 + @XML14 + @XML15 + @XML16 + @XML17 + @XML18+ @XML19 + @XML20 + 
	 @XML21 + @XML22 + @XML23 + @XML24 + @XML25 + @XML26 + @XML27 + @XML28+ @XML29 + @XML30 +
	 @XML31 + @XML32 + @XML33 + @XML34 + @XML35 + @XML36 + @XML37 + @XML38+ @XML39 + @XML40 + 
	 @XML41 + @XML42 + @XML43 + @XML44 + @XML45 + @XML46 + @XML47 + @XML48+ @XML49 + @XML50 +
	 @XML51 + @XML52 + @XML53 + @XML54 + @XML55 + @XML56 + @XML57 + @XML58+ @XML59 + @XML60 + ''' 
DECLARE i_XMLCursor CURSOR FOR SELECT @Handle'
)
DECLARE @i_XMLHandle int
OPEN i_XMLCursor
FETCH i_XMLCursor into @i_XMLHandle
DEALLOCATE i_XMLCursor
IF @i_XMLHandle IS NULL
RAISERROR( 'Invalid Handle!', 16, 1 )
-- now you can just refer to the XMLObject just like you would normally
SELECT  Code, Contact.dbo.SICCodes.SICName
FROM    (OPENXML (@i_XMLHandle, '/SICCodes/SICCode', 1)
        WITH (Code  char(6), [order] int '@mp:id') 
	inner join Contact.dbo.SICCodes on
		Contact.dbo.SICCodes.SIC = Code)
ORDER BY [order];
EXEC sp_xml_removedocument @i_XMLHandle;
set NoCount OFF


GO
