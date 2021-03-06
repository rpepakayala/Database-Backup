/****** Object:  Table [dbo].[xf_admin_search_type]    Script Date: 5/15/2018 12:00:15 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_admin_search_type](
	[search_type] [varbinary](25) NOT NULL,
	[handler_class] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[display_order] [bigint] NOT NULL,
 CONSTRAINT [PK_xf_admin_search_type_search_type] PRIMARY KEY CLUSTERED 
(
	[search_type] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
