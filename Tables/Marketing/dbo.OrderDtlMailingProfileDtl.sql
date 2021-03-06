/****** Object:  Table [dbo].[OrderDtlMailingProfileDtl]    Script Date: 5/15/2018 12:02:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OrderDtlMailingProfileDtl](
	[OrdDMPHId] [int] NOT NULL,
	[OrdDMPDId] [int] NOT NULL,
	[OrdDMPDType] [tinyint] NOT NULL,
	[OrdDMPDSelection] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdDMPDQty] [int] NULL,
	[OrdDMPDQtyFee] [float] NULL,
	[OrdDMPDExtraFee] [float] NULL,
	[OrdDMPDAmount] [float] NULL,
	[OrdDMPDSICTemplateId] [int] NULL,
	[OrdDMPDSICTemplateName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdDMPDSICModified] [bit] NULL,
	[OrdDMPDValues] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OrdDMPDVisited] [bit] NULL,
 CONSTRAINT [PK_OrderDtlMailingProfileDtl] PRIMARY KEY CLUSTERED 
(
	[OrdDMPHId] ASC,
	[OrdDMPDId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
