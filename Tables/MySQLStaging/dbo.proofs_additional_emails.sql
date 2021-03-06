/****** Object:  Table [dbo].[proofs_additional_emails]    Script Date: 5/15/2018 12:04:27 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[proofs_additional_emails](
	[proof_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[email] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[added_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[added_on] [datetime2](0) NOT NULL,
	[name] [nvarchar](120) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
 CONSTRAINT [PK_proofs_additional_emails_proof_id] PRIMARY KEY CLUSTERED 
(
	[proof_id] ASC,
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

ALTER TABLE [dbo].[proofs_additional_emails] ADD  DEFAULT (NULL) FOR [name]
GO
