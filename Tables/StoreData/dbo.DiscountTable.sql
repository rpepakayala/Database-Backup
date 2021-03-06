/****** Object:  Table [dbo].[DiscountTable]    Script Date: 5/15/2018 12:06:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DiscountTable](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[ParameterID] [int] NULL,
	[ParameterClassTypeID] [int] NULL,
	[DiscountTableName] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DiscountType] [int] NULL,
	[UnitID] [int] NULL,
 CONSTRAINT [DiscountTable_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Index_DiscountTable_UnitID]    Script Date: 5/15/2018 12:06:44 PM ******/
CREATE NONCLUSTERED INDEX [Index_DiscountTable_UnitID] ON [dbo].[DiscountTable]
(
	[UnitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Indexes_DiscountTable]    Script Date: 5/15/2018 12:06:44 PM ******/
CREATE NONCLUSTERED INDEX [Indexes_DiscountTable] ON [dbo].[DiscountTable]
(
	[ParameterID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
