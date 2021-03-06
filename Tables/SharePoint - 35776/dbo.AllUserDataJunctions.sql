/****** Object:  Table [dbo].[AllUserDataJunctions]    Script Date: 5/15/2018 12:05:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AllUserDataJunctions](
	[tp_SiteId] [uniqueidentifier] NOT NULL,
	[tp_DeleteTransactionId] [varbinary](16) NOT NULL,
	[tp_IsCurrentVersion] [bit] NOT NULL,
	[tp_DirName] [nvarchar](256) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_LeafName] [nvarchar](128) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[tp_FieldId] [uniqueidentifier] NULL,
	[tp_CalculatedVersion] [int] NOT NULL,
	[tp_Level] [tinyint] NOT NULL,
	[tp_UIVersion] [int] NOT NULL,
	[tp_Id] [int] NOT NULL,
	[tp_Ordinal] [int] NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [AllUserDataJunctions_PK]    Script Date: 5/15/2018 12:05:33 PM ******/
CREATE UNIQUE CLUSTERED INDEX [AllUserDataJunctions_PK] ON [dbo].[AllUserDataJunctions]
(
	[tp_SiteId] ASC,
	[tp_DeleteTransactionId] ASC,
	[tp_IsCurrentVersion] ASC,
	[tp_DirName] ASC,
	[tp_LeafName] ASC,
	[tp_FieldId] ASC,
	[tp_CalculatedVersion] ASC,
	[tp_Level] ASC,
	[tp_Ordinal] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[AllUserDataJunctions] ADD  DEFAULT (0x) FOR [tp_DeleteTransactionId]
ALTER TABLE [dbo].[AllUserDataJunctions] ADD  DEFAULT (CONVERT([bit],(1),0)) FOR [tp_IsCurrentVersion]
ALTER TABLE [dbo].[AllUserDataJunctions] ADD  DEFAULT ((1)) FOR [tp_Level]
GO
