/*markdown
LEFT & RIGHT
*/

/*markdown
1. In the accounts table, there is a column holding the website for each company. The last three digits specify what type of web address they are using. Pull these extensions and provide how many of each website type exist in the accounts table.
*/

SELECT RIGHT (website, 3) domain, COUNT (RIGHT (website, 3)) companies
FROM accounts
GROUP BY 1;

/*markdown
2. There is much debate about how much the name (or even the first letter of a company name) matters. Use the accounts table to pull the first letter of each company name to see the distribution of company names that begin with each letter (or number).
*/

SELECT LEFT (name, 1) name, COUNT (LEFT (name, 1)) companies
FROM accounts
GROUP BY 1
ORDER BY 2 DESC;

/*markdown
3. Use the accounts table and a CASE statement to create two groups: one group of company names that start with a number and a second group of those company names that start with a letter. What proportion of company names start with a letter?
*/

WITH s1 AS (SELECT name,
                  CASE WHEN LEFT (name, 1) IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN '1' ELSE 0 
                    END AS number,
                  CASE WHEN LEFT (name, 1) NOT IN ('0', '1', '2', '3', '4', '5', '6', '7', '8', '9') THEN '1' ELSE 0 
                    END AS letter
           FROM accounts)

SELECT SUM (number) number, SUM (letter) letter
FROM s1;






/*markdown
4. Consider vowels as a, e, i, o, and u. What proportion of company names start with a vowel, and what percent start with anything else?
*/

WITH s1 AS (SELECT name,
                   CASE WHEN LEFT (lower(name), 1) IN ('a', 'e', 'i', 'o', 'u') THEN 1 ELSE 0 
                    END AS vowel,
                    CASE WHEN LEFT (lower(name), 1) NOT IN ('a', 'e', 'i', 'o', 'u') THEN 1 ELSE 0 
                    END AS not_vowel
            FROM accounts)

SELECT SUM(vowel) vowel, SUM(not_vowel) not_vowel
FROM s1;

/*markdown
5. Use the accounts table to create first and last name columns that hold the first and last names for the primary_poc.
*/






SELECT name, 
       LEFT (primary_poc, POSITION (' ' IN primary_poc) - 1) first_name,            /* the '- 1'  is there to remove the seperator character (space between the name) itself*/
       RIGHT (primary_poc, LENGTH (primary_poc) - POSITION (' ' IN primary_poc)) last_name
FROM accounts;

/*markdown
6. Now see if you can do the same thing for every rep name in the sales_reps table. Again provide first and last name columns.


*/

SELECT name,
       LEFT (name, STRPOS (name, ' ')),         /* the '- 1'  wasn"t put there this time though to remove the seperator character (space between the name) itself*/
       RIGHT (name, LENGTH (name) - STRPOS (name, ' '))
FROM sales_reps;

/*markdown
7. Each company in the accounts table wants to create an email address for each primary_poc. The email address should be the first name of the primary_poc . last name primary_poc @ company name .com.
*/

WITH s1 AS (SELECT name account,
             LEFT (primary_poc, POSITION (' ' IN primary_poc) - 1) first_name,
             RIGHT (primary_poc, LENGTH (primary_poc) - POSITION (' ' IN primary_poc)) last_name
      		FROM accounts)

SELECT account,
		CONCAT (first_name, '.', last_name, '@', account, '.com') email
FROM s1; 





/*markdown
8. You may have noticed that in the previous solution some of the company names include spaces, which will certainly not work in an email address. See if you can create an email address that will work by removing all of the spaces in the account name, but otherwise your solution should be just as in question 1.
*/

WITH s1 AS (SELECT name account,
             LOWER (LEFT (primary_poc, POSITION (' ' IN primary_poc) - 1)) first_name,
             LOWER (RIGHT (primary_poc, LENGTH (primary_poc) - POSITION (' ' IN primary_poc))) last_name
      		FROM accounts)

SELECT account,
		CONCAT (first_name, '.', last_name, '@', REPLACE (account, ' ', ''), '.com') email
FROM s1; 





/*markdown
9. We would also like to create an initial password, which they will change after their first log in. The first password will be the first letter of the primary_poc's first name (lowercase), then the last letter of their first name (lowercase), the first letter of their last name (lowercase), the last letter of their last name (lowercase), the number of letters in their first name, the number of letters in their last name, and then the name of the company they are working with, all capitalized with no spaces.
*/

WITH s1 AS (SELECT name account,
                   primary_poc,
                   LEFT (primary_poc, POSITION (' ' IN primary_poc) - 1) first_name,
                   RIGHT (primary_poc, LENGTH (primary_poc) - POSITION (' ' IN primary_poc)) last_name,

                   LOWER (LEFT (primary_poc, 1)) first_character,
                   LOWER (RIGHT ((LEFT (primary_poc, POSITION (' ' IN primary_poc) - 1)), 1)) second_character,
                   LOWER (LEFT (((RIGHT (primary_poc, LENGTH (primary_poc) - POSITION (' ' IN primary_poc)))), 1 )) third_character,
                   LOWER (RIGHT (primary_poc, 1)) fourth_character,
                   
                   LENGTH (LEFT (primary_poc, POSITION (' ' IN primary_poc) - 1)) fifth_character,
                   LENGTH (RIGHT (primary_poc, LENGTH (primary_poc) - POSITION (' ' IN primary_poc))) sixth_character,
                   UPPER (REPLACE (name, ' ', '')) seventh_character
            FROM accounts)

