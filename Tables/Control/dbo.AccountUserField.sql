/****** Object:  Table [dbo].[AccountUserField]    Script Date: 5/15/2018 11:58:47 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AccountUserField](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[List_Source] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_COMPANY_NAME] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_CONTACT_NAME] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_PHONE] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_SHIPPING_METHOD] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_P_O__NUMBER] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Sub_P_O__AMOUNT] [float] NULL,
	[Sub_SHIP_DATE_PROJECTED] [datetime] NULL,
	[Sub_TRACKING_NO_] [float] NULL,
	[Sub_ITEM_RECEIVED_DATE] [datetime] NULL,
	[Sub_NOTES] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Recently_Picked_up_List] [datetime] NULL,
	[Absent_Customers] [datetime] NULL,
	[Do_not_mails] [datetime] NULL,
	[Exclude_From_Fastmail] [datetime] NULL,
	[letter_guide] [datetime] NULL,
	[letter_guide_discount] [datetime] NULL,
	[nothing] [datetime] NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_AccountUserField] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
