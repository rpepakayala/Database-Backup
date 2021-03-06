/****** Object:  Table [dbo].[Employee Database]    Script Date: 5/15/2018 12:00:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[Employee Database](
	[EmployeeID] [int] NOT NULL,
	[StoreID] [int] NOT NULL,
	[FirstName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[LastName] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SocialSecurityNumber] [varchar](16) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Birthdate] [datetime] NULL,
	[HireDate] [datetime] NULL,
	[TerminationDate] [datetime] NULL,
	[Title] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneNumber] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PhoneExtention] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FaxNumber] [varchar](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmailAddress] [varchar](75) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmployeeStoreID] [int] NULL,
	[Department] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Address] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[City] [varchar](15) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[State] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Zip] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HomePhoneNumber] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PagerNumber] [varchar](30) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CellularPhoneNumber] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CurrentStatus] [smallint] NULL,
	[PricingRatio] [float] NULL,
	[ReportsToID] [int] NULL,
	[SalesPerson] [bit] NULL,
	[CommissionSales] [bit] NULL,
	[CommPaidOnPickedUp] [bit] NULL,
	[CommRateProdLoc1] [float] NULL,
	[CommRateProdLoc2] [float] NULL,
	[CommRateProdLoc3] [float] NULL,
	[Password] [varchar](8) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[SecurityRights] [varbinary](4) NULL,
	[Active] [bit] NULL,
	[PareaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[FareaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[HPareaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[CPareaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[PGareaCode] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EnteredByList] [bit] NULL,
	[TimeClockList] [bit] NULL,
	[EmergencyContact] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmergencyPhone] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EmployeePhoto] [image] NULL,
	[EmployeeSignature] [image] NULL,
	[sys_di] [datetime] NOT NULL,
	[sys_du] [datetime] NOT NULL,
	[zw_franchise_id] [char](7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[zw_active] [bit] NULL,
	[zw_pk_id] [int] IDENTITY(1,1) NOT NULL,
	[ModifiedByComputer] [varchar](25) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ModifiedDate] [datetime] NULL,
	[AllowFinInfo] [bit] NULL,
	[CanVoidRefundOrder] [bit] NULL,
	[CanVoidRefundCredit] [bit] NULL,
 CONSTRAINT [PK_Employee Database] PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC,
	[StoreID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_FranchiseID]    Script Date: 5/15/2018 12:00:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_FranchiseID] ON [dbo].[Employee Database]
(
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [IX_MAIN_EmployeeID]    Script Date: 5/15/2018 12:00:49 PM ******/
CREATE NONCLUSTERED INDEX [IX_MAIN_EmployeeID] ON [dbo].[Employee Database]
(
	[EmployeeID] ASC,
	[zw_franchise_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
ALTER TABLE [dbo].[Employee Database] ADD  CONSTRAINT [DF_Employee Database_ModifiedDate]  DEFAULT (getdate()) FOR [ModifiedDate]
GO
