/****** Object:  Table [dbo].[IMPEXP]    Script Date: 5/15/2018 12:01:15 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[IMPEXP](
	[RECTYPE] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[NUMBER1] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ENTRYDESC] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[OPTIONS1] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPTIONS2] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PARAMS] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTUSER] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LASTDATE] [datetime] NULL,
	[LASTTIME] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
