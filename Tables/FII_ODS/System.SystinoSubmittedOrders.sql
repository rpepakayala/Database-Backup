/****** Object:  Table [System].[SystinoSubmittedOrders]    Script Date: 5/15/2018 11:59:48 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[SystinoSubmittedOrders](
	[OrderID] [int] NOT NULL,
	[FranchiseID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Submitted] [bit] NULL,
	[DateSubmitted] [datetime] NULL,
	[StoreID] [int] NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_SystinoSubmittedOrders_1]    Script Date: 5/15/2018 11:59:48 AM ******/
CREATE CLUSTERED INDEX [IX_SystinoSubmittedOrders_1] ON [System].[SystinoSubmittedOrders]
(
	[OrderID] ASC,
	[FranchiseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
