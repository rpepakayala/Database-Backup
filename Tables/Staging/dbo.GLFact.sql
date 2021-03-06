/****** Object:  Table [dbo].[GLFact]    Script Date: 5/15/2018 12:06:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GLFact](
	[ID] [int] NOT NULL,
	[DateTime] [datetime] NULL,
	[OrderID] [int] NULL,
	[CustomerID] [int] NULL,
	[RecordID] [int] NULL,
	[AccountCode] [int] NULL,
	[UserID] [int] NULL,
	[Amount] [money] NULL,
	[Description] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Closed] [bit] NULL,
	[ClosedDate] [date] NULL,
	[Exported] [bit] NULL,
	[ExportedDate] [date] NULL,
	[ExportedBatch] [int] NULL,
	[EnteredByID] [int] NULL,
	[SubAccountCode] [int] NULL,
	[Taxable] [bit] NULL,
	[Consolidated] [bit] NULL,
	[Category] [int] NULL,
	[OLTP_InsertDate] [datetime] NOT NULL,
	[OLTP_UpdateDate] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RoyaltyGroupID] [int] NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[OrderDetailID] [int] NULL,
	[ProductID] [int] NULL,
	[UpdateCheckSum] [int] NULL,
	[KeystoneGLFactKey] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
