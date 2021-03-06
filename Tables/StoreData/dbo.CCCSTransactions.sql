/****** Object:  Table [dbo].[CCCSTransactions]    Script Date: 5/15/2018 12:06:42 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[CCCSTransactions](
	[TransactionGUID] [uniqueidentifier] NOT NULL,
	[CustomerGUID] [uniqueidentifier] NULL,
	[TransactionType] [int] NULL,
	[TransactionTypeText] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProcessedDateTime] [datetime] NULL,
	[OrderNumber] [int] NULL,
	[Amount] [money] NULL,
	[NeededAuthorization] [bit] NULL,
	[AuthorizationCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WasSuccessful] [bit] NULL,
	[ProcessorRecordID] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProcessorResponse] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProcessorErrorCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProcessorErrorDescription] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CVVChecked] [bit] NULL,
	[CVVResponse] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CVVResponseCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Forced] [bit] NULL,
	[AVSChecked] [bit] NULL,
	[AVSResponse] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[AVSResponseCode] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsSettled] [bit] NULL,
	[ProcessorBatchID] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_CCCSTransactions] PRIMARY KEY CLUSTERED 
(
	[TransactionGUID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
