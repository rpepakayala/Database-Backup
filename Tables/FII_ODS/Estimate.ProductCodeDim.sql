/****** Object:  Table [Estimate].[ProductCodeDim]    Script Date: 5/15/2018 11:59:31 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Estimate].[ProductCodeDim](
	[ProductCodeKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductCodeName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ProductCodeKey] PRIMARY KEY CLUSTERED 
(
	[ProductCodeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Estimate].[ProductCodeDim] ADD  CONSTRAINT [DF_ProductCode_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
