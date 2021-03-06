/****** Object:  StoredProcedure [dbo].[zw_collection_nodes_upsert]    Script Date: 5/15/2018 12:09:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE procedure zw_collection_nodes_upsert
(
@concept_id char(3),
@node_id varchar(10),
@lastcollected_clienttime datetime = NULL,
@lastcollected_servertime datetime = NULL
)
as

SET NOCOUNT ON

DECLARE @existing_count int

SELECT @existing_count = count(1)
FROM [collection_nodes]
WHERE [concept_id] = @concept_id
AND [node_id] = @node_id

IF( @existing_count = 0 )
BEGIN
	
	INSERT INTO [collection_nodes] ( [concept_id], [node_id], [lastcollected_clienttime], [lastcollected_servertime] )
	VALUES( @concept_id, @node_id, @lastcollected_clienttime, @lastcollected_servertime )

END

ELSE IF( @lastcollected_clienttime IS NOT NULL )
BEGIN
	UPDATE [collection_nodes]
	SET
		[lastcollected_clienttime] = @lastcollected_clienttime,
		[lastcollected_servertime] = @lastcollected_servertime
	WHERE 
		[concept_id] = @concept_id
	AND 
		[node_id] = @node_id
END
GO
