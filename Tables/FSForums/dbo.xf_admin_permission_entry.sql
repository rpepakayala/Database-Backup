/****** Object:  Table [dbo].[xf_admin_permission_entry]    Script Date: 5/15/2018 12:00:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[xf_admin_permission_entry](
	[user_id] [int] NOT NULL,
	[admin_permission_id] [varbinary](25) NOT NULL,
 CONSTRAINT [PK_xf_admin_permission_entry_user_id] PRIMARY KEY CLUSTERED 
(
	[user_id] ASC,
	[admin_permission_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
