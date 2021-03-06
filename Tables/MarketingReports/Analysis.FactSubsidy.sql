/****** Object:  Table [Analysis].[FactSubsidy]    Script Date: 5/15/2018 12:02:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Analysis].[FactSubsidy](
	[FK_DateFrom] [datetime] NOT NULL,
	[FK_DateTo] [datetime] NOT NULL,
	[FK_Store] [int] NOT NULL,
	[FK_Subsidy] [int] NOT NULL,
	[TransactionID] [int] NOT NULL,
	[InvoiceAmount] [money] NOT NULL,
	[ClaimedAmount] [money] NOT NULL,
	[RemainingAmount] [money] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_FactSubsidy]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactSubsidy] ON [Analysis].[FactSubsidy]
(
	[FK_DateFrom] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_FactSubsidy_1]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactSubsidy_1] ON [Analysis].[FactSubsidy]
(
	[FK_DateTo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_FactSubsidy_2]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactSubsidy_2] ON [Analysis].[FactSubsidy]
(
	[FK_Store] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_FactSubsidy_3]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactSubsidy_3] ON [Analysis].[FactSubsidy]
(
	[FK_Subsidy] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Analysis].[FactSubsidy]  WITH CHECK ADD  CONSTRAINT [FK_FactSubsidy_DimDate] FOREIGN KEY([FK_DateFrom])
REFERENCES [Analysis].[DimDate] ([PK_Date])
ALTER TABLE [Analysis].[FactSubsidy] CHECK CONSTRAINT [FK_FactSubsidy_DimDate]
ALTER TABLE [Analysis].[FactSubsidy]  WITH CHECK ADD  CONSTRAINT [FK_FactSubsidy_DimDate1] FOREIGN KEY([FK_DateTo])
REFERENCES [Analysis].[DimDate] ([PK_Date])
ALTER TABLE [Analysis].[FactSubsidy] CHECK CONSTRAINT [FK_FactSubsidy_DimDate1]
ALTER TABLE [Analysis].[FactSubsidy]  WITH CHECK ADD  CONSTRAINT [FK_FactSubsidy_DimStore] FOREIGN KEY([FK_Store])
REFERENCES [Analysis].[DimStore] ([PK_Store])
ALTER TABLE [Analysis].[FactSubsidy] CHECK CONSTRAINT [FK_FactSubsidy_DimStore]
ALTER TABLE [Analysis].[FactSubsidy]  WITH CHECK ADD  CONSTRAINT [FK_FactSubsidy_DimSubsidy] FOREIGN KEY([FK_Subsidy])
REFERENCES [Analysis].[DimSubsidy] ([PK_Subsidy])
ALTER TABLE [Analysis].[FactSubsidy] CHECK CONSTRAINT [FK_FactSubsidy_DimSubsidy]
GO
