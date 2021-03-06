/****** Object:  Table [dbo].[VendorImport]    Script Date: 5/15/2018 12:06:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[VendorImport](
	[VendorNumber] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorName] [nvarchar](65) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CompanyPhone] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CompanyFax] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingAddressLine1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingAddressLine2] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingCity] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingState] [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingPostalCode] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingCountry] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingContactFirstName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingContactLastName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingContactEmail] [nvarchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingContactPhone] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingContactPhoneExt] [nvarchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingContactMobile] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingContactFax] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingContactPreferredDocumentDelivery] [int] NOT NULL,
	[VendorAddressLine1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorAddressLine2] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VendorCity] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorState] [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorPostalCode] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorCountry] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorContactSameAsBilling] [bit] NOT NULL,
	[VendorContactPreferredCommunication] [int] NOT NULL,
	[VendorContactPreferredDocumentDelivery] [int] NOT NULL,
	[NationalAccountsAgreement] [bit] NOT NULL,
	[NationalAccountsElectrical] [bit] NOT NULL,
	[WebNumber] [int] NULL,
	[CenterNumber] [int] NULL,
	[Status] [int] NOT NULL,
	[CreditStatus] [int] NULL,
	[Type] [int] NOT NULL,
	[LimitedServices] [bit] NOT NULL,
	[AlertStatus] [bit] NOT NULL,
	[LastModified] [datetime] NOT NULL,
 CONSTRAINT [PK_dbo.VendorImport] PRIMARY KEY CLUSTERED 
(
	[VendorNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

GO
