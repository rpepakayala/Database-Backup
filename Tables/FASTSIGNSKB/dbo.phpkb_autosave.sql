/****** Object:  Table [dbo].[phpkb_autosave]    Script Date: 5/15/2018 11:59:16 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[phpkb_autosave](
	[autosaved_draft_id] [int] IDENTITY(1,1) NOT NULL,
	[draft_type] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[draft_title] [nvarchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[draft_content] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[draft_datetime] [smalldatetime] NOT NULL,
	[draft_reference_id] [int] NOT NULL,
	[author_id] [int] NOT NULL,
 CONSTRAINT [autosaved_draft_id] PRIMARY KEY CLUSTERED 
(
	[autosaved_draft_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[phpkb_autosave] ADD  DEFAULT ('article') FOR [draft_type]
ALTER TABLE [dbo].[phpkb_autosave] ADD  DEFAULT ('0') FOR [draft_reference_id]
ALTER TABLE [dbo].[phpkb_autosave]  WITH CHECK ADD  CONSTRAINT [fk___author_autosave] FOREIGN KEY([author_id])
REFERENCES [dbo].[phpkb_authors] ([author_id])
ALTER TABLE [dbo].[phpkb_autosave] CHECK CONSTRAINT [fk___author_autosave]
ALTER TABLE [dbo].[phpkb_autosave]  WITH CHECK ADD CHECK  (([draft_type]='news' OR [draft_type]='article'))
GO
