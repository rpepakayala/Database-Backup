/****** Object:  Table [dbo].[ImportWarnings]    Script Date: 5/15/2018 12:02:50 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ImportWarnings](
	[ImportId] [int] NOT NULL,
	[LogId] [int] NOT NULL,
 CONSTRAINT [pk_ImportWarnings] PRIMARY KEY CLUSTERED 
(
	[ImportId] ASC,
	[LogId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ImportWarnings]  WITH CHECK ADD  CONSTRAINT [ref_ImportWarnings_OASyncLog] FOREIGN KEY([LogId])
REFERENCES [dbo].[OASyncLog] ([Id])
ALTER TABLE [dbo].[ImportWarnings] CHECK CONSTRAINT [ref_ImportWarnings_OASyncLog]
ALTER TABLE [dbo].[ImportWarnings]  WITH CHECK ADD  CONSTRAINT [ref_ImprtWrnngs_OASyn_907689F8] FOREIGN KEY([ImportId])
REFERENCES [dbo].[OASyncImportSummary] ([Id])
ALTER TABLE [dbo].[ImportWarnings] CHECK CONSTRAINT [ref_ImprtWrnngs_OASyn_907689F8]
GO
