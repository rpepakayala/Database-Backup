/****** Object:  Table [dbo].[xf_permission_cache_content]    Script Date: 5/15/2018 12:00:28 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_permission_cache_content](
	[permission_combination_id] [bigint] NOT NULL,
	[content_type] [varbinary](25) NOT NULL,
	[content_id] [bigint] NOT NULL,
	[cache_value] [varbinary](max) NOT NULL,
 CONSTRAINT [PK_xf_permission_cache_content_permission_combination_id] PRIMARY KEY CLUSTERED 
(
	[permission_combination_id] ASC,
	[content_type] ASC,
	[content_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
