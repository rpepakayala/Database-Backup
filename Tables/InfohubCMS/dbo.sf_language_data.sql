/****** Object:  Table [dbo].[sf_language_data]    Script Date: 5/15/2018 12:01:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_language_data](
	[scheduled_date] [datetime] NULL,
	[publication_date] [datetime] NOT NULL,
	[last_modified] [datetime] NOT NULL,
	[language_version] [int] NOT NULL,
	[language] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[id] [uniqueidentifier] NOT NULL,
	[expiration_date] [datetime] NULL,
	[content_state] [int] NOT NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_language_data] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
