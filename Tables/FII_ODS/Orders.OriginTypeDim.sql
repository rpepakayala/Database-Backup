/****** Object:  Table [Orders].[OriginTypeDim]    Script Date: 5/15/2018 11:59:37 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[OriginTypeDim](
	[OriginTypeKey] [int] IDENTITY(1,1) NOT NULL,
	[OriginTypeName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
	[MarketingCategory] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MarketingType] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_OriginTypeKey] PRIMARY KEY CLUSTERED 
(
	[OriginTypeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Orders].[OriginTypeDim] ADD  CONSTRAINT [DF_OriginType_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
