/****** Object:  Table [FII].[fs_report]    Script Date: 5/15/2018 12:04:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [FII].[fs_report](
	[fs_report_id] [int] IDENTITY(1,1) NOT NULL,
	[fs_report_title] [varchar](140) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[fs_report_description] [varchar](1023) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[fs_report_path] [varchar](1023) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_fs_report] PRIMARY KEY CLUSTERED 
(
	[fs_report_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
