/****** Object:  Table [dbo].[RC_AdvEDGE]    Script Date: 5/15/2018 12:07:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[RC_AdvEDGE](
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
	[Q12] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Misc] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_RC_AdvEDGE] PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
