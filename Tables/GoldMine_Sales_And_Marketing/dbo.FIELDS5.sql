/****** Object:  Table [dbo].[FIELDS5]    Script Date: 5/15/2018 12:01:14 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[FIELDS5](
	[RECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[VIEWID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FLDPOS] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FCOL] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FROW] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LABEL] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LABELSIZE] [smallint] NULL,
	[EDITSIZE] [smallint] NULL,
	[USERID] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NTXNO] [smallint] NULL,
	[FTYPE] [smallint] NULL,
	[FLDNAME] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EXPR] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
