/****** Object:  Table [dbo].[ReportMenuItem]    Script Date: 5/15/2018 12:06:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ReportMenuItem](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[MenuItemName] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseSystemReport] [bit] NULL,
	[FileName] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParentID] [int] NULL,
	[ParentStoreID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[SystemReportID] [int] NULL,
	[SystemReportClassTypeID] [int] NULL,
	[TemplateID] [int] NULL,
	[TemplateStoreID] [int] NULL,
	[CriteriaOptions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeviceOptions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortingOptions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OtherOptions] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityRightID] [int] NULL,
	[SecurityRightClassTypeID] [int] NULL,
	[ChildSortOrder] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AllowGroupPrint] [bit] NULL,
	[Shortcut] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChangedShowOnMenu] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrintOption] [int] NULL,
	[HasSeparator] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RequiredModules] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [ReportMenuItem_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_ReportMenuItem_siReportMenuItem_Parent]    Script Date: 5/15/2018 12:06:54 PM ******/
CREATE NONCLUSTERED INDEX [Index_ReportMenuItem_siReportMenuItem_Parent] ON [dbo].[ReportMenuItem]
(
	[ParentID] ASC,
	[ParentStoreID] ASC,
	[ParentClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_ReportMenuItem_siReportMenuItem_Template]    Script Date: 5/15/2018 12:06:54 PM ******/
CREATE NONCLUSTERED INDEX [Index_ReportMenuItem_siReportMenuItem_Template] ON [dbo].[ReportMenuItem]
(
	[TemplateID] ASC,
	[TemplateStoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
