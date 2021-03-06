/****** Object:  Table [dbo].[awLogEntries]    Script Date: 5/15/2018 12:07:07 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[awLogEntries](
	[awLogEntryID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[DateAccessed] [datetime] NULL,
 CONSTRAINT [PK_awLogEntries] PRIMARY KEY CLUSTERED 
(
	[awLogEntryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[awLogEntries]  WITH NOCHECK ADD  CONSTRAINT [FK_awLogEntries_AWUsers] FOREIGN KEY([UserID])
REFERENCES [dbo].[AWUsers] ([UserID])
ON UPDATE CASCADE
ON DELETE CASCADE
ALTER TABLE [dbo].[awLogEntries] CHECK CONSTRAINT [FK_awLogEntries_AWUsers]
GO
