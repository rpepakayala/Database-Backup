/****** Object:  StoredProcedure [dbo].[sp_GetMailingsDates]    Script Date: 5/15/2018 12:10:25 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE [dbo].[sp_GetMailingsDates] 
AS
BEGIN
      SET NOCOUNT ON;

      select distinct convert(      VARCHAR, mailingdate, 101) as 'MailingDate' from dmmailings

END

GO
