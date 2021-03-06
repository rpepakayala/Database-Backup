/****** Object:  Table [dbo].[fimOwner]    Script Date: 5/15/2018 12:00:12 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[fimOwner](
	[referenceId] [bigint] NULL,
	[ownerTitle] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[firstName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[lastName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[muidValue] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimFranchisee_Id] [numeric](20, 0) NULL
) ON [PRIMARY]

GO
