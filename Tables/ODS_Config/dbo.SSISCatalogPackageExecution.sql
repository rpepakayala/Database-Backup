/****** Object:  Table [dbo].[SSISCatalogPackageExecution]    Script Date: 5/15/2018 12:04:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SSISCatalogPackageExecution](
	[ExecutionId] [bigint] NOT NULL,
	[ExecutionGuid] [uniqueidentifier] NOT NULL,
	[FolderId] [bigint] NOT NULL,
	[FolderName] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProjectId] [bigint] NULL,
	[ProjectName] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PackageId] [bigint] NOT NULL,
	[PackageGuid] [uniqueidentifier] NOT NULL,
	[PackageName] [nvarchar](260) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ProjectLsn] [bigint] NOT NULL,
	[ServerName] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MachineName] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NOT NULL,
	[StoppedByName] [nvarchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_SSISCatalogPackageExecutionComposite] PRIMARY KEY CLUSTERED 
(
	[ExecutionId] ASC,
	[ServerName] ASC,
	[FolderId] ASC,
	[PackageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_SSISCatalogPackageExecution_ExecutionId_ExecutionGuid]    Script Date: 5/15/2018 12:04:55 PM ******/
CREATE NONCLUSTERED INDEX [IX_SSISCatalogPackageExecution_ExecutionId_ExecutionGuid] ON [dbo].[SSISCatalogPackageExecution]
(
	[ExecutionId] ASC,
	[ExecutionGuid] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
