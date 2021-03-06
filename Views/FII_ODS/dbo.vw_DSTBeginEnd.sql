/****** Object:  View [dbo].[vw_DSTBeginEnd]    Script Date: 5/15/2018 12:13:48 PM ******/
SET ANSI_NULLS ON
SET QUOTED_IDENTIFIER ON





CREATE   VIEW [dbo].[vw_DSTBeginEnd]
AS
    /* US CA first april sunday up to 2006  yes I see now that I could have used month_of_year so shut up! */
SELECT  'US' AS CountryCode
      , 'DSTBegin' AS BeginEnd
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.TimeDim t   WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 4
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND DATEPART(YEAR, t.pk_date) <= 2005
        AND ( SELECT    COUNT(*)
              FROM      [FII_ODS].System.[TimeDim] t2
              WHERE     t2.pk_Date <= t.pk_Date
                        AND t2.[Year] = t.[Year]
                        AND t2.[Month] = t.[Month]
                        AND t2.Date_Name LIKE 'Sunday%'
            ) = 1
UNION

/* US CA second sunday march after 2005  */
SELECT  'US'
      , 'DSTBegin'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t   WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 3
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND DATEPART(YEAR, t.pk_date) > 2005
        AND ( SELECT    COUNT(*)
              FROM      [FII_ODS].System.[TimeDim] t2
              WHERE     t2.pk_Date <= t.pk_Date
                        AND t2.[Year] = t.[Year]
                        AND t2.[Month] = t.[Month]
                        AND t2.Date_Name LIKE 'Sunday%'
            ) = 2
UNION
/* MX  first april sunday  up to 2009  */
SELECT  'MX'
      , 'DSTBegin'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t  WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 4
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND DATEPART(YEAR, t.pk_date) <= 2008
        AND ( SELECT    COUNT(*)
              FROM      [FII_ODS].System.[TimeDim] t2
              WHERE     t2.pk_Date <= t.pk_Date
                        AND t2.[Year] = t.[Year]
                        AND t2.[Month] = t.[Month]
                        AND t2.Date_Name LIKE 'Sunday%'
            ) = 1
UNION
/* MX second sunday march after 2008  */
SELECT  'MX'
      , 'DSTBegin'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t  WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 3
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND DATEPART(YEAR, t.pk_date) > 2008
        AND ( SELECT    COUNT(*)
              FROM      [FII_ODS].System.[TimeDim] t2
              WHERE     t2.pk_Date <= t.pk_Date
                        AND t2.[Year] = t.[Year]
                        AND t2.[Month] = t.[Month]
                        AND t2.Date_Name LIKE 'Sunday%'
            ) = 2
UNION
/* AU first october sunday 2am*/
SELECT  'AU'
      , 'DSTBegin'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t  WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 10
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND ( SELECT    COUNT(*)
              FROM      [FII_ODS].System.[TimeDim] t2
              WHERE     t2.pk_Date <= t.pk_Date
                        AND t2.[Year] = t.[Year]
                        AND t2.[Month] = t.[Month]
                        AND t2.Date_Name LIKE 'Sunday%'
            ) = 1
UNION
/* End DST */

/* US CA last october sunday up to 2006  2am*/
SELECT  'US'
      , 'DSTEnd'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t  WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 10
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND DATEPART(YEAR, t.pk_date) <= 2005
        AND t.pk_Date IN ( SELECT   MAX(t2.pk_Date)
                           FROM     [FII_ODS].System.[TimeDim] t2
                           WHERE    t2.[Year] = t.[Year]
                                    AND t2.[Month] = t.[Month]
                                    AND t2.Date_Name LIKE 'Sunday%' )
UNION

/* US CA first November sunday  after 2005  */
SELECT  'US'
      , 'DSTEnd'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t  WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 11
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND DATEPART(YEAR, t.pk_date) > 2005
        AND ( SELECT    COUNT(*)
              FROM      [FII_ODS].System.[TimeDim] t2
              WHERE     t2.pk_Date <= t.pk_Date
                        AND t2.[Year] = t.[Year]
                        AND t2.[Month] = t.[Month]
                        AND t2.Date_Name LIKE 'Sunday%'
            ) = 1
UNION

/* MX  last oct sunday  up to 2009  */
SELECT  'MX'
      , 'DSTEnd'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t  WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 10
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND DATEPART(YEAR, t.pk_date) <= 2008
        AND t.pk_Date IN ( SELECT   MAX(t2.pk_Date)
                           FROM     [FII_ODS].System.[TimeDim] t2
                           WHERE    t2.[Year] = t.[Year]
                                    AND t2.[Month] = t.[Month]
                                    AND t2.Date_Name LIKE 'Sunday%' )
UNION

/* MX first sunday nov after 2008  */
SELECT  'MX'
      , 'DSTEnd'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t  WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 11
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND DATEPART(YEAR, t.pk_date) > 2008
        AND ( SELECT    COUNT(*)
              FROM      [FII_ODS].System.[TimeDim] t2
              WHERE     t2.pk_Date <= t.pk_Date
                        AND t2.[Year] = t.[Year]
                        AND t2.[Month] = t.[Month]
                        AND t2.Date_Name LIKE 'Sunday%'
            ) = 1
UNION
/* AU first April sunday 2am*/
SELECT  'AU'
      , 'DSTEnd'
      , DATEADD(Hour,2,t.PK_Date) AS DST_Date
      , DATEPART(YEAR, t.pk_date)  AS DST_Year
      , t.[Month_Of_Year]
FROM    [FII_ODS].System.[TimeDim] t  WITH ( NOLOCK ) 
WHERE   DATEPART(MONTH, t.pk_date) = 4
        AND DATENAME(weekday, t.pk_date) = 'Sunday'
        AND ( SELECT    COUNT(*)
              FROM      [FII_ODS].System.[TimeDim] t2
              WHERE     t2.pk_Date <= t.pk_Date
                        AND t2.[Year] = t.[Year]
                        AND t2.[Month] = t.[Month]
                        AND t2.Date_Name LIKE 'Sunday%'
            ) = 1

				




GO
