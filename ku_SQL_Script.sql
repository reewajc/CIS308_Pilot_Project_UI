

CREATE table PRODUCT_REGISTRATION (
	FIRST_NAME		VARCHAR2(30) NOT NULL,
	LAST_NAME       VARCHAR2(30) NOT NULL,
	EMAIL 			VARCHAR2(60) NOT NULL,
	PRODUCT_NAME 	VARCHAR2(20) NOT NULL,
	PRODUCT_MODEL 	VARCHAR2(8)  NOT NULL,
	SERIAL_NUMBER   VARCHAR2(10) NOT NULL,
	PURCHASED_DATE 	DATE,
	STOLEN 			VARCHAR2(1) NOT NULL,
	constraint PRODUCT_REGISTRATION_PK primary key(SERIAL_NUMBER)
);
	
CREATE table USERS (
    ID         NUMBER(9) NOT NULL,
    EMAIL      VARCHAR2(500) NOT NULL,
    USERNAME   VARCHAR2(50) NOT NULL,
    PASSWORD   VARCHAR2(50) NOT NULL,
    constraint  USERS_PK primary key (ID)
);

CREATE sequence "USERS_SEQ";

CREATE trigger "BI_USERS"  
  before insert on "USERS"              
  for each row 
begin  
  if :NEW."ID" is null then
    select "USERS_SEQ".nextval into :NEW."ID" from dual;
  end if;
end;

INSERT INTO USERS VALUES ('','tstreeter@kuElectronic.com','tstreeter','password123');
INSERT INTO USERS VALUES ('','dmoore@kuElectronic.com','dmoore','123password');
INSERT INTO USERS VALUES ('','rchapagai@kuElectronic.com','rchapagia','123password321');
INSERT INTO USERS VALUES ('','dosier@kuElectronic.com','dosier','mypassword123');
INSERT INTO USERS VALUES ('','ssampson@kuElectronic.com','ssampson','pass123word');

SELECT * FROM USERS;

INSERT INTO PRODUCT_REGISTRATION VALUES('tstreeter@kuElectronic.com','Troy','Streeter','SpeedMinder','SM500','1234B6789C','01-10-2020','N');
INSERT INTO PRODUCT_REGISTRATION VALUES('dmoore@kuElectronic.com','David','Moore','SpeedMinder','SM5001','2345G7890I','12-08-2020','N');
INSERT INTO PRODUCT_REGISTRATION VALUES('rchapagai@kuElectronic.com','Ram','Chapagai','SpeedMinder','SM500','3456J8765L','08-14-2020','N');
INSERT INTO PRODUCT_REGISTRATION VALUES('dosier@kuElectronic.com','Darin','Osier','SpeedMinder','SM5002','5678U7654Y','09-16-2020','N');
INSERT INTO PRODUCT_REGISTRATION VALUES('ssampson@kuElectronic.com','Sue','Sampson','SpeedMinder','SM500','3456T6543R','10-04-2020','N');

SELECT * FROM PRODUCT_REGISTRATION;
