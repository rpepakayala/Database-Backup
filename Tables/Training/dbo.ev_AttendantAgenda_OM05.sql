/****** Object:  Table [dbo].[ev_AttendantAgenda_OM05]    Script Date: 5/15/2018 12:07:10 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[ev_AttendantAgenda_OM05](
	[AttendantAgendaID] [int] IDENTITY(1,1) NOT NULL,
	[AttendantID] [int] NULL,
	[ThursBreakfast] [bit] NULL,
	[ThursLunch] [bit] NULL,
	[ThursCocktail] [bit] NULL,
	[FriBreakfast] [bit] NULL,
	[FriLunch] [bit] NULL,
	[Golf] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GolfShirt] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GolfShirtType] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[GolfShirtSize] [varchar](20) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[StayFridayNight] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ActivitiesOnSaturday] [varchar](5) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[EntryDate] [char](10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_ev_AttendantAgenda_OM05] PRIMARY KEY CLUSTERED 
(
	[AttendantAgendaID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
