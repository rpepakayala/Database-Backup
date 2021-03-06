/****** Object:  Table [dbo].[MAILBOX]    Script Date: 5/15/2018 12:01:16 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MAILBOX](
	[LINKRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FLAGS] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[USERID] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FOLDER] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FOLDER2] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[ACCOUNTNO] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[CREATEON] [datetime] NULL,
	[MAILSIZE] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILDATE] [datetime] NULL,
	[MAILTIME] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MAILREF] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LOPRECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RFC822] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
