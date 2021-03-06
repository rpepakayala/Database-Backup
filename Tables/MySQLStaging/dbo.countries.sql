/****** Object:  Table [dbo].[countries]    Script Date: 5/15/2018 12:04:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[countries](
	[country_id] [int] IDENTITY(258,1) NOT NULL,
	[code] [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[active] [int] NULL,
 CONSTRAINT [PK_countries_country_id] PRIMARY KEY CLUSTERED 
(
	[country_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[countries] ADD  DEFAULT (NULL) FOR [code]
ALTER TABLE [dbo].[countries] ADD  DEFAULT (NULL) FOR [name]
ALTER TABLE [dbo].[countries] ADD  DEFAULT ((1)) FOR [active]
GO
