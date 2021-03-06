/****** Object:  Table [dbo].[FORMS]    Script Date: 5/15/2018 12:01:14 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FORMS](
	[RECTYPE] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[USERID] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FLAGS] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TEMPLATE] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FORMDESC] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[APPNAME] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MACRO] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LINKEDDOC] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
