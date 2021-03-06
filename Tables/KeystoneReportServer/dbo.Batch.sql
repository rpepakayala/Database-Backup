/****** Object:  Table [dbo].[Batch]    Script Date: 5/15/2018 12:02:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Batch](
	[BatchID] [uniqueidentifier] NOT NULL,
	[AddedOn] [datetime] NOT NULL,
	[Action] [varchar](32) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Item] [nvarchar](425) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Parent] [nvarchar](425) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Param] [nvarchar](425) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[BoolParam] [bit] NULL,
	[Content] [image] NULL,
	[Properties] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_Batch]    Script Date: 5/15/2018 12:02:18 PM ******/
CREATE CLUSTERED INDEX [IX_Batch] ON [dbo].[Batch]
(
	[BatchID] ASC,
	[AddedOn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_Batch_1]    Script Date: 5/15/2018 12:02:18 PM ******/
CREATE NONCLUSTERED INDEX [IX_Batch_1] ON [dbo].[Batch]
(
	[AddedOn] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
