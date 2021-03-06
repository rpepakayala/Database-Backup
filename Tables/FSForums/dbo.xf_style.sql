/****** Object:  Table [dbo].[xf_style]    Script Date: 5/15/2018 12:00:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_style](
	[style_id] [bigint] IDENTITY(8,1) NOT NULL,
	[parent_id] [bigint] NOT NULL,
	[parent_list] [varbinary](100) NOT NULL,
	[title] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[properties] [varbinary](max) NOT NULL,
	[last_modified_date] [bigint] NOT NULL,
	[user_selectable] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_style_style_id] PRIMARY KEY CLUSTERED 
(
	[style_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_style] ADD  DEFAULT (N'') FOR [description]
ALTER TABLE [dbo].[xf_style] ADD  DEFAULT ((0)) FOR [last_modified_date]
ALTER TABLE [dbo].[xf_style] ADD  DEFAULT ((1)) FOR [user_selectable]
GO
