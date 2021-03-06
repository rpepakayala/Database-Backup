/****** Object:  Table [dbo].[SLS_KCLUB]    Script Date: 5/15/2018 11:58:38 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SLS_KCLUB](
	[kClubID] [bigint] IDENTITY(1,1) NOT NULL,
	[StoreID] [bigint] NOT NULL,
	[kClub] [int] NULL,
	[SalesDate] [datetime] NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
PRIMARY KEY NONCLUSTERED 
(
	[kClubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
