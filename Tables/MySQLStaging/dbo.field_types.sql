/****** Object:  Table [dbo].[field_types]    Script Date: 5/15/2018 12:04:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[field_types](
	[field_type_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[field] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[field_keyword] [nvarchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[field_class_id] [int] NOT NULL,
 CONSTRAINT [PK_field_types_field_type_id] PRIMARY KEY CLUSTERED 
(
	[field_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[field_types] ADD  DEFAULT (NULL) FOR [field]
ALTER TABLE [dbo].[field_types] ADD  DEFAULT (NULL) FOR [field_keyword]
ALTER TABLE [dbo].[field_types] ADD  DEFAULT ((1)) FOR [field_class_id]
GO
