/*
For each day compute the rolling 7 days total number of answers by device
Rolling 7 days: 6 days before + this day
HINT: x rows rolling average window in Postgres syntax
SUM(col1) OVER(PARTITION BY col2 ORDER BY col3 ROWS BETWEEN x-1 PRECEDING AND CURRENT ROW)
If there aren't 7 days before a row, use all days available.
For simplicity, we assume there were at least one event every day.
 

Table: alexa_answers 

Number of answers Alexa provided by date and device.

  col_name    | col_type 
--------------+-------------
date          | date
device        | varchar(20)
answers       | bigint

Sample results

    date    |   device    | rolling_sum
------------+-------------+-------------
 2021-08-01 | app         |       49923
 2021-08-02 | app         |      100670
 2021-08-03 | app         |      150725
 2021-08-04 | app         |      200691
 2021-08-05 | app         |      249833
 2021-08-06 | app         |      301035
 2021-08-07 | app         |      349954
 2021-08-08 | app         |      349464
 2021-08-09 | app         |      347215
 2021-08-10 | app         |      347614
 2021-08-11 | app         |      348713
 2021-08-12 | app         |      350495
*/
SELECT 
    date, 
    device,
    SUM(answers) OVER(PARTITION BY device ORDER BY date ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS rolling_sum
FROM alexa_answers;
