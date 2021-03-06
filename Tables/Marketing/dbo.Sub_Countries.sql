/****** Object:  Table [dbo].[Sub_Countries]    Script Date: 5/15/2018 12:02:37 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Sub_Countries](
	[CountryID] [int] NOT NULL,
	[Name] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ISO3166] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CultureInfo] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Sub_Countries] PRIMARY KEY CLUSTERED 
(
	[CountryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Sub_Countries] ADD  CONSTRAINT [DF_Sub_Countries_ISO3166]  DEFAULT (0) FOR [ISO3166]
GO
