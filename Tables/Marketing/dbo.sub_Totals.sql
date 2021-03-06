/****** Object:  Table [dbo].[sub_Totals]    Script Date: 5/15/2018 12:02:38 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sub_Totals](
	[SourceID] [int] NOT NULL,
	[SubsidyTypeID] [int] NOT NULL,
	[SubsidyID] [int] NOT NULL,
	[AmountEarned] [money] NOT NULL,
	[AmountAvailable] [money] NOT NULL,
	[TransactionID] [int] NOT NULL,
 CONSTRAINT [PK_sub_CoOpTotals] PRIMARY KEY CLUSTERED 
(
	[SourceID] ASC,
	[SubsidyTypeID] ASC,
	[SubsidyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
