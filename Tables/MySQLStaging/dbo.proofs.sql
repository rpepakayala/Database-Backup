/****** Object:  Table [dbo].[proofs]    Script Date: 5/15/2018 12:04:26 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[proofs](
	[proof_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[asset_id] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[proof_sent_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[proof_sent_on] [datetime2](0) NOT NULL,
	[status_changed_on] [datetime2](0) NULL,
	[status_changed_by] [nvarchar](32) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[status_id] [smallint] NOT NULL,
	[response] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[overridden] [smallint] NOT NULL,
 CONSTRAINT [PK_proofs_proof_id] PRIMARY KEY CLUSTERED 
(
	[proof_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY],
 CONSTRAINT [proofs$asset_id] UNIQUE NONCLUSTERED 
(
	[asset_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [dbo].[proofs] ADD  DEFAULT (NULL) FOR [status_changed_on]
ALTER TABLE [dbo].[proofs] ADD  DEFAULT (NULL) FOR [status_changed_by]
ALTER TABLE [dbo].[proofs] ADD  DEFAULT ((1)) FOR [status_id]
ALTER TABLE [dbo].[proofs] ADD  DEFAULT ((0)) FOR [overridden]
GO
