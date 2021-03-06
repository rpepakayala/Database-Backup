/****** Object:  Table [Staging].[PeerGroup]    Script Date: 5/15/2018 11:59:57 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Staging].[PeerGroup](
	[WebNumber] [smallint] NULL,
	[AccountNo] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
	[OwnerCount] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Landlord] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FAC] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NAC] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TAC] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SquareFeetRaw] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

/****** Object:  Index [IX_PeerGroup]    Script Date: 5/15/2018 11:59:57 AM ******/
CREATE CLUSTERED INDEX [IX_PeerGroup] ON [Staging].[PeerGroup]
(
	[WebNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
