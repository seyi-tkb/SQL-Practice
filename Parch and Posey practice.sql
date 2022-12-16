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