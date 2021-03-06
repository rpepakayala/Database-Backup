/****** Object:  StoredProcedure [bix].[usp_SSISOps_Audit_Insert_RowCount_59]    Script Date: 5/15/2018 12:11:06 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
/*
Source : Pragmatic Works - BI xPress Auditing Framework 59
Created On : 2/19/2016
Purpose : 
    - Insert record for row count
*/
CREATE PROCEDURE [bix].[usp_SSISOps_Audit_Insert_RowCount_59]
(
    @ComponentName NVARCHAR(100) = NULL,
    @ComponentTypeCode NVARCHAR(100) = NULL,
    @ComponentTypeName NVARCHAR(100) = NULL,
    @ComponentUniqueID VARCHAR(100) = NULL,
    @DataObjectCatalog NVARCHAR(100) = NULL,
    @DataObjectConnectionName NVARCHAR(100) = NULL,
    @DataObjectConnectionString NVARCHAR(4000) = NULL,
    @DataObjectDataSource NVARCHAR(100) = NULL,
    @DataObjectName NVARCHAR(4000) = NULL,
    @DataObjectQuery VARCHAR(8000) = NULL,
    @DataObjectType VARCHAR(50) = NULL,
    @DataObjectUserName NVARCHAR(100) = NULL,
    @ExecutionID VARCHAR(50),
    @RecordCount BIGINT = NULL,
    @SourceID VARCHAR(50),
    @SourceName VARCHAR(255) = NULL
)
AS 
BEGIN
    SET NOCOUNT ON
    SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED

    DECLARE @ParentLogID INT
    DECLARE @CurrentDate DATETIME

    SET @CurrentDate = GETDATE()

    SELECT @ParentLogID = MAX(e.[LogID])
    FROM [bix].[vw_SSISTaskExecutionLog_59] e
    WHERE e.[ExecutionID] = @ExecutionID AND e.[SourceID] = @SourceID

    INSERT INTO [bix].[vw_SSISPackageRowCountLog_59] (
          [ComponentName]
        , [ComponentTypeCode]
        , [ComponentTypeName]
        , [ComponentUniqueID]
        , [DataObjectCatalog]
        , [DataObjectConnectionName]
        , [DataObjectConnectionString]
        , [DataObjectDataSource]
        , [DataObjectName]
        , [DataObjectQuery]
        , [DataObjectType]
        , [DataObjectUserName]
        , [ExecutionID]
        , [LogDate]
        , [RecordCount]
        , [SourceID]
        , [SourceName]
        , [ParentLogID])
    VALUES (
          @ComponentName
        , @ComponentTypeCode
        , @ComponentTypeName
        , @ComponentUniqueID
        , @DataObjectCatalog
        , @DataObjectConnectionName
        , @DataObjectConnectionString
        , @DataObjectDataSource
        , @DataObjectName
        , @DataObjectQuery
        , @DataObjectType
        , @DataObjectUserName
        , @ExecutionID
        , @CurrentDate
        , @RecordCount
        , @SourceID
        , @SourceName
        , @ParentLogID
    )
END

GO
