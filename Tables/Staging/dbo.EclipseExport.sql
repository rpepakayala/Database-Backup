/****** Object:  Table [dbo].[EclipseExport]    Script Date: 5/15/2018 12:06:19 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[EclipseExport](
	[ID] [int] NULL,
	[RECORDID] [int] NULL,
	[status_activity] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vendor_company] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_street_1] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_street_2] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_city] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_state] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_ZIP] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_country] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_status] [tinyint] NULL,
	[vendor_type] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Extension] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FAX] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GeoLocation] [varbinary](max) NULL,
	[lat] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[long] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vendor_Website] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[web] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
