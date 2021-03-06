/****** Object:  Table [dbo].[INFOMINE]    Script Date: 5/15/2018 12:01:15 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[INFOMINE](
	[ACCOUNTNO] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CREATEBY] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECTYPE] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SORTKEY] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[TSECTION] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TOPIC] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[KEYWORDS] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPTIONS] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPTIONS1] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPTIONS2] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LINKEDDOC] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NOTES] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USERREAD] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USERWRITE] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTUSER] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTDATE] [datetime] NULL,
	[LASTTIME] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[U_TSECTION] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[U_TOPIC] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
