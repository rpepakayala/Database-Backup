/****** Object:  Table [Store].[OperationalDim]    Script Date: 5/15/2018 11:59:44 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Store].[OperationalDim](
	[OperationalKey] [int] IDENTITY(1,1) NOT NULL,
	[OperationalName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_OperationalKey] PRIMARY KEY CLUSTERED 
(
	[OperationalKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Store].[OperationalDim] ADD  CONSTRAINT [DF_Operational_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
