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
ORDER BY times_used DESC 



