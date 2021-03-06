/****** Object:  Table [dbo].[AddressAttributeValue]    Script Date: 5/15/2018 12:07:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AddressAttributeValue](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[AddressAttributeId] [int] NOT NULL,
	[Name] [nvarchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsPreSelected] [bit] NOT NULL,
	[DisplayOrder] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[AddressAttributeValue]  WITH CHECK ADD  CONSTRAINT [AddressAttributeValue_AddressAttribute] FOREIGN KEY([AddressAttributeId])
REFERENCES [dbo].[AddressAttribute] ([Id])
ON DELETE CASCADE
ALTER TABLE [dbo].[AddressAttributeValue] CHECK CONSTRAINT [AddressAttributeValue_AddressAttribute]
GO
