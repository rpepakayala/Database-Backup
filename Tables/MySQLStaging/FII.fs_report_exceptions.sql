/****** Object:  Table [FII].[fs_report_exceptions]    Script Date: 5/15/2018 12:04:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [FII].[fs_report_exceptions](
	[fs_report_id] [int] NOT NULL,
	[fs_user_id] [int] NOT NULL,
	[report_exceptions_note] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_fs_report_exceptions] PRIMARY KEY CLUSTERED 
(
	[fs_report_id] ASC,
	[fs_user_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
