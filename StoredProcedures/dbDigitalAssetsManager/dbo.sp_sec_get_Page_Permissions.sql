/****** Object:  StoredProcedure [dbo].[sp_sec_get_Page_Permissions]    Script Date: 5/15/2018 12:09:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE  PROCEDURE [dbo].[sp_sec_get_Page_Permissions]
	@node_id numeric,
	@node_type numeric,
	@mode numeric
	AS	
	/*	Mode determines ONLY the output type
		MODE=1 : Returns minimal data - URL, Parameters, Access, and Background image
		MODE=2 : Returns above data as well as MaxAccess, Node Id's, and Navigation Name
	*/
	
	select 	* 
	into 		#dump  
	from 		dbo.fn_sec_get_Access( @node_id , @node_type , 0 ) 
	
	DECLARE	@NodeId int, @NodeType int, @Access int, @Level int, @e tinyint, @numrows int
	
	select @numrows = count(*) from #dump where Done=0
	while @numrows > 0 
	BEGIN
		select top 1 @NodeId= NodeId, @NodeType= NodeType, @Access= Access, @Level= Level from #dump where Done=0
		update #dump set Done=1 where NodeId=@NodeId and NodeType=@NodeType and Level=@Level and Done=0
		set @Level = @Level + 1
		insert 
		into 		#dump 
		select 	* 
		from 		fn_sec_get_Access(@NodeId,@NodeType,@Level) NewNodes
		where 	not exists ( 	select 	* 						-- This only inserts the node
							from 		#dump 					--   if it is not already in the table
							where 	NodeId=NewNodes.NodeId 
							and 		NodeType=NewNodes.NodeType 
							and		(		Access=NewNodes.Access	-- This allows the node to be added but
										or	Level<NewNodes.Level	-- 	only if it is in the same level
									)
						)
		select @numrows = count(*) from #dump where Done=0
		print @numrows 
	END
/*****************************************************************************************/	
if @mode = 1
	BEGIN
		select 	max(Access) Access,
				URL,
				isnull(Parameters,''),
				Background,
				BackgroundStyle
		from 		#dump 
		join		SEC_Pages	
		on		NodeId = PageID
		where 	nodetype = 3 
		group by 	NodeId, URL, isnull(Parameters,''), Background, BackgroundStyle
		order by	URL , isnull(Parameters,'')
	END
if @mode = 2
	BEGIN
		select 	NodeID,
				RelationshipId,
				isnull(Text,''),
				URL + ' ' + isnull(Parameters,''),
				max(Access) Access,
				AccessCode  MaxAccess
		from 		#dump 
		join		SEC_Pages	
		on		NodeId = PageID
		left join 	SEC_Navigation 
		on SEC_pages.pageid = SEC_Navigation.pageid 
		where 	nodetype = 3 
		group by 	NodeId, RelationshipId, URL + ' ' + isnull(Parameters,''), Text, AccessCode
		order by	URL + ' ' + isnull(Parameters,'')
	END
 
/*****************************************************************************************/	
--	select * from #dump where nodetype = 3 order by nodeid
/*****************************************************************************************/	
	drop table #dump
GO
