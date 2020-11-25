-- ------------------------------------------------------------------
--  Program Name:   apply_oracle_lab2.sql
--  Lab Assignment: 02
--  Program Author: Michael McLaughlin
--  Creation Date:  17-Jan-2018
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  13-Aug-2019    Incorporate diagnostic scripts.
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
--   sql> @apply_oracle_lab2.sql
--
-- ------------------------------------------------------------------

-- Set SQL*Plus environmnet variables.
SET ECHO ON
SET FEEDBACK ON
-- SET NULL '<Null>'
SET NULL ''
SET PAGESIZE 999
SET SERVEROUTPUT ON

-- ------------------------------------------------------------------
--  Cleanup prior installations and run previous lab scripts.
-- ------------------------------------------------------------------

@@/home/student/Data/cit225/oracle/lab1/apply_oracle_lab1.sql

SET NULL ''

-- Open log file.
SPOOL apply_oracle_lab2.txt

-- Enter code below.
-- ------------------------------------------------------------------

-- Step 01
-- ------------------------------------------------------------------
SELECT account_number, credit_card_number 
FROM member;

-- Step 02
-- ------------------------------------------------------------------
SELECT first_name, middle_name, last_name
FROM contact;

-- Step 03
-- ------------------------------------------------------------------
SELECT city, state_province, postal_code
FROM address;

-- Step 04
-- ------------------------------------------------------------------
SELECT check_out_date, return_date
FROM rental;

-- Step 05
-- ------------------------------------------------------------------
SELECT item_title, item_rating, item_release_date 
FROM item

-- Step 06
-- ------------------------------------------------------------------
SELECT item_title, item_rating item_release_date
FROM item
WHERE item_rating LIKE '%PG%'
ORDER BY item_title ASC;

-- Step 07 
-- ------------------------------------------------------------------
SELECT first_name, middle_name, last_name
FROM contact
WHERE last_name LIKE '%Sweeney%' AND middle_name IS NULL;

-- Step 08
-- ------------------------------------------------------------------
SELECT first_name, middle_name, last_name
FROM contact
WHERE lower(last_name) LIKE '%viz%';

-- Step 09
-- ------------------------------------------------------------------
SELECT city, state_province, postal_code
FROM address
WHERE city = 'San Jose' OR city = 'Provo';

-- Step 10
-- ------------------------------------------------------------------
SELECT item_title, item_release_date
FROM item
WHERE item_release_date BETWEEN '01-JAN-2003' AND '31-DEC-2003';

-- ------------------------------------------------------------------
-- Enter lab code above.

-- Close log file.
SPOOL OFF
