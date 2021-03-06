/****** Object:  StoredProcedure [dbo].[FM_LogErrors]    Script Date: 5/15/2018 12:09:43 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
-- =============================================
-- Author:		Alex Montminy
-- Create date: 10/08/2012
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[FM_LogErrors] 
	-- Add the parameters for the stored procedure here
	@XML xml 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	
insert into [dbo].[FastmailErrorLog]( ActionType,ErrorMsg,ET_ErrorCode,EmailAddress,[Time])
select
E.N.value('./ActionType[1]', 'nvarchar(max)'),
E.N.value('./ErrorMsg[1]', 'nvarchar(max)'),
E.N.value('./ET_ErrorCode[1]', 'nvarchar(max)'),
E.N.value('./EmailAddress[1]', 'nvarchar(max)'),
getDate()

from 
@XML.nodes('/ErrorSyncXml/Nodes/ErrorSyncNode') E(N)
END

GO
