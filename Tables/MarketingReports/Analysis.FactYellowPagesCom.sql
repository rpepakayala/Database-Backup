/****** Object:  Table [Analysis].[FactYellowPagesCom]    Script Date: 5/15/2018 12:02:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Analysis].[FactYellowPagesCom](
	[FK_Date] [datetime] NOT NULL,
	[FK_Store] [int] NOT NULL,
	[Clicks] [int] NOT NULL,
	[Calls] [int] NOT NULL,
	[CPC] [money] NOT NULL,
	[CostByMonth] [money] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_FactYellowPagesCom]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactYellowPagesCom] ON [Analysis].[FactYellowPagesCom]
(
	[FK_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_FactYellowPagesCom_1]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactYellowPagesCom_1] ON [Analysis].[FactYellowPagesCom]
(
	[FK_Store] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [Analysis].[FactYellowPagesCom]  WITH CHECK ADD  CONSTRAINT [FK_FactYellowPagesCom_DimDate] FOREIGN KEY([FK_Date])
REFERENCES [Analysis].[DimDate] ([PK_Date])
ALTER TABLE [Analysis].[FactYellowPagesCom] CHECK CONSTRAINT [FK_FactYellowPagesCom_DimDate]
ALTER TABLE [Analysis].[FactYellowPagesCom]  WITH CHECK ADD  CONSTRAINT [FK_FactYellowPagesCom_DimStore] FOREIGN KEY([FK_Store])
REFERENCES [Analysis].[DimStore] ([PK_Store])
ALTER TABLE [Analysis].[FactYellowPagesCom] CHECK CONSTRAINT [FK_FactYellowPagesCom_DimStore]
GO
