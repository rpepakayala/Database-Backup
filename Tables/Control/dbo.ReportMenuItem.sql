/****** Object:  Table [dbo].[ReportMenuItem]    Script Date: 5/15/2018 11:58:55 AM ******/
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
	[Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseSystemReport] [bit] NULL,
	[FileName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParentID] [int] NULL,
	[ParentStoreID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[SystemReportID] [int] NULL,
	[SystemReportClassTypeID] [int] NULL,
	[TemplateID] [int] NULL,
	[TemplateStoreID] [int] NULL,
	[CriteriaOptions] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DeviceOptions] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortingOptions] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OtherOptions] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityRightID] [int] NULL,
	[SecurityRightClassTypeID] [int] NULL,
	[ChildSortOrder] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AllowGroupPrint] [bit] NULL,
	[Shortcut] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ChangedShowOnMenu] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrintOption] [int] NULL,
	[HasSeparator] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ReportMenuItem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
