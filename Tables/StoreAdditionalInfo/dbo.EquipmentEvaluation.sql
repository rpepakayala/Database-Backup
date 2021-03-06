/****** Object:  Table [dbo].[EquipmentEvaluation]    Script Date: 5/15/2018 12:06:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[EquipmentEvaluation](
	[EquipmentEvaluationID] [int] IDENTITY(1,1) NOT NULL,
	[EquipmentModelID] [bigint] NOT NULL,
	[EvaluationDescr] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EvaluationURL] [nvarchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_EquipmentEvaluation] PRIMARY KEY CLUSTERED 
(
	[EquipmentEvaluationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_EquipmentEvaluation]    Script Date: 5/15/2018 12:06:34 PM ******/
CREATE NONCLUSTERED INDEX [IX_EquipmentEvaluation] ON [dbo].[EquipmentEvaluation]
(
	[EquipmentModelID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[EquipmentEvaluation]  WITH CHECK ADD  CONSTRAINT [FK_EquipmentEvaluation_EquipmentModel] FOREIGN KEY([EquipmentModelID])
REFERENCES [dbo].[EquipmentModel] ([EquipmentModel_Id])
ALTER TABLE [dbo].[EquipmentEvaluation] CHECK CONSTRAINT [FK_EquipmentEvaluation_EquipmentModel]
GO
