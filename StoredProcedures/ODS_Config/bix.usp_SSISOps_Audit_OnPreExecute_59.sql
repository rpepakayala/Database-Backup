/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_OnPreExecute_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
Source : Pragmatic Works - BI xPress Auditing Framework 59
Created On : 2/19/2016
Purpose : 
    - Called from OnPreExecute Event Handler.
    - Logs Start Time for Package/Task.
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Audit_OnPreExecute_59]
    @Scope VARCHAR(10), -- Package or Task
    @ExecutionID VARCHAR(50),
    @SourceID VARCHAR(50), -- TaskID or PackageID
    @SourceName NVARCHAR(255), -- TaskName or PackageName
    @SourceType VARCHAR(255) = NULL,
    @ParentSourceID VARCHAR(50) = NULL,
    @InteractiveMode BIT = NULL,
    @UserName NVARCHAR(255) = NULL,
    @MachineName NVARCHAR(255) = NULL,
    @LogCustomValues BIT = NULL,
    @CustomValue_Num_1 NVARCHAR(255) = NULL,
    @CustomValue_Num_2 NVARCHAR(255) = NULL,
    @CustomValue_Num_3 NVARCHAR(255) = NULL,
    @CustomValue_Dt_1 DATETIME = NULL,
    @CustomValue_Dt_2 DATETIME = NULL,
    @CustomValue_Dt_3 DATETIME = NULL,
    @CustomValue_Str_1 NVARCHAR(255) = NULL,
    @CustomValue_Str_2 NVARCHAR(255) = NULL,
    @CustomValue_Str_3 NVARCHAR(255) = NULL,
    @LayoutXML NVARCHAR(MAX) = NULL,
    @TaskListXML NVARCHAR(MAX) = NULL,
    @DFLayoutXML NVARCHAR(MAX) = NULL,
    @Variables NVARCHAR(MAX) = NULL,
    @Connections NVARCHAR(MAX) = NULL,
    @GroupNames NVARCHAR(MAX) = NULL
