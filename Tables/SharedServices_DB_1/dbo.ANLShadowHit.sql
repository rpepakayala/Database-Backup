/****** Object:  Table [dbo].[ANLShadowHit]    Script Date: 5/15/2018 12:05:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ANLShadowHit](
	[DayId] [int] NOT NULL,
	[ShadowResourceId] [int] NOT NULL,
	[ResourceId] [int] NULL,
	[ShadowUserId] [int] NOT NULL,
	[UserId] [int] NULL,
	[ReferrerResourceId] [int] NULL,
	[ShadowReferrerResourceId] [int] NULL
) ON [PRIMARY]

GO
