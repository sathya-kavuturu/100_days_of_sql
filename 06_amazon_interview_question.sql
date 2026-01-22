--Write a query to provide the date for nth occurrence of sunday in future from given date.

USE DaysOfSQL;

declare @today_date date;
declare @n int;
set @today_date = '2022-01-01'; -- saturday
set @n = 3;

SELECT
DATEADD(week,@n-1,DATEADD(DAY,8-DATEPART(w,@today_date),@today_date))
 

