/****** Object:  Table [dbo].[Station]    Script Date: 5/15/2018 12:06:57 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Station](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[StationName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortIndex] [float] NULL,
	[ParentID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[DepartmentID] [int] NULL,
	[Level2StationID] [int] NULL,
	[Level3StationID] [int] NULL,
	[Level4StationID] [int] NULL,
	[ShowForWIP] [bit] NULL,
	[ShowForBuilt] [bit] NULL,
	[ShowForSale] [bit] NULL,
	[ShowForPendingEstimates] [bit] NULL,
	[ShowOnTimeClock] [bit] NULL,
	[IsPaid] [bit] NULL,
	[IsGLDepartment] [bit] NULL,
	[MarkLIComplete] [bit] NULL,
	[ShowForLineItem] [bit] NULL,
	[ShowForVendorLineItem] [bit] NULL,
	[PayrollExpenseID] [int] NULL,
	[PayrollExpenseClassTypeID] [int] NULL,
	[PayrollExpenseIDOV] [bit] NULL,
	[WorkersCompID] [int] NULL,
	[TimeCardPayStatus] [int] NULL,
	[ShowForProductionTerm] [bit] NULL,
 CONSTRAINT [Station_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Index_Station_DepartmentID]    Script Date: 5/15/2018 12:06:57 PM ******/
CREATE NONCLUSTERED INDEX [Index_Station_DepartmentID] ON [dbo].[Station]
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_Station_Level2StationID]    Script Date: 5/15/2018 12:06:57 PM ******/
CREATE NONCLUSTERED INDEX [Index_Station_Level2StationID] ON [dbo].[Station]
(
	[Level2StationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_Station_Level3StationID]    Script Date: 5/15/2018 12:06:57 PM ******/
CREATE NONCLUSTERED INDEX [Index_Station_Level3StationID] ON [dbo].[Station]
(
	[Level3StationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_Station_Level4StationID]    Script Date: 5/15/2018 12:06:57 PM ******/
CREATE NONCLUSTERED INDEX [Index_Station_Level4StationID] ON [dbo].[Station]
(
	[Level4StationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_Station_ParentID]    Script Date: 5/15/2018 12:06:57 PM ******/
CREATE NONCLUSTERED INDEX [Index_Station_ParentID] ON [dbo].[Station]
(
	[ParentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
