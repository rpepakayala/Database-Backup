/****** Object:  Table [dbo].[FC_ContractSigning]    Script Date: 5/15/2018 12:00:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_ContractSigning](
	[fimContractSigning_Id] [numeric](20, 0) NULL,
	[referenceId] [bigint] NULL,
	[fimDdContractRecievedSigned] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimContract0] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrPromissoryAgreementProperlySigned] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimContract1] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrUfocRecieptProperlySigned] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimContract2] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrGuaranteeProperlySigned] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimContract3] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrStateAddendumProperlySigned] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimContract4] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrNatlAdvAgmtProperlySigned] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimContract5] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrEftProperlySigned] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimContract6] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[recByFrancDate1] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[bussDayExp10Date] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[firstFrancPaymentDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrStateRegistration] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdSecondPaymentDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrStateAddendum] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[francCommiteeApproval] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ipAddress] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[browserType] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrCommissionDue] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtSalesPersonName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtAmount] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[_fddVersionDate1033618324] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCenterInfo_Id] [numeric](20, 0) NULL,
	[franchiseeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
