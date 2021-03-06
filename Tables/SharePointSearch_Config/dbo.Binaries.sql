/****** Object:  Table [dbo].[Binaries]    Script Date: 5/15/2018 12:06:05 PM ******/
SET ANSI_NULLS OFF
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Binaries](
	[ObjectId] [uniqueidentifier] NOT NULL,
	[FileImage] [image] NOT NULL,
 CONSTRAINT [PK_ObjectId] PRIMARY KEY CLUSTERED 
(
	[ObjectId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Binaries]  WITH CHECK ADD  CONSTRAINT [FK_Binaries1_Objects] FOREIGN KEY([ObjectId])
REFERENCES [dbo].[Objects] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[Binaries] CHECK CONSTRAINT [FK_Binaries1_Objects]
GO
