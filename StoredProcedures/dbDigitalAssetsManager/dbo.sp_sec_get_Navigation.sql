/****** Object:  StoredProcedure [dbo].[sp_sec_get_Navigation]    Script Date: 5/15/2018 12:09:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[sp_sec_get_Navigation]
	@node_id numeric
	AS
/*
declare	@node_id numeric
set	@node_id = 6
*/
--[ Temp Table Creation ]--------------------------------------------------------------
	CREATE TABLE #Nodes	(	id Numeric(7,0),
						type int,
						name varchar(256),
						access int,
						inherited_level int
					)
--	delete from #Nodes
--[ Temp Table Population ]--------------------------------------------------------------
			Insert into #Nodes
			Select 	RoleID,1,Name,access, 1 from dbo.fn_sec_get_Roles( @node_id, 5 ) 
					where access > 0
			Insert into #Nodes
			Select 	ModuleID,2,Name,access, 2  from dbo.fn_sec_get_Modules( @node_id, 5 ) 
					where access > 0
			Insert into #Nodes
			Select 	PageID,3,Name,access, 3  from dbo.fn_sec_get_Pages( @node_id, 5 )
					where access > 0
--[ Temp Table Population ]--------------------------------------------------------------
	DECLARE @id Numeric(7,0)
	DECLARE cursor_1 CURSOR FOR 
		SELECT id 
		FROM 	#Nodes
		where type=1 
	OPEN cursor_1 FETCH NEXT FROM cursor_1 INTO @id
	WHILE @@FETCH_STATUS = 0
	BEGIN
		insert into 	#Nodes 					-- Get Role's Modules
			select 	ModuleID,2,Name,access, 2
			from 		fn_sec_get_Modules( @id , 1 )
					where access > 0
 
--		insert into 	#Nodes 					-- Get Role's Pages
	--		select 	PageID,3,Name,access, 2
		--	from 		fn_sec_get_Pages( @id , 1 )
		FETCH NEXT FROM cursor_1 INTO @id
	END
	CLOSE cursor_1
	DEALLOCATE cursor_1
--------------------------------------------------------------------------------------
	DECLARE cursor_2 CURSOR FOR 
		SELECT id 
		FROM 	#Nodes
		where type=2
	OPEN cursor_2 FETCH NEXT FROM cursor_2 INTO @id
	WHILE @@FETCH_STATUS = 0
	BEGIN
		insert into 	#Nodes 					-- Get Module's Pages
			select 	PageID,3,Name,access,3
			from 		fn_sec_get_Pages( @id , 2 ) 
					where access > 0
		FETCH NEXT FROM cursor_2 INTO @id
	END
	CLOSE cursor_2
	DEALLOCATE cursor_2
--------------------------------------------------------------------------------------
	
	SELECT 	distinct
			N.* , 
			URL, 
			Parameters,
			case when exists	(	
							select 	top 1 	navid 
							from 		SEC_NAVIGATION N2 
							where 	N2.parentnavid = N.NavID
						) 
				then 1 
				else 0 
			end as Parent  
			 into #almost_there
	FROM 		SEC_NAVIGATION N 
	left join 	SEC_PAGES P 	on P.pageid = N.pageid 
	left join	#Nodes on P.pageid = #Nodes.id
	where		#Nodes.type = 3
	and		#Nodes.access > 0
	and		#Nodes.access < 16
	
-- Now we've got to add the parent directories of the child pages ... ghetto code! ghetto code!!!
	insert into #almost_there
	select 	* , 
		'',
		'',
		1 as Parent
	 from SEC_NAVIGATION 
	where navid in (select parentNavID from #almost_there)
	and navid not in (select NavId from #almost_there) 
				
	select distinct * from  #almost_there
	ORDER BY 	ListOrder

	drop table #nodes
GO
