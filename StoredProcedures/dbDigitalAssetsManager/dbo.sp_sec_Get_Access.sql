/****** Object:  StoredProcedure [dbo].[sp_sec_Get_Access]    Script Date: 5/15/2018 12:09:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE    PROCEDURE [dbo].[sp_sec_Get_Access]
	@node_id numeric,
	@node_type numeric,
	@return_type numeric
	AS
/*
declare	@node_id numeric
declare	@node_type numeric
declare	@return_type numeric
set	@node_id = 6
set	@node_type = 1
set	@return_type = 2
*/
--[ Temp Table Creation ]--------------------------------------------------------------
	CREATE TABLE #Nodes	(	id Numeric(7,0),
						type int,
						name varchar(256),
						access int,
						inherited int
					)
--	delete from #Nodes
--[ Temp Table Population ]--------------------------------------------------------------
			Insert into #Nodes
			Select 	RoleID,1,Name,access, case when @return_type=1 and access=0 then 99 else 0 end from dbo.fn_sec_get_Roles( @node_id, @node_type ) 
					where access > case when @return_type = 1 then -1 else 0 end
			Insert into #Nodes
			Select 	ModuleID,2,Name,access, case when @return_type=2 and access=0 then 99 else 0 end  from dbo.fn_sec_get_Modules( @node_id, @node_type ) 
					where access > case when @return_type = 2 then -1 else 0 end
			Insert into #Nodes
			Select 	PageID,3,Name,access, case when @return_type=3 and access=0 then 99 else 0 end  from dbo.fn_sec_get_Pages( @node_id, @node_type )
					where access > case when @return_type = 3 then -1 else 0 end
--[ Temp Table Population ]--------------------------------------------------------------
	DECLARE @id Numeric(7,0)
	DECLARE cursor_1 CURSOR FOR 
		SELECT id 
		FROM 	#Nodes
		where type=1 
		and access > 0
	OPEN cursor_1 FETCH NEXT FROM cursor_1 INTO @id
	WHILE @@FETCH_STATUS = 0
	BEGIN
		insert into 	#Nodes 					-- Get Role's Modules
			select 	ModuleID,2,Name,access, 1
			from 		fn_sec_get_Modules( @id , 1 ) 
--		insert into 	#Nodes 					-- Get Role's Pages
	--		select 	PageID,3,Name,access, 2
		--	from 		sm_fn_GetPages( @id , 1 )
		FETCH NEXT FROM cursor_1 INTO @id
	END
	CLOSE cursor_1
	DEALLOCATE cursor_1
--------------------------------------------------------------------------------------
	DECLARE cursor_2 CURSOR FOR 
		SELECT id 
		FROM 	#Nodes
		where type=2
		and access > 0
	OPEN cursor_2 FETCH NEXT FROM cursor_2 INTO @id
	WHILE @@FETCH_STATUS = 0
	BEGIN
		insert into 	#Nodes 					-- Get Module's Pages
			select 	PageID,3,Name,access,2
			from 		fn_sec_get_Pages( @id , 2 ) 
		FETCH NEXT FROM cursor_2 INTO @id
	END
	CLOSE cursor_2
	DEALLOCATE cursor_2
--------------------------------------------------------------------------------------
	select distinct id,name,max(access) as access, min(inherited) as inherited from #Nodes where type = @return_type group by id,name order by name
	drop table #nodes


GO
