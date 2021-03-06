/****** Object:  Table [dbo].[OrderPayment]    Script Date: 5/15/2018 12:02:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderPayment](
	[OrdHId] [int] NOT NULL,
	[OrdPmId] [int] NOT NULL,
	[OrdPmType] [tinyint] NULL,
	[OrdPmDate] [smalldatetime] NULL,
	[OrdPmChkNumber] [int] NULL,
	[OrdPmCCFSName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmCCType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmCCNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmCCExpDate] [varchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmAmount] [float] NULL,
	[OrdPmBillAddr1] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmBillAddr2] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmBillCity] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmBillState] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmBillPostalCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmBillCountry] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmBatchNo] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmBatchNum] [int] NULL,
	[OrdPmAuthCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmAuthReason] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdPmCCStatus] [tinyint] NULL,
 CONSTRAINT [PK_OrderPayment] PRIMARY KEY CLUSTERED 
(
	[OrdHId] ASC,
	[OrdPmId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[OrderPayment] ADD  CONSTRAINT [DF_OrderPayment_OrdPmCCStatus]  DEFAULT (0) FOR [OrdPmCCStatus]
GO
