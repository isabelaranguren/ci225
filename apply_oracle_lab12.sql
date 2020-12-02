CREATE TABLE calendar 
( calendar_id          NUMBER
, calendar_name		   VARCHAR2(10)	   CONSTRAINT nn_calendar_1 NOT NULL
, calendar_short_name  VARCHAR2(3)     CONSTRAINT nn_calendar_2 NOT NULL
, start_date           DATE            CONSTRAINT nn_calendar_3 NOT NULL
, end_date             DATE            CONSTRAINT nn_calendar_4 NOT NULL
, created_by           NUMBER
, creation_date        DATE 	       CONSTRAINT nn_calendar_5 NOT NULL
, last_updated_by      NUMBER
, last_update_date     DATE            CONSTRAINT nn_calendar_6 NOT NULL
, CONSTRAINT pk_calendar_1	PRIMARY KEY(calendar_id)
, CONSTRAINT fk_calendar_1	FOREIGN KEY(created_by) 	REFERENCES system_user(system_user_id)
, CONSTRAINT fk_calendar_2	FOREIGN KEY(last_updated_by) 	REFERENCES system_user(system_user_id)); 

CREATE SEQUENCE calendar_s1 START WITH 1001;
