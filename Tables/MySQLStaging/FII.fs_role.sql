/****** Object:  Table [FII].[fs_role]    Script Date: 5/15/2018 12:04:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [FII].[fs_role](
	[fs_role_id] [int] IDENTITY(1,1) NOT NULL,
	[fs_role_name] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[display_order] [int] NULL,
 CONSTRAINT [PK_fs_role] PRIMARY KEY CLUSTERED 
(
	[fs_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
