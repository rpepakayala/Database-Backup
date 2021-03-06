/****** Object:  Table [dbo].[MSSScopeDisplayGroupMemberships]    Script Date: 5/15/2018 12:09:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSScopeDisplayGroupMemberships](
	[DisplayGroupID] [int] NOT NULL,
	[ScopeID] [int] NOT NULL,
	[Rank] [int] NOT NULL
) ON [PRIMARY]

/****** Object:  Index [IX_ScopeDisplayGroupMemberships_DisplayGroupID]    Script Date: 5/15/2018 12:09:11 PM ******/
CREATE CLUSTERED INDEX [IX_ScopeDisplayGroupMemberships_DisplayGroupID] ON [dbo].[MSSScopeDisplayGroupMemberships]
(
	[DisplayGroupID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[MSSScopeDisplayGroupMemberships]  WITH CHECK ADD  CONSTRAINT [FK_ScopeDisplayGroupMemberships_ScopeID] FOREIGN KEY([ScopeID])
REFERENCES [dbo].[MSSScopes] ([ScopeID])
ON DELETE CASCADE
ALTER TABLE [dbo].[MSSScopeDisplayGroupMemberships] CHECK CONSTRAINT [FK_ScopeDisplayGroupMemberships_ScopeID]
GO
