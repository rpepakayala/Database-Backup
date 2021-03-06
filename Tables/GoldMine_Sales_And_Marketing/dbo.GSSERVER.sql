/****** Object:  Table [dbo].[GSSERVER]    Script Date: 5/15/2018 12:01:15 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GSSERVER](
	[RECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MACHINEID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PROCID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PROCTYPE] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PROCNAME] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[AUTOSTART] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[MAXTASKS] [varchar](2) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SYNCPERIOD] [varchar](63) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPTIONS] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PARAMS] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CURRSTATUS] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
