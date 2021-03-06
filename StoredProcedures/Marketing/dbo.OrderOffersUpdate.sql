/****** Object:  StoredProcedure [dbo].[OrderOffersUpdate]    Script Date: 5/15/2018 12:10:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE dbo.OrderOffersUpdate
(
	@OrdOStoreId int = NULL,
	@OrdOStoreIdFlag bit = NULL,
	@OrdHid int = NULL,
	@OrdPSId int = NULL,
	@OrdOffId int = NULL,
	@PrdDPrdId int = NULL,
	@PrdDPrdIdFlag bit = NULL,
	@OrdOffType tinyint = NULL,
	@OrdOffTypeFlag bit = NULL,
	@OrdOffImage varchar(50) = NULL,
	@OrdOffImageFlag bit = NULL
)
AS
DECLARE @SQL varchar(4000);
SET @SQL = ' ';
IF (@OrdOStoreIdFlag Is Not NULL)
BEGIN
	IF (@OrdOStoreId Is Not NULL)
		SET @SQL = @SQL + 'OrdOStoreId=' + convert(varchar,@OrdOStoreId) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdOStoreId=NULL, ';
END
IF (@PrdDPrdIdFlag Is Not NULL)
BEGIN
	IF (@PrdDPrdId Is Not NULL)
		SET @SQL = @SQL + 'PrdDPrdId=' + convert(varchar,@PrdDPrdId) + ', ';
	ELSE
		SET @SQL = @SQL + 'PrdDPrdId=NULL, ';
END
IF (@OrdOffTypeFlag Is Not NULL)
BEGIN
	IF (@OrdOffType Is Not NULL)
		SET @SQL = @SQL + 'OrdOffType=' + convert(varchar,@OrdOffType) + ', ';
	ELSE
		SET @SQL = @SQL + 'OrdOffType=NULL, ';
END
IF (@OrdOffImageFlag Is Not NULL)
BEGIN
	IF (@OrdOffImage Is Not NULL)
		SET @SQL = @SQL + 'OrdOffImage=''' + @OrdOffImage + ''', ';
	ELSE
		SET @SQL = @SQL + 'OrdOffImage=NULL, ';
END
IF (Len(@SQL) > 0)
BEGIN
	SET @SQL = 'UPDATE OrderOffers SET ' + Left(@SQL, Len(@SQL)-1) + ' Where OrdHid = ' + convert(varchar,@OrdHid) + ' AND OrdPSId = ' + convert(varchar,@OrdPSId) + ' AND OrdOffId = ' + convert(varchar,@OrdOffId) 
	EXEC(@SQL)
END
SET QUOTED_IDENTIFIER OFF 


GO
