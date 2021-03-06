/****** Object:  Table [internal].[event_message_context]    Script Date: 5/15/2018 12:06:11 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [internal].[event_message_context](
	[context_id] [bigint] IDENTITY(1,1) NOT NULL,
	[operation_id] [bigint] NOT NULL,
	[event_message_id] [bigint] NOT NULL,
	[context_depth] [int] NULL,
	[package_path] [nvarchar](max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[context_type] [smallint] NULL,
	[context_source_name] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[context_source_id] [nvarchar](38) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[property_name] [nvarchar](4000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
	[property_value] [sql_variant] NULL,
 CONSTRAINT [PK_Event_Message_Context] PRIMARY KEY CLUSTERED 
(
	[context_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

ALTER TABLE [internal].[event_message_context]  WITH CHECK ADD  CONSTRAINT [FK_EventMessageContext_EventMessageId_EventMessages] FOREIGN KEY([event_message_id])
REFERENCES [internal].[event_messages] ([event_message_id])
ON DELETE CASCADE
ALTER TABLE [internal].[event_message_context] CHECK CONSTRAINT [FK_EventMessageContext_EventMessageId_EventMessages]
ALTER TABLE [internal].[event_message_context]  WITH CHECK ADD  CONSTRAINT [FK_EventMessagecontext_Operations] FOREIGN KEY([operation_id])
REFERENCES [internal].[operations] ([operation_id])
ALTER TABLE [internal].[event_message_context] CHECK CONSTRAINT [FK_EventMessagecontext_Operations]
GO
