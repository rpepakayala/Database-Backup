/****** Object:  Table [dbo].[MaterialGroupsQty]    Script Date: 5/15/2018 12:02:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MaterialGroupsQty](
	[MatGHid] [int] NOT NULL,
	[MatGPrdId] [int] NULL,
	[MatGDDate] [smalldatetime] NULL,
	[MatGQId] [int] NOT NULL,
	[MatGQtyBreak] [smallint] NULL,
	[MatGPriceBreak] [float] NULL,
	[MatGDBPriceBreak] [float] NULL,
 CONSTRAINT [PK_ScheduledMainlingsQty] PRIMARY KEY CLUSTERED 
(
	[MatGQId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_MaterialGroupsQty]    Script Date: 5/15/2018 12:02:32 PM ******/
CREATE NONCLUSTERED INDEX [IX_MaterialGroupsQty] ON [dbo].[MaterialGroupsQty]
(
	[MatGHid] ASC,
	[MatGPrdId] ASC,
	[MatGDDate] ASC,
	[MatGQId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
