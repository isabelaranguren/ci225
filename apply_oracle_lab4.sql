-- ------------------------------------------------------------------
--  Program Name:   apply_oracle_lab4.sql
--  Lab Assignment: N/A
--  Program Author: Michael McLaughlin
--  Creation Date:  17-Jan-2018
-- ------------------------------------------------------------------
--  Change Log:
-- ------------------------------------------------------------------
--  Change Date    Change Reason
-- -------------  ---------------------------------------------------
--  
-- ------------------------------------------------------------------
-- This creates tables, sequences, indexes, and constraints necessary
-- to begin lesson #4. Demonstrates proper process and syntax.
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
--   sql> @apply_oracle_lab4.sql
--
-- ------------------------------------------------------------------

-- Run the prior lab script.
@@/home/student/Data/cit225/oracle/lab3/apply_oracle_lab3.sql
 
-- ... insert calls to other code script files here ...
 
SPOOL apply_oracle_lab4.txt



------------- 
-- Step 01 --
------------- 

SELECT DISTINCT m.member_id 
FROM member m
INNER JOIN contact c
ON c.member_id = m.member_id
WHERE c.last_name = 'Sweeney';


------------- 
-- Step 02 --
------------- 

SELECT last_name, account_number, credit_card_number
FROM member m
INNER JOIN contact c
ON c.member_id = m.member_id
WHERE c.last_name = 'Sweeney';


------------- 
-- Step 03 --
------------- 

SELECT DISTINCT last_name, account_number, credit_card_number
FROM member m
INNER JOIN contact c
ON c.member_id = m.member_id
WHERE c.last_name = 'Sweeney';

------------- 
-- Step 04 --
-------------

SELECT DISTINCT c.last_name, m.account_number, m.credit_card_number, a.city ||', ' ||a.state_province|| ', '||a.postal_code as "Address"
FROM member m 
INNER JOIN contact c
ON c.member_id = m.member_id
INNER JOIN address a 
ON a.contact_id = c.contact_id 
WHERE c.last_name = 'Vizquel';


------------- 
-- Step 05 --
-------------


SELECT DISTINCT c.last_name, m.account_number, m.credit_card_number, s.street_address||', ' ||a.city ||', ' ||a.state_province|| ', '||a.postal_code as address
FROM member m 
INNER JOIN contact c
ON c.member_id = m.member_id
INNER JOIN address a 
ON a.contact_id = c.contact_id 
INNER JOIN street_address s
ON a.address_id = s.address_id 
WHERE c.last_name = 'Vizquel';


------------- 
-- Step 06 --
-------------

SELECT DISTINCT c.last_name, m.account_number, m.credit_card_number, 
s.street_address||CHR(10)||a.city ||', ' ||a.state_province|| ', '||a.postal_code as address, 
CONCAT('(', t.area_code||')' || t.telephone_number) as "Telephone"
  FROM member m 
  INNER JOIN contact c
  ON c.member_id = m.member_id
  INNER JOIN address a 
  ON a.contact_id = c.contact_id 
  INNER JOIN street_address s
  ON a.address_id = s.address_id 
  INNER JOIN telephone t 
  ON t.address_id = a.address_id 
  WHERE c.last_name = 'Vizquel';



------------- 
-- Step 07 --
-------------


SELECT DISTINCT c.last_name, m.account_number, m.credit_card_number, 
s.street_address||CHR(10)||a.city ||', ' ||a.state_province|| ', '||a.postal_code as address, 
CONCAT('(', t.area_code||')' || t.telephone_number) as telephone
  FROM member m 
  INNER JOIN contact c
  ON c.member_id = m.member_id
  INNER JOIN address a 
  ON a.contact_id = c.contact_id 
  INNER JOIN street_address s
  ON a.address_id = s.address_id 
  INNER JOIN telephone t 
  ON t.address_id = a.address_id 


------------- 
-- Step 08 --
-------------


SELECT DISTINCT c.last_name, m.account_number, m.credit_card_number, 
s.street_address||CHR(10)||a.city ||', ' ||a.state_province|| ', '||a.postal_code as address, 
CONCAT('(', t.area_code||')' || t.telephone_number) as telephone
  FROM member m 
  INNER JOIN contact c
  ON c.member_id = m.member_id
  INNER JOIN address a 
  ON a.contact_id = c.contact_id 
  INNER JOIN street_address s
  ON a.address_id = s.address_id 
  INNER JOIN telephone t 
  ON t.address_id = a.address_id 
  right outer join rental r
  ON c.contact_id = r.customer_id
  ORDER BY c.last_name asc;


------------- 
-- Step 09 --
-------------

SELECT DISTINCT c.last_name, m.account_number, m.credit_card_number, 
s.street_address||CHR(10)||a.city ||', ' ||a.state_province|| ', '||a.postal_code as address, 
CONCAT('(', t.area_code||')' || t.telephone_number) as telephone, count(r.customer_id)
  FROM member m 
  INNER JOIN contact c
  ON c.member_id = m.member_id
  INNER JOIN address a 
  ON a.contact_id = c.contact_id 
  INNER JOIN street_address s
  ON a.contact_id = s.street_address_id 
  INNER JOIN telephone t 
  ON c.contact_id = t.address_id 
  LEFT OUTER JOIN rental r
  ON c.contact_id = r.rental_id
  GROUP BY  c.last_name, m.account_number, m.credit_card_number, 
s.street_address||CHR(10)||a.city ||', ' ||a.state_province|| ', '||a.postal_code, 
CONCAT('(', t.area_code||')' || t.telephone_number)
  HAVING count(r.customer_id) = 0 
  ORDER BY c.last_name asc;

------------- 
-- Step 10 --
-------------

SELECT DISTINCT c.last_name || ', ' || c.first_name as full_name,  m.account_number, CONCAT('(', t.area_code||')' 
|| t.telephone_number||CHR(10) || s.street_address||', ' ||a.city ||' '||a.state_province|| ' '||a.postal_code) AS address, i.item_title as item_title
  FROM member m 
  INNER JOIN contact c
  ON c.member_id = m.member_id
  INNER JOIN address a 
  ON a.contact_id = c.contact_id 
  INNER JOIN street_address s
  ON a.contact_id = s.street_address_id 
  INNER JOIN telephone t 
  ON c.contact_id = t.address_id
  right outer join rental r
  ON c.contact_id = r.customer_id
  INNER JOIN rental_item ri 
  ON c.contact_id = ri.rental_id
  INNER JOIN item i 
  ON c.contact_id = i.item_id
  WHERE i.item_title like 'St_r%';


SPOOL OFF
