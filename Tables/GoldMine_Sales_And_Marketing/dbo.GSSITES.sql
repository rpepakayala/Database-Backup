/****** Object:  Table [dbo].[GSSITES]    Script Date: 5/15/2018 12:01:15 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GSSITES](
	[RECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ACCOUNTNO] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[QPROCESS] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SYNCTYPE] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SITETYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USERID] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SECRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SITEID] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SNAME] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SPASSWORD] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CONTCO] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CALCO] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CALCO2] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NEXTSYNC] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LASTSYNC] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STARTSYNC] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NEXTCONTCO] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NEXTCALCO] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NXTSCONTCO] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NXTSCALCO] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NXTSSEND] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NXTSCREATE] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTRTRVTS] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTSESS] [varchar](13) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RETRIES] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPTIONS] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPTIONS2] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OVERRIDES] [varchar](12) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTRESULT] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LASTRPARAM] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CURRSTATUS] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PARAMS] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LOGRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
