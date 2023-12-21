/*
Context

We recently launched the Snap app in this new country on 2022-03-01, and now we want to run some data analysis.

Instruction

Write a query to return DAU from 2022-03-01 to 2022-03-31
If there is no DAU on that date, return 0.
DAU: a user who has at least one event on that day.
Table 1: dates 

Calendar dates from 01/01/2019 to 12/31/2025.

 col_name | col_type
----------+----------
 year     | smallint
 month    | smallint
 date     | date
Table 2: snap_session 

   col_name     | col_type
----------------+--------------------------
 user_id        | bigint
 event          | text 
 dt             | date -- date of the event
Sample results

    date    | count
------------+-------
 2022-03-01 |     9
 2022-03-02 |     7
 2022-03-03 |     0
 2022-03-04 |     6
 2022-03-05 |    15
*/
SELECT D.date, count(DISTINCT S.user_id)
FROM dates D
LEFT JOIN snap_session S
ON D.date = S.dt
WHERE D.date >= '2022-03-01'
AND D.date <= '2022-03-31'
GROUP BY 1
ORDER BY 1;
