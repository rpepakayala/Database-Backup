/****** Object:  View [catalog].[event_messages]    Script Date: 5/15/2018 12:14:29 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON

CREATE VIEW [catalog].[event_messages]
AS
SELECT     opmsg.[operation_message_id] as [event_message_id],
           opmsg.[operation_id], 
           opmsg.[message_time],
           opmsg.[message_type],
           opmsg.[message_source_type],  
           opmsg.[message], 
           opmsg.[extended_info_id],
           eventmsg.[package_name],
           eventmsg.[event_name],
           
           message_source_name = 
                      CASE 
                        WHEN (opmsg.message_source_type = 10) THEN 'ISServerExec' 
                        WHEN (opmsg.message_source_type = 20) THEN 'Transact-SQL stored procedure'
                        ELSE eventmsg.message_source_name
                    END,
           eventmsg.[message_source_id],
           eventmsg.[subcomponent_name],
           eventmsg.[package_path],
           eventmsg.[execution_path],
           eventmsg.[threadID],
           eventmsg.[message_code]
FROM       [internal].[operation_messages] opmsg LEFT JOIN [internal].[event_messages] eventmsg
           ON opmsg.[operation_message_id] = eventmsg.[event_message_id]
WHERE      opmsg.[operation_id] in (SELECT [id] FROM [internal].[current_user_readable_operations])
           OR (IS_MEMBER('ssis_admin') = 1)
           OR (IS_SRVROLEMEMBER('sysadmin') = 1)

GO
