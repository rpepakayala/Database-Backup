/****** Object:  Table [dbo].[SecData]    Script Date: 5/15/2018 12:02:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SecData](
	[SecDataID] [uniqueidentifier] NOT NULL,
	[PolicyID] [uniqueidentifier] NOT NULL,
	[AuthType] [int] NOT NULL,
	[XmlDescription] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[NtSecDescPrimary] [image] NOT NULL,
	[NtSecDescSecondary] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL,
 CONSTRAINT [PK_SecData] PRIMARY KEY NONCLUSTERED 
(
	[SecDataID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [IX_SecData]    Script Date: 5/15/2018 12:02:22 PM ******/
CREATE UNIQUE CLUSTERED INDEX [IX_SecData] ON [dbo].[SecData]
(
	[PolicyID] ASC,
	[AuthType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[SecData]  WITH NOCHECK ADD  CONSTRAINT [FK_SecDataPolicyID] FOREIGN KEY([PolicyID])
REFERENCES [dbo].[Policies] ([PolicyID])
ON DELETE CASCADE
ALTER TABLE [dbo].[SecData] CHECK CONSTRAINT [FK_SecDataPolicyID]
GO
