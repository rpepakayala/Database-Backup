/****** Object:  Table [Contact].[CountryDim]    Script Date: 5/15/2018 11:59:21 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Contact].[CountryDim](
	[CountryKey] [int] IDENTITY(1,1) NOT NULL,
	[CountryName] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
	[CountryCode] [char](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CountryKey] PRIMARY KEY CLUSTERED 
(
	[CountryKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Contact].[CountryDim] ADD  CONSTRAINT [DF_Country_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
