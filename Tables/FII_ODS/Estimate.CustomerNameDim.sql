/****** Object:  Table [Estimate].[CustomerNameDim]    Script Date: 5/15/2018 11:59:29 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Estimate].[CustomerNameDim](
	[CustomerNameKey] [int] IDENTITY(1,1) NOT NULL,
	[CustomerNameName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_CustomerNameKey] PRIMARY KEY CLUSTERED 
(
	[CustomerNameKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Estimate].[CustomerNameDim] ADD  CONSTRAINT [DF_CustomerName_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
