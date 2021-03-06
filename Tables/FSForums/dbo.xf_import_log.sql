/****** Object:  Table [dbo].[xf_import_log]    Script Date: 5/15/2018 12:00:23 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_import_log](
	[content_type] [varbinary](25) NOT NULL,
	[old_id] [varbinary](50) NOT NULL,
	[new_id] [varbinary](50) NOT NULL,
 CONSTRAINT [PK_xf_import_log_content_type] PRIMARY KEY CLUSTERED 
(
	[content_type] ASC,
	[old_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
