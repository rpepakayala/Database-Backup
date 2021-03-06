/****** Object:  Table [dbo].[ANLHistoricalWebUsage]    Script Date: 5/15/2018 12:05:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ANLHistoricalWebUsage](
	[DayId] [int] NOT NULL,
	[WebGuid] [uniqueidentifier] NOT NULL,
	[Hits] [int] NOT NULL,
	[UniqueUsers] [int] NOT NULL,
	[HomePageHits] [int] NOT NULL,
	[HomePageUniqueUsers] [int] NOT NULL,
 CONSTRAINT [PK_ANLHistoricalWebUsage] PRIMARY KEY CLUSTERED 
(
	[WebGuid] ASC,
	[DayId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
