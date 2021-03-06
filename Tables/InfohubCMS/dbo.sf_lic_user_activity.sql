/****** Object:  Table [dbo].[sf_lic_user_activity]    Script Date: 5/15/2018 12:01:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_lic_user_activity](
	[user_id] [uniqueidentifier] NOT NULL,
	[token_id] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[provider_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[login_ip] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_login_date] [datetime] NULL,
	[last_activity_date] [datetime] NOT NULL,
	[is_logged_in] [tinyint] NOT NULL,
	[is_backend_user] [tinyint] NOT NULL,
 CONSTRAINT [pk_sf_lic_user_activity] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
