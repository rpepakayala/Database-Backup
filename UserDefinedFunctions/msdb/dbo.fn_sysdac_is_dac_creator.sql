/****** Object:  UserDefinedFunction [dbo].[fn_sysdac_is_dac_creator]    Script Date: 5/15/2018 12:14:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION [dbo].[fn_sysdac_is_dac_creator]()
RETURNS int
BEGIN
    DECLARE @engineEdition int = CAST(SERVERPROPERTY('EngineEdition') AS int);
    DECLARE @isdaccreator int;

    -- Check the engine edition
    IF (@engineEdition = 5)
    BEGIN
        -- Sql Azure:
        --   is member of dbmanager or is superuser.

        SET @isdaccreator = COALESCE(IS_MEMBER('dbmanager'), 0) | 
            dbo.fn_sysdac_is_currentuser_sa()

    END ELSE
    BEGIN
        -- Standalone, default:
        --  is member of dbcreator

        /*
        We should only require CREATE ANY DATABASE but the database rename 
        step of creating a DAC requires that we have dbcreator.
    
        If that changes use the code below
    
        -- CREATE ANY DATABASE is what makes somebody a creator
        Set @isdaccreator = HAS_PERMS_BY_NAME(null, null, 'CREATE ANY DATABASE')
        */

        SET @isdaccreator = COALESCE(is_srvrolemember('dbcreator'), 0)
        
    END

    RETURN @isdaccreator;
END

GO
