SELECT id, occurred_at, total_amt_usd
	FROM orders
ORDER BY occurred_at
LIMIT 10;   /* 10 most recent orders */

SELECT id, account_id, total_amt_usd
	FROM orders
ORDER BY total_amt_usd DESC
LIMIT 5;    

SELECT id, account_id, total_amt_usd
	FROM orders
ORDER BY total_amt_usd
LIMIT 20;

SELECT id, account_id, total_amt_usd
    FROM orders
ORDER BY account_id, total_amt_usd DESC;    /* 1st order by account_id, then order by total_amt_usd */

SELECT id, account_id, total_amt_usd
    FROM orders
ORDER BY total_amt_usd DESC, account_id;    /* 1st order by largest-smallest total_amt_usd, then order by account_id */

SELECT * FROM orders

SELECT * FROM orders
WHERE gloss_amt_usd >= 1000    /* a filter for when gloss paper amount of an order "gloss_amt_usd >= 1000" */  
LIMIT 5;

SELECT * FROM orders
WHERE total_amt_usd < 500   /* a filter for when total amount for all papers of an order "total_amt_usd < 500" */
LIMIT 10;

SELECT name, website, primary_poc
    FROM accounts
WHERE name = 'Exxon Mobil';

SELECT id, account_id, standard_amt_usd/standard_qty AS standard_unit_price
    FROM orders
LIMIT 10;

SELECT id, account_id, 
        poster_amt_usd * 100 / (standard_amt_usd + gloss_amt_usd + poster_amt_usd) AS poster_pct 
        /* to calculate the percentage of revenue from poster paper in an order and return as a derived column*/
    FROM orders
LIMIT 10;

SELECT * FROM accounts
WHERE name LIKE 'C%';    /* a filter for when the name of a customer-company starts with "C" */

SELECT * FROM  accounts
WHERE name LIKE '%one%';   /* a filter for when the name of a customer-company contains "one" */

SELECT * FROM accounts
WHERE name LIKE '%s';   /* a filter for when the name of a customer-company ends with "s" */

SELECT name, primary_poc, sales_rep_id 
    FROM accounts
WHERE name IN ('Walmart', 'Target', 'Nordstrom');    /* a filter for when the name of a customer-company is "Walmart", "Target", or "Nordstrom" */










SELECT * FROM web_events
WHERE channel IN ('organic', 'adwords');

SELECT name, primary_poc, sales_rep_id
    FROM accounts
WHERE name NOT IN ('Walmart', 'Target', 'Nordstrom');    /* a filter for when the name of a customer-company is not "Walmart", "Target", or "Nordstrom" */

SELECT * FROM web_events
WHERE channel NOT IN ('organic', 'adwords');   

SELECT name FROM accounts
WHERE name NOT LIKE 'C%';

SELECT name FROM accounts
WHERE name NOT LIKE '%one%';

SELECT name FROM accounts
WHERE name NOT LIKE '%s';

SELECT * FROM orders
WHERE standard_qty > 1000 AND poster_qty = 0 AND gloss_qty = 0;   /* a filter for when the quantity of standard paper is greater than 1000, and the quantity of poster paper and gloss paper are both 0 */

SELECT name FROM accounts
WHERE name NOT LIKE 'C%' AND name  LIKE '%s';   

SELECT occurred_at, gloss_qty FROM orders
WHERE gloss_qty BETWEEN 24 AND 29
ORDER BY gloss_qty DESC;

SELECt * from web_events
LIMIT 5;

SELECT * FROM web_events
WHERE channel IN ('organic', 'adwords') AND occurred_at BETWEEN '2016-01-01' AND '2017-01-01'   
/* a filter for when the channel is "organic" or "adwords" and the occurred_at any point in 2016 (note date endpoint tricky) */
ORDER BY occurred_at DESC;

SELECT id FROM orders
WHERE gloss_qty > 4000 OR poster_qty > 4000;

SELECT * FROM orders 
WHERE standard_qty = 0 AND (gloss_qty > 1000 OR poster_qty > 1000);   /* a filter for when the quantity of standard paper is 0, and the quantity of either gloss paper or poster paper is greater than 1000 */

