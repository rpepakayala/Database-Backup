/****** Object:  Table [dbo].[MSSQLogNonClicked]    Script Date: 5/15/2018 12:05:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSQLogNonClicked](
	[clickId] [bigint] NOT NULL,
	[rank] [int] NOT NULL,
	[nonClickedUrlId] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [PK_MSSQLogNonClicked]    Script Date: 5/15/2018 12:05:16 PM ******/
CREATE CLUSTERED INDEX [PK_MSSQLogNonClicked] ON [dbo].[MSSQLogNonClicked]
(
	[clickId] ASC,
	[rank] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
