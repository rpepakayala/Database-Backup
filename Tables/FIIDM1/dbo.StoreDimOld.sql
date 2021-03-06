/****** Object:  Table [dbo].[StoreDimOld]    Script Date: 5/15/2018 11:59:54 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[StoreDimOld](
	[StoreKey] [int] IDENTITY(1,1) NOT NULL,
	[StoreName]  AS (case when [T_StoreID]=(-1) then 'Unknown' else ((((CONVERT([varchar],[T_StoreNumber],(0))+' - ')+[CITY])+' (')+[VanityName])+')' end),
	[IsRowCurrent] [bit] NULL,
	[WebsiteUrl] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AuditID] [int] NULL,
	[Status] [int] NULL,
	[RoyaltyFIIpercent] [numeric](9, 4) NULL,
	[RoyaltyNACpercent] [numeric](9, 4) NULL,
	[Alert] [bit] NULL,
	[LimitedServices] [bit] NULL,
	[COD] [bit] NULL,
	[Operational] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Pacesetter] [bit] NULL,
	[VanityName] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreOpenDate] [datetime] NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Reportable] [bit] NULL,
	[AddressType] [int] NULL,
	[Address1] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address2] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PostalCode] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Latitude] [numeric](18, 0) NULL,
	[Longitude] [numeric](18, 0) NULL,
	[AddrAuditID] [int] NULL,
	[AddrStatus] [int] NULL,
	[GoldMinePlacement] [int] NULL,
	[DivisionCode] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DivisionName] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SalesRegionName] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountryCode] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountryName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[InternationalRegionName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FBC] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STB_Level] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ASI] [bit] NULL,
	[EquipmentPackage] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Router] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastConvention] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OutsideSalesRep] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Luminate] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LocationType] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrafficCount] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SingleOwner] [bit] NULL,
	[OwnerCount] [int] NULL,
	[Landlord] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FAC] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NAC] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TAC] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SquareFeetRaw] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SquareFeet] [int] NULL,
	[T_WebNumber] [smallint] NULL,
	[T_StoreID] [int] NULL,
	[T_StoreNumber] [int] NULL,
	[T_AddressID] [int] NULL,
	[T_PoliticalDivisionID] [int] NULL,
	[T_SalesRegionID] [int] NULL,
	[T_CountryID] [int] NULL,
	[T_InternationalRegionID] [int] NULL,
	[SalesRegionLevel1]  AS (case when [SalesRegionName] like 'International' then [SalesRegionName] else [InternationalRegionName] end),
	[SalesRegionLevel2]  AS (case when [SalesRegionName] like 'International' then [InternationalRegionName] else [SalesRegionName] end),
	[StoreOpenDate_YYYYMM]  AS (datepart(year,[StoreOpenDate])*(100)+datepart(month,[StoreOpenDate])),
	[StoreOpenDate_YYYY]  AS (datepart(year,[StoreOpenDate])),
	[StoreOpenDate_Month]  AS ((right('00'+CONVERT([varchar],datepart(month,[StoreOpenDate]),(0)),(2))+'-')+datename(month,[StoreOpenDate])),
	[StoreOpenDate_YYYY_Month]  AS ((CONVERT([varchar],datepart(year,[StoreOpenDate]),0)+'-')+datename(month,[StoreOpenDate])),
 CONSTRAINT [PK_StoreDimOld] PRIMARY KEY CLUSTERED 
(
	[StoreKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_StoreDimOld_WebNumber]    Script Date: 5/15/2018 11:59:54 AM ******/
CREATE UNIQUE NONCLUSTERED INDEX [IX_StoreDimOld_WebNumber] ON [dbo].[StoreDimOld]
(
	[T_WebNumber] ASC,
	[T_StoreID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
