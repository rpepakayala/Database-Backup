/****** Object:  StoredProcedure [dbo].[sub_SubsidySearch]    Script Date: 5/15/2018 12:10:28 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF




CREATE PROCEDURE sub_SubsidySearch
(
	@SubHMrktCountry int,
	@SubLYear int,
	@WebNumber int
)
AS
DECLARE @str nvarchar(1500)
SELECT @str = 'SELECT Distinct SD.SubDID, SL.SubLStoreID, SL.SubLYear, SL.SubLID, SL.SubLType, SL.SubLHType, SL.SubLDType, SL.SubLDesc AS SubsidyDesc, '--dbo.fn_SubsidyDesc(SL.SubLDesc) AS SubsidyDesc
SELECT @str = @str + 'SL.SubLAmount, SL.SubLDate, SL.InvoiceAmount, SL.SubsidyQualifierID, SL.UsageDateFrom, SL.UsageDateTo, '
SELECT @str = @str + 'SH.SubHMrktCountry '
SELECT @str = @str + 'FROM SubsidyLog SL INNER JOIN SubsidyHdr SH ON SH.SubHID = SL.SubLHID INNER JOIN SubsidyDtl SD ON SD.SubHID = SH.SubHID AND SD.SubDCalanderYear = SL.SubLYear WHERE '
SELECT @str = @str + 'SL.SubLAmount > 0 AND SL.SubLYear = ' + cast(@SubLYear as varchar) 
IF (@SubHMrktCountry  <> 0)
	BEGIN
		SELECT @str =@str +  '  AND SH.SubHMrktCountry = ' + cast(@SubHMrktCountry as varchar) + '  '
	END
IF (@WebNumber <> 0)
	BEGIN
		SELECT @str = @str + 'AND SL.SubLStoreID=' + cast(@WebNumber as varchar)
	END
SELECT @str = @str + ' ORDER BY SL.SubLDate Desc;'
EXECUTE sp_ExecuteSql @str;



GO
