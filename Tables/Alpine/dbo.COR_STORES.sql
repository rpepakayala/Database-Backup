/****** Object:  Table [dbo].[COR_STORES]    Script Date: 5/15/2018 11:58:37 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[COR_STORES](
	[StoreID] [bigint] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[StoreNumber] [bigint] NULL,
	[WebNumber] [bigint] NULL,
	[GoldmineId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WebsiteUrl] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
	[RoyaltyFIIpercent] [decimal](18, 4) NULL,
	[RoyaltyNACpercent] [decimal](18, 4) NULL,
	[Alert] [bit] NULL,
	[LimitedServices] [bit] NULL,
	[COD] [bit] NULL,
	[Operational] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Pacesetter] [bit] NULL,
	[VanityName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreOpenDate] [datetime] NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Reportable] [bit] NOT NULL,
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
	[StoreType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_STORES] PRIMARY KEY CLUSTERED 
(
	[StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
