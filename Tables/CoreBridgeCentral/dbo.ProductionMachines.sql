/****** Object:  Table [dbo].[ProductionMachines]    Script Date: 5/15/2018 11:59:04 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProductionMachines](
	[CompanyLocationId] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[LocationNumber] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Name] [varchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsRollFedMachine] [bit] NOT NULL,
	[IsOffsetPress] [bit] NULL,
	[ID] [int] IDENTITY(1,1) NOT NULL
) ON [PRIMARY]

GO
