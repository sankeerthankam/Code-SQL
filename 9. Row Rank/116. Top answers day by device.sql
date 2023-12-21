/*
Return for each Alex device, the date when they have the most number of answers, and the number of answers.
Table: alexa_answers 

Number of answers Alexa provided by date and device.

  col_name    | col_type 
--------------+-------------
date          | date
device        | varchar(20)
answers       | bigint

Sample results

    date    |   device    | answers
------------+-------------+---------
 2021-08-28 | app         |   52066
 2021-08-23 | echo dot    |  101653
*/
WITH answers_ranking AS (
  SELECT 
      date, device, 
      answers, 
      ROW_NUMBER() OVER(PARTITION BY device ORDER BY answers DESC) ranking
  FROM alexa_answers
)
SELECT date, device, answers
FROM answers_ranking
WHERE ranking = 1;
