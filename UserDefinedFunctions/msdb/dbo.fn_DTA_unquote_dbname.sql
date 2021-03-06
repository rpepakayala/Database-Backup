/****** Object:  UserDefinedFunction [dbo].[fn_DTA_unquote_dbname]    Script Date: 5/15/2018 12:14:54 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
create function fn_DTA_unquote_dbname(@dbname nvarchar(258) )
returns sysname
as
begin
	declare @unquote nvarchar(258) 
	set @unquote = @dbname
	if(patindex(N'[[]%',@unquote) > 0)
		  select @unquote = right(@unquote, LEN(@unquote)-1)
	if(patindex(N'%]',@unquote)  > 0)
		  select @unquote = left(@unquote, LEN(@unquote)-1)
	select @unquote =REPLACE (@unquote,N']]',N']')
	return @unquote
end

GO
