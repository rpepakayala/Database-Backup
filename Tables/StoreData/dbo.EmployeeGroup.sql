/****** Object:  Table [dbo].[EmployeeGroup]    Script Date: 5/15/2018 12:06:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[EmployeeGroup](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[Notes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GroupName] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GroupCode] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailAddress] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MainPhoneNumberID] [int] NULL,
	[MainFaxNumberID] [int] NULL,
	[AddressID] [int] NULL,
	[ManagerID] [int] NULL,
	[PricingPlanID] [int] NULL,
	[TaxClassID] [int] NULL,
	[PrintAsName] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ParentID] [int] NULL,
	[QPHomeListID] [int] NULL,
	[QPHomeListStoreID] [int] NULL,
	[QPTransListID] [int] NULL,
	[QPTransListStoreID] [int] NULL,
	[QPServiceListID] [int] NULL,
	[QPServiceListStoreID] [int] NULL,
	[IsDivision] [bit] NULL,
	[DivisionName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrimaryNumber] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PriNumberTypeID] [int] NULL,
	[PriNumberTypeText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecondaryNumber] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecNumberTypeID] [int] NULL,
	[SecNumberTypeText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultHomeScreen] [int] NULL,
	[ThirdNumber] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ThirdNumberTypeID] [int] NULL,
	[ThirdNumberTypeText] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AddressLinkID] [int] NULL,
 CONSTRAINT [EmployeeGroup_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Index_EmployeeGroup_ManagerID]    Script Date: 5/15/2018 12:06:46 PM ******/
CREATE NONCLUSTERED INDEX [Index_EmployeeGroup_ManagerID] ON [dbo].[EmployeeGroup]
(
	[ManagerID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_EmployeeGroup_PricingPlanID]    Script Date: 5/15/2018 12:06:46 PM ******/
CREATE NONCLUSTERED INDEX [Index_EmployeeGroup_PricingPlanID] ON [dbo].[EmployeeGroup]
(
	[PricingPlanID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_EmployeeGroup_TaxClassID]    Script Date: 5/15/2018 12:06:46 PM ******/
CREATE NONCLUSTERED INDEX [Index_EmployeeGroup_TaxClassID] ON [dbo].[EmployeeGroup]
(
	[TaxClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Indexes_EmployeeGroup]    Script Date: 5/15/2018 12:06:46 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_EmployeeGroup] ON [dbo].[EmployeeGroup]
(
	[GroupName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
