/****** Object:  Table [dbo].[FC_Outlook]    Script Date: 5/15/2018 12:00:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_Outlook](
	[referenceId] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[recepient] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sender] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[subject] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[sendOn] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[rcvdDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCenterInfo_Id] [numeric](20, 0) NULL,
	[franchiseeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
