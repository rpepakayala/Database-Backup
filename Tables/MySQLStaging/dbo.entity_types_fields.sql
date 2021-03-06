/****** Object:  Table [dbo].[entity_types_fields]    Script Date: 5/15/2018 12:04:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[entity_types_fields](
	[entity_type_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[field_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[label] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[order] [int] NOT NULL,
	[grid] [smallint] NOT NULL,
	[required] [smallint] NOT NULL,
	[default_sort] [smallint] NOT NULL,
	[on_add] [smallint] NULL,
 CONSTRAINT [PK_entity_types_fields_entity_type_id] PRIMARY KEY CLUSTERED 
(
	[entity_type_id] ASC,
	[field_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[entity_types_fields] ADD  DEFAULT ((0)) FOR [order]
ALTER TABLE [dbo].[entity_types_fields] ADD  DEFAULT ((0)) FOR [grid]
ALTER TABLE [dbo].[entity_types_fields] ADD  DEFAULT ((0)) FOR [required]
ALTER TABLE [dbo].[entity_types_fields] ADD  DEFAULT ((1)) FOR [on_add]
GO
