/****** Object:  StoredProcedure [dbo].[proc_MSS_GetScopeDisplayGroupsForConsumer]    Script Date: 5/15/2018 12:13:33 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetScopeDisplayGroupsForConsumer(
    @ConsumerName nvarchar( 60 ) )
AS
    SELECT
        DisplayGroupID,
        Name,
        Description,
        dbo.MSSRegisteredConsumers.ConsumerName,
        DisplayInAdminUI,
        Undeletable,
        DefaultScopeID,
        LastModifiedTime,
        LastModifiedBy
    FROM
        dbo.MSSScopeDisplayGroups, dbo.MSSRegisteredConsumers
    WHERE
        dbo.MSSScopeDisplayGroups.ConsumerID = dbo.MSSRegisteredConsumers.ConsumerID AND
        dbo.MSSRegisteredConsumers.ConsumerName = @ConsumerName
    RETURN @@ERROR

GO
