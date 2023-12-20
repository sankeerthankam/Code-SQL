/*
Write a query to aggregate daily purchases by the platform in August 2021;
The platform is derived from order_channel: desktop, mobile, other (any other channel); 
Return the following columns: date, platform, sum of purchase
Table: ap_order 

Afterpay's order table

  col_name      | col_type
----------------+-------------------
id              | bigint
date            | date
customer_id     | bigint
merchant_id     | bigint
order_channel   | varchar(10)
purchase_amount | float

Sample results

 2021-08-06 | others   | 1548.3799999999999
 2021-08-07 | desktop  | 2187.4300000000003
 2021-08-07 | mobile   |             1774.8
 2021-08-07 | others   |            1259.52
 2021-08-08 | desktop  |            1488.89
*/
SELECT
    date,
    CASE WHEN order_channel = 'mobile' THEN 'mobile'
         WHEN order_channel = 'desktop' THEN 'desktop'
         ELSE 'others' END AS platform,
    SUM(purchase_amount)
FROM ap_order
WHERE date >= '2021-08-01'
AND date <= '2021-08-31'
GROUP BY 1,2
ORDER BY 1,2;
