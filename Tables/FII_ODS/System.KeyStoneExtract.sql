/****** Object:  Table [System].[KeyStoneExtract]    Script Date: 5/15/2018 11:59:47 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[KeyStoneExtract](
	[StoreNumber] [int] NOT NULL,
	[ConversionDate] [datetime] NOT NULL,
	[Finished] [bit] NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[FirstGenDate] [datetime] NOT NULL,
	[FinalConvDate] [datetime] NULL,
	[CutOverDate] [datetime] NULL,
 CONSTRAINT [PK_kEYsTONEeXTRACT] PRIMARY KEY CLUSTERED 
(
	[StoreNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [System].[KeyStoneExtract] ADD  CONSTRAINT [DF_KeyStoneExtract_CreatedDate]  DEFAULT (getdate()) FOR [CreatedDate]
GO
