/****** Object:  Table [dbo].[WebCat]    Script Date: 5/15/2018 12:06:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[WebCat](
	[WebId] [uniqueidentifier] NOT NULL,
	[CategoryId] [uniqueidentifier] NOT NULL,
	[Category] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [WebCat_WebIdCategory]    Script Date: 5/15/2018 12:06:02 PM ******/
CREATE UNIQUE CLUSTERED INDEX [WebCat_WebIdCategory] ON [dbo].[WebCat]
(
	[WebId] ASC,
	[Category] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
