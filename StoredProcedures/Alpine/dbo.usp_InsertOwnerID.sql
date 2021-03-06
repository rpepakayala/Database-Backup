/****** Object:  StoredProcedure [dbo].[usp_InsertOwnerID]    Script Date: 5/15/2018 12:09:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE  PROC [dbo].[usp_InsertOwnerID] ( -- Add the parameters for the function here
                                        @OwnerName VARCHAR(50) )
AS 
    BEGIN
        DECLARE @temptable TABLE ( ReturnINT INT )
        DECLARE
            @AlpineStoreID INT ,
            @AlpinePersonID INT ,
            @LName VARCHAR(50) ,
            @FName VARCHAR(50) ,
            @Name VARCHAR(50) ,
            @Owner1ID VARCHAR(50)
        SET @Name = REPLACE(@OwnerName,'/',' ')
        SELECT
            @FName = CASE WHEN NOT ( @Name = ''
                                     OR @Name LIKE '%Director%'
                                     OR @Name LIKE '%Training%'
                                     OR @Name LIKE '%FBC%'
                                     OR @Name LIKE '%TBD%'
                                   )
                          THEN SUBSTRING(ISNULL(@Name, ''), 1,
                                         CHARINDEX(' ', ISNULL(@Name, '')) - 1)
                          ELSE 'TBD'
                     END ,
            @LName = CASE WHEN NOT ( @Name = ''
                                     OR @Name LIKE '%Director%'
                                     OR @Name LIKE '%Training%'
                                     OR @Name LIKE '%FBC%'
                                     OR @Name LIKE '%TBD%'
                                   )
                          THEN SUBSTRING(ISNULL(@Name, ''),
                                         CHARINDEX(' ', ISNULL(@Name, '')) + 1,
                                         LEN(ISNULL(@Name, '')))
                          ELSE 'TBD'
                     END 
    -- Add new preson as needed
        SELECT
            @AlpinePersonID = PersonID
        FROM
            COR_PERSONS
        WHERE
            FirstName = @FName
            AND LastName = @LName
        IF @AlpinePersonID IS NULL 
            BEGIN
                INSERT  INTO dbo.COR_PERSONS
                        ( FirstName ,
                          LastName ,
                          PersonType ,
                          AuditID 
                        )
                OUTPUT  INSERTED.PersonID
                        INTO @temptable
                VALUES
                        ( @FName ,
                          @LName ,
                          2001 ,
                          0
                        ) 
                SELECT
                    @AlpinePersonID = ReturnINT
                FROM
                    @temptable
            END  
	
        RETURN @AlpinePersonID

    END



GO
