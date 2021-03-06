/****** Object:  Table [dbo].[TransHeaderHistoryUserField]    Script Date: 5/15/2018 12:07:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransHeaderHistoryUserField](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[Location_JobBox] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_COMPANY_NAME] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_CONTACT_NAME] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_PHONE] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_P_O__NUMBER] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_P_O__AMOUNT] [float] NULL,
	[Sub_SHIPPING_METHOD] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_TRACKING_NO_] [float] NULL,
	[Sub_SHIP_DATE_PROJECTED] [datetime] NULL,
	[Sub_ITEM_RECEIVED_DATE] [datetime] NULL,
	[Sub_NOTES] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPT___OUT_of_FASTMAIL] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Supplied_] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Date_Supplied_] [datetime] NULL,
	[Refresh_GL] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OriginalClosedDate] [datetime] NULL,
 CONSTRAINT [TransHeaderHistoryUserField_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
