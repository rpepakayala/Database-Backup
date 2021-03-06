/****** Object:  StoredProcedure [dbo].[proc_MSS_FlushAnchorText0]    Script Date: 5/15/2018 12:13:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_FlushAnchorText0
@DocID int,
@CrawlID int,
@AnchorsLimit int
AS
    SET NOCOUNT ON  
    DECLARE @PRTH_S_NOT_MODIFIED int SET @PRTH_S_NOT_MODIFIED = 0x41203 DECLARE @GTHR_E_URL_EXCLUDED int SET @GTHR_E_URL_EXCLUDED = 0x80040d07 DECLARE @GTHR_E_URL_EXCLUDED_DEPTH int SET @GTHR_E_URL_EXCLUDED_DEPTH = 0x80040d08 DECLARE @GTHR_S_NO_INDEX int SET @GTHR_S_NO_INDEX = 0x40D90 DECLARE @WSS_TOKEN_TOO_EARLY int SET @WSS_TOKEN_TOO_EARLY = 0x810200BC
    DECLARE @ITEMTYPE_INVALIDLINK int SET @ITEMTYPE_INVALIDLINK = 0 DECLARE @ITEMTYPE_STARTADDRESS int SET @ITEMTYPE_STARTADDRESS = 1 DECLARE @ITEMTYPE_LINK int SET @ITEMTYPE_LINK = 2 DECLARE @ITEMTYPE_COMMITTED int SET @ITEMTYPE_COMMITTED = 3 DECLARE @ITEMTYPE_ANCHORNEWLINK int SET @ITEMTYPE_ANCHORNEWLINK = 4 DECLARE @ITEMTYPE_ANCHORCOMMITTED int SET @ITEMTYPE_ANCHORCOMMITTED = 5 DECLARE @ITEMTYPE_ANCHORNOCRAWL int SET @ITEMTYPE_ANCHORNOCRAWL = 6
    INSERT INTO MSSCrawlQueue (CrawlID,
            StartAddressID,
            DocID,
            SourceDocID,
            TransactionType,
            Scope,
            TransactionFlags,
            HostDepth,
            EnumerationDepth,           
            ItemType,
            ProjectID)
    SELECT CrawlID,
            StartAddressID,
            DocID,
            SourceDocID,
            TransactionType,
            Scope, 
            TransactionFlags,
            HostDepth,
            EnumerationDepth,
            ItemType,
            ProjectID
    FROM MSSTranTempTable0
    WHERE ( SourceDocID = @DocID AND CrawlID = @CrawlID AND ItemType = @ITEMTYPE_ANCHORNEWLINK)
    INSERT INTO MSSCrawlChangedTargetDocs (CrawlId, DocId)
        SELECT MSSTranTempTable0.CrawlId, TargetDocId FROM MSSAnchorText 
                JOIN MSSTranTempTable0 ON MSSTranTempTable0.SourceDocID = MSSAnchorText.SourceDocId
                        AND FirstLink = 1
                WHERE MSSTranTempTable0.SourceDocID = @DocId 
                AND MSSTranTempTable0.CrawlID = @CrawlId
                        AND TargetDocId <> -1
    DELETE FROM MSSAnchorText WHERE SourceDocID IN
        (SELECT SourceDocID 
        FROM MSSTranTempTable0
        WHERE SourceDocID = @DocID AND CrawlID = @CrawlID AND FirstLink = 1)
    INSERT INTO MSSAnchorText (sourceDocId, targetDocId, Link, LinkHash, LCID, AnchorText)
    SELECT TTT0.SourceDocid, TTT0.DocId, TTT0.DisplayUrl, TTT0.DisplayHash, TTT0.LCID, TTT0.AnchorText
    FROM MSSTranTempTable0 as TTT0
    WHERE SourceDocID = @DocID AND CrawlID = @CrawlID AND  
        (TTT0.itemtype = @ITEMTYPE_LINK OR  TTT0.itemtype = @ITEMTYPE_ANCHORNOCRAWL) AND
         TTT0.DisplayUrl not like 'anchorqh%' AND TTT0.DisplayUrl not like 'spsimport%' AND TTT0.DisplayUrl not like 'bdc%' AND
         TTT0.HrResult <> @GTHR_E_URL_EXCLUDED AND FirstLink <= @AnchorsLimit

GO
