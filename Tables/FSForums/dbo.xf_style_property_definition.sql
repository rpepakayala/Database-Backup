/****** Object:  Table [dbo].[xf_style_property_definition]    Script Date: 5/15/2018 12:00:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_style_property_definition](
	[property_definition_id] [bigint] IDENTITY(1357,1) NOT NULL,
	[definition_style_id] [int] NOT NULL,
	[group_name] [varbinary](25) NULL,
	[title] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[property_name] [varbinary](100) NOT NULL,
	[property_type] [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[css_components] [varbinary](max) NOT NULL,
	[scalar_type] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[scalar_parameters] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[addon_id] [varbinary](25) NOT NULL,
	[display_order] [bigint] NOT NULL,
	[sub_group] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_xf_style_property_definition_property_definition_id] PRIMARY KEY CLUSTERED 
(
	[property_definition_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [xf_style_property_definition$definition_style_id_property_name] UNIQUE NONCLUSTERED 
(
	[definition_style_id] ASC,
	[property_name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_style_property_definition] ADD  DEFAULT (NULL) FOR [group_name]
ALTER TABLE [dbo].[xf_style_property_definition] ADD  DEFAULT (N'') FOR [description]
ALTER TABLE [dbo].[xf_style_property_definition] ADD  DEFAULT (N'') FOR [scalar_type]
ALTER TABLE [dbo].[xf_style_property_definition] ADD  DEFAULT (N'') FOR [scalar_parameters]
ALTER TABLE [dbo].[xf_style_property_definition] ADD  DEFAULT ((0)) FOR [display_order]
ALTER TABLE [dbo].[xf_style_property_definition] ADD  DEFAULT (N'') FOR [sub_group]
GO
