/****** Object:  Table [GL].[GLFact]    Script Date: 5/15/2018 11:59:33 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [GL].[GLFact](
	[GLFactKey] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NULL,
	[ZW_Franchise_ID] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[TransactionDateTime] [datetime] NULL,
	[OrderID] [int] NULL,
	[OrderKey] [int] NULL,
	[CustomerID] [int] NULL,
	[CustomerKey] [int] NULL,
	[AccountCode] [int] NULL,
	[UserID] [int] NULL,
	[UserKey] [int] NULL,
	[Amount] [money] NULL,
	[DescriptionKey] [int] NULL,
	[Closed] [bit] NULL,
	[ClosedDate] [date] NULL,
	[Exported] [bit] NULL,
	[ExportedDate] [date] NULL,
	[ExportedBatch] [int] NULL,
	[EnteredByID] [int] NULL,
	[EnteredByKey] [int] NULL,
	[SubAccountCode] [int] NULL,
	[Taxable] [bit] NULL,
	[Consolidated] [bit] NULL,
	[Category] [int] NULL,
	[RoyaltyGroupID] [int] NULL,
	[ModifiedByComputerKey] [int] NULL,
	[OrderDetailID] [int] NULL,
	[OrderDetailKey] [int] NULL,
	[ProductID] [int] NULL,
	[OLTP_InsertDate] [datetime] NULL,
	[OLTP_UpdateDate] [datetime] NULL,
	[UpdateCheckSum] [int] NULL,
	[CenterKey] [int] NULL,
	[KeystoneGLFactKey] [varchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[System] [varchar](4) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GL_Account] [smallint] NULL,
 CONSTRAINT [PK_GLFactTemp] PRIMARY KEY CLUSTERED 
(
	[GLFactKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [Hint_GLFact_AccountCode]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [Hint_GLFact_AccountCode] ON [GL].[GLFact]
(
	[AccountCode] ASC
)
INCLUDE ( 	[ZW_Franchise_ID],
	[TransactionDateTime],
	[Amount],
	[CenterKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_GLFact_CenterKey_AccountCode]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [Hint_GLFact_CenterKey_AccountCode] ON [GL].[GLFact]
(
	[CenterKey] ASC,
	[AccountCode] ASC
)
INCLUDE ( 	[ZW_Franchise_ID],
	[TransactionDateTime],
	[Amount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_GLFact_KeystoneGLFactKey]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [Hint_GLFact_KeystoneGLFactKey] ON [GL].[GLFact]
(
	[KeystoneGLFactKey] ASC
)
INCLUDE ( 	[ZW_Franchise_ID],
	[TransactionDateTime]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_TransactionDateTime_OrderID_AccountCode]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [Hint_TransactionDateTime_OrderID_AccountCode] ON [GL].[GLFact]
(
	[TransactionDateTime] ASC,
	[OrderID] ASC,
	[AccountCode] ASC
)
INCLUDE ( 	[ZW_Franchise_ID],
	[Amount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_ZW_Franchise_ID_AccountCode]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [Hint_ZW_Franchise_ID_AccountCode] ON [GL].[GLFact]
(
	[ZW_Franchise_ID] ASC,
	[AccountCode] ASC
)
INCLUDE ( 	[TransactionDateTime],
	[Amount],
	[System],
	[GL_Account]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [Hint_ZW_Franchise_ID_TransactionDateTime_AccountCode]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [Hint_ZW_Franchise_ID_TransactionDateTime_AccountCode] ON [GL].[GLFact]
(
	[ZW_Franchise_ID] ASC,
	[TransactionDateTime] ASC,
	[AccountCode] ASC
)
INCLUDE ( 	[OrderID],
	[Amount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
/****** Object:  Index [IDX_GLFACTCENTERKEYHINT]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [IDX_GLFACTCENTERKEYHINT] ON [GL].[GLFact]
(
	[CenterKey] ASC,
	[TransactionDateTime] ASC
)
INCLUDE ( 	[AccountCode],
	[Amount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IDX_GLFACTDATETIME_Hint]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [IDX_GLFACTDATETIME_Hint] ON [GL].[GLFact]
(
	[TransactionDateTime] ASC
)
INCLUDE ( 	[ZW_Franchise_ID],
	[AccountCode],
	[Amount],
	[CenterKey]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IDX_GLFactFranIDTranDateTime]    Script Date: 5/15/2018 11:59:33 AM ******/
CREATE NONCLUSTERED INDEX [IDX_GLFactFranIDTranDateTime] ON [GL].[GLFact]
(
	[ZW_Franchise_ID] ASC,
	[TransactionDateTime] ASC
)
INCLUDE ( 	[Amount]) WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
GO
