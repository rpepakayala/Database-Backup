/****** Object:  Table [dbo].[sf_publishing_point]    Script Date: 5/15/2018 12:02:00 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[sf_publishing_point](
	[storage_type_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[storage_item_provider_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[id2] [uniqueidentifier] NULL,
	[pblshng_pnt_bsness_object_name] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[ownr] [uniqueidentifier] NULL,
	[nme] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[last_publication_date] [datetime] NULL,
	[last_modified] [datetime] NULL,
	[is_template] [tinyint] NOT NULL,
	[is_shared_with_all_sites] [tinyint] NOT NULL,
	[is_active] [tinyint] NOT NULL,
	[id] [uniqueidentifier] NOT NULL,
	[description_] [nvarchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[date_created] [datetime] NULL,
	[application_name] [varchar](255) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[voa_version] [smallint] NOT NULL,
 CONSTRAINT [pk_sf_publishing_point] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, FILLFACTOR = 90) ON [PRIMARY]
) ON [PRIMARY]

GO
