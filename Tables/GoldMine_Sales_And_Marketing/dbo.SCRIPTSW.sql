/****** Object:  Table [dbo].[SCRIPTSW]    Script Date: 5/15/2018 12:01:18 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SCRIPTSW](
	[RECTYPE] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[QUESTNO] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ANSNO] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TITLE] [varchar](60) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SAVEHIST] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USERKEYFLD] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[QUESTION] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FREQANS] [int] NULL,
	[ANSGOTO] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTUSER] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTDATE] [datetime] NULL,
	[LASTTIME] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
