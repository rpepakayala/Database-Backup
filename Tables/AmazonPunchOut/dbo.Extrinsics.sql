/****** Object:  Table [dbo].[Extrinsics]    Script Date: 5/15/2018 11:58:42 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Extrinsics](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Value] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SetupRequest_Id] [int] NULL,
 CONSTRAINT [PK_dbo.Extrinsics] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Extrinsics]  WITH CHECK ADD  CONSTRAINT [FK_dbo.Extrinsics_dbo.SetupRequests_SetupRequest_Id] FOREIGN KEY([SetupRequest_Id])
REFERENCES [dbo].[SetupRequests] ([Id])
ALTER TABLE [dbo].[Extrinsics] CHECK CONSTRAINT [FK_dbo.Extrinsics_dbo.SetupRequests_SetupRequest_Id]
GO
