/****** Object:  Table [dbo].[COR_STORES_PERSONS_LINK_backup]    Script Date: 5/15/2018 11:58:38 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[COR_STORES_PERSONS_LINK_backup](
	[StoreID] [bigint] NOT NULL,
	[PersonID] [bigint] NOT NULL,
	[Status] [bigint] NULL,
	[GoldMinePlacement] [bigint] NULL,
	[OwnershipPercent] [decimal](18, 4) NULL,
	[StorePersonsLinkID] [bigint] IDENTITY(1,1) NOT NULL,
	[AuditID] [bigint] NULL
) ON [PRIMARY]

GO
