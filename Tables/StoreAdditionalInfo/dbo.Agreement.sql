/****** Object:  Table [dbo].[Agreement]    Script Date: 5/15/2018 12:06:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Agreement](
	[uFOCState] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[uFOCDate] [datetime] NULL,
	[ackOfReceipt] [datetime] NULL,
	[devAgreement] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[devAgreementExp] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[coOpDate] [datetime] NULL,
	[nAPAgreement] [datetime] NULL,
	[nAPDirectAgreement] [datetime] NULL,
	[nAPElectrical] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[specialProvs] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[transferDate] [datetime] NULL,
	[franchiseDate] [datetime] NULL,
	[termInYears] [int] NULL,
	[expirationDate] [datetime] NULL,
	[terminationDate] [datetime] NULL,
	[terminationReason] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Agreement_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_Agreement_Id] PRIMARY KEY CLUSTERED 
(
	[Agreement_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
