/****** Object:  Table [dbo].[Perms]    Script Date: 5/15/2018 12:06:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Perms](
	[SiteId] [uniqueidentifier] NOT NULL,
	[ScopeId] [uniqueidentifier] NOT NULL,
	[RoleDefWebId] [uniqueidentifier] NOT NULL,
	[WebId] [uniqueidentifier] NOT NULL,
	[DelTransId] [varbinary](16) NOT NULL,
	[ScopeUrl] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[AnonymousPermMask] [dbo].[tPermMask] NOT NULL,
	[Acl] [image] NULL,
 CONSTRAINT [Perms_PK] PRIMARY KEY CLUSTERED 
(
	[SiteId] ASC,
	[DelTransId] ASC,
	[ScopeUrl] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [Perms_Url]    Script Date: 5/15/2018 12:06:00 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Perms_Url] ON [dbo].[Perms]
(
	[SiteId] ASC,
	[ScopeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [Perms_WebId]    Script Date: 5/15/2018 12:06:00 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [Perms_WebId] ON [dbo].[Perms]
(
	[SiteId] ASC,
	[WebId] ASC,
	[ScopeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Perms] ADD  DEFAULT (0x) FOR [DelTransId]
GO
