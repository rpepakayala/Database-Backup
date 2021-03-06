/****** Object:  Table [dbo].[AccountConsolidated]    Script Date: 5/15/2018 11:59:01 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AccountConsolidated](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[CompanyLocationId] [char](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FranchiseName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AccountId] [int] NULL,
	[LocationId] [int] NULL,
	[CompanyName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AccountNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrimaryAccountContactId] [int] NULL,
	[BillingContactId] [int] NULL,
	[PrimaryPhoneNumber] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrimaryPhoneNumberTypeText] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SecondaryPhoneNumber] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecondaryPhoneNumberTypeText] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TertiaryPhoneNumber] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TertiaryPhoneNumberTypeText] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IndustryType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FirstOrderDate] [datetimeoffset](7) NULL,
	[LastOrderDate] [datetimeoffset](7) NULL,
	[LastSaleAmount] [decimal](18, 6) NULL,
	[BalanceDue] [money] NULL,
	[IsUpdate] [int] NULL,
	[IsRoyaltyOverriden] [bit] NULL,
	[CustomerType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIICustomerID] [int] NULL,
	[FIIPrimaryContactID] [int] NULL,
	[FIIBillingContactID] [int] NULL,
	[UpdateCheckSum] [int] NULL,
	[OLTP_InsertDate] [datetime] NULL,
	[OLTP_UpdateDate] [datetime] NULL,
 CONSTRAINT [PK_AccountConsolidated] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [AccountConsolidated_CompanyLocationId_AccountId]    Script Date: 5/15/2018 11:59:01 AM ******/
CREATE NONCLUSTERED INDEX [AccountConsolidated_CompanyLocationId_AccountId] ON [dbo].[AccountConsolidated]
(
	[CompanyLocationId] ASC,
	[AccountId] ASC
)
INCLUDE ( 	[CompanyName]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[AccountConsolidated] ADD  CONSTRAINT [DF_ccountConsolidated_OLTP_InsertDate]  DEFAULT (getdate()) FOR [OLTP_InsertDate]
GO
