/****** Object:  Table [dbo].[users_address]    Script Date: 5/15/2018 12:04:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[users_address](
	[address_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[users_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[address_1] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[address_2] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[city] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[state_id] [int] NULL,
	[zipcode] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[country_id] [int] NULL,
	[lat] [decimal](10, 7) NULL,
	[lng] [decimal](10, 7) NULL,
	[address_type_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[primary_address] [smallint] NOT NULL,
	[created_on] [datetime2](0) NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified_on] [datetime2](0) NOT NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_users_address_address_id] PRIMARY KEY CLUSTERED 
(
	[address_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [country_id]    Script Date: 5/15/2018 12:04:33 PM ******/
CREATE NONCLUSTERED INDEX [country_id] ON [dbo].[users_address]
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [state_id]    Script Date: 5/15/2018 12:04:33 PM ******/
CREATE NONCLUSTERED INDEX [state_id] ON [dbo].[users_address]
(
	[state_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [users_id]    Script Date: 5/15/2018 12:04:33 PM ******/
CREATE NONCLUSTERED INDEX [users_id] ON [dbo].[users_address]
(
	[users_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[users_address] ADD  DEFAULT (NULL) FOR [address_1]
ALTER TABLE [dbo].[users_address] ADD  DEFAULT (NULL) FOR [address_2]
ALTER TABLE [dbo].[users_address] ADD  DEFAULT (NULL) FOR [city]
ALTER TABLE [dbo].[users_address] ADD  DEFAULT (NULL) FOR [state_id]
ALTER TABLE [dbo].[users_address] ADD  DEFAULT (NULL) FOR [zipcode]
ALTER TABLE [dbo].[users_address] ADD  DEFAULT (NULL) FOR [country_id]
ALTER TABLE [dbo].[users_address] ADD  DEFAULT (NULL) FOR [lat]
ALTER TABLE [dbo].[users_address] ADD  DEFAULT (NULL) FOR [lng]
GO
