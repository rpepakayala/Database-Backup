/****** Object:  Table [dbo].[ev_Attendants]    Script Date: 5/15/2018 12:07:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ev_Attendants](
	[AttendantID] [int] IDENTITY(1,1) NOT NULL,
	[EventID] [int] NULL,
	[AttendantRoleID] [int] NULL,
	[AttendantStatusID] [int] NULL,
	[BillingStatusID] [int] NULL,
	[LocalBilling] [bit] NULL,
	[FirstName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[BadgeName] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[State] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Email] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[WebNumber] [int] NULL,
	[FBCTradeout] [bit] NULL,
	[MealRequest] [varchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[MealOtherRequirements] [varchar](500) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FirstTime] [bit] NULL,
	[EntryDate] [datetime] NULL,
	[YearsOfService] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
) ON [PRIMARY]

GO
