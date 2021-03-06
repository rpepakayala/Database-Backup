/****** Object:  Table [System].[CenterGEO]    Script Date: 5/15/2018 11:59:46 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[CenterGEO](
	[VendorAddressLine1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorAddressLine2] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VendorCity] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorState] [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorPostalCode] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorCounty] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VendorCountry] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VendorLocation] [geography] NULL,
	[VendorPhone] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VendorFax] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WebNumber] [int] NULL,
	[CenterNumber] [int] NULL,
	[Status] [int] NOT NULL,
	[CreditStatus] [int] NULL,
	[Type] [int] NOT NULL,
	[BillingContactFirstName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingContactLastName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[BillingContactEmail] [nvarchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingContactPhone] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BillingContactTimeZoneId] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastModified] [datetime] NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
