/****** Object:  Table [dbo].[Categories]    Script Date: 5/15/2018 12:05:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Categories](
	[DocId] [uniqueidentifier] NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [Categories_DocId]    Script Date: 5/15/2018 12:05:50 PM ******/
CREATE CLUSTERED INDEX [Categories_DocId] ON [dbo].[Categories]
(
	[DocId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [Categories_CategoryId]    Script Date: 5/15/2018 12:05:50 PM ******/
CREATE NONCLUSTERED INDEX [Categories_CategoryId] ON [dbo].[Categories]
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
