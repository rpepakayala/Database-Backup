/****** Object:  Table [dbo].[ModelItemPolicy]    Script Date: 5/15/2018 12:05:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ModelItemPolicy](
	[ID] [uniqueidentifier] NOT NULL,
	[CatalogItemID] [uniqueidentifier] NOT NULL,
	[ModelItemID] [nvarchar](425) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[PolicyID] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_ModelItemPolicy] PRIMARY KEY NONCLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_ModelItemPolicy]    Script Date: 5/15/2018 12:05:00 PM ******/
CREATE CLUSTERED INDEX [IX_ModelItemPolicy] ON [dbo].[ModelItemPolicy]
(
	[CatalogItemID] ASC,
	[ModelItemID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[ModelItemPolicy]  WITH NOCHECK ADD  CONSTRAINT [FK_PoliciesPolicyID] FOREIGN KEY([PolicyID])
REFERENCES [dbo].[Policies] ([PolicyID])
ON DELETE CASCADE
ALTER TABLE [dbo].[ModelItemPolicy] CHECK CONSTRAINT [FK_PoliciesPolicyID]
GO
