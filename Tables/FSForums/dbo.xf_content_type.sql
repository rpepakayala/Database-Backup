/****** Object:  Table [dbo].[xf_content_type]    Script Date: 5/15/2018 12:00:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_content_type](
	[content_type] [varbinary](25) NOT NULL,
	[addon_id] [varbinary](25) NOT NULL,
	[fields] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_content_type_content_type] PRIMARY KEY CLUSTERED 
(
	[content_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[xf_content_type] ADD  DEFAULT (0x) FOR [addon_id]
GO
