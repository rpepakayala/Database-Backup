/****** Object:  Table [argot].[fs_report_report_type]    Script Date: 5/15/2018 11:59:07 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [argot].[fs_report_report_type](
	[fs_report_id] [int] NOT NULL,
	[fs_report_type_id] [int] NOT NULL,
	[fs_role_id] [int] NOT NULL,
	[fs_center_id] [int] NOT NULL,
 CONSTRAINT [PK_fs_report_report_type] PRIMARY KEY CLUSTERED 
(
	[fs_report_id] ASC,
	[fs_report_type_id] ASC,
	[fs_role_id] ASC,
	[fs_center_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