SELECT id, name FROM accounts
WHERE name LIKE '%ana%' OR name LIKE '%Ana%' AND name NOT LIKE '%eana%';    /* a filter for when the name of a customer-company contains "ana" or "Ana" but does not contain "eana" */ 

SELECT * 
FROM orders
JOIN accounts 
ON orders.account_id = accounts.id;

SELECT standard_qty, gloss_qty, poster_qty, website, primary_poc /* works but it's standard to specify every table a column comes from (orders.standard_qty, accounts.website)*/
FROM orders
JOIN accounts
ON orders.account_id = accounts.id;










/*markdown
## Aliases
*/


SELECT * FROM web_events
LIMIT 5;

SELECT acc.primary_poc, web.occurred_at, web.channel, acc.name
FROM web_events web
JOIN accounts acc
ON web.account_id = acc.id
WHERE acc.name = 'Walmart';











SELECT reg.name region, rep.name sales_rep, acc.name acccount
FROM accounts acc
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
ORDER BY acc.name;

SELECT reg.name AS region, acc.name AS account, 
       (ord.total_amt_usd/(ord.total + 0.01)) AS unit_price
FROM orders AS ord
JOIN accounts AS acc
ON ord.account_id = acc.id
JOIN sales_reps AS rep
ON acc.sales_rep_id = rep.id
JOIN region AS reg
ON rep.region_id = reg.id;

/*markdown
## Joins 
*/

SELECT rep.name sales_rep, reg.name region, acc.name account
FROM accounts acc
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
WHERE reg.name = 'Midwest'
ORDER BY acc.name;

SELECT rep.name sales_rep, reg.name region, acc.name account
FROm accounts acc
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
WHERE rep.name LIKE 'S%' AND reg.name = 'Midwest'
ORDER BY acc.name;

SELECT reg.name region, rep.name sales_rep, acc.name account
FROM accounts acc
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
WHERE rep.name LIKE '% K%' AND reg.name = 'Midwest'
ORDER BY acc.name;

SELECT acc.name account, reg.name region, 
       (total_amt_usd/(total + 0.01)) unit_price
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
WHERE standard_qty > 100;

SELECT acc.name account, reg.name region, 
       (total_amt_usd/(total + 0.01)) unit_price
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
WHERE standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price;

SELECT acc.name account, reg.name region, 
       (total_amt_usd/(total + 0.01)) unit_price
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
WHERE standard_qty > 100 AND poster_qty > 50
ORDER BY unit_price DESC;

SELECT DISTINCT acc.name account, web.channel channel_used
FROM accounts acc
JOIN web_events web
ON web.account_id = acc.id
WHERE acc.id = 1001;

SELECT ord.occurred_at, acc.name account, ord.total total_order,
       ord.total_amt_usd total_amt_used
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
WHERE ord.occurred_at BETWEEN '2015-01-01' AND  '2016-01-01'
ORDER BY ord.occurred_at;

/*markdown
## Aggregations


*/

SELECT COUNT (*)
FROM orders;

SELECT COUNT (id) FROM orders;

SELECT SUM (poster_qty) AS total_poster_sold
FROM orders;

SELECT sUM (standard_qty) AS total_standard_sold
FROM orders;

SELECT SUM (total_amt_usd) AS total_dollar_sales
FROM orders;

SELECT (standard_amt_usd + gloss_amt_usd) AS total_standard_gloss
FROM orders;

SELECT SUM (standard_amt_usd) / SUM (standard_qty) AS standard_price_per_unit
FROM orders;

SELECT * FROM orders
LIMIT 5;

SELECT MIN (occurred_at) AS earliest_order
FROM orders;

SELECT occurred_at AS earliest_order_date
FROM orders
ORDER BY occurred_at
LIMIT 1;

SELECT * FROM web_events
LIMIT 5;

SELECT MAX (occurred_at) AS latest_web_event
FROM web_events;

SELECT occurred_at AS latest_web_event_date
FROM web_events
ORDER BY occurred_at DESC
LIMIT 1;

SELECT AVG (standard_amt_usd) AS average_standard_price,
       AVG (gloss_amt_usd) AS average_gloss_price,
       AVG (poster_amt_usd) AS average_poster_price,
       AVG (standard_qty) AS average_standard_qty,
       AVG (gloss_qty) AS average_gloss_qty,
       AVG (poster_qty) AS average_poster_qty
