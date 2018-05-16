/****** Object:  Table [dbo].[OPMGRFLD]    Script Date: 5/15/2018 12:01:16 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[OPMGRFLD](
	[LOPID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FNAME] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FVALUE] [varchar](80) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[NOTES] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LINKEDDOC] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[U_FNAME] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
