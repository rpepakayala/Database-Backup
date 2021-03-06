/****** Object:  UserDefinedFunction [dbo].[f_BuildQueryNodeTree]    Script Date: 5/15/2018 12:15:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION f_BuildQueryNodeTree (
		@ParentID int,
		@ParentClassTypeID int,
		@StartingDepth int,
		@LevelsDeep int,
		@SortIndexRoot VarChar(200)
)

RETURNS @results TABLE (ID int, ClassTypeID int, Depth int, SortIndex VarChar(200), ParentID int, ParentClassTypeID int)
AS
BEGIN
	IF @LevelsDeep <= 0 RETURN;    

	declare @nextID int;
    declare @prevID int;
    declare @nextclasstypeid int;
    declare @nextsortindex VarChar(200);
	-- Declare results table for the child
	declare @childresults TABLE (ID int, ClassTypeID int, Depth int, SortIndex VarChar(200), ParentID int, ParentClassTypeID int);
    
	-- Increment Starting Depth
	set @StartingDepth = @StartingDepth + 1;
	-- Decrease Levels Deep
	set @LevelsDeep = @LevelsDeep - 1;

	-- Now find all AdvQueryNodes that have those parents
	insert into @results
	select ID, ClassTypeID, @StartingDepth, @SortIndexRoot + Cast(ID as VarChar(8)) + '_', @ParentID, @ParentClassTypeID
		from AdvQueryNode
		where ParentID = @ParentID and ParentClassTypeID = @ParentClassTypeID;

	-- Now iterate over the table and call it for each row
    

--	select @nextID = min(id) from @results;
--
--	while  @nextID is not null
--	begin
--        set @prevID = @nextID;
--        select @nextclasstypeid=ClassTypeID from @results where id=@nextID;
--
--		insert into @childresults
--		select * from f_BuildQueryNodeTree( @nextID, @nextclasstypeid, @StartingDepth );
--
--		select @nextID = min(id) from @results where id>@prevID;
--	end

	DECLARE Child_Cursor CURSOR FORWARD_ONLY
	  FOR SELECT ID, ClassTypeID, SortIndex FROM @results

	OPEN Child_Cursor

	FETCH NEXT FROM Child_Cursor
	INTO @nextid, @nextclasstypeid, @nextsortindex

	WHILE @@FETCH_STATUS = 0
	BEGIN
		insert into @childresults
		select * from f_BuildQueryNodeTree( @nextID, @nextclasstypeid, @StartingDepth, @LevelsDeep, @nextsortindex );

		FETCH NEXT FROM Child_Cursor
		INTO @nextid, @nextclasstypeid, @nextsortindex
	END

	CLOSE Child_Cursor

	DEALLOCATE Child_Cursor

	-- Now combine the results
	insert into @results
	select * from @childresults;

	return;	
END

GO
