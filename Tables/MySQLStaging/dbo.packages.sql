/****** Object:  Table [dbo].[packages]    Script Date: 5/15/2018 12:04:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[packages](
	[package_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[franchise_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[active] [smallint] NOT NULL,
 CONSTRAINT [PK_packages_package_id] PRIMARY KEY CLUSTERED 
(
	[package_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [franchise_id]    Script Date: 5/15/2018 12:04:21 PM ******/
CREATE NONCLUSTERED INDEX [franchise_id] ON [dbo].[packages]
(
	[franchise_id] ASC,
	[active] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[packages] ADD  DEFAULT (N'0') FOR [franchise_id]
ALTER TABLE [dbo].[packages] ADD  DEFAULT ((1)) FOR [active]
GO
