/****** Object:  Table [Product].[QuestionDim]    Script Date: 5/15/2018 11:59:42 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Product].[QuestionDim](
	[QuestionKey] [int] IDENTITY(1,1) NOT NULL,
	[QuestionName] [varchar](128) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_QuestionKey] PRIMARY KEY CLUSTERED 
(
	[QuestionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Product].[QuestionDim] ADD  CONSTRAINT [DF_Question_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
