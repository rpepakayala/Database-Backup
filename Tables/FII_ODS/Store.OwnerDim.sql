/****** Object:  Table [Store].[OwnerDim]    Script Date: 5/15/2018 11:59:44 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Store].[OwnerDim](
	[StoreNumber] [int] NOT NULL,
	[OwnerName] [varchar](254) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_OwnerDim] PRIMARY KEY CLUSTERED 
(
	[StoreNumber] ASC,
	[OwnerName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [Store].[OwnerDim] ADD  CONSTRAINT [DF_Owner_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
