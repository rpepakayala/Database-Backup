/****** Object:  Table [dbo].[MSSDocSdids]    Script Date: 5/15/2018 12:05:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSDocSdids](
	[DocId] [int] NOT NULL,
	[Type] [smallint] NOT NULL,
	[Sdid] [int] NOT NULL,
	[HasPluggableSecurityTrimming] [bit] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_MSSDocSdids]    Script Date: 5/15/2018 12:05:27 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_MSSDocSdids] ON [dbo].[MSSDocSdids]
(
	[DocId] ASC,
	[Type] ASC,
	[HasPluggableSecurityTrimming] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = ON, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
