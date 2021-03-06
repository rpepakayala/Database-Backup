/****** Object:  Table [dbo].[UserFieldDef]    Script Date: 5/15/2018 12:07:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[UserFieldDef](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[FieldName] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Description] [nvarchar](300) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DataType] [int] NULL,
	[AssociatedClassTypeID] [int] NULL,
	[FieldIndex] [int] NULL,
	[AnswerRequired] [bit] NULL,
	[Alignment] [int] NULL,
	[DisplayFormatString] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SortIndex] [int] NULL,
	[UseDropdownBox] [bit] NULL,
	[DropdownValues] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LimitToList] [bit] NULL,
	[CategoryName] [varchar](1024) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseDefaultColors] [bit] NULL,
	[DescriptionColor] [int] NULL,
	[AnswerColor] [int] NULL,
	[DescriptionFontColor] [int] NULL,
	[AnswerFontColor] [int] NULL,
	[AnswerRequiredOrd] [bit] NULL,
	[AnswerRequiredEst] [bit] NULL,
	[AnswerRequiredTemp] [bit] NULL,
	[AnswerRequiredST] [bit] NULL,
	[ShowOrder] [bit] NULL,
	[ShowEstimate] [bit] NULL,
	[ShowTemplate] [bit] NULL,
	[ShowService] [bit] NULL,
	[ShowClient] [bit] NULL,
	[ShowProspect] [bit] NULL,
	[ClearOnClone] [bit] NULL,
	[ClearOnConvert] [bit] NULL,
	[ShowFullContact] [bit] NULL,
	[ShowLimitedContact] [bit] NULL,
	[ShowVendor] [bit] NULL,
	[ShowPersonal] [bit] NULL,
	[AllowMultiSelect] [bit] NULL,
	[ShowMaterialPart] [bit] NULL,
	[ShowLaborPart] [bit] NULL,
	[ShowEquipmentPart] [bit] NULL,
	[ShowOutsourcePart] [bit] NULL,
	[ShowOtherPart] [bit] NULL,
	[ShowFreightPart] [bit] NULL,
	[ShowLocationPart] [bit] NULL,
	[SelectionListID] [int] NULL,
	[UseSelectionList] [bit] NULL,
	[DependentListName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DependentUDFName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UseListFromUDF] [bit] NULL,
	[DefaultFx] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [UserFieldDef_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Index_UserFieldDef_Description]    Script Date: 5/15/2018 12:07:02 PM ******/
CREATE NONCLUSTERED INDEX [Index_UserFieldDef_Description] ON [dbo].[UserFieldDef]
(
	[Description] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Index_UserFieldDef_FieldName]    Script Date: 5/15/2018 12:07:02 PM ******/
CREATE NONCLUSTERED INDEX [Index_UserFieldDef_FieldName] ON [dbo].[UserFieldDef]
(
	[FieldName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [Index_UserFieldDef_sidSelectionListID]    Script Date: 5/15/2018 12:07:02 PM ******/
CREATE NONCLUSTERED INDEX [Index_UserFieldDef_sidSelectionListID] ON [dbo].[UserFieldDef]
(
	[SelectionListID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
