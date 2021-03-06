/****** Object:  Table [FII].[fs_report_permissions]    Script Date: 5/15/2018 12:04:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [FII].[fs_report_permissions](
	[fs_role_id] [int] NOT NULL,
	[fs_center_id] [int] NOT NULL,
	[fs_report_report_type_id] [int] NOT NULL,
 CONSTRAINT [PK_fs_report_permissions] PRIMARY KEY CLUSTERED 
(
	[fs_role_id] ASC,
	[fs_center_id] ASC,
	[fs_report_report_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
