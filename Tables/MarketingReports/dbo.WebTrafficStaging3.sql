/****** Object:  Table [dbo].[WebTrafficStaging3]    Script Date: 5/15/2018 12:02:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[WebTrafficStaging3](
	[Webnumber] [int] NOT NULL,
	[Month] [datetime] NOT NULL,
	[SendAFile] [int] NOT NULL,
	[RFQ] [int] NOT NULL,
	[MyFastsignsRegistration] [int] NOT NULL,
 CONSTRAINT [PK_WebTrafficStaging3] PRIMARY KEY CLUSTERED 
(
	[Webnumber] ASC,
	[Month] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_WebTrafficStaging3]    Script Date: 5/15/2018 12:02:48 PM ******/
CREATE NONCLUSTERED INDEX [IX_WebTrafficStaging3] ON [dbo].[WebTrafficStaging3]
(
	[Webnumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_WebTrafficStaging3_1]    Script Date: 5/15/2018 12:02:48 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_WebTrafficStaging3_1] ON [dbo].[WebTrafficStaging3]
(
	[Webnumber] ASC,
	[Month] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
