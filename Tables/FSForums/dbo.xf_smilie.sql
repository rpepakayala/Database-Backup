/****** Object:  Table [dbo].[xf_smilie]    Script Date: 5/15/2018 12:00:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_smilie](
	[smilie_id] [bigint] IDENTITY(13,1) NOT NULL,
	[title] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[smilie_text] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[image_url] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sprite_mode] [tinyint] NOT NULL,
	[sprite_params] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[smilie_category_id] [bigint] NOT NULL,
	[display_order] [bigint] NOT NULL,
	[display_in_editor] [tinyint] NOT NULL,
 CONSTRAINT [PK_xf_smilie_smilie_id] PRIMARY KEY CLUSTERED 
(
	[smilie_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [display_order]    Script Date: 5/15/2018 12:00:33 PM ******/
CREATE NONCLUSTERED INDEX [display_order] ON [dbo].[xf_smilie]
(
	[display_order] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[xf_smilie] ADD  DEFAULT ((0)) FOR [sprite_mode]
ALTER TABLE [dbo].[xf_smilie] ADD  DEFAULT ((0)) FOR [smilie_category_id]
ALTER TABLE [dbo].[xf_smilie] ADD  DEFAULT ((1)) FOR [display_order]
ALTER TABLE [dbo].[xf_smilie] ADD  DEFAULT ((1)) FOR [display_in_editor]
GO
