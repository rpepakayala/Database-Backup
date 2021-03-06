/****** Object:  Table [dbo].[Groups]    Script Date: 5/15/2018 12:05:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Groups](
	[SiteId] [uniqueidentifier] NOT NULL,
	[ID] [int] NOT NULL,
	[Title] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Description] [nvarchar](512) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Owner] [int] NOT NULL,
	[OwnerIsUser] [bit] NOT NULL,
	[DLAlias] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[DLErrorMessage] [nvarchar](512) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[DLFlags] [int] NULL,
	[DLJobId] [int] NULL,
	[DLArchives] [varchar](4000) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[RequestEmail] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Flags] [int] NOT NULL,
 CONSTRAINT [Groups_PK] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Groups_DLAlias]    Script Date: 5/15/2018 12:05:35 PM ******/
CREATE NONCLUSTERED INDEX [Groups_DLAlias] ON [dbo].[Groups]
(
	[SiteId] ASC,
	[DLAlias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [Groups_Id]    Script Date: 5/15/2018 12:05:35 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Groups_Id] ON [dbo].[Groups]
(
	[SiteId] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Groups_Title]    Script Date: 5/15/2018 12:05:35 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Groups_Title] ON [dbo].[Groups]
(
	[SiteId] ASC,
	[Title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Groups] ADD  DEFAULT ((0)) FOR [Flags]
GO
