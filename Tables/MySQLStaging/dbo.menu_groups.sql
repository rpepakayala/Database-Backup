/****** Object:  Table [dbo].[menu_groups]    Script Date: 5/15/2018 12:04:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[menu_groups](
	[menu_groups_id] [bigint] IDENTITY(10,1) NOT NULL,
	[label] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[icon] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[order_by] [int] NOT NULL,
 CONSTRAINT [PK_menu_groups_menu_groups_id] PRIMARY KEY CLUSTERED 
(
	[menu_groups_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
