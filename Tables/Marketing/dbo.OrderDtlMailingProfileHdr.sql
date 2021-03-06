/****** Object:  Table [dbo].[OrderDtlMailingProfileHdr]    Script Date: 5/15/2018 12:02:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderDtlMailingProfileHdr](
	[MalPId] [int] NOT NULL,
	[OrdDMPHId] [int] NOT NULL,
	[OrdHId] [int] NOT NULL,
	[OrdDMPHTelemIncluded] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdDMPHUploadDBDate] [smalldatetime] NULL,
	[OrdDMPHPurchaseList] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdDMPHPurchaseListFee] [float] NULL,
	[OrdDMPHPurchaseListFeeQty] [int] NULL,
	[OrdDMPHPurchaseListAmt] [float] NULL,
	[OrdDMPHOveragePrc] [float] NULL,
	[OrdDMPHProvideDB] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdDMPHProvideDBFee] [float] NULL,
	[OrdDMPHProvideDBFeeQty] [int] NULL,
	[OrdDMPHProvideDBAmt] [float] NULL,
	[OrdDMPHDBName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdDMPHDBQty] [int] NULL,
	[OrdDMPHListMatrix] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdDMPHListRequestQty] [int] NULL,
	[OrdDMPHListStatus] [tinyint] NULL,
	[OrdDMPHApproved] [smalldatetime] NULL,
 CONSTRAINT [PK_OrderDtlMailingProfileHdr] PRIMARY KEY CLUSTERED 
(
	[OrdDMPHId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
