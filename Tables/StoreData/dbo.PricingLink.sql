/****** Object:  Table [dbo].[PricingLink]    Script Date: 5/15/2018 12:06:52 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PricingLink](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[LeftID] [int] NULL,
	[LeftStoreID] [int] NULL,
	[LeftClassTypeID] [int] NULL,
	[RightID] [int] NULL,
	[RightStoreID] [int] NULL,
	[RightClassTypeID] [int] NULL,
	[LinkIndex] [int] NULL,
 CONSTRAINT [PricingLink_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Index_PricingLink_RightID]    Script Date: 5/15/2018 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [Index_PricingLink_RightID] ON [dbo].[PricingLink]
(
	[RightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_PricingLink]    Script Date: 5/15/2018 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_PricingLink] ON [dbo].[PricingLink]
(
	[LeftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_PricingLink_LinkIndex]    Script Date: 5/15/2018 12:06:52 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_PricingLink_LinkIndex] ON [dbo].[PricingLink]
(
	[LinkIndex] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
