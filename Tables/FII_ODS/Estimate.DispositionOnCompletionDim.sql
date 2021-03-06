/****** Object:  Table [Estimate].[DispositionOnCompletionDim]    Script Date: 5/15/2018 11:59:30 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Estimate].[DispositionOnCompletionDim](
	[DispositionOnCompletionKey] [int] IDENTITY(1,1) NOT NULL,
	[DispositionOnCompletionName] [varchar](9) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_DispositionOnCompletionKey] PRIMARY KEY CLUSTERED 
(
	[DispositionOnCompletionKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Estimate].[DispositionOnCompletionDim] ADD  CONSTRAINT [DF_DispositionOnCompletion_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
