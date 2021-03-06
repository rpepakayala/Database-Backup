/****** Object:  Table [dbo].[CONTUDEF]    Script Date: 5/15/2018 12:01:13 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CONTUDEF](
	[DBFNAME] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FIELD_NAME] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FIELD_TYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIELD_LEN] [smallint] NULL,
	[FIELD_DEC] [smallint] NULL,
	[FIELDDESC] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIELDNO] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FIELD_PICT] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LOCALLABEL] [varchar](18) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RACCESS] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WACCESS] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FLDOPTS] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[STATUS] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

GO
