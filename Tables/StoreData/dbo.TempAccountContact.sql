/****** Object:  Table [dbo].[TempAccountContact]    Script Date: 5/15/2018 12:06:58 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TempAccountContact](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[Controlled] [bit] NULL,
	[ControlledByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ControlledByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ControlledDate] [datetime] NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[Notes] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FirstName] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Title] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Position] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailAddress] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MainPhoneNumberID] [int] NULL,
	[MainFaxNumberID] [int] NULL,
	[AccountID] [int] NULL,
	[IsPrimaryContact] [bit] NULL,
	[IsAccountingContact] [bit] NULL,
	[BillingAddressID] [int] NULL,
	[ShippingAddressID] [int] NULL,
	[BirthDateMonth] [int] NULL,
	[BirthDateDay] [int] NULL,
	[DefaultPaymentExpDate] [datetime] NULL,
	[DefaultPaymentTrackingNumber] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPaymentNameOnCard] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPaymentTypeID] [int] NULL,
	[CCBillingAddress] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPaymentVCode] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UserID] [int] NULL,
	[SalespersonID1] [int] NULL,
	[SalespersonID2] [int] NULL,
	[SalespersonID3] [int] NULL,
	[UseCompanySalespeople] [bit] NULL,
	[IsCCNumEncrypt] [bit] NULL,
	[DisplayNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
