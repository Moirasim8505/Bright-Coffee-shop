SELECT*
FROM SALES.MOIRA.COFFEE
LIMIT 20;

SELECT MIN(transaction_time)
FROM SALES.MOIRA.COFFEE;

SELECT MAX(transaction_time)
FROM SALES.MOIRA.COFFEE;

--Coffee shop result build up
SELECT
    --TIME
    TO_DATE(transaction_date)AS Transaction_date,
    DAYOFMONTH(TO_DATE(transaction_date)) AS Day_of_month,
    DAYNAME(TO_DATE(transaction_date))AS Day_name,
    MONTHNAME(TO_DATE(transaction_date))AS Month_name,
    TO_CHAR(TO_DATE(transaction_date),'YYYYMM' ) AS Month_id,
 CASE
    WHEN transaction_time BETWEEN '06:00:00' AND '11:59:59' THEN 'Morning'
    WHEN transaction_time BETWEEN '12:00:00' AND '16:59:59' THEN 'Afternoon'
    WHEN transaction_time BETWEEN '17:00:00' AND '19:59:59' THEN 'Evening' 
    ELSE 'Night'
END AS Time_bucket,

CASE 
    WHEN Day_name NOT IN ('Sat','Sun') THEN 'Weekday'
    ELSE 'Weekend'
END AS Day_Classification,


ROUND(SUM(IFNULL(transaction_qty, 0) * IFNULL(unit_price, 0)), 0) AS Revenue,


    COUNT(DISTINCT transaction_id) AS Number_of_sales,
    COUNT(DISTINCT product_id) AS Number_of_unique_products,
    COUNT(DISTINCT store_id) AS Number_of_shops,
    --Categorical data
    store_location,
    product_category,
    product_detail,
    product_type,

FROM SALES.MOIRA.COFFEE
GROUP BY ALL;
