/****** Object:  Table [Analysis].[FactDexKnowsCom]    Script Date: 5/15/2018 12:02:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Analysis].[FactDexKnowsCom](
	[FK_Date] [datetime] NOT NULL,
	[FK_Store] [int] NOT NULL,
	[Clicks] [int] NOT NULL,
	[CPC] [money] NOT NULL,
	[CostByMonth] [money] NOT NULL,
	[Calls] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_FactDexKnowsCom]    Script Date: 5/15/2018 12:02:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactDexKnowsCom] ON [Analysis].[FactDexKnowsCom]
(
	[FK_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_FactDexKnowsCom_1]    Script Date: 5/15/2018 12:02:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactDexKnowsCom_1] ON [Analysis].[FactDexKnowsCom]
(
	[FK_Store] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [Analysis].[FactDexKnowsCom]  WITH CHECK ADD  CONSTRAINT [FK_FactDexKnowsCom_DimDate] FOREIGN KEY([FK_Date])
REFERENCES [Analysis].[DimDate] ([PK_Date])
ALTER TABLE [Analysis].[FactDexKnowsCom] CHECK CONSTRAINT [FK_FactDexKnowsCom_DimDate]
ALTER TABLE [Analysis].[FactDexKnowsCom]  WITH CHECK ADD  CONSTRAINT [FK_FactDexKnowsCom_DimStore] FOREIGN KEY([FK_Store])
REFERENCES [Analysis].[DimStore] ([PK_Store])
ALTER TABLE [Analysis].[FactDexKnowsCom] CHECK CONSTRAINT [FK_FactDexKnowsCom_DimStore]
GO
