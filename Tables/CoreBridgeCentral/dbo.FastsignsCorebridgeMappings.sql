/****** Object:  Table [dbo].[FastsignsCorebridgeMappings]    Script Date: 5/15/2018 11:59:03 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FastsignsCorebridgeMappings](
	[StoreID] [char](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ID_Type] [tinyint] NOT NULL,
	[FastsignsID] [int] NOT NULL,
	[CorbridgeID] [int] NOT NULL,
	[ZW_Franchise_ID]  AS ('FSI'+[StoreID]) PERSISTED NOT NULL
) ON [PRIMARY]

GO
