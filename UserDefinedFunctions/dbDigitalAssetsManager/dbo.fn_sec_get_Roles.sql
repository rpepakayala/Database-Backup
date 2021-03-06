/****** Object:  UserDefinedFunction [dbo].[fn_sec_get_Roles]    Script Date: 5/15/2018 12:14:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE   Function [dbo].[fn_sec_get_Roles]
(	@ObjectID int,
	@ObjectTYPE int
)
RETURNS TABLE AS 
RETURN(	
	select 		roleid, 
				name,
				max(	case when childtype=1 and parenttype=@ObjectTYPE and parentid = @ObjectID
						then accesscode
						else 0
					end
				) as access
	from 		SEC_Roles 	left join  SEC_relationships 
					on 		childid=roleid 
	group by			roleid,name
	)



GO
