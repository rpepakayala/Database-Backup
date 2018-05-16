/****** Object:  StoredProcedure [dbo].[el_UpdateResource]    Script Date: 5/15/2018 12:13:19 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON

CREATE PROCEDURE el_UpdateResource 
(   @URL varchar(100),
    @Description varchar(100),
    @ID int   )

AS

UPDATE Resources
SET URL = @URL,
Description = @Description
WHERE ID = @ID

GO
