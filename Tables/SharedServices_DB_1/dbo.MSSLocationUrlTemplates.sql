/****** Object:  Table [dbo].[MSSLocationUrlTemplates]    Script Date: 5/15/2018 12:05:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSLocationUrlTemplates](
	[LocationId] [int] NOT NULL,
	[UrlTemplate] [nvarchar](2048) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[TemplateType] [tinyint] NOT NULL,
 CONSTRAINT [PK_MSSLocationUrlTemplates] PRIMARY KEY CLUSTERED 
(
	[LocationId] ASC,
	[TemplateType] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[MSSLocationUrlTemplates]  WITH CHECK ADD  CONSTRAINT [FK_MSSLocationUrlTemplates_MSSLocations] FOREIGN KEY([LocationId])
REFERENCES [dbo].[MSSLocations] ([Id])
ALTER TABLE [dbo].[MSSLocationUrlTemplates] CHECK CONSTRAINT [FK_MSSLocationUrlTemplates_MSSLocations]
GO
