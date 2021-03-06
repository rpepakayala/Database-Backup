/****** Object:  StoredProcedure [dbo].[proc_MSS_GetAllBestBetsCount]    Script Date: 5/15/2018 12:13:30 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE PROCEDURE dbo.proc_MSS_GetAllBestBetsCount
@ConsumerGpId NVARCHAR(50),
@Filter int,
@Value NVARCHAR(2048) = null,
@Count int OUTPUT  AS 
set @Count = 0
declare @strCommand nvarchar(4000)
declare @filterCommand nvarchar (1000)
set @filterCommand = ''
set @strCommand = 'SELECT @cnt = count(*) FROM MSSBestBets a join MSSBBConsumerGpLink b 
ON a.BestBetId = b.BestBetID
WHERE ConsumerGpId = @ConsumerGpId '
if(@Value is not null)
BEGIN
if (@Filter = 0)
BEGIN
 SET @filterCommand = ' and Title like @value '
END
if (@Filter = 1)
BEGIN
 SET @filterCommand = ' and Url like @value '
END
if (@Filter = 2)
BEGIN
 SET @filterCommand = ' and (Title like @value OR Url like @value) '
END
END
SET @strCommand = @strCommand + @filterCommand 
EXEC sp_executesql @strCommand, N'@cnt int OUTPUT, @consumerGpId NVARCHAR(50), @value NVARCHAR(2048)', @cnt = @Count OUTPUT, @consumerGpId = @ConsumerGpId, @value = @Value

GO
