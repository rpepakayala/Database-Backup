/****** Object:  Table [Analysis].[FactAria]    Script Date: 5/15/2018 12:02:44 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Analysis].[FactAria](
	[FK_Date] [datetime] NOT NULL,
	[FK_Store] [int] NOT NULL,
	[Programs] [int] NOT NULL,
	[Appointments] [int] NOT NULL,
	[Leads] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_FactAria]    Script Date: 5/15/2018 12:02:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactAria] ON [Analysis].[FactAria]
(
	[FK_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_FactAria_1]    Script Date: 5/15/2018 12:02:44 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactAria_1] ON [Analysis].[FactAria]
(
	[FK_Store] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Analysis].[FactAria]  WITH CHECK ADD  CONSTRAINT [FK_FactAria_DimDate] FOREIGN KEY([FK_Date])
REFERENCES [Analysis].[DimDate] ([PK_Date])
ALTER TABLE [Analysis].[FactAria] CHECK CONSTRAINT [FK_FactAria_DimDate]
ALTER TABLE [Analysis].[FactAria]  WITH CHECK ADD  CONSTRAINT [FK_FactAria_DimStore] FOREIGN KEY([FK_Store])
REFERENCES [Analysis].[DimStore] ([PK_Store])
ALTER TABLE [Analysis].[FactAria] CHECK CONSTRAINT [FK_FactAria_DimStore]
GO
