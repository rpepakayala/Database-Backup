/****** Object:  Table [FII].[fs_user_role]    Script Date: 5/15/2018 12:04:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [FII].[fs_user_role](
	[fs_user_role_id] [int] IDENTITY(1,1) NOT NULL,
	[fs_user_id] [int] NOT NULL,
	[fs_role_id] [int] NOT NULL,
 CONSTRAINT [PK_fs_user_role] PRIMARY KEY CLUSTERED 
(
	[fs_user_role_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
