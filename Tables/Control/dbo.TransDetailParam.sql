/****** Object:  Table [dbo].[TransDetailParam]    Script Date: 5/15/2018 11:58:58 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[TransDetailParam](
	[ID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[ClassTypeID] [int] NOT NULL,
	[ModifiedByUser] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedByComputer] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
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
	[ParameterName] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FormattedText] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ListID] [int] NULL,
	[ListValue] [int] NULL,
	[Units] [int] NULL,
	[ValueType] [int] NULL,
	[ValueAsString] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ValueAsFloat] [float] NULL,
	[ValueAsInteger] [int] NULL,
	[ValueAsDateTime] [datetime] NULL,
	[ValueAsBinary] [image] NULL,
	[ValueAsBlob] [image] NULL,
	[ValueAsStr25] [nvarchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BlobType] [int] NULL,
	[Overridden] [bit] NULL,
	[VariableID] [int] NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_active] [bit] NOT NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
 CONSTRAINT [PK_TransDetailParam] PRIMARY KEY CLUSTERED 
(
	[ID] ASC,
	[StoreID] ASC,
	[ClassTypeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
