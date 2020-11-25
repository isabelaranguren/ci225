-- ------------------------------------------------------------------
--  Program Name:   apply_oracle_lab3.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  17-Jan-2018
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  01-Apr-2020    Porting the code from Linux to Windows.
-- ------------------------------------------------------------------
-- This creates tables, sequences, indexes, and constraints necessary
-- to begin lesson #3. Demonstrates proper process and syntax.
-- ------------------------------------------------------------------
-- Instructions:
-- ------------------------------------------------------------------
-- The two scripts contain spooling commands, which is why there
-- isn't a spooling command in this script. When you run this file
-- you first connect to the Oracle database with this syntax:
--
--   sqlplus student/student@xe
--
-- Then, you call this script with the following syntax:
--
--   sql> @apply_oracle_lab3.sql
--
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------
--  Cleanup prior installations and run previous lab scripts.
-- ------------------------------------------------------------------
@@/home/student/Data/cit225/oracle/lab1/apply_oracle_lab1.sql


-- Open log file.
SPOOL apply_oracle_lab3.txt

-- Enter code below.
-- ------------------------------------------------------------------



------------- 
-- Step 01 --
------------- 

SELECT COUNT(*)
FROM member

------------- 
-- Step 02 --
------------- 
SELECT last_name, count(*) as total_names
FROM contact
GROUP BY  last_name
ORDER BY last_name ASC;

------------- 
-- Step 03 --
------------- 
SELECT item_rating, count(*) as total_names
FROM item
WHERE item_rating in ('G', 'PG', 'NR')
GROUP BY  item_rating;

------------- 
-- Step 04 --
------------- 
SELECT a.last_name, account_number, b.credit_card_number, count(*) as total_names
FROM contact a, member b
WHERE a.member_id = b.member_id
GROUP BY  last_name, account_number, credit_card_number
having count(*) > 1
order by total_names desc;

------------- 
-- Step 05 --
-------------

SELECT DISTINCT a.last_name, city, b.state_province 
FROM contact a, address b
WHERE a.contact_id = b.contact_id
ORDER BY last_name asc;


------------- 
-- Step 06 --
------------- 

SELECT a.last_name ||' (' ||b.area_code||')' || b.telephone_number 
FROM contact a, 
TELEPHONE b
WHERE a.contact_id = b.contact_id
ORDER BY last_name asc;

------------- 
-- Step 07 --
------------- 

SELECT common_lookup_id, common_lookup_context, common_lookup_type, common_lookup_meaning
FROM common_lookup 
WHERE common_lookup_type in ('BLU-RAY', 'DVD_FULL_SCREEN', 'DVD_WIDE_SCREEN')
ORDER BY common_lookup_type  asc;


------------- 
-- Step 08 --
------------- 

SELECT DISTINCT item_title, item_rating
FROM item a, rental_item b
WHERE item_type in (SELECT common_lookup_id FROM common_lookup WHERE common_lookup_type in ('BLU-RAY', 'DVD_FULL_SCREEN', 'DVD_WIDE_SCREEN'))
order BY item_title asc;


------------- 
-- Step 09 --
------------- 

SELECT a.common_lookup_id, a.common_lookup_context, a.common_lookup_type, a.common_lookup_meaning,  count(b.credit_card_type) AS credit_cards
  FROM common_lookup a
  INNER JOIN member b
  ON a.common_lookup_id = b.credit_card_type 
  WHERE a.common_lookup_type = 'VISA_CARD'
  GROUP BY  a.common_lookup_id, a.common_lookup_context, a.common_lookup_type, a.common_lookup_meaning;

------------- 
-- Step 10 --
------------- 


SELECT a.common_lookup_id, a.common_lookup_context, a.common_lookup_type, a.common_lookup_meaning, count(b.credit_card_type) AS credit_cards
  FROM common_lookup a
  LEFT OUTER JOIN member b
  ON a.common_lookup_id = b.credit_card_type 
  WHERE a.common_lookup_type = 'MASTER_CARD'
  HAVING count(b.credit_card_type) = 0 
  GROUP BY  a.common_lookup_id, a.common_lookup_context, a.common_lookup_type, a.common_lookup_meaning;



-- ------------------------------------------------------------------
-- Enter lab code above.

-- Close log file.
SPOOL OFF
