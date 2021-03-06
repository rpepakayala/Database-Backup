/****** Object:  Table [dbo].[Folder]    Script Date: 5/15/2018 12:01:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Folder](
	[FolderID] [int] IDENTITY(1,1) NOT NULL,
	[FolderTypeID] [int] NOT NULL,
	[FolderName] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FolderDescr] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FolderParentID] [int] NOT NULL,
 CONSTRAINT [PK_NAPFolder] PRIMARY KEY CLUSTERED 
(
	[FolderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[Folder]  WITH CHECK ADD  CONSTRAINT [FK_Folder_FolderType] FOREIGN KEY([FolderTypeID])
REFERENCES [dbo].[FolderType] ([FolderTypeID])
ALTER TABLE [dbo].[Folder] CHECK CONSTRAINT [FK_Folder_FolderType]
GO
