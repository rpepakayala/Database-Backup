/****** Object:  Table [Analysis].[FactYearlySubsidy]    Script Date: 5/15/2018 12:02:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Analysis].[FactYearlySubsidy](
	[FK_Store] [int] NOT NULL,
	[FK_Year] [datetime] NOT NULL,
	[FK_Subsidy] [int] NOT NULL,
	[BaseAmount] [money] NOT NULL,
	[RemainingAmount] [money] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_FactYearlySubsidy]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactYearlySubsidy] ON [Analysis].[FactYearlySubsidy]
(
	[FK_Store] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_FactYearlySubsidy_1]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactYearlySubsidy_1] ON [Analysis].[FactYearlySubsidy]
(
	[FK_Subsidy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_FactYearlySubsidy_2]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactYearlySubsidy_2] ON [Analysis].[FactYearlySubsidy]
(
	[FK_Year] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Analysis].[FactYearlySubsidy]  WITH CHECK ADD  CONSTRAINT [FK_FactYearlySubsidy_DimDate] FOREIGN KEY([FK_Year])
REFERENCES [Analysis].[DimDate] ([PK_Date])
ALTER TABLE [Analysis].[FactYearlySubsidy] CHECK CONSTRAINT [FK_FactYearlySubsidy_DimDate]
ALTER TABLE [Analysis].[FactYearlySubsidy]  WITH CHECK ADD  CONSTRAINT [FK_FactYearlySubsidy_DimStore] FOREIGN KEY([FK_Store])
REFERENCES [Analysis].[DimStore] ([PK_Store])
ALTER TABLE [Analysis].[FactYearlySubsidy] CHECK CONSTRAINT [FK_FactYearlySubsidy_DimStore]
ALTER TABLE [Analysis].[FactYearlySubsidy]  WITH CHECK ADD  CONSTRAINT [FK_FactYearlySubsidy_DimSubsidy] FOREIGN KEY([FK_Subsidy])
REFERENCES [Analysis].[DimSubsidy] ([PK_Subsidy])
ALTER TABLE [Analysis].[FactYearlySubsidy] CHECK CONSTRAINT [FK_FactYearlySubsidy_DimSubsidy]
GO
