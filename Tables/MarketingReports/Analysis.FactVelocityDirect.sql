/****** Object:  Table [Analysis].[FactVelocityDirect]    Script Date: 5/15/2018 12:02:46 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Analysis].[FactVelocityDirect](
	[FK_Date] [datetime] NOT NULL,
	[FK_Store] [int] NOT NULL,
	[Programs] [int] NOT NULL,
	[Appointments] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_FactVelocityDirect]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactVelocityDirect] ON [Analysis].[FactVelocityDirect]
(
	[FK_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IX_FactVelocityDirect_1]    Script Date: 5/15/2018 12:02:46 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactVelocityDirect_1] ON [Analysis].[FactVelocityDirect]
(
	[FK_Store] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Analysis].[FactVelocityDirect]  WITH CHECK ADD  CONSTRAINT [FK_FactVelocityDirect_DimDate] FOREIGN KEY([FK_Date])
REFERENCES [Analysis].[DimDate] ([PK_Date])
ALTER TABLE [Analysis].[FactVelocityDirect] CHECK CONSTRAINT [FK_FactVelocityDirect_DimDate]
ALTER TABLE [Analysis].[FactVelocityDirect]  WITH CHECK ADD  CONSTRAINT [FK_FactVelocityDirect_DimStore] FOREIGN KEY([FK_Store])
REFERENCES [Analysis].[DimStore] ([PK_Store])
ALTER TABLE [Analysis].[FactVelocityDirect] CHECK CONSTRAINT [FK_FactVelocityDirect_DimStore]
GO
