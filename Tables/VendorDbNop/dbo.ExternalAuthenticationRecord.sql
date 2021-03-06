/****** Object:  Table [dbo].[ExternalAuthenticationRecord]    Script Date: 5/15/2018 12:07:22 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ExternalAuthenticationRecord](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CustomerId] [int] NOT NULL,
	[Email] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExternalIdentifier] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ExternalDisplayIdentifier] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OAuthToken] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OAuthAccessToken] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProviderSystemName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[ExternalAuthenticationRecord]  WITH CHECK ADD  CONSTRAINT [ExternalAuthenticationRecord_Customer] FOREIGN KEY([CustomerId])
REFERENCES [dbo].[Customer] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[ExternalAuthenticationRecord] CHECK CONSTRAINT [ExternalAuthenticationRecord_Customer]
GO
