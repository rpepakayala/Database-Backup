/****** Object:  StoredProcedure [dbo].[NewDocsLastMonth]    Script Date: 5/15/2018 12:09:51 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE NewDocsLastMonth 
AS
BEGIN

	select 
		vcLocation as 'Document Name', 
		CONVERT(varchar(10),dtmDateModified,101) as 'Date Modified', 
		CONVERT(varchar(10),dtmDateCreated,101) as 'Date Created', 
		nDocID as 'Doc ID'
	from tblAssets
	where bactive = 1 and dtmDateModified between dateadd(m,-1,GETDATE()) and GETDATE()

END

GO
