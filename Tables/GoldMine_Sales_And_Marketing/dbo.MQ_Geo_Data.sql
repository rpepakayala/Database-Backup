/****** Object:  Table [dbo].[MQ_Geo_Data]    Script Date: 5/15/2018 12:01:16 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MQ_Geo_Data](
	[Web_Num] [numeric](9, 0) NULL,
	[Col002] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Street] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Col005] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[State] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Country] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Zip] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Col010] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Col011] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Store_Num] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Col014] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Lat] [numeric](9, 0) NULL,
	[Long] [numeric](9, 0) NULL,
	[Data_Source] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
