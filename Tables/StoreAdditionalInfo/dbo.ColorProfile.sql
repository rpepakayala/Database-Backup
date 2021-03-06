/****** Object:  Table [dbo].[ColorProfile]    Script Date: 5/15/2018 12:06:34 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ColorProfile](
	[FileName] [varchar](256) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Equipment_Id] [bigint] NULL,
	[Software_Id] [bigint] NULL,
	[LinkName] [varchar](64) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ColorProfile_Id] [bigint] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_ColorProfile_Id] PRIMARY KEY CLUSTERED 
(
	[ColorProfile_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[ColorProfile]  WITH CHECK ADD  CONSTRAINT [FK_ColorProfile_Equipment] FOREIGN KEY([Equipment_Id])
REFERENCES [dbo].[Equipment] ([Equipment_Id])
ALTER TABLE [dbo].[ColorProfile] CHECK CONSTRAINT [FK_ColorProfile_Equipment]
GO
