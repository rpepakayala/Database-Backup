/****** Object:  Table [dbo].[COR_PENDING_STATUS]    Script Date: 5/15/2018 11:58:35 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[COR_PENDING_STATUS](
	[PendingId] [bigint] IDENTITY(1,1) NOT NULL,
	[PendingItemSystemTableId] [bigint] NOT NULL,
	[PendingItemPrimaryKeyId] [bigint] NOT NULL,
	[OriginSystemTableId] [bigint] NOT NULL,
	[OriginSystemColumnId] [bigint] NOT NULL,
	[Status] [tinyint] NULL,
	[AuditId] [bigint] NULL
) ON [PRIMARY]

GO
