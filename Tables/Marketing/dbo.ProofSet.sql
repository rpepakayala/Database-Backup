/****** Object:  Table [dbo].[ProofSet]    Script Date: 5/15/2018 12:02:35 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ProofSet](
	[PrfSId] [int] NOT NULL,
	[PrfSName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrfSFirstClassPostage] [float] NULL,
	[PrfSMailingHandOut] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrfSFolding] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrfSHandOut] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrfSMultiStore] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrfSMap] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PrfSImprintFee] [float] NULL,
	[PrfSImprintQty] [smallint] NULL,
	[PrfSWidth] [int] NULL,
	[PrfSHeight] [int] NULL,
 CONSTRAINT [PK_ProofSet] PRIMARY KEY CLUSTERED 
(
	[PrfSId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_ProofSet]    Script Date: 5/15/2018 12:02:35 PM ******/
CREATE NONCLUSTERED INDEX [IX_ProofSet] ON [dbo].[ProofSet]
(
	[PrfSName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
GO
