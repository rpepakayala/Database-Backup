/****** Object:  Table [dbo].[IndustryDim]    Script Date: 5/15/2018 12:06:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[IndustryDim](
	[IndustryTypeID] [int] NOT NULL,
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IndustryType] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ActiveType] [bit] NULL,
	[SICCode] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OLTP_InsertDate] [datetime] NOT NULL,
	[OLTP_UpdateDate] [datetime] NOT NULL,
	[UpdateCheckSum] [int] NOT NULL
) ON [PRIMARY]

GO
