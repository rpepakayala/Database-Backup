/****** Object:  Table [dbo].[xf_widgetframework_widget_page]    Script Date: 5/15/2018 12:00:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_widgetframework_widget_page](
	[node_id] [bigint] NOT NULL,
	[widgets] [varbinary](max) NULL,
	[options] [varbinary](max) NULL,
 CONSTRAINT [PK_xf_widgetframework_widget_page_node_id] PRIMARY KEY CLUSTERED 
(
	[node_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
