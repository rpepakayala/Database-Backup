/****** Object:  Table [dbo].[SecurityLink]    Script Date: 5/15/2018 12:06:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SecurityLink](
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
 CONSTRAINT [SecurityLink_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Index_SecurityLink_LeftID]    Script Date: 5/15/2018 12:06:56 PM ******/
CREATE NONCLUSTERED INDEX [Index_SecurityLink_LeftID] ON [dbo].[SecurityLink]
(
	[LeftID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_SecurityLink_RightID]    Script Date: 5/15/2018 12:06:56 PM ******/
CREATE NONCLUSTERED INDEX [Index_SecurityLink_RightID] ON [dbo].[SecurityLink]
(
	[RightID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
