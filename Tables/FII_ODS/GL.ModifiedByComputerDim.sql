/****** Object:  Table [GL].[ModifiedByComputerDim]    Script Date: 5/15/2018 11:59:33 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [GL].[ModifiedByComputerDim](
	[ModifiedByComputerKey] [int] IDENTITY(1,1) NOT NULL,
	[ModifiedByComputerName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ModifiedByComputerKey] PRIMARY KEY CLUSTERED 
(
	[ModifiedByComputerKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [GL].[ModifiedByComputerDim] ADD  CONSTRAINT [DF_ModifiedByComputer_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