FROM orders;

SELECT *
FROM (SELECT total_amt_usd
      FROM orders
      ORDER BY total_amt_usd
      LIMIT 3457) AS Table1
ORDER BY total_amt_usd DESC
LIMIT 2;

SELECT MIN (occurred_at) 
FROM orders;

SELECT acc.name account, ord.occurred_at
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
ORDER BY occurred_at
LIMIT 1;

SELECT acc.name account, SUM (ord.total_amt_usd) total_sales
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY acc.name

SELECT MAX (occurred_at) FROM web_events LIMIT 1;

SELECT acc.name account, web.channel channel, web.occurred_at date
FROM accounts acc
JOIN web_events web
ON web.account_id = acc.id
ORDER BY web.occurred_at DESC
LIMIT 1;

SELECT channel, COUNT (channel) AS total_times_used
FROM web_events
GROUP BY channel
ORDER BY channel;

SELECT ACC.primary_poc, web.occurred_at
FROM accounts acc
JOIN web_events web
ON web.account_id = acc.id
ORDER BY web.occurred_at
LIMIT 1;

SELECT acc.name account, MIN (ord.total_amt_usd) min_order
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY acc.name
ORDER BY MIN (ord.total_amt_usd);

SELECT reg.name region, COUNT (rep.*) total_sales_reps
FROM sales_reps rep
JOIN region reg
ON rep.region_id = reg.id
GROUP BY reg.name
ORDER BY COUNT (rep.*);

SELECT acc.name account, 
       AVG (standard_qty) avg_standard_qty,
       AVG (gloss_qty) avg_gloss_qty,
       AVG (poster_qty) avg_poster_qty
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY account;

SELECT acc.name account, 
       AVG (standard_amt_usd) avg_standard_price, 
       AVG (gloss_amt_usd) avg_gloss_price, 
       AVG (poster_amt_usd) avg_poster_price
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY acc.name;

SELECT rep.name sales_rep, web.channel, COUNT (web.channel) times_used
FROM sales_reps rep
JOIN accounts acc
ON acc.sales_rep_id = rep.id
JOIN web_events web
ON web.account_id = acc.id
GROUP BY rep.name, web.channel
ORDER BY rep.name, times_used DESC;

SELECT reg.name region,
       web.channel channel,
       COUNT (web.channel) times_used
FROM web_events web
JOIN accounts acc
ON web.account_id = acc.id
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
GROUP BY region, channel
ORDER BY times_used DESC;

SELECT DISTINCT acc.name account, reg.name
FROM accounts acc
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id;

SELECT acc.name account, COUNT (reg.name) regions
    FROM accounts acc
    JOIN sales_reps rep
    ON acc.sales_rep_id = rep.id
    JOIN region reg
    ON rep.region_id = reg.id
    GROUP BY account;

SELECT s.name, COUNT (a.*) AS total_accounts
FROM accounts a 
JOIN sales_reps s
ON a.sales_rep_id = s.id
GROUP BY s.name
ORDER BY total_accounts;




SELECT DISTINCT id, name
FROM sales_reps;

SELECT rep.name sales_rep, COUNT (acc.name) accounts_managed
FROM accounts acc
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
GROUP BY sales_rep
HAVING COUNT (acc.name) > 5
ORDER BY accounts_managed, sales_rep;






SELECT acc.name account, COUNT (ord.*) as orders_made
FROM orders ord
JOIN accounts acc
On ord.account_id = acc.id
GROUP BY account
HAVING COUNT (ord.*) > 20
ORDER BY orders_made;

SELECT acc.name account, COUNT (ord.*) as orders_made
FROM orders ord
JOIN accounts acc
On ord.account_id = acc.id
GROUP BY account
ORDER BY orders_made DESC
LIMIT 1;

SELECT acc.name account, SUM (total_amt_usd) total_ord_amt
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY account
HAVING SUM (total_amt_usd) > 30000
ORDER BY total_ord_amt;

SELECT acc.name account, SUM (total_amt_usd) total_ord_amt
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY account
HAVING SUM (total_amt_usd) < 1000
ORDER BY total_ord_amt;

