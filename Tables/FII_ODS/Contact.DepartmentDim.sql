/****** Object:  Table [Contact].[DepartmentDim]    Script Date: 5/15/2018 11:59:22 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Contact].[DepartmentDim](
	[DepartmentKey] [int] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_DepartmentKey] PRIMARY KEY CLUSTERED 
(
	[DepartmentKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [DepartmentDim_DepartmentName]    Script Date: 5/15/2018 11:59:22 AM ******/
CREATE NONCLUSTERED INDEX [DepartmentDim_DepartmentName] ON [Contact].[DepartmentDim]
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [Contact].[DepartmentDim] ADD  CONSTRAINT [DF_Department_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
