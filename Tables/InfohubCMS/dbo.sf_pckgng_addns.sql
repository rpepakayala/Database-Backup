/****** Object:  Table [dbo].[sf_pckgng_addns]    Script Date: 5/15/2018 12:01:56 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_pckgng_addns](
	[version] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addn_id] [uniqueidentifier] NOT NULL,
	[description] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[author] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_sf_pckgng_addns] PRIMARY KEY CLUSTERED 
(
	[addn_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
