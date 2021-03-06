/****** Object:  Table [dbo].[CCCSCustomer]    Script Date: 5/15/2018 12:06:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CCCSCustomer](
	[CustomerGUID] [uniqueidentifier] NOT NULL,
	[CreditCardNumber] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NameOnCard] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExpirationDate] [datetime] NULL,
	[SendAddress] [bit] NULL,
	[StreetAddress] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PostalCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CustomerAccountNumber] [int] NULL,
	[CustomerID] [int] NULL,
	[ContactID] [int] NULL,
	[IsCurrent] [bit] NULL,
	[AddressLinkID] [int] NULL,
	[CreditCardType] [int] NULL,
	[CreditCardTypeText] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CCCSCustomer] PRIMARY KEY CLUSTERED 
(
	[CustomerGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