SELECT acc.name account, SUM (total_amt_usd) total_ord_amt
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY account
ORDER BY total_ord_amt DESC
LIMIT 1;

SELECT acc.name account, SUM (total_amt_usd) total_ord_amt
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY account
ORDER BY total_ord_amt
LIMIT 1;

SELECT acc.name account, web.channel channel, COUNT (web.*) times_used
FROM accounts acc
JOIN web_events web
ON web.account_id = acc.id
GROUP BY account, channel
HAVING channel = 'facebook' AND COUNT (web.*) > 6
ORDER BY times_used;






SELECT acc.name account, web.channel channel, COUNT (web.*) times_used
FROM accounts acc
JOIN web_events web
ON web.account_id = acc.id
GROUP BY account, channel
HAVING channel = 'facebook'
ORDER BY times_used DESC
LIMIT 1;






SELECT web.channel channel, COUNT (acc.*)
FROM accounts acc
JOIN web_events web
ON web.account_id = acc.id
GROUP BY channel
ORDER BY COUNT (acc.*) DESC
LIMIT 1;

SELECT DATE_PART ('year', occurred_at) year_occurred, 
       SUM (total_amt_usd) year_sales
FROM orders
GROUP BY 1
ORDER BY 2 DESC;





SELECT DATE_TRUNC ('month', occurred_at) month_occurred, 
       SUM (total_amt_usd) sales_usd
FROM orders

GROUP BY 1
ORDER BY 1 DESC;

SELECT DATE_PART ('month', occurred_at) month_occurred, 
       SUM (total_amt_usd) month_sales
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_PART ('year', occurred_at) year_occurred, 
       COUNT (*) year_orders
FROM orders
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_PART ('month', occurred_at) month_occurred, 
       COUNT (*) month_orders
FROM orders
WHERE occurred_at BETWEEN '2014-01-01' AND '2017-01-01'
GROUP BY 1
ORDER BY 2 DESC;

SELECT DATE_TRUNC ('month', ord.occurred_at) month_occurred, SUM (ord.gloss_amt_usd) gloss_sales
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
WHERE acc.name = 'Walmart'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT occurred_at, total_amt_usd
FROM orders
ORDER BY 1 DESC;

SELECT id, account_id, total_amt_usd, 
  CASE WHEN total_amt_usd >= 3000 THEN 'large'  
       ELSE'small'
       END AS order_level
FROM orders;

SELECT CASE WHEN total >= 2000 THEN 'at_least_2000'
            WHEN total >= 1000 AND total < 2000 THEN 'between_1000_and_2000'
            ELSE 'less_than_1000'
            END AS order_catgories,
            COUNT (*) category_orders
FROM orders
GROUP BY 1
ORDER BY 1 DESC;

