/****** Object:  Table [dbo].[xf_admin_template]    Script Date: 5/15/2018 12:00:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_admin_template](
	[template_id] [bigint] IDENTITY(1544,1) NOT NULL,
	[title] [varbinary](50) NOT NULL,
	[template] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[template_parsed] [varbinary](max) NOT NULL,
	[addon_id] [varbinary](25) NOT NULL,
 CONSTRAINT [PK_xf_admin_template_template_id] PRIMARY KEY CLUSTERED 
(
	[template_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_admin_template$title] UNIQUE NONCLUSTERED 
(
	[title] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_admin_template] ADD  DEFAULT (0x) FOR [addon_id]
GO
