/****** Object:  Table [dbo].[SEC_USERS]    Script Date: 5/15/2018 11:59:14 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SEC_USERS](
	[UserID] [int] NOT NULL,
	[Username] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Password] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[FirstName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LastName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Email] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DateCreated] [datetime] NULL,
	[DateLastModified] [datetime] NULL
) ON [PRIMARY]

GO
