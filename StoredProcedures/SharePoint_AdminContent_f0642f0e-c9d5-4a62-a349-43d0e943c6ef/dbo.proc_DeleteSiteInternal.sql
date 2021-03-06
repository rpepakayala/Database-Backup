/****** Object:  StoredProcedure [dbo].[proc_DeleteSiteInternal]    Script Date: 5/15/2018 12:12:32 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_DeleteSiteInternal(
    @SiteId uniqueidentifier)
AS
    SET NOCOUNT ON
    DECLARE @ReturnStatus int
    DELETE
        Categories
    FROM
        Categories, AllDocs
    WHERE
        Categories.DocId = AllDocs.Id AND
        AllDocs.SiteId = @SiteId
    DELETE
        WebCat
    FROM
        WebCat, Webs
    WHERE
        WebCat.WebId = Webs.Id AND
        Webs.SiteId = @SiteId
    DELETE
        WebPartLists
    WHERE
        tp_SiteId = @SiteId
    DELETE
        WebParts
    WHERE
        tp_SiteId = @SiteId
    DELETE FROM
        AllDocs
    WHERE
        SiteId = @SiteId
    DELETE FROM
        AllDocStreams
    WHERE
        SiteId = @SiteId
    DELETE FROM
        AllDocVersions
    WHERE
        SiteId = @SiteId
    DELETE FROM
        Deps
    WHERE
        SiteId = @SiteId
    DELETE FROM
        Links
    WHERE
        SiteId = @SiteId
    DELETE FROM 
        BuildDependencies
    WHERE
        SiteId = @SiteId
    DELETE FROM
        NavNodes
    WHERE
        SiteId = @SiteId
    DELETE FROM
        AllUserData
    WHERE
        tp_SiteId = @SiteId
    EXEC proc_DeleteFromNVP @SiteId
    DELETE
        AllLists
    FROM
        AllLists, Webs
    WHERE
        Webs.SiteId = @SiteId AND
        AllLists.tp_WebId = Webs.Id
    DELETE FROM
        WorkflowAssociation
    WHERE
        SiteId = @SiteId
    DELETE FROM
        Workflow
    WHERE
        SiteId = @SiteId
    DELETE FROM
        UserInfo
    WHERE
        tp_SiteId = @SiteId
    SELECT BitFlags FROM
        Sites
    WHERE
        Id = @SiteId
    SELECT DLAlias FROM
        Groups
    WHERE
        SiteID = @SiteId AND
        DLAlias IS NOT NULL AND
        DLAlias != ''
    DELETE FROM
        Groups
    WHERE
        SiteID = @SiteId
    DELETE FROM
        GroupMembership
    WHERE
        SiteID = @SiteId
    DELETE FROM
        RoleAssignment
    WHERE
        SiteID = @SiteId
    DELETE
        Perms
    FROM
        Perms, Webs
    WHERE
        Perms.SiteId = @SiteId AND
        Perms.RoleDefWebId = Webs.Id AND
        Webs.SiteId = @SiteId
    DELETE FROM
        Roles
    WHERE
        SiteID = @SiteId
    DELETE
          WebMembers
    FROM
          WebMembers, Webs
    WHERE
          WebMembers.WebID = Webs.Id AND
          Webs.SiteId = @SiteId
    DELETE FROM
        Webs
    WHERE
        SiteId = @SiteId
    DELETE FROM
        EventLog
    WHERE
        SiteId = @SiteId
    DELETE FROM
        ImmedSubscriptions
    WHERE
        SiteId = @SiteId
    DELETE FROM
        SchedSubscriptions
    WHERE
        SiteId = @SiteId
    DELETE FROM
        ComMd
    WHERE
        SiteId = @SiteId
    DELETE FROM
        ContentTypes
    WHERE
        SiteId = @SiteId
    DELETE FROM
        Features
    WHERE
        SiteId = @SiteId
    DELETE FROM
        RecycleBin
    WHERE
        SiteId = @SiteId
    DELETE FROM
        EventReceivers
    WHERE
        SiteId = @SiteId
    DELETE FROM
        ScheduledWorkItems
    WHERE
        SiteId = @SiteId
    DELETE FROM
        SiteVersions
    WHERE
        SiteId = @SiteId
    DELETE FROM
        ContentTypeUsage
    WHERE
        SiteId = @SiteId
    DELETE FROM
        AllUserDataJunctions
    WHERE
        tp_SiteId = @SiteId
    EXEC proc_UpdateDiskUsed @SiteId
    RETURN 0

GO
