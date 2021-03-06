/****** Object:  StoredProcedure [dbo].[fsi_storenumbers_list]    Script Date: 5/15/2018 12:09:43 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER OFF
CREATE  PROCEDURE [dbo].[fsi_storenumbers_list] (
@list_franchise_ids varchar(8000),
@list_storenumbers varchar(8000) OUTPUT
)
AS
SET NOCOUNT ON
DECLARE @current_row varchar(150)
SET @list_storenumbers = ''
DECLARE cur_Results CURSOR LOCAL FOR
SELECT name_organization 
FROM zg_Franchise 
WHERE CHARINDEX( franchise_id, @list_franchise_ids ) > 0
OPEN cur_Results
FETCH NEXT FROM cur_Results into @current_row
SET @list_storenumbers = @current_row
FETCH NEXT FROM cur_Results into @current_row
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @list_storenumbers = @list_storenumbers + ', ' + @current_row 
	FETCH NEXT FROM cur_Results into @current_row
END
CLOSE cur_Results
DEALLOCATE cur_Results

GO
