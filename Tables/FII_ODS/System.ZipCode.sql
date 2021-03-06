/****** Object:  Table [System].[ZipCode]    Script Date: 5/15/2018 11:59:48 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[ZipCode](
	[zip] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[city] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[state] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[latitude] [float] NULL,
	[longitude] [float] NULL,
	[timezone] [decimal](9, 2) NULL,
	[dst] [bit] NOT NULL,
	[GeoLocation] [geography] NULL,
	[CountryCode] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ZipCode] PRIMARY KEY CLUSTERED 
(
	[zip] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IDX_ZipCountry]    Script Date: 5/15/2018 11:59:48 AM ******/
CREATE NONCLUSTERED INDEX [IDX_ZipCountry] ON [System].[ZipCode]
(
	[CountryCode] ASC
)
INCLUDE ( 	[zip]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [System].[ZipCode]  WITH CHECK ADD  CONSTRAINT [FK_ZipCode_CountryCodes] FOREIGN KEY([CountryCode])
REFERENCES [System].[CountryCodes] ([CountryCode])
ALTER TABLE [System].[ZipCode] CHECK CONSTRAINT [FK_ZipCode_CountryCodes]
GO
