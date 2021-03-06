/****** Object:  Table [dbo].[xf_route_prefix]    Script Date: 5/15/2018 12:00:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_route_prefix](
	[route_type] [nvarchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[original_prefix] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[route_class] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[build_link] [nvarchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[addon_id] [varbinary](25) NOT NULL,
 CONSTRAINT [PK_xf_route_prefix_route_type] PRIMARY KEY CLUSTERED 
(
	[route_type] ASC,
	[original_prefix] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[xf_route_prefix] ADD  DEFAULT (N'none') FOR [build_link]
ALTER TABLE [dbo].[xf_route_prefix] ADD  DEFAULT (0x) FOR [addon_id]
GO
