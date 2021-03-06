/****** Object:  Table [dbo].[SystemDefaults]    Script Date: 5/15/2018 12:02:40 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[SystemDefaults](
	[SystemDefaultsId] [int] NOT NULL,
	[StoreImagePath] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ImagePath] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FilePath] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DBPath] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ProofPath] [varchar](250) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SignUpDeadline] [smallint] NULL,
	[UploadDBDeadline] [smallint] NULL,
	[CreditCardValidation] [smallint] NULL,
	[PlanSignUpDeadline] [smallint] NULL,
	[DeclineOrderDeadline] [smallint] NULL,
	[OperationalStatusValue] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[DBNotUploadedNotificationDays] [smallint] NULL,
	[MailOrderDeclinedNotificationDays] [smallint] NULL,
	[MaterialOrderDeclinedNotificationDays] [smallint] NULL,
	[OrderNotFulfilledNotificationDays] [smallint] NULL,
	[CreditCardExpirationDeadline] [smallint] NULL,
 CONSTRAINT [PK_SystemDefaults] PRIMARY KEY CLUSTERED 
(
	[SystemDefaultsId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
