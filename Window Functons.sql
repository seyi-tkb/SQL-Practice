/*markdown
SQL WINDOWS Function
*/

/*markdown
1. create a running total of standard_amt_usd (in the orders table) over order time with no date truncation.
*/

SELECT standard_amt_usd,
	   SUM (standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders;

/*markdown
02. create a running total of standard_amt_usd (in the orders table) over order time, but this time, date truncate occurred_at by year and partition by that same year-truncated occurred_at variable.
*/

SELECT standard_amt_usd,
	   SUM (standard_amt_usd) OVER (ORDER BY occurred_at) AS running_total
FROM orders;