/****** Object:  Table [dbo].[Tombstones]    Script Date: 5/15/2018 12:06:08 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Tombstones](
	[Id] [uniqueidentifier] NOT NULL,
	[Version] [timestamp] NOT NULL,
 CONSTRAINT [PK_Tombstones] PRIMARY KEY NONCLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

/****** Object:  Index [IX_Tombstones_Version]    Script Date: 5/15/2018 12:06:08 PM ******/
CREATE CLUSTERED INDEX [IX_Tombstones_Version] ON [dbo].[Tombstones]
(
	[Version] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
