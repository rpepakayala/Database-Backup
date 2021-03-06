/****** Object:  Table [System].[CountryCodes]    Script Date: 5/15/2018 12:02:17 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[CountryCodes](
	[CountryCode] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CountryCode3] [char](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountryNum] [smallint] NULL,
	[Country] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CountryCodes] PRIMARY KEY CLUSTERED 
(
	[CountryCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
