/****** Object:  Table [Store].[StoreFact]    Script Date: 5/15/2018 11:59:45 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Store].[StoreFact](
	[CenterKey] [int] IDENTITY(1,1) NOT NULL,
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StoreNumber] [bigint] NULL,
	[GoldmineId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Status] [int] NULL,
	[RoyaltyFIIpercent] [float] NULL,
	[RoyaltyNACpercent] [float] NULL,
	[Alert] [bit] NULL,
	[LimitedServices] [bit] NULL,
	[COD] [bit] NULL,
	[OperationalKey] [int] NULL,
	[Pacesetter] [bit] NULL,
	[VanityNameKey] [int] NULL,
	[StoreOpenDate] [date] NULL,
	[Email] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Reportable] [bit] NULL,
	[STBLevelKey] [int] NULL,
	[ASI] [bit] NULL,
	[EquipmentPackage] [int] NULL,
	[Router] [bit] NULL,
	[LastConvention] [int] NULL,
	[OutsideSalesRep] [bit] NULL,
	[Luminate] [bit] NULL,
	[LocationTypeKey] [int] NULL,
	[TrafficCount] [int] NULL,
	[SingleOwner] [bit] NULL,
	[OwnerCount] [int] NULL,
	[Landlord] [bit] NULL,
	[FAC] [bit] NULL,
	[NAC] [bit] NULL,
	[TAC] [bit] NULL,
	[SquareFeet] [int] NULL,
	[StoreTypeKey] [int] NULL,
	[CountryKey] [int] NULL,
	[CityKey] [int] NULL,
	[StateKey] [int] NULL,
	[UpdateCheckSum] [int] NULL,
	[Zip] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OpenStatus] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address] [varchar](120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Region] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FAX] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FBC] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Director] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CloseDate] [date] NULL,
	[ResaleOpenDate] [date] NULL,
	[NCBC] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[System] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[County] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LAT] [float] NULL,
	[LONG] [float] NULL,
	[GeoCode] [geography] NULL,
	[ExcludeFromPickedUP] [bit] NULL,
	[OpenMonth]  AS (CONVERT([date],case when datepart(day,[StoreOpenDate])<(15) then (CONVERT([varchar](2),datepart(month,[StoreOpenDate]))+'/1/')+CONVERT([char](4),datepart(year,[StoreOpenDate])) else (CONVERT([varchar](2),datepart(month,dateadd(month,(1),[StoreOpenDate])))+'/1/')+CONVERT([char](4),datepart(year,dateadd(month,(1),[StoreOpenDate]))) end)),
	[CompStart]  AS (CONVERT([date],(CONVERT([varchar](2),datepart(month,dateadd(month,(1),[StoreOpenDate])))+'/1/')+CONVERT([char](4),datepart(year,dateadd(month,(1),[StoreOpenDate]))))),
	[AreaKey] [int] NULL,
 CONSTRAINT [PK_StoreFact] PRIMARY KEY CLUSTERED 
(
	[CenterKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_ZW_Franchise_ID_inc_CenterKey]    Script Date: 5/15/2018 11:59:45 AM ******/
CREATE NONCLUSTERED INDEX [Hint_ZW_Franchise_ID_inc_CenterKey] ON [Store].[StoreFact]
(
	[ZW_Franchise_ID] ASC
)
INCLUDE ( 	[CenterKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_StoreFact_StoreTypeKey_CenterKey_ZW_Franchise_ID_StoreNumber_GoldmineId_Status_RoyaltyFIIpercent_RoyaltyNACpercent_Alert_Limi]    Script Date: 5/15/2018 11:59:45 AM ******/
CREATE NONCLUSTERED INDEX [IX_StoreFact_StoreTypeKey_CenterKey_ZW_Franchise_ID_StoreNumber_GoldmineId_Status_RoyaltyFIIpercent_RoyaltyNACpercent_Alert_Limi] ON [Store].[StoreFact]
(
	[StoreTypeKey] ASC
)
INCLUDE ( 	[CenterKey],
	[ZW_Franchise_ID],
	[StoreNumber],
	[GoldmineId],
	[Status],
	[RoyaltyFIIpercent],
	[RoyaltyNACpercent],
	[Alert],
	[LimitedServices],
	[COD],
	[OperationalKey],
	[Pacesetter],
	[VanityNameKey],
	[StoreOpenDate],
	[Email],
	[Reportable],
	[STBLevelKey],
	[ASI],
	[EquipmentPackage],
	[Router],
	[LastConvention],
	[OutsideSalesRep],
	[Luminate],
	[LocationTypeKey],
	[TrafficCount],
	[SingleOwner],
	[OwnerCount],
	[Landlord],
	[FAC],
	[NAC],
	[TAC],
	[SquareFeet],
	[CountryKey],
	[CityKey],
	[StateKey],
	[Zip],
	[OpenStatus],
	[Address],
	[Region],
	[Phone],
	[FAX],
	[FBC]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [LocationTypeKey_ZW_Franchise_ID]    Script Date: 5/15/2018 11:59:45 AM ******/
CREATE NONCLUSTERED INDEX [LocationTypeKey_ZW_Franchise_ID] ON [Store].[StoreFact]
(
	[LocationTypeKey] ASC
)
INCLUDE ( 	[ZW_Franchise_ID],
	[StoreNumber],
	[OperationalKey],
	[StoreOpenDate],
	[STBLevelKey],
	[StoreTypeKey],
	[CountryKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_Area] FOREIGN KEY([AreaKey])
REFERENCES [Store].[AreaDim] ([AreaKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_Area]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_CityKey] FOREIGN KEY([CityKey])
REFERENCES [Store].[CityDim] ([CityKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_CityKey]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_CountryKey] FOREIGN KEY([CountryKey])
REFERENCES [Store].[CountryDim] ([CountryKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_CountryKey]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_LocationTypeKey] FOREIGN KEY([LocationTypeKey])
REFERENCES [Store].[LocationTypeDim] ([LocationTypeKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_LocationTypeKey]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_OperationalKey] FOREIGN KEY([OperationalKey])
REFERENCES [Store].[OperationalDim] ([OperationalKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_OperationalKey]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_StateKey] FOREIGN KEY([StateKey])
REFERENCES [Store].[StateDim] ([StateKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_StateKey]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_STBLevelKey] FOREIGN KEY([STBLevelKey])
REFERENCES [Store].[STBLevelDim] ([STBLevelKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_STBLevelKey]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_StoreTypeKey] FOREIGN KEY([StoreTypeKey])
REFERENCES [Store].[StoreTypeDim] ([StoreTypeKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_StoreTypeKey]
ALTER TABLE [Store].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_VanityNameKey] FOREIGN KEY([VanityNameKey])
REFERENCES [Store].[VanityNameDim] ([VanityNameKey])
ALTER TABLE [Store].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_VanityNameKey]
GO
