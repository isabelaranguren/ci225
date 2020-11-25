-- ------------------------------------------------------------------
--  Program Name:   apply_oracle_lab7.sql
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
-- to begin lesson #5. Demonstrates proper process and syntax.
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
--   sql> @apply_oracle_lab7.sql
--
-- ------------------------------------------------------------------

-- ------------------------------------------------------------------
--  Cleanup prior installations and run previous lab scripts.
-- ------------------------------------------------------------------
@/home/student/Data/cit225/oracle/lab6/apply_oracle_lab6.sql

-- Open log file.
SPOOL apply_oracle_lab7.txt

-- Enter code below.
-- ------------------------------------------------------------------

-- --------------------------------------------------------
--  Step #1
--  -------
--  Insert two ACTIVE_FLAG records in the COMMON_LOOKUP table.
-- --------------------------------------------------------
-- Insert step #1 statements here.

INSERT INTO common_lookup
( common_lookup_id
, common_lookup_table
, common_lookup_column
, COMMON_LOOKUP_CODE
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
(common_lookup_s1.nextval
, 'PRICE'
, 'ACTIVE_FLAG'
, NULL
, 'YES'
, 'Y'
, 1
, sysdate
, 1
, sysdate);

INSERT INTO common_lookup
( common_lookup_id
, common_lookup_table
, common_lookup_column
, COMMON_LOOKUP_CODE
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
(common_lookup_s1.nextval
, 'PRICE'
, 'ACTIVE_FLAG'
, NULL
, 'NO'
, 'N'
, 1
, sysdate
, 1
, sysdate);

COLUMN common_lookup_table  FORMAT A20 HEADING "COMMON_LOOKUP_TABLE"
COLUMN common_lookup_column FORMAT A20 HEADING "COMMON_LOOKUP_COLUMN"
COLUMN common_lookup_type   FORMAT A20 HEADING "COMMON_LOOKUP_TYPE"
SELECT   common_lookup_table
,        common_lookup_column
,        common_lookup_type
FROM     common_lookup
WHERE    common_lookup_table = 'PRICE'
AND      common_lookup_column = 'ACTIVE_FLAG'
ORDER BY 1, 2, 3 DESC;

-- --------------------------------------------------------
--  Step #2
--  -------
--  Insert three PRICE_TYPE and three RENTAL_ITEM_TYPE
--  records in the COMMON_LOOKUP table.
-- --------------------------------------------------------

-- Insert step #2 statements here.

-- Start Price Table
INSERT INTO common_lookup
( common_lookup_id
, common_lookup_table
, common_lookup_column
, COMMON_LOOKUP_CODE
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
(
common_lookup_s1.nextval
, 'PRICE'
, 'PRICE_TYPE'
, 1
, '1-DAY RENTAL'
, '1-Day Rental'
, 1
, sysdate
, 1
, sysdate);

INSERT INTO common_lookup
( common_lookup_id
, common_lookup_table
, common_lookup_column
, COMMON_LOOKUP_CODE
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
(
common_lookup_s1.nextval
, 'RENTAL_ITEM'
, 'RENTAL_ITEM_TYPE'
, 1
, '1-DAY RENTAL'
, '1-Day Rental'
, 1
, sysdate
, 1
, sysdate);
INSERT INTO common_lookup
( common_lookup_id
, common_lookup_table
, common_lookup_column
, COMMON_LOOKUP_CODE
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
(
common_lookup_s1.nextval
, 'PRICE'
, 'PRICE_TYPE'
, 3
, '3-DAY RENTAL'
, '3-Day Rental'
, 1
, sysdate
, 1
, sysdate);

INSERT INTO common_lookup
( common_lookup_id
, common_lookup_table
, common_lookup_column
, COMMON_LOOKUP_CODE
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
(
common_lookup_s1.nextval
, 'PRICE'
, 'PRICE_TYPE'
,  5
, '5-DAY RENTAL'
, '5-Day Rental'
, 1
, sysdate
, 1
, sysdate);

INSERT INTO common_lookup
( common_lookup_id
, common_lookup_table
, common_lookup_column
, COMMON_LOOKUP_CODE
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
(
common_lookup_s1.nextval
, 'RENTAL_ITEM'
, 'RENTAL_ITEM_TYPE'
, 3
, '3-DAY RENTAL'
, '3-Day Rental'
, 1
, sysdate
, 1
, sysdate);

INSERT INTO common_lookup
( common_lookup_id
, common_lookup_table
, common_lookup_column
, COMMON_LOOKUP_CODE
, common_lookup_type
, common_lookup_meaning
, created_by
, creation_date
, last_updated_by
, last_update_date )
VALUES
(
common_lookup_s1.nextval
, 'RENTAL_ITEM'
, 'RENTAL_ITEM_TYPE'
,  5
, '5-DAY RENTAL'
, '5-Day Rental'
, 1
, sysdate
, 1
, sysdate);
-- End Rental_item table

COLUMN common_lookup_table  FORMAT A20 HEADING "COMMON_LOOKUP_TABLE"
COLUMN common_lookup_column FORMAT A20 HEADING "COMMON_LOOKUP_COLUMN"
COLUMN common_lookup_type   FORMAT A20 HEADING "COMMON_LOOKUP_TYPE"
SELECT   common_lookup_table
,        common_lookup_column
,        common_lookup_type
FROM     common_lookup
WHERE    common_lookup_table IN ('PRICE','RENTAL_ITEM')
AND      common_lookup_column IN ('PRICE_TYPE','RENTAL_ITEM_TYPE')
ORDER BY 1, 3;

-- --------------------------------------------------------
--  Step #3
--  -------
--  Update the RENTAL_ITEM_TYPE column values and add a
--  foreign key constraint on the RENTAL_ITEM_TYPE column.
-- --------------------------------------------------------
-- Insert step #3 statements here.

COLUMN table_name   FORMAT A14
COLUMN column_id    FORMAT 9999
COLUMN column_name  FORMAT A22
COLUMN data_type    FORMAT A12
SELECT   table_name
,        column_id
,        column_name
,        CASE
           WHEN nullable = 'N' THEN 'NOT NULL'
           ELSE ''
         END AS nullable
,        CASE
           WHEN data_type IN ('CHAR','VARCHAR2','NUMBER') THEN
             data_type||'('||data_length||')'
           ELSE
             data_type
         END AS data_type
FROM     user_tab_columns
WHERE    table_name = 'RENTAL_ITEM'
ORDER BY 2;

UPDATE   rental_item ri
SET      rental_item_type =
           (SELECT   cl.common_lookup_id
            FROM     common_lookup cl
            WHERE    cl.common_lookup_code =
              (SELECT   r.return_date - r.check_out_date
               FROM     rental r
               WHERE    r.rental_id = ri.rental_id)
            AND      cl.common_lookup_table = 'RENTAL_ITEM'
            AND      cl.common_lookup_column = 'RENTAL_ITEM_TYPE');
            
SELECT   ROW_COUNT
,        col_count
FROM    (SELECT   COUNT(*) AS ROW_COUNT
         FROM     rental_item) rc CROSS JOIN
        (SELECT   COUNT(rental_item_type) AS col_count
         FROM     rental_item
         WHERE    rental_item_type IS NOT NULL) cc;
         
COL ROWNUM              FORMAT 999999  HEADING "Row|Number"
COL rental_item_type    FORMAT 999999  HEADING "Rental|Item|Type"
COL common_lookup_id    FORMAT 999999  HEADING "Common|Lookup|ID #"
COL common_lookup_code  FORMAT A6      HEADING "Common|Lookup|Code"
COL return_date         FORMAT A11     HEADING "Return|Date"
COL check_out_date      FORMAT A11     HEADING "Check Out|Date"
COL r_rental_id         FORMAT 999999  HEADING "Rental|ID #"
COL ri_rental_id        FORMAT 999999  HEADING "Rental|Item|Rental|ID #"
SELECT   ROWNUM
,        ri.rental_item_type
,        cl.common_lookup_id
,        cl.common_lookup_code
,        r.return_date
,        r.check_out_date
,        CAST((r.return_date - r.check_out_date) AS CHAR) AS lookup_code
,        r.rental_id AS r_rental_id
,        ri.rental_id AS ri_rental_id
FROM     rental r FULL JOIN rental_item ri
ON       r.rental_id = ri.rental_id FULL JOIN common_lookup cl
ON       cl.common_lookup_code =
           CAST((r.return_date - r.check_out_date) AS CHAR)
WHERE    cl.common_lookup_table = 'RENTAL_ITEM'
AND      cl.common_lookup_column = 'RENTAL_ITEM_TYPE'
AND      cl.common_lookup_type LIKE '%-DAY RENTAL'
ORDER BY r.rental_id
,        ri.rental_id;
-- End Part 3a

-- Add the FK_RENTAL_ITEM_7 foreign key to the RENTAL_ITEM table.

ALTER TABLE rental_item
ADD CONSTRAINT fk_rental_item_7 
FOREIGN KEY(rental_item_type) REFERENCES common_lookup(common_lookup_id);

UPDATE   rental_item ri
SET      rental_item_price =
           (SELECT   cl.common_lookup_id
            FROM     common_lookup cl
            WHERE    cl.common_lookup_code =
              (SELECT   r.return_date - r.check_out_date
               FROM     rental r
               WHERE    r.rental_id = ri.rental_id)
            AND      cl.common_lookup_table = 'PRICE'
            AND      cl.common_lookup_column = 'PRICE_TYPE');


ALTER TABLE rental_item
MODIFY rental_item_type NUMBER CONSTRAINT nn_ritem_9 NOT NULL;

COLUMN CONSTRAINT FORMAT A10
SELECT   TABLE_NAME
,        column_name
,        CASE
           WHEN NULLABLE = 'N' THEN 'NOT NULL'
           ELSE 'NULLABLE'
         END AS CONSTRAINT
FROM     user_tab_columns
WHERE    TABLE_NAME = 'RENTAL_ITEM'
AND      column_name = 'RENTAL_ITEM_TYPE';

-- --------------------------------------------------------
--  Step #4
--  -------
--  Create a query to fabricate pricing data that you
--  will insert into a PRICE table in lab 8.
-- --------------------------------------------------------

COLUMN item_id     FORMAT 9999 HEADING "ITEM|ID"
COLUMN active_flag FORMAT A6   HEADING "ACTIVE|FLAG"
COLUMN price_type  FORMAT 9999 HEADING "PRICE|TYPE"
COLUMN price_desc  FORMAT A12  HEADING "PRICE DESC"
COLUMN start_date  FORMAT A10  HEADING "START|DATE"
COLUMN end_date    FORMAT A10  HEADING "END|DATE"
COLUMN amount      FORMAT 9999 HEADING "AMOUNT"

SELECT  i.item_id AS item_id
,       active_flag AS active_flag
,       cl.common_lookup_id AS price_type
,       cl.common_lookup_type AS price_desc
,       CASE
           WHEN (TRUNC(SYSDATE) - i.release_date) <= 30 OR
		     (TRUNC(SYSDATE) - i.release_date) > 30 AND
		      af.active_flag = 'N' THEN
               TO_CHAR(TRUNC(i.release_date), 'DD-MON-YY')
           ELSE
               TO_CHAR(TRUNC(i.release_date) + 31, 'DD-MON-YY')
        END AS start_date
 ,      CASE
           WHEN (TRUNC(SYSDATE) - i.release_date) > 30 AND active_flag = 'N' THEN
               TO_CHAR(TRUNC(i.release_date) + 30, 'DD-MON-YY')
           ELSE
               NULL
        END AS end_date
,       CASE
           WHEN (TRUNC(SYSDATE) - 30) > TRUNC(i.release_date) AND active_flag = 'Y' THEN
                CASE
                   WHEN cl.common_lookup_type = '1-DAY RENTAL' THEN 1
                   WHEN cl.common_lookup_type = '3-DAY RENTAL' THEN 3
                   WHEN cl.common_lookup_type = '5-DAY RENTAL' THEN 5
                END
           ELSE
                CASE
                  WHEN cl.common_lookup_type = '1-DAY RENTAL' THEN 3
                  WHEN cl.common_lookup_type = '3-DAY RENTAL' THEN 10
                  WHEN cl.common_lookup_type = '5-DAY RENTAL' THEN 15
                END
        END AS amount
FROM    item i CROSS JOIN
        (SELECT 'Y' AS active_flag FROM dual
           UNION ALL
         SELECT 'N' AS active_flag FROM dual) af CROSS JOIN
        (SELECT '1' AS rental_days FROM dual
           UNION ALL
        SELECT '3' AS rental_days FROM dual
           UNION ALL
        SELECT '5' AS rental_days FROM dual) dr INNER JOIN
        common_lookup cl ON dr.rental_days = SUBSTR(cl.common_lookup_type,1,1)
WHERE   cl.common_lookup_table = 'PRICE'
AND     cl.common_lookup_column = 'PRICE_TYPE'
AND NOT (active_flag = 'N' AND (TRUNC(SYSDATE) - 30) <= TRUNC(i.release_date))
ORDER BY 1, 2, 3;

-- ------------------------------------------------------------------
-- Enter lab code above.

-- Close log file.
SPOOL OFF