SELECT acc.name account, SUM (ord.total_amt_usd) order_amount , 
CASE WHEN SUM (ord.total_amt_usd) > 200000 THEN 'level_1'
     WHEN SUM (ord.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'level_2'
     ELSE 'level_3'
     END AS account_level
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY 1
ORDER BY 2 DESC;

SELECT acc.name account, SUM (ord.total_amt_usd) order_amount , 
  CASE WHEN SUM (ord.total_amt_usd) > 200000 THEN 'level_1'
       WHEN SUM (ord.total_amt_usd) BETWEEN 100000 AND 200000 THEN 'level_2'
       ELSE 'level_3'
       END AS account_level
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
WHERE ord.occurred_at > '2015-12-31'
GROUP BY 1
ORDER BY 2 DESC;

SELECT rep.name sales_rep, COUNT (ord.*) orders_attended, 
  CASE WHEN COUNT (ord.*) > 200 THEN 'top' ELSE 'not' END AS performing_sales_rep
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
GROUP BY 1
ORDER BY 2 DESC;

SELECT rep.name sales_rep, COUNT (ord.*) orders_attended, SUM (ord.total_amt_usd) total_sales,
  CASE WHEN COUNT (ord.*) > 200 OR SUM (ord.total_amt_usd) > 750000 THEN 'top' 
       WHEN (COUNT (ord.*) BETWEEN 150 AND 200) OR (SUM (ord.total_amt_usd) BETWEEN 500000 AND 750000) THEN 'middle'
       ELSE 'low' END AS performing_sales_rep
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
GROUP BY 1
ORDER BY 3 DESC;

SELECT channel, AVG (events)
FROM (  SELECT DATE_TRUNC ('day', occurred_at) date, channel, COUNT(channel) events
        FROM web_events
        GROUP BY 1, 2
        ORDER BY 1) sub
GROUP BY 1
ORDER BY 1;

SELECT DATE_TRUNC ('day', occurred_at) date, channel, COUNT(channel) events
FROM web_events
GROUP BY 1, 2
ORDER BY 3 DESC

SELECT DATE_TRUNC ('month', MIN (occurred_at))
FROM orders

SELECT *
FROM orders
WHERE DATE_TRUNC ('month', occurred_at) = ( SELECT DATE_TRUNC ('month', MIN (occurred_at))
                                            FROM orders)

SELECT AVG (standard_qty) avg_standard_qty,
       AVG (gloss_qty) avg_gloss_qty,
       AVG (poster_qty) avg_poster_qty,
       SUM (total_amt_usd) total_sales
FROM (  SELECT *
        FROM orders
        WHERE DATE_TRUNC ('month', occurred_at) = ( SELECT DATE_TRUNC ('month', MIN (occurred_at))
                                            FROM orders)) sub_2;

/*markdown
1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
*/

SELECT reg.name region, rep.name sales_rep, SUM (ord.total_amt_usd) total_sales
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        JOIN sales_reps rep 
        ON acc.sales_rep_id = rep.id
        JOIN region reg
        ON rep.region_id = reg.id
        GROUP BY 1, 2
        ORDER BY 1, 3 DESC

SELECT region, MAX (total_sales) max_sales
FROM (SELECT reg.name region, rep.name sales_rep, SUM (ord.total_amt_usd) total_sales
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        JOIN sales_reps rep 
        ON acc.sales_rep_id = rep.id
        JOIN region reg
        ON rep.region_id = reg.id
        GROUP BY 1, 2
        ORDER BY 1, 3 DESC) sub
GROUP BY 1;

/*markdown
A table that utilizes 2 subqueries on the FROM and JOIN statement.
*/

SELECT sub_1.region, sub_2.sales_rep, sub_1.max_sales
FROM (SELECT region, MAX (total_sales) max_sales
      FROM (SELECT reg.name region, rep.name sales_rep, SUM (ord.total_amt_usd) total_sales
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        JOIN sales_reps rep 
        ON acc.sales_rep_id = rep.id
        JOIN region reg
        ON rep.region_id = reg.id
        GROUP BY 1, 2
        ORDER BY 1, 3 DESC) sub
      GROUP BY 1) sub_1
JOIN (SELECT reg.name region, rep.name sales_rep, SUM (ord.total_amt_usd) total_sales
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        JOIN sales_reps rep 
        ON acc.sales_rep_id = rep.id
        JOIN region reg
        ON rep.region_id = reg.id
        GROUP BY 1, 2
        ORDER BY 1, 3 DESC) sub_2
ON sub_1.max_sales = sub_2.total_sales

/*markdown
2. For the region with the largest (sum) of sales total_amt_usd, how many total (count) orders were placed?
*/

SELECT reg.name region, SUM (total_amt_usd) total_sales
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT reg.name region, COUNT (*) total_orders
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
JOIN sales_reps rep
ON acc.sales_rep_id = rep.id
JOIN region reg
ON rep.region_id = reg.id
GROUP BY 1

SELECT sub_1.region, sub_1.total_sales, sub_2.total_orders
FROM (SELECT reg.name region, SUM (total_amt_usd) total_sales
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        JOIN sales_reps rep
        ON acc.sales_rep_id = rep.id
        JOIN region reg
        ON rep.region_id = reg.id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 1) sub_1
JOIN (SELECT reg.name region, COUNT (*) total_orders
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        JOIN sales_reps rep
        ON acc.sales_rep_id = rep.id
        JOIN region reg
        ON rep.region_id = reg.id
        GROUP BY 1) sub_2
ON sub_1.region = sub_2.region



/*markdown
3. How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
*/

SELECT acc.name, SUM (standard_qty) total_standard_qty, SUM (total) total_sales
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT acc.name account
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY 1
HAVING SUM (ord.total) >= (SELECT total_sales
                          FROM (SELECT acc.name, SUM (standard_qty) total_standard_qty, SUM (total) total_sales
                                FROM orders ord
                                JOIN accounts acc
                                ON ord.account_id = acc.id
                                GROUP BY 1
                                ORDER BY 2 DESC
                                LIMIT 1) sub)
ORDER BY SUM (ord.total) DESC;

SELECT COUNT (*)
FROM ( SELECT acc.name account
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        GROUP BY 1
        HAVING SUM (ord.total) > ( SELECT total_sales
                                    FROM (SELECT acc.name, SUM (standard_qty) total_standard_qty, SUM (total) total_sales
                                            FROM orders ord
                                            JOIN accounts acc
                                            ON ord.account_id = acc.id
                                            GROUP BY 1
                                            ORDER BY 2 DESC
                                            LIMIT 1) sub)) sub_out

/*markdown
4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
*/

SELECT acc.name account, SUM (total_amt_usd) total_sales
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 1;

SELECT acc.name account, channel, COUNT (*) events
FROM accounts acc
JOIN web_events web
ON acc.id = web.account_id
GROUP BY 1, 2
ORDER BY 1, 2;

SELECT s1.account, s2.channel, s2.events
FROM (  SELECT acc.name account, SUM (total_amt_usd) total_sales
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 1) s1
LEFT JOIN (     SELECT acc.name account, channel, COUNT (*) events
                FROM accounts acc
                JOIN web_events web
                ON acc.id = web.account_id
                GROUP BY 1, 2
                ORDER BY 1, 2) s2
ON s1.account = s2.account;

/*markdown
5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
*/



SELECT acc.name account, SUM (total_amt_usd)
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

SELECT AVG(tot_spent)
FROM (SELECT a.id, a.name, SUM(o.total_amt_usd) tot_spent
      FROM orders o
      JOIN accounts a
      ON a.id = o.account_id
      GROUP BY a.id, a.name
      ORDER BY 3 DESC
       LIMIT 10) temp;

/*markdown
or
*/

SELECT acc.name account, AVG (total_amt_usd)
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY 1

SELECT s1.account, s2.avg average_sales
FROM (SELECT acc.name account, SUM (total_amt_usd)
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        GROUP BY 1
        ORDER BY 2 DESC
        LIMIT 10) s1
LEFT JOIN (     SELECT acc.name account, AVG (total_amt_usd)
                FROM orders ord
                JOIN accounts acc
                ON ord.account_id = acc.id
                GROUP BY 1) s2
ON s1.account = s2.account 



/*markdown
6. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
*/

SELECT acc.name account, AVG (total_amt_usd) average_sales
FROM orders ord
JOIN accounts acc
ON ord.account_id = acc.id
GROUP BY 1

SELECT AVG (total_amt_usd)
FROM orders

SELECT *
FROM (  SELECT acc.name account, AVG (total_amt_usd) average_sales
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        GROUP BY 1) sub
WHERE average_sales > (SELECT AVG (total_amt_usd) 
                        FROM orders);



SELECT AVG (average_sales)
FROM (SELECT *
FROM (  SELECT acc.name account, AVG (total_amt_usd) average_sales
        FROM orders ord
        JOIN accounts acc
        ON ord.account_id = acc.id
        GROUP BY 1) sub
WHERE average_sales > (SELECT AVG (total_amt_usd) 
                        FROM orders)
) sub_out;



/*markdown
WITH command for Subqueries
*/

/*markdown
1. Provide the name of the sales_rep in each region with the largest amount of total_amt_usd sales.
*/

WITH sales AS ( SELECT reg.name region, rep.name sales_rep, SUM (total_amt_usd) total_sales
                FROM orders ord
                JOIN accounts acc
                ON ord.account_id = acc.id
                JOIN sales_reps rep
                ON acc.sales_rep_id = rep.id
                JOIN region reg
                ON rep.region_id = reg.id
                GROUP BY 1, 2
                ORDER BY 1, 3 DESC),

       max AS ( SELECT region, MAX (total_sales) max_sales
                FROM sales
                GROUP BY 1)


SELECT max.region, sales.sales_rep, max.max_sales
FROM sales
JOIN max
ON sales.total_sales = max.max_sales




/*markdown
2. For the region with the largest sales total_amt_usd, how many total orders were placed?
*/

WITH reg_sales AS ( SELECT reg.name region, SUM (total_amt_usd) total_sales
                    FROM orders ord
                    JOIN accounts acc
                    ON ord.account_id = acc.id
                    JOIN sales_reps rep
                    ON acc.sales_rep_id = rep.id
                    JOIN region reg
                    ON rep.region_id = reg.id
                    GROUP BY 1
                    ORDER BY 2 DESC
                    LIMIT 1),

    reg_orders AS ( SELECT reg.name region, COUNT (ord.*)
                    FROM orders ord
                    JOIN accounts acc
                    ON ord.account_id = acc.id
                    JOIN sales_reps rep
                    ON acc.sales_rep_id = rep.id
                    JOIN region reg
                    ON rep.region_id = reg.id
                    GROUP BY 1)

SELECT reg_sales.region, reg_sales.total_sales, reg_orders.count orders
FROM reg_sales
JOIN reg_orders
ON reg_sales.region = reg_orders.region

/*markdown
3. How many accounts had more total purchases than the account name which has bought the most standard_qty paper throughout their lifetime as a customer?
*/

WITH s1 AS (SELECT acc.name account, SUM (standard_qty) standard_qty, SUM (total) total_sales
            FROM orders ord
            JOIN accounts acc
            ON ord.account_id = acc.id
            GROUP BY 1
            ORDER BY 2 DESC
            LIMIT 1),

     s2 AS (SELECT total_sales
            FROM s1),

     s3 AS (SELECT acc.name
            FROM  orders ord
            JOIN accounts acc
            ON ord.account_id = acc.id
            GROUP BY 1
            HAVING SUM (ord.total) > ( SELECT total_sales FROM s2))

SELECT COUNT (*)
FROM s3;



/*markdown
4. For the customer that spent the most (in total over their lifetime as a customer) total_amt_usd, how many web_events did they have for each channel?
*/

WITH s1 AS (SELECT acc.name account, SUM (total_amt_usd) total_sales
            FROM orders ord
            JOIN accounts acc
            ON ord.account_id = acc.id
            GROUP BY 1
            ORDER BY 2 DESC
            LIMIT 1),

     s2 AS (SELECT acc.name account, channel, COUNT (*) events
            FROM accounts acc
            JOIN web_events web
            ON acc.id = web.account_id
            GROUP BY 1, 2
            ORDER BY 1, 2)

SELECT s2.*
FROM s1
LEFT JOIN s2
ON s1.account = s2.account;



/*markdown
5. What is the lifetime average amount spent in terms of total_amt_usd for the top 10 total spending accounts?
*/

WITH s1 AS (SELECT acc.name account, SUM (total_amt_usd) average_sales
            FROM orders ord
            JOIN accounts acc
            ON ord.account_id = acc.id
            GROUP BY 1
            ORDER BY 2 DESC
            LIMIT 10)

SELECT AVG(s1.average_sales)
FROM s1;

/*markdown
6. What is the lifetime average amount spent in terms of total_amt_usd, including only the companies that spent more per order, on average, than the average of all orders.
*/

WITH s1 AS (SELECT acc.name account, AVG(ord.total_amt_usd) avg_sales
            FROM orders ord
            JOIN accounts acc
            ON ord.account_id = acc.id
            JOIN web_events web
            ON acc.id = web.account_id
            GROUP BY 1),

     s2 AS (SELECT acc.name account
            FROM orders ord
            JOIN accounts acc
            ON ord.account_id = acc.id
            JOIN web_events web
            ON acc.id = web.account_id
            GROUP BY 1
            HAVING AVG (ord.total_amt_usd) > (SELECT AVG (total_amt_usd) FROM orders)),

     s3 AS (SELECT s2.account, s1.avg_sales average_sales
            FROM s2
            LEFT JOIN s1
            ON s1.account = s2.account)

SELECT AVG (s3.average_sales)
FROM s3





