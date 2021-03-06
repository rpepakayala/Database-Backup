/****** Object:  Table [dbo].[sub_Transactions]    Script Date: 5/15/2018 12:02:39 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sub_Transactions](
	[TransactionID] [int] IDENTITY(1,1) NOT NULL,
	[SourceID] [int] NOT NULL,
	[SubsidyID] [int] NOT NULL,
	[SubsidyTypeID] [int] NULL,
	[ProviderID] [int] NULL,
	[QualifierID] [int] NOT NULL,
	[CatalogID] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MaterialID] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OrderID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InvoiceAmount] [money] NOT NULL,
	[AmountReimbursed] [money] NOT NULL,
	[AmountRemaining] [money] NOT NULL,
	[DateFrom] [datetime] NOT NULL,
	[DateTo] [datetime] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[CreatedBy] [int] NOT NULL,
 CONSTRAINT [PK_sub_SubsidyLog] PRIMARY KEY CLUSTERED 
(
	[TransactionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
