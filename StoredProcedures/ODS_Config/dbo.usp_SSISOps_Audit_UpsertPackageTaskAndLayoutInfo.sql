/****** Object:  StoredProcedure [dbo].[usp_SSISOps_Audit_UpsertPackageTaskAndLayoutInfo]    Script Date: 5/15/2018 12:11:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
    Source : Pragmatic Works - BI xPress Auditing Framework 47
    Created On : 6/13/2013
    Purpose : - Updates or inserts package control flow and / or data flow layout information into the [SSISPackageLayout] table and the [SSISPackageExecutionLog] table.
*/

CREATE PROCEDURE [dbo].[usp_SSISOps_Audit_UpsertPackageTaskAndLayoutInfo]
(
    @PackageExecutionLogId INT,
    @LayoutId INT,
    @ExecutionId VARCHAR(50),
    @PackageName NVARCHAR(255),
    @TaskListXml NVARCHAR(MAX),
    @LayoutXml NVARCHAR(MAX),
    @DFLayoutXml NVARCHAR(MAX)
)
AS
BEGIN
    SET NOCOUNT ON

    SELECT @LayoutId = MAX([LayoutID])
    FROM [SSISPackageLayout]
    WHERE [PackageID] = @ExecutionId
        AND [PackageName] = @PackageName
        AND DATALENGTH(@LayoutXml) = DATALENGTH([LayoutXML])
        AND DATALENGTH(@DFLayoutXml) = DATALENGTH([DFLayoutXML])

    DECLARE @CurrentDate As DATETIME
    
    SET @CurrentDate = GETDATE()

    IF @LayoutId IS NOT NULL
    BEGIN
        -- Layout might be changed but no new Task added / removed
        UPDATE [SSISPackageLayout]
        SET [LayoutXML] = @LayoutXml, [DFLayoutXML] = @DFLayoutXml, [TasklistXML] = @TaskListXml, [LastUpdatedOn] = @CurrentDate
        WHERE [LayoutID] = @LayoutId
    END
    ELSE
    BEGIN
        INSERT INTO [SSISPackageLayout] ([PackageID], [PackageName], [LayoutXML], [DFLayoutXML], [TasklistXML], [CreatedOn])
        VALUES(@ExecutionId, @PackageName, @LayoutXml, @DFLayoutXml, @TaskListXml, @CurrentDate)
        SET @LayoutId = @@IDENTITY
    END

    IF @LayoutId IS NOT NULL
    BEGIN
        DECLARE @CurrentPackageExecutionLogLayoutId AS INT

        SELECT @CurrentPackageExecutionLogLayoutId = p.[LayoutID]
        FROM [SSISPackageExecutionLog] p
        WHERE p.[LogID] = @PackageExecutionLogId

        IF (@CurrentPackageExecutionLogLayoutId IS NULL) OR (@CurrentPackageExecutionLogLayoutId <> @LayoutId)
        BEGIN
            UPDATE [SSISPackageExecutionLog]
            SET [LayoutID] = @LayoutId
            WHERE [LogID] = @PackageExecutionLogId
        END
    END

    SELECT @LayoutId

    SET NOCOUNT OFF
END

GO
