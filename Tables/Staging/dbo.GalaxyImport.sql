/****** Object:  Table [dbo].[GalaxyImport]    Script Date: 5/15/2018 12:06:24 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GalaxyImport](
	[VENDORID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[VENDNAME] [varchar](65) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ADDRESS1] [varchar](61) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ADDRESS2] [varchar](61) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ADDRESS3] [varchar](61) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CITY] [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STATE] [varchar](29) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ZIPCODE] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[COUNTRY] [varchar](61) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHNUMBR1] [varchar](21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHNUMBR2] [varchar](21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PHONE3] [varchar](21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FAXNUMBR] [varchar](21) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Credit Limit] [smallint] NULL,
	[Current Balance] [numeric](19, 5) NULL,
	[VNDCLSID1] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MODIFDT1] [datetime] NULL,
	[LSTPURDT1] [datetime] NULL,
	[LinkID] [int] NULL,
	[Status] [int] NULL,
	[WebNumber] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Operational] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FAC] [bit] NULL,
	[NAC] [bit] NULL,
	[TAC] [bit] NULL,
	[LimitedServices] [int] NULL,
	[StoreNumber] [int] NULL,
	[StoreType] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
