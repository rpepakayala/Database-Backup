/****** Object:  Table [dbo].[MSSLocationAuthentication]    Script Date: 5/15/2018 12:05:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSLocationAuthentication](
	[LocationId] [int] NOT NULL,
	[Type] [tinyint] NOT NULL,
	[Data] [ntext] COLLATE Latin1_General_CI_AS_KS_WS NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[MSSLocationAuthentication]  WITH CHECK ADD  CONSTRAINT [FK_MSSLocationAuthentication_MSSLocations] FOREIGN KEY([LocationId])
REFERENCES [dbo].[MSSLocations] ([Id])
ALTER TABLE [dbo].[MSSLocationAuthentication] CHECK CONSTRAINT [FK_MSSLocationAuthentication_MSSLocations]
GO
