/****** Object:  Table [dbo].[SSISPackageExecutionLog]    Script Date: 5/15/2018 12:04:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SSISPackageExecutionLog](
	[LogID] [int] IDENTITY(1,1) NOT NULL,
	[ExecutionID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PackageName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PackageID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[InteractiveMode] [bit] NULL,
	[UserName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MachineName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LogDate] [smalldatetime] NOT NULL,
	[ExecutionStartDateTime] [datetime] NOT NULL,
	[ExecutionEndDateTime] [datetime] NULL,
	[TotalErrorCount] [int] NULL,
	[TotalWarningCount] [int] NULL,
	[TotalRecordsExtracted] [bigint] NULL,
	[TotalRecordsLoaded] [bigint] NULL,
	[CPUUtilization] [float] NULL,
	[RAMUtilization] [float] NULL,
	[DiskUtilization] [float] NULL,
	[CustomValue_Num_1] [decimal](10, 2) NULL,
	[CustomValue_Num_2] [decimal](10, 2) NULL,
	[CustomValue_Num_3] [decimal](10, 2) NULL,
	[CustomValue_Dt_1] [datetime] NULL,
	[CustomValue_Dt_2] [datetime] NULL,
	[CustomValue_Dt_3] [datetime] NULL,
	[CustomValue_Str_1] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomValue_Str_2] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomValue_Str_3] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LayoutID] [int] NULL,
	[Variables] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Connections] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK__SSISPack__5E5499A807020F21] PRIMARY KEY CLUSTERED 
(
	[LogID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_SSISPackageExecutionLog_TotalErrorCount_ExecutionEndDateTime]    Script Date: 5/15/2018 12:04:56 PM ******/
CREATE NONCLUSTERED INDEX [Hint_SSISPackageExecutionLog_TotalErrorCount_ExecutionEndDateTime] ON [dbo].[SSISPackageExecutionLog]
(
	[TotalErrorCount] ASC,
	[ExecutionEndDateTime] ASC
)
INCLUDE ( 	[PackageID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_SSISPackageExecutionLog_ExecutionID]    Script Date: 5/15/2018 12:04:56 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_SSISPackageExecutionLog_ExecutionID] ON [dbo].[SSISPackageExecutionLog]
(
	[ExecutionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_SSISPackageExecutionLog_ExecutionStartDateTime_PackageName_PackageID]    Script Date: 5/15/2018 12:04:56 PM ******/
CREATE NONCLUSTERED INDEX [IX_SSISPackageExecutionLog_ExecutionStartDateTime_PackageName_PackageID] ON [dbo].[SSISPackageExecutionLog]
(
	[ExecutionStartDateTime] ASC
)
INCLUDE ( 	[PackageName],
	[PackageID]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_SSISPackageExecutionLog_LayoutID]    Script Date: 5/15/2018 12:04:56 PM ******/
CREATE NONCLUSTERED INDEX [IX_SSISPackageExecutionLog_LayoutID] ON [dbo].[SSISPackageExecutionLog]
(
	[LayoutID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_SSISPackageExecutionLog_LogDate]    Script Date: 5/15/2018 12:04:56 PM ******/
CREATE NONCLUSTERED INDEX [IX_SSISPackageExecutionLog_LogDate] ON [dbo].[SSISPackageExecutionLog]
(
	[LogDate] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_SSISPackageExecutionLog_PackageName]    Script Date: 5/15/2018 12:04:56 PM ******/
CREATE NONCLUSTERED INDEX [IX_SSISPackageExecutionLog_PackageName] ON [dbo].[SSISPackageExecutionLog]
(
	[PackageName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[SSISPackageExecutionLog] ADD  CONSTRAINT [DF__SSISPacka__Inter__08EA5793]  DEFAULT ((0)) FOR [InteractiveMode]
ALTER TABLE [dbo].[SSISPackageExecutionLog] ADD  CONSTRAINT [DF__SSISPacka__LogDa__09DE7BCC]  DEFAULT (CONVERT([varchar](10),getdate(),(126))+'T00:00:00') FOR [LogDate]
ALTER TABLE [dbo].[SSISPackageExecutionLog] ADD  CONSTRAINT [DF__SSISPacka__Execu__0AD2A005]  DEFAULT (getdate()) FOR [ExecutionStartDateTime]
GO
