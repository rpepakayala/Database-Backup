/****** Object:  Table [dbo].[xf_user_profile]    Script Date: 5/15/2018 12:00:41 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_user_profile](
	[user_id] [bigint] NOT NULL,
	[dob_day] [tinyint] NOT NULL,
	[dob_month] [tinyint] NOT NULL,
	[dob_year] [int] NOT NULL,
	[status] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[status_date] [bigint] NOT NULL,
	[status_profile_post_id] [bigint] NOT NULL,
	[signature] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[homepage] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[location] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[occupation] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[following] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ignored] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[csrf_token] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[avatar_crop_x] [bigint] NOT NULL,
	[avatar_crop_y] [bigint] NOT NULL,
	[about] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[custom_fields] [varbinary](max) NOT NULL,
	[external_auth] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_user_profile_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [dob]    Script Date: 5/15/2018 12:00:41 PM ******/
CREATE NONCLUSTERED INDEX [dob] ON [dbo].[xf_user_profile]
(
	[dob_month] ASC,
	[dob_day] ASC,
	[dob_year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT ((0)) FOR [dob_day]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT ((0)) FOR [dob_month]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT ((0)) FOR [dob_year]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT ((0)) FOR [status_date]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT ((0)) FOR [status_profile_post_id]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT (N'') FOR [location]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT (N'') FOR [occupation]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT ((0)) FOR [avatar_crop_x]
ALTER TABLE [dbo].[xf_user_profile] ADD  DEFAULT ((0)) FOR [avatar_crop_y]
GO
