/****** Object:  Table [dbo].[GenEvals]    Script Date: 5/15/2018 12:07:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[GenEvals](
	[EvalID] [int] IDENTITY(1,1) NOT FOR REPLICATION NOT NULL,
	[RegID] [int] NULL,
	[Name] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Title] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TrainingSession] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EvalDate] [datetime] NULL,
	[Instructors] [varchar](150) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q1] [int] NULL,
	[Q2] [int] NULL,
	[Q3] [int] NULL,
	[Q4] [int] NULL,
	[Q5] [int] NULL,
	[Q6] [int] NULL,
	[Q7] [int] NULL,
	[Q8] [int] NULL,
	[Q9] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q10] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q11] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q12] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q13] [int] NULL,
	[Q14] [int] NULL,
	[Q15] [int] NULL,
	[Q16] [int] NULL,
	[Q17] [int] NULL,
	[Q18] [int] NULL,
	[Q19] [int] NULL,
	[Q20] [int] NULL,
	[Q21] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q22] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q23] [int] NULL,
	[Q24] [int] NULL,
	[Q25] [int] NULL,
	[Q26] [int] NULL,
	[Q27] [int] NULL,
	[Q28] [int] NULL,
	[Q29] [int] NULL,
	[Q30] [int] NULL,
	[Q31] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q32] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q33] [int] NULL,
	[Q34] [int] NULL,
	[Q35] [int] NULL,
	[Q36] [int] NULL,
	[Q37] [int] NULL,
	[Q38] [int] NULL,
	[Q39] [int] NULL,
	[Q40] [int] NULL,
	[Q41] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q42] [varchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q43] [int] NULL,
	[Q44] [int] NULL,
	[Q45] [int] NULL,
	[Q46] [int] NULL,
	[Q47] [int] NULL,
	[Q48] [int] NULL,
	[Q49] [int] NULL,
	[Q50] [int] NULL,
	[Q51] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q52] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q53] [int] NULL,
	[Q54] [int] NULL,
	[Q55] [bit] NULL,
	[Q56] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q57] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Q58] [varchar](1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_Evals] PRIMARY KEY CLUSTERED 
(
	[EvalID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[GenEvals]  WITH CHECK ADD  CONSTRAINT [FK_GenEvals_Registrants] FOREIGN KEY([RegID])
REFERENCES [dbo].[Registrants] ([ID])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[GenEvals] CHECK CONSTRAINT [FK_GenEvals_Registrants]
GO
