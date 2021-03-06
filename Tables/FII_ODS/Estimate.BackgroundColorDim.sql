/****** Object:  Table [Estimate].[BackgroundColorDim]    Script Date: 5/15/2018 11:59:29 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Estimate].[BackgroundColorDim](
	[BackgroundColorKey] [int] IDENTITY(1,1) NOT NULL,
	[BackgroundColorName] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_BackgroundColorKey] PRIMARY KEY CLUSTERED 
(
	[BackgroundColorKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Estimate].[BackgroundColorDim] ADD  CONSTRAINT [DF_BackgroundColor_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
