/****** Object:  Table [Orders].[PaymentTermsFact]    Script Date: 5/15/2018 11:59:37 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[PaymentTermsFact](
	[PaymentTermsKey] [int] IDENTITY(1,1) NOT NULL,
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PaymentTermsID] [int] NULL,
	[Terms] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Message] [varchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DiscountDays] [int] NULL,
	[DiscountRate] [float] NULL,
	[LateDays] [int] NULL,
	[InterestFee] [float] NULL,
	[LateFromDueDate] [bit] NULL,
	[InterestOnInterest] [bit] NULL,
	[AccountCode] [int] NULL,
 CONSTRAINT [PK_PaymentTermsFact] PRIMARY KEY CLUSTERED 
(
	[PaymentTermsKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
