/****** Object:  Table [system].[linenumbertoletter]    Script Date: 5/15/2018 12:04:36 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [system].[linenumbertoletter](
	[linenumber] [smallint] NOT NULL,
	[letter] [char](1) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
 CONSTRAINT [PK_linenumbertoletter] PRIMARY KEY CLUSTERED 
(
	[linenumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
