/****** Object:  Table [Store].[StoreTypeDim]    Script Date: 5/15/2018 11:59:45 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Store].[StoreTypeDim](
	[StoreTypeKey] [int] IDENTITY(1,1) NOT NULL,
	[StoreTypeName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_StoreTypeKey] PRIMARY KEY CLUSTERED 
(
	[StoreTypeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Store].[StoreTypeDim] ADD  CONSTRAINT [DF_StoreType_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
