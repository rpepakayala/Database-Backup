/****** Object:  Table [Contact].[CountyDim]    Script Date: 5/15/2018 11:59:21 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Contact].[CountyDim](
	[CountyKey] [int] IDENTITY(1,1) NOT NULL,
	[CountyName] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_CountyKey] PRIMARY KEY CLUSTERED 
(
	[CountyKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Contact].[CountyDim] ADD  CONSTRAINT [DF_County_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
