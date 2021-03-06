/****** Object:  Table [dbo].[SYSLOG]    Script Date: 5/15/2018 12:01:18 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SYSLOG](
	[RECTYPE] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PID] [varchar](33) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[SITEID] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ONDATE] [datetime] NULL,
	[ONTIME] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RESULTCODE] [varchar](3) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USERID] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[REF] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PARAMS] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
