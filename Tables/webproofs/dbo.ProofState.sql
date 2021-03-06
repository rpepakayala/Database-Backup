/****** Object:  Table [dbo].[ProofState]    Script Date: 5/15/2018 12:09:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProofState](
	[ProofStateId] [bigint] IDENTITY(1,1) NOT NULL,
	[StateLabel] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StateDesc] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[RowVersion] [timestamp] NOT NULL,
 CONSTRAINT [PK_CurrentProofState_Id] PRIMARY KEY CLUSTERED 
(
	[ProofStateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
