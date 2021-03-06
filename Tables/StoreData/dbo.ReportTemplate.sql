/****** Object:  Table [dbo].[ReportTemplate]    Script Date: 5/15/2018 12:06:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ReportTemplate](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [smalldatetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[TemplateName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParentID] [int] NULL,
	[ParentStoreID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[SecurityRightID] [int] NULL,
	[SystemReportID] [int] NULL,
	[ReportFileName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseSystemReport] [bit] NULL,
	[CriteriaOptions] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OutputDeviceOptions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortingOptions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortIndex] [float] NULL,
	[OtherOptions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SystemReportClassTypeID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [ReportTemplate_PK]    Script Date: 5/15/2018 12:06:54 PM ******/
CREATE CLUSTERED INDEX [ReportTemplate_PK] ON [dbo].[ReportTemplate]
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_ReportTemplate_Security]    Script Date: 5/15/2018 12:06:54 PM ******/
CREATE NONCLUSTERED INDEX [Index_ReportTemplate_Security] ON [dbo].[ReportTemplate]
(
	[SecurityRightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_ReportTemplate_SortIndex]    Script Date: 5/15/2018 12:06:54 PM ******/
CREATE NONCLUSTERED INDEX [Index_ReportTemplate_SortIndex] ON [dbo].[ReportTemplate]
(
	[SortIndex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_ReportTemplate_Parent]    Script Date: 5/15/2018 12:06:54 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_ReportTemplate_Parent] ON [dbo].[ReportTemplate]
(
	[ParentID] ASC,
	[ParentStoreID] ASC,
	[ParentClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_ReportTemplate_SystemReport]    Script Date: 5/15/2018 12:06:54 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_ReportTemplate_SystemReport] ON [dbo].[ReportTemplate]
(
	[StoreID] ASC,
	[SystemReportID] ASC,
	[SystemReportClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
