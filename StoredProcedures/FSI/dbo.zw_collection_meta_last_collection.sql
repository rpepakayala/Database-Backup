/****** Object:  StoredProcedure [dbo].[zw_collection_meta_last_collection]    Script Date: 5/15/2018 12:09:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[zw_collection_meta_last_collection]
(
@zw_franchise_id char(7),
@table_name varchar(200) = NULL,
@record_action char(1) = NULL
)
AS


BEGIN TRY
	UPDATE [_zw_collection_meta] 
	SET last_collection = getdate()
	WHERE zw_franchise_id = @zw_franchise_id
	AND table_name = @table_name

	IF(@@ROWCOUNT =0)
	BEGIN
		INSERT INTO [_zw_collection_meta] ( zw_franchise_id, table_name, last_collection )
		VALUES ( @zw_franchise_id, @table_name, getdate() )
	END
END TRY

BEGIN CATCH
	PRINT 'Unable to track collection action.'
END CATCH




GO
