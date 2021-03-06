/****** Object:  Table [dbo].[CONTHIST]    Script Date: 5/15/2018 12:01:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CONTHIST](
	[USERID] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ACCOUNTNO] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SRECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RECTYPE] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ONDATE] [datetime] NULL,
	[ONTIME] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ACTVCODE] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RESULTCODE] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STATUS] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DURATION] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UNITS] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[REF] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NOTES] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LINKRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LOPRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CREATEBY] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CREATEON] [datetime] NULL,
	[CREATEAT] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTUSER] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTDATE] [datetime] NULL,
	[LASTTIME] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
