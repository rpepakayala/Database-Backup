/****** Object:  Table [dbo].[sf_meta_type_descriptions]    Script Date: 5/15/2018 12:01:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_meta_type_descriptions](
	[id] [uniqueidentifier] NOT NULL,
	[app_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[meta_type_id] [uniqueidentifier] NULL,
	[user_friendly_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[description] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_meta_type_descriptions] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
