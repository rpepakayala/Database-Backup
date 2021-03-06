/****** Object:  Table [SalesAnalysis].[SalesTime]    Script Date: 5/15/2018 11:58:40 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [SalesAnalysis].[SalesTime](
	[PK_Date] [datetime] NOT NULL,
	[Date_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Year] [datetime] NULL,
	[Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Half_Year] [datetime] NULL,
	[Half_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quarter] [datetime] NULL,
	[Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month] [datetime] NULL,
	[Month_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Day_Of_Year] [int] NULL,
	[Day_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Day_Of_Half_Year] [int] NULL,
	[Day_Of_Half_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Day_Of_Quarter] [int] NULL,
	[Day_Of_Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Day_Of_Month] [int] NULL,
	[Day_Of_Month_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month_Of_Year] [int] NULL,
	[Month_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month_Of_Half_Year] [int] NULL,
	[Month_Of_Half_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month_Of_Quarter] [int] NULL,
	[Month_Of_Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quarter_Of_Year] [int] NULL,
	[Quarter_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quarter_Of_Half_Year] [int] NULL,
	[Quarter_Of_Half_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Half_Year_Of_Year] [int] NULL,
	[Half_Year_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Year] [datetime] NULL,
	[Fiscal_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Half_Year] [datetime] NULL,
	[Fiscal_Half_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Quarter] [datetime] NULL,
	[Fiscal_Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Month] [datetime] NULL,
	[Fiscal_Month_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Day] [datetime] NULL,
	[Fiscal_Day_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Day_Of_Year] [int] NULL,
	[Fiscal_Day_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Day_Of_Half_Year] [int] NULL,
	[Fiscal_Day_Of_Half_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Day_Of_Quarter] [int] NULL,
	[Fiscal_Day_Of_Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Day_Of_Month] [int] NULL,
	[Fiscal_Day_Of_Month_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Month_Of_Year] [int] NULL,
	[Fiscal_Month_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Month_Of_Half_Year] [int] NULL,
	[Fiscal_Month_Of_Half_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Month_Of_Quarter] [int] NULL,
	[Fiscal_Month_Of_Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Quarter_Of_Year] [int] NULL,
	[Fiscal_Quarter_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Quarter_Of_Half_Year] [int] NULL,
	[Fiscal_Quarter_Of_Half_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Fiscal_Half_Year_Of_Year] [int] NULL,
	[Fiscal_Half_Year_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_SalesTime] PRIMARY KEY CLUSTERED 
(
	[PK_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 97) ON [PRIMARY]
) ON [PRIMARY]

GO
