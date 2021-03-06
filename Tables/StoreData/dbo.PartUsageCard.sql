/****** Object:  Table [dbo].[PartUsageCard]    Script Date: 5/15/2018 12:06:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[PartUsageCard](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[PartID] [int] NULL,
	[Amount] [float] NULL,
	[Cost] [float] NULL,
	[StationID] [int] NULL,
	[UnitID] [int] NULL,
	[PartType] [int] NULL,
	[TransHeaderID] [int] NULL,
	[TransHeaderClassTypeID] [int] NULL,
	[TransDetailID] [int] NULL,
	[TransDetailClassTypeID] [int] NULL,
	[TransPartID] [int] NULL,
	[TransPartClassTypeID] [int] NULL,
	[TransModID] [int] NULL,
	[TransModClassTypeID] [int] NULL,
	[EmployeeID] [int] NULL,
	[PostDate] [datetime] NULL,
	[Description] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsVoided] [bit] NULL,
	[StraightTime] [float] NULL,
	[OverTime] [float] NULL,
	[DoubleTime] [float] NULL,
	[ShiftDiffTime] [float] NULL,
	[IsFromTimeCard] [bit] NULL,
	[WarehouseID] [int] NULL,
	[VendorDetailID] [int] NULL,
 CONSTRAINT [PartUsageCard_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [Index_PartUsageCard_EmployeeID]    Script Date: 5/15/2018 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [Index_PartUsageCard_EmployeeID] ON [dbo].[PartUsageCard]
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_PartUsageCard_PartID]    Script Date: 5/15/2018 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [Index_PartUsageCard_PartID] ON [dbo].[PartUsageCard]
(
	[PartID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_PartUsageCard_StationID]    Script Date: 5/15/2018 12:06:49 PM ******/
CREATE NONCLUSTERED INDEX [Index_PartUsageCard_StationID] ON [dbo].[PartUsageCard]
(
	[StationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
