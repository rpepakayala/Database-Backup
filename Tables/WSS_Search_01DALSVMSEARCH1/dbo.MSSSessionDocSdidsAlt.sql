/****** Object:  Table [dbo].[MSSSessionDocSdidsAlt]    Script Date: 5/15/2018 12:09:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSSessionDocSdidsAlt](
	[DocId] [int] NOT NULL,
	[Type] [smallint] NOT NULL,
	[Sdid] [int] NOT NULL,
	[HasPluggableSecurityTrimming] [bit] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_MSSSessionDocSdidsAlt]    Script Date: 5/15/2018 12:09:12 PM ******/
CREATE CLUSTERED INDEX [IX_MSSSessionDocSdidsAlt] ON [dbo].[MSSSessionDocSdidsAlt]
(
	[DocId] ASC,
	[Type] ASC,
	[HasPluggableSecurityTrimming] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
