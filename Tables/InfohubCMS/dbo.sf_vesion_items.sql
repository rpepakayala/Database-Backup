/****** Object:  Table [dbo].[sf_vesion_items]    Script Date: 5/15/2018 12:02:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_vesion_items](
	[type_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[trunk_id] [uniqueidentifier] NULL,
	[last_version] [int] NOT NULL,
	[id2] [uniqueidentifier] NULL,
	[last_modified] [datetime] NOT NULL,
	[synced] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[app_name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_vesion_items] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
