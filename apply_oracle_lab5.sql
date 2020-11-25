-- ------------------------------------------------------------------
--  Program Name:   apply_oracle_lab5.sql
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
--   sql> @apply_oracle_lab5.sql
--
-- ------------------------------------------------------------------

-- Call library files.
@/home/student/Data/cit225/oracle/lib1/utility/cleanup_oracle.sql
@/home/student/Data/cit225/oracle/lib1/create/create_oracle_store2.sql
@/home/student/Data/cit225/oracle/lib1/preseed/preseed_oracle_store.sql
@/home/student/Data/cit225/oracle/lib1/seed/seeding.sql

-- Open log file.
SPOOL apply_oracle_lab5.txt

-- ... insert lab 5 commands here ...

------------- 
-- Step 01 --
-------------

SELECT DISTINCT system_user_id
from system_user 
WHERE system_user_name = 'DBA1';

------------- 
-- Step 02 --
------------- 

SELECT system_user_id, system_user_name
from system_user 
WHERE system_user_name = 'DBA1';

------------- 
-- Step 03 --
------------- 

SELECT su1.system_user_id as system_user_id1, su1.system_user_name as system_user_name1, su2.system_user_id as system_user_id2, su2.system_user_name as system_user_name2
FROM  system_user su1 INNER JOIN system_user su2
ON  su1.created_by = su2.system_user_id
WHERE su1.system_user_name = 'DBA1';

------------- 
-- Step 04 --
------------- 
SELECT su1.system_user_id as system_user_id1, su1.system_user_name as system_user_name1, 
       su2.system_user_id as system_user_id2, su2.system_user_name as system_user_name2, 
       su3.system_user_id as system_user_id3, su2.system_user_name as system_user_name3
FROM     system_user su1
,        system_user su2
,        system_user su3
WHERE    su1.created_by = su2.system_user_id      
AND      su1.last_updated_by = su3.system_user_id 
AND su1.system_user_name = 'DBA1';

------------- 
-- Step 05 --
-------------

SELECT su1.system_user_id as system_user_id1, su1.system_user_name as system_user_name1, 
       su2.system_user_id as system_user_id2, su2.system_user_name as system_user_name2, 
       su3.system_user_id as system_user_id3, su2.system_user_name as system_user_name3
FROM     system_user su1
,        system_user su2
,        system_user su3
WHERE    su1.created_by = su2.system_user_id      
AND      su1.last_updated_by = su3.system_user_id;

------------- 
-- Step 06 --
-------------

-- Drop table 
DROP TABLE rating_agency;
-- Create table 
CREATE TABLE rating_agency 
( rating_agency_id              NUMBER        
, rating_agency_abbr            VARCHAR2(4)    CONSTRAINT nn_rating_agency_1  NOT NULL
, rating_agency_name            VARCHAR2(40)   CONSTRAINT nn_rating_agency_2  NOT NULL
, created_by                    NUMBER         CONSTRAINT nn_rating_agency_3  NOT NULL
, creation_date                 DATE           CONSTRAINT nn_rating_agency_4  NOT NULL
, last_updated_by               NUMBER         CONSTRAINT nn_rating_agency_5  NOT NULL
, last_update_date              DATE           CONSTRAINT nn_rating_agency_6  NOT NULL
, CONSTRAINT pk_rating_agency   PRIMARY KEY(rating_agency_id)
, CONSTRAINT uq_rating_agency UNIQUE(rating_agency_abbr)
, CONSTRAINT fk_rating_agency_1 FOREIGN KEY(created_by)      REFERENCES system_user(system_user_id)
, CONSTRAINT fk_rating_agency_2 FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id) );

-- Drop sequences
DROP SEQUENCE rating_agency_s1;

-- Create sequence one_s.
CREATE SEQUENCE rating_agency_s1
START WITH 1000
INCREMENT BY 1;

------------- 
-- Step 07 --
-------------

