/****** Object:  Table [dbo].[FC_Termination]    Script Date: 5/15/2018 12:00:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FC_Termination](
	[referenceId] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdApprovedDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdTerminatedDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCbReason] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCbReasonOther] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdActionDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdFollowUpDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdCuredDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimDdEffectiveActionDate] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCbTypeOfAction] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTerminationdoc0] [nvarchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtAmount] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtLiquidatedDamages] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtCollected] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTaComments] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrBankruptcy] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCbBankruptcyType] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimOtherBankruptcyType] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCbEntityClaimingBk] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimRrRepresentative] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtName2] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTermination0] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtCaseBk] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtCollectionAgency] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTtName1] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimTermination1] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[fimCenterInfo_Id] [numeric](20, 0) NULL,
	[franchiseeName] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
