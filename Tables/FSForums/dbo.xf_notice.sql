/****** Object:  Table [dbo].[xf_notice]    Script Date: 5/15/2018 12:00:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_notice](
	[notice_id] [bigint] IDENTITY(31,1) NOT NULL,
	[title] [nvarchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[message] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[active] [tinyint] NOT NULL,
	[display_order] [bigint] NOT NULL,
	[dismissible] [tinyint] NOT NULL,
	[wrap] [tinyint] NOT NULL,
	[user_criteria] [varbinary](max) NOT NULL,
	[page_criteria] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_notice_notice_id] PRIMARY KEY CLUSTERED 
(
	[notice_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_notice] ADD  DEFAULT ((1)) FOR [active]
ALTER TABLE [dbo].[xf_notice] ADD  DEFAULT ((0)) FOR [display_order]
ALTER TABLE [dbo].[xf_notice] ADD  DEFAULT ((1)) FOR [dismissible]
ALTER TABLE [dbo].[xf_notice] ADD  DEFAULT ((1)) FOR [wrap]
GO
