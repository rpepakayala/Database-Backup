/****** Object:  StoredProcedure [dbo].[usp_FM_Cont_LastSync2_update]    Script Date: 5/15/2018 12:09:45 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:        Alex Montminy
-- Create date: 1/29/2013
-- Description:   Updates last sync for FSI
-- =============================================
CREATE PROCEDURE [dbo].[usp_FM_Cont_LastSync2_update] @SyncXML XML
AS 
    BEGIN

        SET NOCOUNT ON;


        UPDATE
            dbo._ExactTarget_Integration_Contacts
        SET 
            [_ExactTarget_Integration_Contacts].LastSync2 = GETDATE()
        FROM
            @SyncXML.nodes('/LastSyncXML/LastSyncNodes/LastSyncNode') Sync ( Nodes )
            INNER JOIN [_ExactTarget_Integration_Contacts] EIC ON ( Sync.Nodes.value('./contactID[1]',
                                                              'nvarchar(max)') = EIC.contactID
                                                              AND Sync.Nodes.value('./ZW_ID[1]',
                                                              'nvarchar(max)') = EIC.zw_franchise_id
                                                              )
   
    END

GO
