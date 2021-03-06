/****** Object:  Table [dbo].[GP_Export]    Script Date: 5/15/2018 12:06:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GP_Export](
	[LinkID] [int] NULL,
	[VENDORID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VENDNAME] [varchar](65) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address1] [varchar](61) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address2] [varchar](61) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContactName] [varchar](61) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CITY] [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STATE] [varchar](29) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ZIPCODE] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[COUNTRY] [varchar](61) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHNUMBR1] [varchar](21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHNUMBR2] [varchar](21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHONE3] [varchar](21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FAXNUMBR] [varchar](21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Credit Limit] [smallint] NULL,
	[CreditLimitAmount] [numeric](19, 5) NULL,
	[Current Balance] [numeric](19, 5) NULL,
	[VNDCLSID1] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MODIFDT1] [datetime] NULL,
	[LSTPURDT1] [datetime] NULL,
	[Type] [int] NULL,
	[VendorStatus] [smallint] NULL
) ON [PRIMARY]

GO
