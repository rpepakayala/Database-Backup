/****** Object:  Table [dbo].[UpgradeInfo]    Script Date: 5/15/2018 12:05:03 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[UpgradeInfo](
	[Item] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Status] [nvarchar](512) COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [PK_UpgradeInfo] PRIMARY KEY CLUSTERED 
(
	[Item] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
