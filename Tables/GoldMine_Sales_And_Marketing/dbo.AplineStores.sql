/****** Object:  Table [dbo].[AplineStores]    Script Date: 5/15/2018 12:01:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AplineStores](
	[StoreID] [bigint] NULL,
	[StoreNumber] [bigint] NULL,
	[WebNumber] [bigint] NULL,
	[GoldmineId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WebsiteUrl] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
	[RoyaltyFIIpercent] [numeric](18, 4) NULL,
	[RoyaltyNACpercent] [numeric](18, 4) NULL,
	[Alert] [bit] NULL,
	[LimitedServices] [bit] NULL,
	[COD] [bit] NULL,
	[Operational] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Pacesetter] [bit] NULL,
	[VanityName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreOpenDate] [datetime] NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Reportable] [bit] NULL,
	[STBLevel] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ASI] [bit] NULL,
	[EquipmentPackage] [int] NULL,
	[Router] [bit] NULL,
	[LastConvention] [int] NULL,
	[OutsideSalesRep] [bit] NULL,
	[Luminate] [bit] NULL,
	[LocationType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrafficCount] [int] NULL,
	[SingleOwner] [bit] NULL,
	[OwnerCount] [int] NULL,
	[Landlord] [bit] NULL,
	[FAC] [bit] NULL,
	[NAC] [bit] NULL,
	[TAC] [bit] NULL,
	[SquareFeet] [int] NULL,
	[StoreType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
