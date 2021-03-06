/****** Object:  Table [dbo].[syscachedcredentials]    Script Date: 5/15/2018 12:03:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syscachedcredentials](
	[login_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[has_server_access] [bit] NOT NULL,
	[is_sysadmin_member] [bit] NOT NULL,
	[cachedate] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[login_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[syscachedcredentials] ADD  DEFAULT ((0)) FOR [has_server_access]
ALTER TABLE [dbo].[syscachedcredentials] ADD  DEFAULT ((0)) FOR [is_sysadmin_member]
ALTER TABLE [dbo].[syscachedcredentials] ADD  DEFAULT (getdate()) FOR [cachedate]
GO
