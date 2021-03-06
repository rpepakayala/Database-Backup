/****** Object:  Table [dbo].[COR_STORE_DATES]    Script Date: 5/15/2018 11:58:37 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[COR_STORE_DATES](
	[StoreDateID] [bigint] IDENTITY(1,1) NOT NULL,
	[StoreID] [bigint] NULL,
	[beginstatus] [bigint] NOT NULL,
	[begindate] [datetime] NOT NULL,
	[AuditID] [bigint] NULL,
	[Status] [bigint] NULL,
	[personid] [bigint] NULL,
	[EndStatus] [bigint] NULL,
	[EndingDate] [datetime] NULL,
	[StoreNumber] [bigint] NULL,
 CONSTRAINT [PK_COR_STORE_DATES] PRIMARY KEY CLUSTERED 
(
	[StoreDateID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
