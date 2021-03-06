/****** Object:  Table [dbo].[syspolicy_facet_events]    Script Date: 5/15/2018 12:03:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TABLE [dbo].[syspolicy_facet_events](
	[management_facet_id] [int] NOT NULL,
	[event_name] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[target_type] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
	[target_type_alias] [sysname] COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
) ON [PRIMARY]

SET ANSI_PADDING ON

/****** Object:  Index [IX_facet_events_target_type_alias]    Script Date: 5/15/2018 12:03:09 PM ******/
CREATE CLUSTERED INDEX [IX_facet_events_target_type_alias] ON [dbo].[syspolicy_facet_events]
(
	[target_type_alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
SET ANSI_PADDING ON

/****** Object:  Index [UX_facet_events]    Script Date: 5/15/2018 12:03:09 PM ******/
CREATE UNIQUE NONCLUSTERED INDEX [UX_facet_events] ON [dbo].[syspolicy_facet_events]
(
	[management_facet_id] ASC,
	[event_name] ASC,
	[target_type] ASC,
	[target_type_alias] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
ALTER TABLE [dbo].[syspolicy_facet_events]  WITH CHECK ADD FOREIGN KEY([management_facet_id])
REFERENCES [dbo].[syspolicy_management_facets] ([management_facet_id])
/****** Object:  Trigger [dbo].[syspolicy_validate_events]    Script Date: 5/15/2018 12:03:09 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE TRIGGER [syspolicy_validate_events] on [dbo].[syspolicy_facet_events]
AFTER INSERT, UPDATE
AS
BEGIN
    -- make sure that caller is dbo and all events inserted are real events.
    IF  (USER_ID() != 1) OR
        EXISTS (SELECT event_name FROM inserted 
                    WHERE event_name NOT IN(SELECT type_name from sys.event_notification_event_types))
    BEGIN
        RAISERROR(N'Unknown event name inserted into [dbo].[syspolicy_facet_events]', 1,1)
        ROLLBACK TRANSACTION
    END
END

GO
