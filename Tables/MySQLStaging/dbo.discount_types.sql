/****** Object:  Table [dbo].[discount_types]    Script Date: 5/15/2018 12:04:02 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[discount_types](
	[discount_type_id] [int] IDENTITY(6,1) NOT NULL,
	[type] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[name] [nvarchar](200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[tiered] [smallint] NOT NULL,
 CONSTRAINT [PK_discount_types_discount_type_id] PRIMARY KEY CLUSTERED 
(
	[discount_type_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[discount_types] ADD  DEFAULT ((0)) FOR [tiered]
GO
