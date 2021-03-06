/****** Object:  Table [dbo].[CoOpAmounts]    Script Date: 5/15/2018 12:02:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CoOpAmounts](
	[MediaCoOpTotalID] [int] IDENTITY(1,1) NOT NULL,
	[CoOpID] [int] NULL,
	[AmountEarned] [real] NULL,
	[AmountAvailable] [real] NULL,
	[Year] [int] NULL,
 CONSTRAINT [PK_MediaCoOpTotals] PRIMARY KEY CLUSTERED 
(
	[MediaCoOpTotalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
