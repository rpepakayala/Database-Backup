/****** Object:  Table [Product].[CostFormulaDim]    Script Date: 5/15/2018 11:59:39 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Product].[CostFormulaDim](
	[CostFormulaKey] [int] IDENTITY(1,1) NOT NULL,
	[CostFormulaName] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_CostFormulaKey] PRIMARY KEY CLUSTERED 
(
	[CostFormulaKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [Product].[CostFormulaDim] ADD  CONSTRAINT [DF_CostFormula_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
