/****** Object:  Table [dbo].[GoldMineExport]    Script Date: 5/15/2018 12:06:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GoldMineExport](
	[GoldmineId] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CurrentGMVaintyName] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Director] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OwnerLastname] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OwnerFirstDear] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreOpenDate] [datetime] NULL,
	[ResaleOpenDate] [datetime] NULL,
	[Status] [int] NULL,
	[Address1] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address2] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[State] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Zip] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Region] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone1] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Ext1] [varchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone2] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Ext2] [varchar](6) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fax] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WebsiteUrl] [varchar](35) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreNumber] [int] NULL,
	[FBC] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WebNumber] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Operational] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Compliance] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RoyaltyFIIpercent] [money] NULL,
	[Royalty_B] [float] NULL,
	[RoyaltyNACpercent] [money] NULL,
	[AdvFee_B] [float] NULL,
	[Shareholder1] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Interest1_A] [money] NULL,
	[Interest1_B] [float] NULL,
	[Shareholder2] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Interest2_A] [money] NULL,
	[Interest2_B] [float] NULL,
	[Shareholder3] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Interest3_A] [money] NULL,
	[Interest3_B] [float] NULL,
	[Shareholder4] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Interest4_A] [money] NULL,
	[Interest4_B] [float] NULL,
	[Shareholder5] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Interest5_A] [money] NULL,
	[Interest5_B] [float] NULL,
	[Shareholder6] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Interest6_A] [money] NULL,
	[Interest6_B] [float] NULL,
	[STBLevel] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ASI] [bit] NULL,
	[EquipmentPackage] [int] NULL,
	[Router] [bit] NULL,
	[LastConvention] [int] NULL,
	[OutsideSalesRep] [bit] NULL,
	[Luminate] [bit] NULL,
	[LocationType] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrafficCount] [int] NULL,
	[SingleOwner] [bit] NULL,
	[OwnerCount] [int] NULL,
	[Landlord] [bit] NULL,
	[FAC] [bit] NULL,
	[NAC] [bit] NULL,
	[TAC] [bit] NULL,
	[SquareFeet] [int] NULL,
	[StoreType] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Alert] [int] NULL,
	[COD] [int] NULL,
	[LimitedServices] [int] NULL,
	[Pacesetter] [int] NULL,
	[Company] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
