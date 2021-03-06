/****** Object:  Table [dbo].[MSSSpecialTerms]    Script Date: 5/15/2018 12:09:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[MSSSpecialTerms](
	[SpecialTermID] [int] NOT NULL,
	[Term] [nvarchar](100) COLLATE Latin1_General_CI_AS_KS_WS NOT NULL,
	[Definition] [nvarchar](500) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[Contact] [nvarchar](50) COLLATE Latin1_General_CI_AS_KS_WS NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NULL,
	[ReviewDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[SpecialTermID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_SpecialTerm_Term]    Script Date: 5/15/2018 12:09:13 PM ******/
CREATE NONCLUSTERED INDEX [IX_SpecialTerm_Term] ON [dbo].[MSSSpecialTerms]
(
	[Term] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
/****** Object:  Trigger [dbo].[trigger_SpecialTermInsTrig]    Script Date: 5/15/2018 12:09:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER trigger_SpecialTermInsTrig
ON MSSSpecialTerms
AFTER INSERT
AS
INSERT INTO MSSSynonyms SELECT SpecialTermID, Term from inserted

/****** Object:  Trigger [dbo].[trigger_SpecialTermUpdTrig]    Script Date: 5/15/2018 12:09:13 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER trigger_SpecialTermUpdTrig
ON MSSSpecialTerms
AFTER UPDATE
AS
IF (UPDATE (Term))
BEGIN
Update MSSSynonyms set term = inserted.term from inserted, deleted, MSSSynonyms 
where deleted.SpecialTermId = MSSSynonyms.SpecialTermId 
and deleted.Term = MSSSynonyms.Term
END

GO
