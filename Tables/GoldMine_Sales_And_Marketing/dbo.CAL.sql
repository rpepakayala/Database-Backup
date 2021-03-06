/****** Object:  Table [dbo].[CAL]    Script Date: 5/15/2018 12:01:11 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CAL](
	[USERID] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ACCOUNTNO] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ONDATE] [datetime] NULL,
	[ONTIME] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ENDDATE] [datetime] NULL,
	[ALARMFLAG] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ALARMTIME] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ALARMDATE] [datetime] NULL,
	[ACTVCODE] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RSVP] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DURATION] [smallint] NULL,
	[RECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ACONFIRM] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[APPTUSER] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STATUS] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DIRCODE] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NUMBER1] [float] NULL,
	[NUMBER2] [int] NULL,
	[COMPANY] [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[REF] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NOTES] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LINKRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LDOCRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
