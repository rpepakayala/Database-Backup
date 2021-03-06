/****** Object:  Table [Estimate].[OrderNotesDim]    Script Date: 5/15/2018 11:59:31 AM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [Estimate].[OrderNotesDim](
	[OrderNotesKey] [int] IDENTITY(1,1) NOT NULL,
	[OrderNotesName] [varchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[IsValid] [bit] NOT NULL,
 CONSTRAINT [PK_OrderNotesKey] PRIMARY KEY CLUSTERED 
(
	[OrderNotesKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [Estimate].[OrderNotesDim] ADD  CONSTRAINT [DF_OrderNotes_IsValid]  DEFAULT ((0)) FOR [IsValid]
GO
