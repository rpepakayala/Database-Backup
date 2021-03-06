/****** Object:  Table [Orders].[StatusDim]    Script Date: 5/15/2018 11:59:38 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[StatusDim](
	[StatusKey] [int] IDENTITY(1,1) NOT NULL,
	[StatusName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_StatusKey] PRIMARY KEY CLUSTERED 
(
	[StatusKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Orders].[StatusDim] ADD  CONSTRAINT [DF_Status_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
