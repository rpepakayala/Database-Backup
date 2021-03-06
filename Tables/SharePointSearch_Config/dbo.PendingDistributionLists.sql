/****** Object:  Table [dbo].[PendingDistributionLists]    Script Date: 5/15/2018 12:06:07 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PendingDistributionLists](
	[SiteId] [uniqueidentifier] NOT NULL,
	[WebId] [uniqueidentifier] NOT NULL,
	[GroupName] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[ModifiedBy] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_PendingDistributionLists] PRIMARY KEY CLUSTERED 
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
