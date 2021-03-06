/****** Object:  Table [dbo].[material_type_categories]    Script Date: 5/15/2018 12:04:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[material_type_categories](
	[material_category_id] [int] IDENTITY(26,1) NOT NULL,
	[material_type_id] [int] NOT NULL,
	[code] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_material_type_categories_material_category_id] PRIMARY KEY CLUSTERED 
(
	[material_category_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[material_type_categories] ADD  DEFAULT (NULL) FOR [code]
ALTER TABLE [dbo].[material_type_categories] ADD  DEFAULT (N'') FOR [name]
GO
