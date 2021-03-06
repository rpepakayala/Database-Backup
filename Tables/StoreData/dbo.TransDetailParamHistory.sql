/****** Object:  Table [dbo].[TransDetailParamHistory]    Script Date: 5/15/2018 12:07:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransDetailParamHistory](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[SeqID] [int] NULL,
	[IsSystem] [bit] NULL,
	[IsActive] [bit] NULL,
	[ParentID] [int] NULL,
	[ParentClassTypeID] [int] NULL,
	[TransactionType] [int] NULL,
	[TransHeaderID] [int] NULL,
	[TransHeaderClassTypeID] [int] NULL,
	[ParameterID] [int] NULL,
	[ParameterClassTypeID] [int] NULL,
	[ParameterName] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FormattedText] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListID] [int] NULL,
	[ListValue] [int] NULL,
	[Units] [int] NULL,
	[ValueType] [int] NULL,
	[ValueAsString] [text] COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValueAsFloat] [float] NULL,
	[ValueAsInteger] [int] NULL,
	[ValueAsDateTime] [datetime] NULL,
	[ValueAsBinary] [image] NULL,
	[ValueAsBlob] [image] NULL,
	[ValueAsStr25] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlobType] [int] NULL,
	[Overridden] [bit] NULL,
	[VariableID] [int] NULL,
 CONSTRAINT [TransDetailParamHistory_PK] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
