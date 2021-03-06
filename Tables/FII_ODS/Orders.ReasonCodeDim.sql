/****** Object:  Table [Orders].[ReasonCodeDim]    Script Date: 5/15/2018 11:59:38 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Orders].[ReasonCodeDim](
	[ReasonCodeKey] [int] IDENTITY(1,1) NOT NULL,
	[ReasonCodeName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ReasonCodeKey] PRIMARY KEY CLUSTERED 
(
	[ReasonCodeKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Orders].[ReasonCodeDim] ADD  CONSTRAINT [DF_ReasonCode_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
