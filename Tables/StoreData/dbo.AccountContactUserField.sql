/****** Object:  Table [dbo].[AccountContactUserField]    Script Date: 5/15/2018 12:06:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[AccountContactUserField](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[username] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[password] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[OPT___OUT_of_FASTMAIL] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AllowWebAccess] [varchar](1) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastWebAccess] [datetime] NULL,
 CONSTRAINT [AccountContactUserField_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
