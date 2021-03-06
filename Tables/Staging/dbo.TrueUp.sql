/****** Object:  Table [dbo].[TrueUp]    Script Date: 5/15/2018 12:06:31 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TrueUp](
	[CompanyLocationId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FranchiseName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContactId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AccountId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FirstName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MiddleName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Title] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Position] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[nEmailAddress] [nvarchar](100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrimaryPhoneNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrimaryPhoneNumberExtension] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrimaryPhoneNumberType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecondaryPhoneNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecondaryPhoneNumberType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TertiaryPhoneNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TertiaryPhoneNumberType] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ContactStatus] [varchar](127) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsUpdate] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
