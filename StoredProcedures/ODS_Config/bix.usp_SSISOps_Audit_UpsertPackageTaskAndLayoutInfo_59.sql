/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_UpsertPackageTaskAndLayoutInfo_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
    Source : Pragmatic Works - BI xPress Auditing Framework 59
    Created On : 2/19/2016
    Purpose : - Updates or inserts package control flow and / or data flow layout information into the [SSISPackageLayout] table and the [SSISPackageExecutionLog] table.
*/

CREATE PROCEDURE [bix].[usp_SSISOps_Audit_UpsertPackageTaskAndLayoutInfo_59]
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
    FROM [bix].[vw_SSISPackageLayout_59]
    WHERE [PackageID] = @ExecutionId
        AND [PackageName] = @PackageName
        AND DATALENGTH(@LayoutXml) = DATALENGTH([LayoutXML])
        AND DATALENGTH(@DFLayoutXml) = DATALENGTH([DFLayoutXML])

    DECLARE @CurrentDate As DATETIME
    
    SET @CurrentDate = GETDATE()

    IF @LayoutId IS NOT NULL
    BEGIN
        -- Layout might be changed but no new Task added / removed
        UPDATE [bix].[vw_SSISPackageLayout_59]
        SET [LayoutXML] = @LayoutXml, [DFLayoutXML] = @DFLayoutXml, [TasklistXML] = @TaskListXml, [LastUpdatedOn] = @CurrentDate
        WHERE [LayoutID] = @LayoutId
    END
    ELSE
    BEGIN
        INSERT INTO [bix].[vw_SSISPackageLayout_59] ([PackageID], [PackageName], [LayoutXML], [DFLayoutXML], [TasklistXML], [CreatedOn])
        VALUES(@ExecutionId, @PackageName, @LayoutXml, @DFLayoutXml, @TaskListXml, @CurrentDate)
        SET @LayoutId = @@IDENTITY
    END

    IF @LayoutId IS NOT NULL
    BEGIN
        DECLARE @CurrentPackageExecutionLogLayoutId AS INT

        SELECT @CurrentPackageExecutionLogLayoutId = p.[LayoutID]
        FROM [bix].[vw_SSISPackageExecutionLog_59] p
        WHERE p.[LogID] = @PackageExecutionLogId

        IF (@CurrentPackageExecutionLogLayoutId IS NULL) OR (@CurrentPackageExecutionLogLayoutId <> @LayoutId)
        BEGIN
            UPDATE [bix].[vw_SSISPackageExecutionLog_59]
            SET [LayoutID] = @LayoutId
            WHERE [LogID] = @PackageExecutionLogId
        END
    END

    SELECT @LayoutId

    SET NOCOUNT OFF
END

GO
