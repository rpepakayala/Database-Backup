/****** Object:  Table [Estimate].[SignTextDim]    Script Date: 5/15/2018 11:59:32 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Estimate].[SignTextDim](
	[SignTextKey] [int] IDENTITY(1,1) NOT NULL,
	[SignTextName] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_SignTextKey] PRIMARY KEY CLUSTERED 
(
	[SignTextKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [Estimate].[SignTextDim] ADD  CONSTRAINT [DF_SignText_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
