/****** Object:  Table [Orders].[DescriptionDim]    Script Date: 5/15/2018 12:02:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[DescriptionDim](
	[DescriptionKey] [int] IDENTITY(1,1) NOT NULL,
	[DescriptionName] [varchar](2000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_DescriptionKey] PRIMARY KEY CLUSTERED 
(
	[DescriptionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