SELECT account, primary_poc,
       LOWER (CONCAT (first_name, '.', last_name, '@', REPLACE (account, ' ', ''), '.com')) email,
       CONCAT (first_character, second_character, third_character, fourth_character, fifth_character, sixth_character, seventh_character) password
       /* could also have used - 
       first_character || second_character || third_character || fourth_character || fifth_character || sixth_character || seventh_character password
       */
FROM s1;

/*markdown
Data Cleaning on SF Crime Data database
*/

/*markdown
CAST function
*/

SELECT * 
FROM sf_crime_data
LIMIT 10;

/*markdown
10. Write a query to change the date to SQL date format and convert to date type
*/

WITH s1 AS (SELECT *, 
					SUBSTR (date, 7, 4) || '-' || 
					SUBSTR (date, 1, 2) || '-' ||
        			SUBSTR (date, 4, 2) formatted_date
			FROM sf_crime_data)

SELECT 	id, incidnt_num, category, descript, time, formatted_date, 
		pd_district, resolution, address, location,
		CAST (formatted_date AS DATE)
        /* could also use 'formatted_date :: DATE' */ 
FROM s1;

/*markdown
COALESCE
*/

SELECT *
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL; 

/*markdown
11. Use COALESCE to fill in the accounts.id column with the account.id for the NULL value for the table from code above.
*/

SELECT COALESCE (o.id, a.id) filled_id, a.name, a.website, a.lat, a.long,
                                        a.primary_poc, a.sales_rep_id, o.*
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL; 



/*markdown
12. Use COALESCE to fill in the orders.accounts_id column with the account.id for the NULL value for the table from code above.
*/

SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, 
        a.primary_poc, a.sales_rep_id, 
        COALESCE(o.account_id, a.id) account_id,
        o.occurred_at, o.standard_qty, o.gloss_qty, o.poster_qty, o.total,
        o.standard_amt_usd, o.gloss_amt_usd, o.poster_amt_usd, o.total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*markdown
13. Use COALESCE to fill in each of the quantity and amount (USD) columns for the table given.
*/

SELECT COALESCE(o.id, a.id) filled_id, 
        a.name, a.website, a.lat, a.long, 
        a.primary_poc, a.sales_rep_id, 
        COALESCE (o.account_id, a.id) account_id, o.occurred_at, 
        COALESCE (o.standard_qty, 0) mod_standard_qty, 
        COALESCE (o.gloss_qty, 0) mod_gloss_qty,
        COALESCE (o.poster_qty, 0) mod_poster_qty, 
        COALESCE (o.total, 0) mod_total, 
        COALESCE (o.standard_amt_usd, 0) mod_standard_amt_usd,
        COALESCE (o.gloss_amt_usd, 0) mod_gloss_amt_usd,
        COALESCE (o.poster_amt_usd, 0) mod_poster_amt_usd,
        COALESCE (o.total_amt_usd, 0) mod_total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
WHERE o.total IS NULL;

/*markdown

*/

SELECT COUNT (o.id)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

SELECT COUNT (*)
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

SELECT COUNT ( COALESCE(o.id, a.id)) filled_id, 
       COUNT ( COALESCE (o.account_id, a.id)) account_id, 
       COUNT ( COALESCE (o.standard_qty, 0)) mod_standard_qty, 
       COUNT ( COALESCE (o.gloss_qty, 0)) mod_gloss_qty,
       COUNT ( COALESCE (o.poster_qty, 0)) mod_poster_qty, 
       COUNT ( COALESCE (o.total, 0)) mod_total, 
       COUNT ( COALESCE (o.standard_amt_usd, 0)) mod_standard_amt_usd,
       COUNT ( COALESCE (o.gloss_amt_usd, 0)) mod_gloss_amt_usd,
       COUNT ( COALESCE (o.poster_amt_usd, 0)) mod_poster_amt_usd,
       COUNT (COALESCE (o.total_amt_usd, 0)) mod_total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id;

SELECT COALESCE(o.id, a.id) filled_id, a.name, a.website, a.lat, a.long, 
        a.primary_poc, a.sales_rep_id, 
        COALESCE(o.account_id, a.id) account_id,
        o.occurred_at, 
        COALESCE(o.standard_qty, 0) standard_qty, 
        COALESCE(o.gloss_qty,0) gloss_qty, 
        COALESCE(o.poster_qty,0) poster_qty,
        COALESCE(o.total,0) total, 
        COALESCE(o.standard_amt_usd,0) standard_amt_usd,
        COALESCE(o.gloss_amt_usd,0) gloss_amt_usd, 
        COALESCE(o.poster_amt_usd,0) poster_amt_usd, 
        COALESCE(o.total_amt_usd,0) total_amt_usd
FROM accounts a
LEFT JOIN orders o
ON a.id = o.account_id
oRDER BY o.id DESC;

/*markdown

*/