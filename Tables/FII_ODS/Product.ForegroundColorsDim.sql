/****** Object:  Table [Product].[ForegroundColorsDim]    Script Date: 5/15/2018 11:59:40 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Product].[ForegroundColorsDim](
	[ForegroundColorsKey] [int] IDENTITY(1,1) NOT NULL,
	[ForegroundColorsName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ForegroundColorsKey] PRIMARY KEY CLUSTERED 
(
	[ForegroundColorsKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Product].[ForegroundColorsDim] ADD  CONSTRAINT [DF_ForegroundColors_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
