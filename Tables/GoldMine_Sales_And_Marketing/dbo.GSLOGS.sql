/****** Object:  Table [dbo].[GSLOGS]    Script Date: 5/15/2018 12:01:15 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GSLOGS](
	[SLRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LOGTYPE] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ACCOUNTNO] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TABLEID] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SYNCSTAMP] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LOGSTAMP] [varchar](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FIELDNAME] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OLDVALUE] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NEWVALUE] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USERID] [varchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PARAMS] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
