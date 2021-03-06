/****** Object:  Table [dbo].[MSSLocations]    Script Date: 5/15/2018 12:05:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSLocations](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[InternalName] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[DisplayName] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[AdminDescription] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[LocationType] [tinyint] NOT NULL,
	[Author] [nvarchar](60) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Version] [nvarchar](50) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[IsDeletable] [bit] NOT NULL,
	[IsPrefixPattern] [bit] NOT NULL,
	[QueryReformatPattern] [nvarchar](512) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[QueryReformatPatternBig] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[PropertySchema] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[QueryRestriction] [nvarchar](512) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[KindsOfResults] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Languages] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[IsRestricted] [bit] NOT NULL,
	[AllowedSiteCollectionGuids] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[CreationDate] [datetime] NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_MSSLocations] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[InternalName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[MSSLocations] ADD  CONSTRAINT [DF_MSSLocations_IsDeletable]  DEFAULT ((0)) FOR [IsDeletable]
ALTER TABLE [dbo].[MSSLocations] ADD  CONSTRAINT [DF_MSSLocations_CreationDate]  DEFAULT (getutcdate()) FOR [CreationDate]
GO
