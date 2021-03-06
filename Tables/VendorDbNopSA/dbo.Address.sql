/****** Object:  Table [dbo].[Address]    Script Date: 5/15/2018 12:08:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Address](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[FirstName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Company] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CountryId] [int] NULL,
	[StateProvinceId] [int] NULL,
	[City] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address1] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address2] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ZipPostalCode] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FaxNumber] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CreatedOnUtc] [datetime] NOT NULL,
	[CustomAttributes] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [Address_Country] FOREIGN KEY([CountryId])
REFERENCES [dbo].[Country] ([Id])
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [Address_Country]
ALTER TABLE [dbo].[Address]  WITH CHECK ADD  CONSTRAINT [Address_StateProvince] FOREIGN KEY([StateProvinceId])
REFERENCES [dbo].[StateProvince] ([Id])
ALTER TABLE [dbo].[Address] CHECK CONSTRAINT [Address_StateProvince]
GO
