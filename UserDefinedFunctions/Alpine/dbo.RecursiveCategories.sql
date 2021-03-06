/****** Object:  UserDefinedFunction [dbo].[RecursiveCategories]    Script Date: 5/15/2018 12:14:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION [dbo].[RecursiveCategories] 
(@Desc varchar(100), @CatID int, @ParentCat int, @breadcrumb varchar(200), @ParentIDs varchar(100))
returns varchar(1000)
AS  
BEGIN 
	DECLARE @Description varchar(100)
	DECLARE @CategoryID int
	DECLARE @ParentCategory int
	DECLARE @breadcrumbtmp varchar(200)
	DECLARE @ParentIDstmp varchar(100)
	DECLARE @rtn varchar(1000)
	IF @ParentCat is not null
		BEGIN
			SELECT @Description= RTRIM(Description), @CategoryID=[ID], @ParentCategory=[ParentID] FROM VendorCategories (NOLOCK) WHERE ID = @ParentCat
			IF (@breadcrumb = '' AND @ParentIDs = '')
			BEGIN
				SET @breadcrumbtmp = RTRIM((select rtrim(@Desc)))
				SET @ParentIDstmp = RTRIM((select Convert(varchar(10),@CatID)))
			END
			ELSE
			BEGIN
				SET @breadcrumbtmp = rtrim((select rtrim(@Desc) + '>' + rtrim(@breadcrumb)))
				SET @ParentIDstmp = rtrim((select Convert(varchar(10),@CatID) + '+' + @ParentIDs))
			END

			SELECT @rtn = dbo.RecursiveCategories(@Description, @CategoryID, @ParentCategory, @breadcrumbtmp, @ParentIDstmp)
		END
	ELSE
		BEGIN
			select @rtn = rtrim(@Desc) + '>' + rtrim(@breadcrumb) + '|' + Convert(varchar(10),@CatID) + '+' + rtrim(@ParentIDs)
		END
			return (@rtn)
END

--remove Ext. from phone number
--Update dbo.VendorVendors set phone = REPLACE(phone, 'Ext.', '') where phone like '%Ext. %'
--Update dbo.VendorVendors set tollfreephone = REPLACE(tollfreephone, 'Ext.', '') where tollfreephone like '%Ext. %'

GO
