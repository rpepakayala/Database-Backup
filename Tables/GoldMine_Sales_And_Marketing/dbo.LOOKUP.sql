/****** Object:  Table [dbo].[LOOKUP]    Script Date: 5/15/2018 12:01:16 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[LOOKUP](
	[FIELDNAME] [varchar](11) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LOOKUPSUPP] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ENTRY] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[U_ENTRY] [varchar](40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[RECID] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

GO
