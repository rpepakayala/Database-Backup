/****** Object:  Table [dbo].[RC_Inkjet]    Script Date: 5/15/2018 12:07:14 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[RC_Inkjet](
	[ReportID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[Q1] [int] NULL,
	[Q2] [int] NULL,
	[Q3] [int] NULL,
	[Q4] [int] NULL,
	[Q5] [int] NULL,
	[Q6] [int] NULL,
	[Q7] [int] NULL,
	[Q8] [int] NULL,
	[Q9] [int] NULL,
	[Q10] [int] NULL,
	[Q11] [int] NULL,
	[Q12] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q13] [int] NULL,
	[Q14] [int] NULL,
	[Q15] [int] NULL,
	[Q16] [int] NULL,
	[Q17] [int] NULL,
	[Q18] [int] NULL,
	[Q19] [int] NULL,
	[Q20] [int] NULL,
	[Q21] [int] NULL,
	[Q22] [int] NULL,
	[Q23] [int] NULL,
	[Q24] [int] NULL,
	[Q25] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Misc] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_RC_Inkjet] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
