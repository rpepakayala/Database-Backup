/****** Object:  Table [Product].[ThicknessDim]    Script Date: 5/15/2018 11:59:42 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Product].[ThicknessDim](
	[ThicknessKey] [int] IDENTITY(1,1) NOT NULL,
	[ThicknessName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_ThicknessKey] PRIMARY KEY CLUSTERED 
(
	[ThicknessKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Product].[ThicknessDim] ADD  CONSTRAINT [DF_Thickness_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
