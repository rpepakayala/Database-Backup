/****** Object:  Table [dbo].[SelectionList]    Script Date: 5/15/2018 11:58:56 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SelectionList](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[ListName] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CategoryID] [int] NULL,
	[Format] [int] NULL,
	[DefaultListValue] [decimal](18, 4) NULL,
	[DefaultListCost] [float] NULL,
	[DefaultSecondaryListID] [int] NULL,
	[DefaultSecondaryListStoreID] [int] NULL,
	[DefaultSecondaryListClassTypeID] [int] NULL,
	[DefaultPriceFormula] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultCostFormula] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPartID] [int] NULL,
	[DefaultPartStoreID] [int] NULL,
	[DefaultPartClassTypeID] [int] NULL,
	[DefaultPartConsumptionFx] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultProperties] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultSecondaryListDefault] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPart2ID] [int] NULL,
	[DefaultPart2StoreID] [int] NULL,
	[DefaultPart2ClassTypeID] [int] NULL,
	[DefaultPart2ConsumptionFx] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankListValue] [float] NULL,
	[BlankListCost] [float] NULL,
	[BlankSecondaryListID] [int] NULL,
	[BlankSecondaryListStoreID] [int] NULL,
	[BlankSecondaryListClassTypeID] [int] NULL,
	[BlankPriceFormula] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankCostFormula] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankPartID] [int] NULL,
	[BlankPartStoreID] [int] NULL,
	[BlankPartClassTypeID] [int] NULL,
	[BlankPartConsumptionFx] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankProperties] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankSecondaryListBlank] [nvarchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankPart2ID] [int] NULL,
	[BlankPart2StoreID] [int] NULL,
	[BlankPart2ClassTypeID] [int] NULL,
	[BlankPart2ConsumptionFx] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankUseDefaultPart] [bit] NULL,
	[BlankUseDefaultPart2] [bit] NULL,
	[DefaultPriceFormulaType] [int] NULL,
	[DefaultCostFormulaType] [int] NULL,
	[BlankPriceFormulaType] [int] NULL,
	[BlankCostFormulaType] [int] NULL,
	[DefaultItemColor] [int] NULL,
	[BlankItemColor] [int] NULL,
	[DefaultPartDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPart2Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankPartDescription] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankPart2Description] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultPartLinksXML] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankPartLinksXML] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultDependentLinksXML] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankDependentLinksXML] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultFilters] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankFilters] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DefaultImageLinks] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlankImageLinks] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_SelectionList] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
