/****** Object:  Table [dbo].[TRACKS]    Script Date: 5/15/2018 12:01:18 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TRACKS](
	[RECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TRACKNO] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EVENTNO] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[EVENTTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NAME] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TRIGGERTYP] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ACTNTYPE] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NEXTACTN] [smallint] NULL,
	[USERID] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[USERTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIELD] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ACTVAGE] [smallint] NULL,
	[TOPTION1] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TOPTION2] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AOPTION1] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AOPTION2] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AOPTION3] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FILTEREXPR] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CONDEXPR] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[UPDTEXPR] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[U_NAME] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
