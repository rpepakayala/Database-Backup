/****** Object:  Table [dbo].[MSSSessionDocSignaturesAlt]    Script Date: 5/15/2018 12:09:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSSessionDocSignaturesAlt](
	[DocId] [int] NOT NULL,
	[UrlSignature] [bigint] NULL,
	[ContentSignature] [bigint] NULL,
	[SchemaSignature] [int] NULL,
	[CrawlTime] [bigint] NULL
) ON [PRIMARY]

/****** Object:  Index [IX_MSSSessionDocSignaturesAlt]    Script Date: 5/15/2018 12:09:13 PM ******/
CREATE CLUSTERED INDEX [IX_MSSSessionDocSignaturesAlt] ON [dbo].[MSSSessionDocSignaturesAlt]
(
	[UrlSignature] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
