/****** Object:  Table [dbo].[sf_rdsgn_media_query_link]    Script Date: 5/15/2018 12:02:01 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_rdsgn_media_query_link](
	[link_type] [int] NOT NULL,
	[last_modified] [datetime] NOT NULL,
	[item_type] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_id] [uniqueidentifier] NULL,
	[id] [uniqueidentifier] NOT NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_rdsgn_media_query_link] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
