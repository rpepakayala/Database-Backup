/****** Object:  Table [dbo].[TimerLock]    Script Date: 5/15/2018 12:05:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TimerLock](
	[ID] [int] NOT NULL,
	[LockedBy] [nvarchar](255) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[LockedTime] [datetime] NOT NULL,
 CONSTRAINT [TimerLock_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
