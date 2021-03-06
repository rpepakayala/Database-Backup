/****** Object:  Table [dbo].[sub_TransactionInternedData]    Script Date: 5/15/2018 12:02:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sub_TransactionInternedData](
	[InternID] [int] IDENTITY(1,1) NOT NULL,
	[OriginalID] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[Text] [varchar](400) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_sub_SharedTransactionDescriptionCache] PRIMARY KEY CLUSTERED 
(
	[InternID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
