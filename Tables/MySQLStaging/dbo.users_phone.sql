/****** Object:  Table [dbo].[users_phone]    Script Date: 5/15/2018 12:04:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[users_phone](
	[phone_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[address_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[users_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[phone_type_id] [nvarchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[telephone] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ext] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[primary_phone] [smallint] NOT NULL,
	[smsable] [smallint] NULL,
	[cellular_email_address_id] [int] NULL,
	[created_on] [datetime2](0) NOT NULL,
	[created_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[last_modified_on] [datetime2](0) NOT NULL,
	[last_modified_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_users_phone_phone_id] PRIMARY KEY CLUSTERED 
(
	[phone_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_KeystoenView_vw_Contacts]    Script Date: 5/15/2018 12:04:33 PM ******/
CREATE NONCLUSTERED INDEX [Hint_KeystoenView_vw_Contacts] ON [dbo].[users_phone]
(
	[phone_type_id] ASC
)
INCLUDE ( 	[users_id],
	[telephone],
	[ext],
	[primary_phone]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [users_id]    Script Date: 5/15/2018 12:04:33 PM ******/
CREATE NONCLUSTERED INDEX [users_id] ON [dbo].[users_phone]
(
	[users_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[users_phone] ADD  DEFAULT (NULL) FOR [ext]
ALTER TABLE [dbo].[users_phone] ADD  DEFAULT (NULL) FOR [smsable]
ALTER TABLE [dbo].[users_phone] ADD  DEFAULT (NULL) FOR [cellular_email_address_id]
GO
