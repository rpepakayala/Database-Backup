/****** Object:  Table [dbo].[dynmc_f74724430569d09b84ff0000]    Script Date: 5/15/2018 12:01:21 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[dynmc_f74724430569d09b84ff0000](
	[id] [uniqueidentifier] NOT NULL,
	[username] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[title] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[summary] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[publication_date] [datetime] NULL,
	[owner_last_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[owner_first_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[owner_email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[lnk] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[item_hash] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[expiration_date] [datetime] NULL,
	[content] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[categories] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [pk_dynmc_f74724430569_27DE9DA0] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[dynmc_f74724430569d09b84ff0000]  WITH CHECK ADD  CONSTRAINT [ref_dynmc_f7472443056_02FDF457] FOREIGN KEY([id])
REFERENCES [dbo].[sf_dynamic_type_base] ([id])
ON DELETE CASCADE
ALTER TABLE [dbo].[dynmc_f74724430569d09b84ff0000] CHECK CONSTRAINT [ref_dynmc_f7472443056_02FDF457]
GO
