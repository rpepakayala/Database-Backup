/****** Object:  Table [dbo].[SelectionListItem]    Script Date: 5/15/2018 11:58:56 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SelectionListItem](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[SelectionListID] [int] NULL,
	[ItemText] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListValue] [decimal](18, 4) NULL,
	[CostValue] [float] NULL,
	[SortIndex] [int] NULL,
	[SecondaryListID] [int] NULL,
	[SecondaryListStoreID] [int] NULL,
	[SecondaryListClassTypeID] [int] NULL,
	[PriceFormula] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CostFormula] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PartID] [int] NULL,
	[PartStoreID] [int] NULL,
	[PartClassTypeID] [int] NULL,
	[PartConsumptionFx] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseDefaultPart] [bit] NULL,
	[ItemProperties] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecondaryListDefault] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Part2ID] [int] NULL,
	[Part2StoreID] [int] NULL,
	[Part2ClassTypeID] [int] NULL,
	[Part2ConsumptionFx] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseDefaultPart2] [bit] NULL,
	[PriceFormulaType] [int] NULL,
	[CostFormulaType] [int] NULL,
	[ItemColor] [int] NULL,
	[PartDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Part2Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PartLinksXML] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DependentLinksXML] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemFilters] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ItemImageLinks] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SelectionListItem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
