/****** Object:  Table [dbo].[xf_admin]    Script Date: 5/15/2018 12:00:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_admin](
	[user_id] [bigint] NOT NULL,
	[extra_user_group_ids] [varbinary](255) NOT NULL,
	[last_login] [bigint] NOT NULL,
	[permission_cache] [varbinary](max) NULL,
 CONSTRAINT [PK_xf_admin_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_admin] ADD  DEFAULT ((0)) FOR [last_login]
GO
