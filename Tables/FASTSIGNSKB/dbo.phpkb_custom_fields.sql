/****** Object:  Table [dbo].[phpkb_custom_fields]    Script Date: 5/15/2018 11:59:17 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_custom_fields](
	[field_id] [int] IDENTITY(1,1) NOT NULL,
	[field_name] [nvarchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[field_required] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[field_type] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[field_options] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [field_id] PRIMARY KEY CLUSTERED 
(
	[field_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_custom_fields] ADD  DEFAULT ('no') FOR [field_required]
ALTER TABLE [dbo].[phpkb_custom_fields] ADD  DEFAULT ('text') FOR [field_type]
ALTER TABLE [dbo].[phpkb_custom_fields]  WITH CHECK ADD CHECK  (([field_required]='no' OR [field_required]='yes'))
ALTER TABLE [dbo].[phpkb_custom_fields]  WITH CHECK ADD CHECK  (([field_type]='text' OR [field_type]='dropdown' OR [field_type]='checkbox'))
GO
