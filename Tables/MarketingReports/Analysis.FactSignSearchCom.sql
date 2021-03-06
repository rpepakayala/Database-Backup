/****** Object:  Table [Analysis].[FactSignSearchCom]    Script Date: 5/15/2018 12:02:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Analysis].[FactSignSearchCom](
	[FK_Date] [datetime] NOT NULL,
	[FK_Store] [int] NOT NULL,
	[ProfileViews] [int] NOT NULL,
	[CTR] [decimal](18, 4) NOT NULL,
	[MapViews] [int] NOT NULL,
	[GalleryViews] [int] NOT NULL,
	[VideoViews] [int] NOT NULL,
	[TextToMobileSends] [int] NOT NULL,
	[FeedbackViews] [int] NOT NULL,
	[LiteratureDownloads] [int] NOT NULL,
	[OtherLocationViews] [int] NOT NULL,
	[SpecialOrderClicks] [int] NOT NULL,
	[Emails] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_FactSignSearchCom]    Script Date: 5/15/2018 12:02:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactSignSearchCom] ON [Analysis].[FactSignSearchCom]
(
	[FK_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Index [IX_FactSignSearchCom_1]    Script Date: 5/15/2018 12:02:45 PM ******/
CREATE NONCLUSTERED INDEX [IX_FactSignSearchCom_1] ON [Analysis].[FactSignSearchCom]
(
	[FK_Store] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [Analysis].[FactSignSearchCom]  WITH CHECK ADD  CONSTRAINT [FK_FactSignSearchCom_DimDate] FOREIGN KEY([FK_Date])
REFERENCES [Analysis].[DimDate] ([PK_Date])
ALTER TABLE [Analysis].[FactSignSearchCom] CHECK CONSTRAINT [FK_FactSignSearchCom_DimDate]
ALTER TABLE [Analysis].[FactSignSearchCom]  WITH CHECK ADD  CONSTRAINT [FK_FactSignSearchCom_DimStore] FOREIGN KEY([FK_Store])
REFERENCES [Analysis].[DimStore] ([PK_Store])
ALTER TABLE [Analysis].[FactSignSearchCom] CHECK CONSTRAINT [FK_FactSignSearchCom_DimStore]
GO
