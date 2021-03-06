/****** Object:  Table [dbo].[Dependencies]    Script Date: 5/15/2018 12:06:06 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Dependencies](
	[ObjectId] [uniqueidentifier] NOT NULL,
	[DependantId] [uniqueidentifier] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_Dependencies_ObjectId]    Script Date: 5/15/2018 12:06:06 PM ******/
CREATE CLUSTERED INDEX [IX_Dependencies_ObjectId] ON [dbo].[Dependencies]
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[Dependencies]  WITH CHECK ADD  CONSTRAINT [FK_Dependencies1_Objects] FOREIGN KEY([ObjectId])
REFERENCES [dbo].[Objects] ([Id])
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies1_Objects]
ALTER TABLE [dbo].[Dependencies]  WITH CHECK ADD  CONSTRAINT [FK_Dependencies1_Objects1] FOREIGN KEY([DependantId])
REFERENCES [dbo].[Objects] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Dependencies] CHECK CONSTRAINT [FK_Dependencies1_Objects1]
GO