-- Insert new data into the mode
INSERT INTO rating_agency
(rating_agency_id
, rating_agency_abbr
, rating_agency_name
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES 
( rating_agency_s1.NEXTVAL
, 'ESRB'
, 'Entertainment Software Rating Board'
, (SELECT DISTINCT system_user_id FROM system_user WHERE system_user_name = 'DBA2')
, SYSDATE
, (SELECT system_user_id
   FROM system_user 
   WHERE system_user_name = 'DBA1')
, SYSDATE );

INSERT INTO rating_agency 
(rating_agency_id
, rating_agency_abbr
, rating_agency_name
, created_by
, creation_date
, last_updated_by
, last_update_date)
VALUES 
( rating_agency_s1.NEXTVAL
, 'MPAA'
, 'Motion Picture Association of America'
, (SELECT DISTINCT system_user_id FROM system_user WHERE system_user_name = 'DBA2')
, SYSDATE
, (SELECT system_user_id
   FROM system_user 
   WHERE system_user_name = 'DBA2')
, SYSDATE );

COL rating_agency_id FORMAT 9999 HEADING "Rating|Agency|ID #"
COL rating_agency_abbr FORMAT A6 HEADING "Rating|Agency|Abbr"
COL rating_agency_name FORMAT A40 HEADING "Rating Agency"

SELECT rating_agency_id
, rating_agency_abbr
, rating_agency_name
FROM rating_agency;


---------------------------------------------------------------------
-- Step 08 --
---------------------------------------------------------------------
-- Drop table 
DROP TABLE rating;


CREATE TABLE rating
( rating_id          NUMBER        
, rating_agency_id   NUMBER         CONSTRAINT nn_rating_1  NOT NULL
, rating             VARCHAR2(4)    CONSTRAINT nn_rating_2  NOT NULL
, description        VARCHAR2(420)  CONSTRAINT nn_rating_3  NOT NULL
, created_by         NUMBER         CONSTRAINT nn_rating_4  NOT NULL
, creation_date      DATE           CONSTRAINT nn_rating_5  NOT NULL
, last_updated_by    NUMBER         CONSTRAINT nn_rating_6  NOT NULL
, last_update_date   DATE           CONSTRAINT nn_rating_7  NOT NULL
, CONSTRAINT pk_rating          PRIMARY KEY(rating_id)
, CONSTRAINT uq_rating          UNIQUE(rating)
, CONSTRAINT fk_rating_1        FOREIGN KEY(created_by)      REFERENCES system_user(system_user_id)
, CONSTRAINT fk_rating_2        FOREIGN KEY(last_updated_by) REFERENCES system_user(system_user_id) );

-- Drop sequences
DROP SEQUENCE rating_s1;

CREATE SEQUENCE rating_s1
START WITH 1000
INCREMENT BY 1;

--ESRB RATINGS
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'ESRB'), 'EC', 'Early Childhood', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'ESRB'), 'E', 'Everyone', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'ESRB'), 'E10+', 'Everyone 10+', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'ESRB'), 'T', 'Teen', (SELECT system_user_id FROM system_user
WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM system_user
WHERE system_user_name = 'DBA2'), SYSDATE);
CIT 225: Oracle Lab #5
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'ESRB'), 'M', 'Mature', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'ESRB'), 'AO', 'Adult Only', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'ESRB'), 'RP', 'Rating Pending', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);




--MPAA RATINGS
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'MPAA'), 'G', 'General Audiences', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'MPAA'), 'PG', 'Parental Guidance Suggested', (SELECT
system_user_id FROM system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT
system_user_id FROM system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'MPAA'), 'PG-13', 'Parental Guidance Strongly Suggested',
(SELECT system_user_id FROM system_user WHERE system_user_name = 'DBA2'), SYSDATE,
(SELECT system_user_id FROM system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'MPAA'), 'NC-17', 'No One 17 And Under Admitted', (SELECT
system_user_id FROM system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT
system_user_id FROM system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'MPAA'), 'R', 'Restricted', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);
INSERT INTO rating
(rating_id, rating_agency_id, rating, description, created_by, creation_date,
last_updated_by, last_update_date)
VALUES
(rating_s1.NEXTVAL, (SELECT rating_agency_id FROM rating_agency WHERE
rating_agency_abbr = 'MPAA'), 'NR', 'Not Rated', (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE, (SELECT system_user_id FROM
system_user WHERE system_user_name = 'DBA2'), SYSDATE);


UPDATE item SET item_rating = 'E' where item_rating = 'Everyone';
UPDATE item SET item_rating = 'T' where item_rating = 'Teen';
UPDATE item SET item_rating = 'M' where item_rating = 'Mature';
UPDATE item SET item_rating = 'PG-13' where item_rating = 'PG13';








SPOOL OFF
