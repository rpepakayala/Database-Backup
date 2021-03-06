/****** Object:  UserDefinedFunction [dbo].[fn_sec_get_Access]    Script Date: 5/15/2018 12:14:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE function [dbo].[fn_sec_get_Access] (@Id int, @Type int, @Level int)
		returns @collaborator table 
		(	RelationshipId int,
			NodeId int,
			NodeType int,
			Access int,
			Level int,
			Done tinyint
		) as
		BEGIN
			insert 	@collaborator
			select	RelationshipId, childid, childtype, accesscode, @Level, case when accesscode = 16 then 1 else 0 end
			from		SEC_RELATIONSHIPS
			where		parentid = @Id
			and		parenttype = @Type
	
			RETURN
		END 




GO
