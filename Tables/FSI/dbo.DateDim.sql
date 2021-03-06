/****** Object:  Table [dbo].[DateDim]    Script Date: 5/15/2018 12:00:49 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[DateDim](
	[PK_Date] [datetime] NOT NULL,
	[Date_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Year] [datetime] NULL,
	[Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quarter] [datetime] NULL,
	[Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month] [datetime] NULL,
	[Month_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Day_Of_Year] [int] NULL,
	[Day_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Day_Of_Quarter] [int] NULL,
	[Day_Of_Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Day_Of_Month] [int] NULL,
	[Day_Of_Month_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month_Of_Year] [int] NULL,
	[Month_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Month_Of_Quarter] [int] NULL,
	[Month_Of_Quarter_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[Quarter_Of_Year] [int] NULL,
	[Quarter_Of_Year_Name] [nvarchar](50) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_DateDim] PRIMARY KEY CLUSTERED 
(
	[PK_Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
