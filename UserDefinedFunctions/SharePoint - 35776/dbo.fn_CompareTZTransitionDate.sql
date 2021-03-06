/****** Object:  UserDefinedFunction [dbo].[fn_CompareTZTransitionDate]    Script Date: 5/15/2018 12:15:08 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON
CREATE FUNCTION dbo.fn_CompareTZTransitionDate(
    @dtLocal datetime,
    @_m int,
    @_nwd int,
    @_wd int,
    @_h int)
RETURNS bit
AS
BEGIN
    DECLARE @month int
    SET @month = MONTH(@dtLocal)
    IF (@month > @_m)
        RETURN 1
    IF (@month < @_m)
        RETURN 0
    DECLARE @nthday int
    DECLARE @day int
    SET @day = DAY(@dtLocal)
    SET @nthday = ((@day - 1) / 7) + 1
    IF (@nthday > @_nwd)
        RETURN 1
    DECLARE @daysinmonth int
    DECLARE @adjnthday int
    IF ((@_nwd = 5) AND (@nthday >= 4))
    BEGIN
        IF (@month IN (4, 6, 9, 11))
            SET @daysinmonth = 30
        ELSE IF (@month <> 2)
            SET @daysinmonth = 31
        ELSE
        BEGIN
            DECLARE @year int
            SET @year = YEAR(@dtLocal)
            SET @daysinmonth =
                CASE
                    WHEN @year % 4 <> 0 THEN 28
                    WHEN @year % 100 <> 0 THEN 29
                    WHEN @year % 400 = 0 THEN 29
                    ELSE 28
                END
        END
        IF ((@nthday = 4) AND ((@daysinmonth - @day) >= 7))
            RETURN 0
    END
    ELSE
    BEGIN
        IF (@nthday < @_nwd)
            RETURN 0
    END
    DECLARE @weekdaypart int
    DECLARE @adjweekday int
    DECLARE @deltaweekday int
    DECLARE @adj_wd int
    SET @weekdaypart = @@DATEFIRST + DATEPART(weekday, @dtLocal) - 1
    IF @weekdaypart > 7
        SET @weekdaypart = @weekdaypart - 7
    SET @adjweekday = (@day - 1) % 7
    SET @deltaweekday = @weekdaypart - @adjweekday
    IF @deltaweekday < 0
        SET @deltaweekday = @deltaweekday + 7
    IF @deltaweekday > 0
    BEGIN
        SET @adj_wd = (@_wd - @deltaweekday)
        IF @adj_wd < 0
            SET @adj_wd = @adj_wd + 7
    END
    ELSE
    BEGIN
        SET @adj_wd = @_wd
    END
    IF (@_nwd < 5)
    BEGIN
        IF (@adjweekday > @adj_wd)
            RETURN 1
        ELSE IF (@adjweekday < @adj_wd)
            RETURN 0
    END
    ELSE
    BEGIN
        DECLARE @last_wd int
        IF (@nthday = 5)
        BEGIN
            IF (@adjweekday > @adj_wd)
            BEGIN
                RETURN 1
            END
            ELSE IF (@adjweekday < @adj_wd)
            BEGIN
                SET @last_wd = @day + (@adj_wd - @adjweekday)
                IF (@last_wd > @daysinmonth)
                    RETURN 1
                ELSE
                    RETURN 0
            END
        END
        ELSE IF (@adjweekday <> @adj_wd)
        BEGIN
            IF (@adjweekday < @adj_wd)
                SET @last_wd = @day + (@adj_wd - @adjweekday)
            ELSE
                SET @last_wd = @day + (@adj_wd + 7) - @adjweekday
            IF (@last_wd > @daysinmonth)
                RETURN 1
            ELSE
                RETURN 0
        END
    END
    DECLARE @bGTE bit
    IF (DATEPART(hour, @dtLocal) >= @_h)
        SET @bGTE = 1
    ELSE
        SET @bGTE = 0
    RETURN  @bGTE
END

GO
