/****** Object:  Table [dbo].[DTA_reports_partitionscheme]    Script Date: 5/15/2018 12:02:55 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DTA_reports_partitionscheme](
	[PartitionSchemeID] [int] IDENTITY(1,1) NOT NULL,
	[PartitionFunctionID] [int] NOT NULL,
	[PartitionSchemeName] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[PartitionSchemeDefinition] [ntext] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PartitionSchemeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

/****** Object:  Index [DTA_reports_partitionscheme_index]    Script Date: 5/15/2018 12:02:55 PM ******/
CREATE NONCLUSTERED INDEX [DTA_reports_partitionscheme_index] ON [dbo].[DTA_reports_partitionscheme]
(
	[PartitionFunctionID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
ALTER TABLE [dbo].[DTA_reports_partitionscheme]  WITH CHECK ADD FOREIGN KEY([PartitionFunctionID])
REFERENCES [dbo].[DTA_reports_partitionfunction] ([PartitionFunctionID])
ON DELETE CASCADE
GO
