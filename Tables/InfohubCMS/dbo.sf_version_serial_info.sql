/****** Object:  Table [dbo].[sf_version_serial_info]    Script Date: 5/15/2018 12:02:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_version_serial_info](
	[last_modified] [datetime] NULL,
	[id] [uniqueidentifier] NOT NULL,
	[formatter] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[app_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_version_serial_info] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
