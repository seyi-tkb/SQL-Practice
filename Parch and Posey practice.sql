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



/*markdown

*/