/****** Object:  StoredProcedure [dbo].[sp_sec_Save_Access]    Script Date: 5/15/2018 12:09:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
create PRocedure [dbo].[sp_sec_Save_Access]
	@ParentID numeric,
	@ParentType numeric,
	@ChildID numeric,
	@ChildType numeric,
	@AccessCode numeric
AS
if @AccessCode = 0
	BEGIN
		DELETE from	sec_relationships
		WHERE		ParentID	=	@ParentID
		AND		ParentType	=	@ParentType 
		AND		ChildID 	=	@ChildID 
		AND		ChildType 	=	@ChildType
	select 1
	END
else
	BEGIN
		if exists( 		SELECT	* 
					FROM		sec_relationships
					WHERE		ParentID	=	@ParentID
					AND		ParentType	=	@ParentType 
					AND		ChildID 	=	@ChildID 
					AND		ChildType 	=	@ChildType
				)
			
			BEGIN	
						UPDATE	sec_relationships
						SET		AccessCode  = 	@AccessCode
						WHERE		ParentID	=	@ParentID
						AND		ParentType	=	@ParentType 
						AND		ChildID 	=	@ChildID 
						AND		ChildType 	=	@ChildType
			END
		else
			BEGIN			
					INSERT into	sec_relationships
					(  ParentID,  ParentType,  ChildID,  ChildType,  AccessCode) VALUES
					( @ParentID, @ParentType, @ChildID, @ChildType, @AccessCode)
	
			END
	SELECT @@rowcount
	END


GO
