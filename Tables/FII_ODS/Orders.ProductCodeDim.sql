/****** Object:  Table [Orders].[ProductCodeDim]    Script Date: 5/15/2018 11:59:37 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[ProductCodeDim](
	[ProductCodeKey] [int] IDENTITY(1,1) NOT NULL,
	[ProductCodeName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ProductCodeKey] PRIMARY KEY CLUSTERED 
(
	[ProductCodeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_ProductCodeName]    Script Date: 5/15/2018 11:59:37 AM ******/
CREATE NONCLUSTERED INDEX [Hint_ProductCodeName] ON [Orders].[ProductCodeDim]
(
	[ProductCodeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Orders].[ProductCodeDim] ADD  CONSTRAINT [DF_ProductCode_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
