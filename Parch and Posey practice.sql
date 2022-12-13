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