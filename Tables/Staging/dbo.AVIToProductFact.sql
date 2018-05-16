/****** Object:  Table [dbo].[AVIToProductFact]    Script Date: 5/15/2018 12:06:18 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AVIToProductFact](
	[ID] [int] NOT NULL,
	[AVID] [int] NOT NULL,
	[ProductID] [int] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OLTP_InsertDate] [datetime] NOT NULL,
	[OLTP_UpdateDate] [datetime] NOT NULL
) ON [PRIMARY]

GO