AS
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED	
    
    IF @CustomValue_Dt_1 = ''
    BEGIN
        SET @CustomValue_Dt_1 = NULL
    END
    
    IF @CustomValue_Dt_2 = ''
    BEGIN
        SET @CustomValue_Dt_2 = NULL
    END
    
    IF @CustomValue_Dt_3 = ''
    BEGIN
        SET @CustomValue_Dt_3 = NULL
    END

    IF @ParentSourceID = char(0)
    BEGIN
        SET @ParentSourceID = ''
    END
    
    IF @Scope = 'Package'
    BEGIN
        -- Insert or update package layout
        DECLARE @LayoutID INT
        
        SELECT @LayoutID = MAX([LayoutID])
        FROM [bix].[vw_SSISPackageLayout_59]
        WHERE [PackageID] = @SourceID AND
              [PackageName] = @SourceName AND
              DATALENGTH(@LayoutXML) = DATALENGTH([LayoutXML]) AND
              DATALENGTH(@DFLayoutXML) = DATALENGTH([DFLayoutXML])
        
        IF @LayoutID IS NOT NULL
        BEGIN
            -- Layout might be changed but no new task has been added or removed
            UPDATE [bix].[vw_SSISPackageLayout_59]
            SET [LayoutXML] = @LayoutXML, [DFLayoutXML] = @DFLayoutXML, [TasklistXML] = @TaskListXML, [LastUpdatedOn] = GETDATE()
            WHERE [LayoutID] = @LayoutID
        END
        ELSE
        BEGIN
            INSERT INTO [bix].[vw_SSISPackageLayout_59]([PackageID], [PackageName], [LayoutXML], [DFLayoutXML], [TasklistXML], [CreatedOn])
                VALUES(@SourceID, @SourceName, @LayoutXML, @DFLayoutXML, @TaskListXML, GETDATE())

            SET @LayoutID = @@IDENTITY
        END

        IF NOT EXISTS(SELECT 1 FROM [bix].[vw_SSISPackageExecutionLog_59] WHERE [ExecutionID] = @ExecutionID)
        BEGIN
            INSERT INTO [bix].[vw_SSISPackageExecutionLog_59](
                 [ExecutionID]
                ,[PackageID]
                ,[PackageName]
                ,[ExecutionStartDateTime]
                ,[InteractiveMode]
                ,[UserName]
                ,[MachineName]
                ,[TotalErrorCount]
                ,[TotalWarningCount]
                ,[TotalRecordsExtracted]
                ,[TotalRecordsLoaded]
                ,[CustomValue_Num_1]
                ,[CustomValue_Num_2]
                ,[CustomValue_Num_3]
                ,[CustomValue_Str_1]
                ,[CustomValue_Str_2]
                ,[CustomValue_Str_3]
                ,[CustomValue_Dt_1]
                ,[CustomValue_Dt_2]
                ,[CustomValue_Dt_3]
                ,[LayoutID]
                ,[Variables]
                ,[Connections]) 
                VALUES (
                 @ExecutionID
                ,@SourceID
                ,@SourceName
                ,getdate()
                ,@InteractiveMode
                ,@UserName
                ,@MachineName
                ,0
                ,0
                ,0
                ,0
                ,@CustomValue_Num_1
                ,@CustomValue_Num_2
                ,@CustomValue_Num_3
                ,@CustomValue_Str_1
                ,@CustomValue_Str_2
                ,@CustomValue_Str_3
                ,@CustomValue_Dt_1
                ,@CustomValue_Dt_2
                ,@CustomValue_Dt_3
                ,@LayoutID
                ,@Variables
                ,@Connections)
        END
        ELSE
        BEGIN
            UPDATE [bix].[vw_SSISPackageExecutionLog_59]
            SET MachineName = @MachineName
                ,UserName = @UserName
                ,InteractiveMode = @InteractiveMode
                ,CustomValue_Num_1 = @CustomValue_Num_1
                ,CustomValue_Num_2 = @CustomValue_Num_2
                ,CustomValue_Num_3 = @CustomValue_Num_3
                ,CustomValue_Str_1 = @CustomValue_Str_1
                ,CustomValue_Str_2 = @CustomValue_Str_2
                ,CustomValue_Str_3 = @CustomValue_Str_3
                ,CustomValue_Dt_1 = @CustomValue_Dt_1
                ,CustomValue_Dt_2 = @CustomValue_Dt_2
                ,CustomValue_Dt_3 = @CustomValue_Dt_3
            WHERE [ExecutionID] = @ExecutionID
        END

        -- Update Package Group Names
        SELECT LTRIM(RTRIM(f.[Value])) As [GroupName]
        INTO #GroupNamesTbl
        FROM [dbo].[fn_ParseStringList](@GroupNames, ',') f
        WHERE ISNULL(f.[Value], '') != ''
        
        -- Insert ONLY new group names, case insensitive
        INSERT INTO [bix].[vw_GroupNames_59] ([Name])
            SELECT gnt.[GroupName]
            FROM #GroupNamesTbl gnt
            LEFT OUTER JOIN [dbo].[GroupNames] gns ON gns.[Name] = gnt.[GroupName] COLLATE Latin1_General_CI_AS
            WHERE gns.[GroupID] IS NULL

        -- Insert into the package group names table only if the group name/package ID doesn't exist.
        INSERT INTO [bix].[vw_SSISPackageGroupNames_59] ([PackageName], [GroupID])
            SELECT @SourceName AS [PackageName], gns.[GroupID]
            FROM [bix].[vw_GroupNames_59] gns
            JOIN #GroupNamesTbl gnt ON gnt.[GroupName] = gns.[Name] COLLATE Latin1_General_CI_AS
            LEFT OUTER JOIN [bix].[vw_SSISPackageGroupNames_59] loj ON loj.[GroupID] = gns.[GroupID] AND loj.[PackageName] = @SourceName COLLATE Latin1_General_CI_AS
            WHERE loj.[LogID] IS NULL

        DROP TABLE #GroupNamesTbl
    END
        
    IF @Scope = 'Task'
    BEGIN
        INSERT INTO [bix].[vw_SSISTaskExecutionLog_59](
         [ExecutionID]
        ,[SourceID]
        ,[ParentSourceID]
        ,[SourceName]
        ,[SourceType]
        ,[ExecutionStartDateTime]
        ,[TotalErrorCount]
        ,[TotalWarningCount]
        ,[TotalRecordsExtracted]
        ,[TotalRecordsLoaded]
        ,[CustomValue_Num_1]
        ,[CustomValue_Num_2]
        ,[CustomValue_Num_3]
        ,[CustomValue_Str_1]
        ,[CustomValue_Str_2]
        ,[CustomValue_Str_3]
        ,[CustomValue_Dt_1]
        ,[CustomValue_Dt_2]
        ,[CustomValue_Dt_3]) 
        VALUES (
         @ExecutionID
        ,@SourceID
        ,@ParentSourceID
        ,@SourceName
        ,@SourceType
        ,GETDATE()
        ,0
        ,0
        ,0
        ,0
        ,@CustomValue_Num_1
        ,@CustomValue_Num_2
        ,@CustomValue_Num_3
        ,@CustomValue_Str_1
        ,@CustomValue_Str_2
        ,@CustomValue_Str_3
        ,@CustomValue_Dt_1
        ,@CustomValue_Dt_2
        ,@CustomValue_Dt_3)
    END
        
    /* Custom Code Execution */
    EXEC [dbo].[usp_SSISOps_Audit_OnPreExecute_CustomCode] @Scope, @ExecutionID, @SourceID, @SourceName, @SourceType, @ParentSourceID, @InteractiveMode, @UserName, @MachineName, @LogCustomValues, @CustomValue_Num_1, @CustomValue_Num_2, @CustomValue_Num_3, @CustomValue_Dt_1, @CustomValue_Dt_2, @CustomValue_Dt_3, @CustomValue_Str_1, @CustomValue_Str_2, @CustomValue_Str_3
END

GO
