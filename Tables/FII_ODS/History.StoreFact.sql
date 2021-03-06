/****** Object:  Table [History].[StoreFact]    Script Date: 5/15/2018 11:59:34 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [History].[StoreFact](
	[HistoryKey] [int] IDENTITY(1,1) NOT NULL,
	[CenterKey] [int] NOT NULL,
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
	[ChangeDate] [datetime] NULL,
	[CloseDate] [datetime] NULL,
	[ResaleOpenDate] [datetime] NULL,
	[NCBC] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_StoreFact] PRIMARY KEY CLUSTERED 
(
	[HistoryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [History].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_CityKey] FOREIGN KEY([CityKey])
REFERENCES [Store].[CityDim] ([CityKey])
ALTER TABLE [History].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_CityKey]
ALTER TABLE [History].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_CountryKey] FOREIGN KEY([CountryKey])
REFERENCES [Store].[CountryDim] ([CountryKey])
ALTER TABLE [History].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_CountryKey]
ALTER TABLE [History].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_LocationTypeKey] FOREIGN KEY([LocationTypeKey])
REFERENCES [Store].[LocationTypeDim] ([LocationTypeKey])
ALTER TABLE [History].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_LocationTypeKey]
ALTER TABLE [History].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_OperationalKey] FOREIGN KEY([OperationalKey])
REFERENCES [Store].[OperationalDim] ([OperationalKey])
ALTER TABLE [History].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_OperationalKey]
ALTER TABLE [History].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_StateKey] FOREIGN KEY([StateKey])
REFERENCES [Store].[StateDim] ([StateKey])
ALTER TABLE [History].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_StateKey]
ALTER TABLE [History].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_STBLevelKey] FOREIGN KEY([STBLevelKey])
REFERENCES [Store].[STBLevelDim] ([STBLevelKey])
ALTER TABLE [History].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_STBLevelKey]
ALTER TABLE [History].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_StoreTypeKey] FOREIGN KEY([StoreTypeKey])
REFERENCES [Store].[StoreTypeDim] ([StoreTypeKey])
ALTER TABLE [History].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_StoreTypeKey]
ALTER TABLE [History].[StoreFact]  WITH CHECK ADD  CONSTRAINT [FK_StoreFact_VanityNameKey] FOREIGN KEY([VanityNameKey])
REFERENCES [Store].[VanityNameDim] ([VanityNameKey])
ALTER TABLE [History].[StoreFact] CHECK CONSTRAINT [FK_StoreFact_VanityNameKey]
GO
