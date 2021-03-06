/****** Object:  Table [FII].[fs_user_center]    Script Date: 5/15/2018 12:04:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [FII].[fs_user_center](
	[fs_user_center_id] [int] IDENTITY(1,1) NOT NULL,
	[fs_user_id] [int] NOT NULL,
	[fs_center_id] [int] NOT NULL,
 CONSTRAINT [PK_fs_user_center] PRIMARY KEY CLUSTERED 
(
	[fs_user_center_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
