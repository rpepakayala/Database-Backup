/****** Object:  Table [System].[GalaxyVendors]    Script Date: 5/15/2018 11:59:47 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [System].[GalaxyVendors](
	[ID] [int] NOT NULL,
	[recordid] [int] NULL,
	[status_activity] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vendor_company] [nvarchar](65) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Name] [nvarchar](101) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_street_1] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_street_2] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_city] [nvarchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_state] [nvarchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_ZIP] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[addr_country] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[vendor_type] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Phone] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Extension] [nvarchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fax] [nvarchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GeoLocation] [geography] NULL,
	[lat] [float] NULL,
	[long] [float] NULL,
	[web] [int] NULL,
	[ExternalKey] [nvarchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Type] [int] NULL,
	[CenterNumber] [int] NULL,
	[WebNumber] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
