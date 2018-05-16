/****** Object:  Table [System].[CollectionInfo]    Script Date: 5/15/2018 11:59:46 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[CollectionInfo](
	[ZW_Franchise_ID] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ClientCollectionTime] [datetime] NULL,
	[ServerCollectionTime] [datetime] NULL,
	[Latest_Update] [datetime] NULL,
	[Notes] [varchar](1023) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
