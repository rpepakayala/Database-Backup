/****** Object:  Table [dbo].[MSSPropagationSearchServerTable]    Script Date: 5/15/2018 12:09:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSPropagationSearchServerTable](
	[SearchServerID] [int] IDENTITY(0,1) NOT NULL,
	[SearchServerName] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[IndexDirectory] [nvarchar](260) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[MachineStatus] [int] NULL,
	[LastPropagationTime] [datetime] NOT NULL,
UNIQUE NONCLUSTERED 
(
	[SearchServerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
