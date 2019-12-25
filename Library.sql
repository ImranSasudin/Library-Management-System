--------------------------------------------------------
--  File created - Wednesday-December-25-2019   
--------------------------------------------------------
DROP SEQUENCE "LIBRARY"."BOOK_SEQ";
DROP SEQUENCE "LIBRARY"."BORROW_SEQ";
DROP SEQUENCE "LIBRARY"."BORROW_SEQ1";
DROP SEQUENCE "LIBRARY"."LIBRARIAN_SEQ";
DROP SEQUENCE "LIBRARY"."LIBRARIAN_SEQ1";
DROP SEQUENCE "LIBRARY"."PATRON_SEQ";
DROP SEQUENCE "LIBRARY"."STUDENT_SEQ";
DROP TABLE "LIBRARY"."BOOK" cascade constraints;
DROP TABLE "LIBRARY"."BORROW" cascade constraints;
DROP TABLE "LIBRARY"."BORROW_BOOK" cascade constraints;
DROP TABLE "LIBRARY"."LIBRARIAN" cascade constraints;
DROP TABLE "LIBRARY"."PATRON" cascade constraints;
DROP TABLE "LIBRARY"."STUDENT" cascade constraints;
DROP TABLE "LIBRARY"."TEACHER" cascade constraints;
--------------------------------------------------------
--  DDL for Sequence BOOK_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "LIBRARY"."BOOK_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence BORROW_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "LIBRARY"."BORROW_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence BORROW_SEQ1
--------------------------------------------------------

   CREATE SEQUENCE  "LIBRARY"."BORROW_SEQ1"  MINVALUE 1 MAXVALUE 99999999 INCREMENT BY 1 START WITH 121 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence LIBRARIAN_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "LIBRARY"."LIBRARIAN_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 141 CACHE 20 ORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence LIBRARIAN_SEQ1
--------------------------------------------------------

   CREATE SEQUENCE  "LIBRARY"."LIBRARIAN_SEQ1"  MINVALUE 1 MAXVALUE 999999999 INCREMENT BY 1 START WITH 61 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence PATRON_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "LIBRARY"."PATRON_SEQ"  MINVALUE 1 MAXVALUE 999999 INCREMENT BY 1 START WITH 2 NOCACHE  NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Sequence STUDENT_SEQ
--------------------------------------------------------

   CREATE SEQUENCE  "LIBRARY"."STUDENT_SEQ"  MINVALUE 1 MAXVALUE 9999999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Table BOOK
--------------------------------------------------------

  CREATE TABLE "LIBRARY"."BOOK" 
   (	"BOOK_ISBN" VARCHAR2(50 BYTE), 
	"BOOK_PRICE" VARCHAR2(20 BYTE), 
	"BOOK_NAME" VARCHAR2(20 BYTE), 
	"BOOK_PUBLISHER" VARCHAR2(20 BYTE), 
	"BOOK_LOCATION" VARCHAR2(20 BYTE), 
	"BOOK_QUANTITY" NUMBER, 
	"BOOK_CURRENTQUANTITY" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table BORROW
--------------------------------------------------------

  CREATE TABLE "LIBRARY"."BORROW" 
   (	"BORROW_ID" NUMBER, 
	"PATRON_ID" VARCHAR2(50 BYTE), 
	"LIBRARIAN_ID" NUMBER, 
	"BORROW_DATE" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table BORROW_BOOK
--------------------------------------------------------

  CREATE TABLE "LIBRARY"."BORROW_BOOK" 
   (	"BORROW_ID" NUMBER, 
	"BOOK_ISBN" VARCHAR2(50 BYTE), 
	"RETURN_DATE" DATE, 
	"STATUS" VARCHAR2(50 BYTE), 
	"EXPECTED_RETURN_DATE" DATE, 
	"PAID_FINE" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table LIBRARIAN
--------------------------------------------------------

  CREATE TABLE "LIBRARY"."LIBRARIAN" 
   (	"LIBRARIAN_ID" NUMBER, 
	"LIBRARIAN_NAME" VARCHAR2(100 BYTE), 
	"LIBRARIAN_PASSWORD" VARCHAR2(500 BYTE), 
	"LIBRARIAN_MANAGERID" NUMBER, 
	"LIBRARIAN_ROLE" VARCHAR2(50 BYTE), 
	"MAX_BORROW" NUMBER
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table PATRON
--------------------------------------------------------

  CREATE TABLE "LIBRARY"."PATRON" 
   (	"PATRON_ID" VARCHAR2(50 BYTE), 
	"PATRON_NAME" VARCHAR2(250 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table STUDENT
--------------------------------------------------------

  CREATE TABLE "LIBRARY"."STUDENT" 
   (	"PATRON_ID" VARCHAR2(50 BYTE), 
	"REGISTER_DATE" DATE, 
	"STATUS" VARCHAR2(50 BYTE), 
	"FORM" NUMBER, 
	"LAST_MODIFIED" DATE
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Table TEACHER
--------------------------------------------------------

  CREATE TABLE "LIBRARY"."TEACHER" 
   (	"PATRON_ID" VARCHAR2(50 BYTE), 
	"TEACHER_SPECIALIZATION" VARCHAR2(50 BYTE), 
	"TABLE_NUMBER" VARCHAR2(50 BYTE)
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
REM INSERTING into LIBRARY.BOOK
SET DEFINE OFF;
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111112','30.00','B.Inggeris','Sasbadi','101',5,2);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111110101','25.00','Bahasa Arab','Sasbadi','500',10,11);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111114','21.00','Fizik','Sasbadi','103',5,4);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111115','10.00','Sejarah','Sasbadi','104',7,4);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111116','50.00','Tamadun Dunia','Sasbadi','105',5,4);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111117','25.00','Once Upon A Time','Sasbadi','106',5,4);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111111','22.2','B.Melayu','Sasbadi','100',5,3);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111118','30.00','Negaraku','Sasbadi','107',5,2);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111119','70.00','DATA COMMUNICATION','Sasbadi','108',5,3);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111110','20.00','Malayan Union','Sasbadi','111',5,3);
Insert into LIBRARY.BOOK (BOOK_ISBN,BOOK_PRICE,BOOK_NAME,BOOK_PUBLISHER,BOOK_LOCATION,BOOK_QUANTITY,BOOK_CURRENTQUANTITY) values ('1111111321321','10.20','SHUD','Sasbadi','400',5,5);
REM INSERTING into LIBRARY.BORROW
SET DEFINE OFF;
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (82,'980519065633',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (83,'980519065633',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (84,'960612013333',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (85,'960612013333',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (86,'801112012235',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (87,'801112013342',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (88,'001122010124',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (81,'970612015578',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (89,'801112012233',3,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.BORROW (BORROW_ID,PATRON_ID,LIBRARIAN_ID,BORROW_DATE) values (103,'980519065631',3,to_date('12/12/2019','DD/MM/RRRR'));
REM INSERTING into LIBRARY.BORROW_BOOK
SET DEFINE OFF;
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (82,'1111111112',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (82,'1111111118',null,'Borrowed',to_date('20/11/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (83,'1111111115',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (84,'1111111117',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (84,'1111111115',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (84,'1111111116',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (85,'1111111110',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (81,'1111111112',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (85,'1111111119',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (85,'1111111114',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (86,'1111111118',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (87,'1111111111',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (87,'1111111110',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (87,'1111111119',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (88,'1111111112',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (88,'1111111111',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (88,'1111111118',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (89,'1111111115',null,'Borrowed',to_date('12/12/2019','DD/MM/RRRR'),null);
Insert into LIBRARY.BORROW_BOOK (BORROW_ID,BOOK_ISBN,RETURN_DATE,STATUS,EXPECTED_RETURN_DATE,PAID_FINE) values (103,'1111110101',to_date('12/12/2019','DD/MM/RRRR'),'Returned',to_date('26/12/2019','DD/MM/RRRR'),0);
REM INSERTING into LIBRARY.LIBRARIAN
SET DEFINE OFF;
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (22,'farah','81dc9bdb52d04dc20036dbd8313ed055',11,'Head Librarian',4);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (3,'MUHAMMAD IMRAN','202cb962ac59075b964b07152d234b70',null,'Head Librarian',4);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (4,'MUHAMMAD FAIZ','202cb962ac59075b964b07152d234b70',3,'Librarian',null);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (11,'NURUL','202cb962ac59075b964b07152d234b70',3,'Head Librarian',4);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (42,'Mohd Suhaimi','202cb962ac59075b964b07152d234b70',3,'Head Librarian',null);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (43,'Ku Nur Amalina','202cb962ac59075b964b07152d234b70',48,'Head Librarian',4);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (8,'SARIP DOL','202cb962ac59075b964b07152d234b70',11,'Librarian',null);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (44,'Amirah Hanim','202cb962ac59075b964b07152d234b70',11,'Librarian',null);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (45,'Zanariah Hazawawi','202cb962ac59075b964b07152d234b70',3,'Librarian',null);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (46,'Ahmad Haikal','202cb962ac59075b964b07152d234b70',3,'Head Librarian',4);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (47,'AMINAH','202cb962ac59075b964b07152d234b70',3,'Librarian',null);
Insert into LIBRARY.LIBRARIAN (LIBRARIAN_ID,LIBRARIAN_NAME,LIBRARIAN_PASSWORD,LIBRARIAN_MANAGERID,LIBRARIAN_ROLE,MAX_BORROW) values (48,'MISS HAJAR','202cb962ac59075b964b07152d234b70',3,'Head Librarian',4);
REM INSERTING into LIBRARY.PATRON
SET DEFINE OFF;
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('970612015578','AHMAD');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('971232889876','AMRAN');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('001122010123','SAFWAN NAIM');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('980519065633','a');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('980519065632','RAHMAT');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('980519065631','AMIRA');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('001122010124','AMIR IMRAN');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('960612013333','FATIHAH');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('960612014344','AIN');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('960612015578','CEKYAH');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('980519061234','AHMADUN');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('131231132131','a');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('980519061111','Nur Jannah');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('801112012233','DIN');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('801112012234','AH CHOOI');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('801112012235','KHAIRUL');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('801112013425','ARIFFIN');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('801112013342','RAZALI');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('980519060101','Nur Jannah');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('801112012287','KHAIRIL');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('801112012111','SHIKIN');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('123123123123','Mohd Amir');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('001122010126','SARIP DOL');
Insert into LIBRARY.PATRON (PATRON_ID,PATRON_NAME) values ('970612014300','SAIFUL');
REM INSERTING into LIBRARY.STUDENT
SET DEFINE OFF;
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('970612015578',to_date('29/11/2019','DD/MM/RRRR'),'Graduated',null,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('001122010123',to_date('19/09/2019','DD/MM/RRRR'),'Graduated',null,to_date('12/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('001122010124',to_date('15/10/2019','DD/MM/RRRR'),'Graduated',null,to_date('28/11/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('001122010126',to_date('16/10/2019','DD/MM/RRRR'),'Studying',2,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('970612014300',to_date('13/11/2019','DD/MM/RRRR'),'Studying',1,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('971232889876',to_date('23/11/2019','DD/MM/RRRR'),'Studying',2,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('980519065633',to_date('22/11/2019','DD/MM/RRRR'),'Studying',2,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('980519065632',to_date('10/10/2019','DD/MM/RRRR'),'Studying',3,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('980519065631',to_date('27/11/2019','DD/MM/RRRR'),'Studying',3,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('960612013333',to_date('20/11/2019','DD/MM/RRRR'),'Studying',4,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('960612014344',to_date('05/11/2019','DD/MM/RRRR'),'Studying',5,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('960612015578',to_date('13/11/2019','DD/MM/RRRR'),'Studying',5,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('980519060101',to_date('27/12/2019','DD/MM/RRRR'),'Studying',4,to_date('22/12/2019','DD/MM/RRRR'));
Insert into LIBRARY.STUDENT (PATRON_ID,REGISTER_DATE,STATUS,FORM,LAST_MODIFIED) values ('123123123123',to_date('24/12/2019','DD/MM/RRRR'),'Studying',1,to_date('22/12/2019','DD/MM/RRRR'));
REM INSERTING into LIBRARY.TEACHER
SET DEFINE OFF;
Insert into LIBRARY.TEACHER (PATRON_ID,TEACHER_SPECIALIZATION,TABLE_NUMBER) values ('801112012233','Matematik','D002');
Insert into LIBRARY.TEACHER (PATRON_ID,TEACHER_SPECIALIZATION,TABLE_NUMBER) values ('801112012234','B.Inggeris','B001');
Insert into LIBRARY.TEACHER (PATRON_ID,TEACHER_SPECIALIZATION,TABLE_NUMBER) values ('801112012235','B.Inggeris','B002');
Insert into LIBRARY.TEACHER (PATRON_ID,TEACHER_SPECIALIZATION,TABLE_NUMBER) values ('801112013425','Sejarah','C001');
Insert into LIBRARY.TEACHER (PATRON_ID,TEACHER_SPECIALIZATION,TABLE_NUMBER) values ('801112013342','Sejarah','C002');
Insert into LIBRARY.TEACHER (PATRON_ID,TEACHER_SPECIALIZATION,TABLE_NUMBER) values ('980519061111','Sejarah','E002');
Insert into LIBRARY.TEACHER (PATRON_ID,TEACHER_SPECIALIZATION,TABLE_NUMBER) values ('801112012287','Geografi','D002');
Insert into LIBRARY.TEACHER (PATRON_ID,TEACHER_SPECIALIZATION,TABLE_NUMBER) values ('801112012111','Matematik','E001');
--------------------------------------------------------
--  DDL for Index BOOK_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARY"."BOOK_PK" ON "LIBRARY"."BOOK" ("BOOK_ISBN") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index BORROW_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARY"."BORROW_PK" ON "LIBRARY"."BORROW" ("BORROW_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index BORROW_BOOK_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARY"."BORROW_BOOK_PK" ON "LIBRARY"."BORROW_BOOK" ("BORROW_ID", "BOOK_ISBN") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index LIBRARIAN_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARY"."LIBRARIAN_PK" ON "LIBRARY"."LIBRARIAN" ("LIBRARIAN_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index TABLE1_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARY"."TABLE1_PK" ON "LIBRARY"."PATRON" ("PATRON_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index STUDENT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARY"."STUDENT_PK" ON "LIBRARY"."STUDENT" ("PATRON_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Index TEACHER_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "LIBRARY"."TEACHER_PK" ON "LIBRARY"."TEACHER" ("PATRON_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM" ;
--------------------------------------------------------
--  DDL for Trigger BOOK_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."BOOK_TRG" 
BEFORE INSERT ON BOOK 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."BOOK_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BOOK_TRG1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."BOOK_TRG1" 
BEFORE INSERT ON BOOK 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."BOOK_TRG1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BORROW_TRG1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."BORROW_TRG1" 
BEFORE INSERT ON BORROW 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    IF INSERTING AND :NEW.BORROW_ID IS NULL THEN
      SELECT BORROW_SEQ1.NEXTVAL INTO :NEW.BORROW_ID FROM SYS.DUAL;
    END IF;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."BORROW_TRG1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BORROW_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."BORROW_TRG" 
BEFORE INSERT ON BORROW 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."BORROW_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger BORROW_BOOK_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."BORROW_BOOK_TRG" 
BEFORE INSERT ON BORROW_BOOK 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."BORROW_BOOK_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger LIBRARIAN_TRG1
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."LIBRARIAN_TRG1" 
BEFORE INSERT ON LIBRARIAN 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."LIBRARIAN_TRG1" ENABLE;
--------------------------------------------------------
--  DDL for Trigger LIBRARIAN_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."LIBRARIAN_TRG" 
BEFORE INSERT ON LIBRARIAN 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."LIBRARIAN_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger LIBRARIAN_TRG2
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."LIBRARIAN_TRG2" 
BEFORE INSERT ON LIBRARIAN 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."LIBRARIAN_TRG2" ENABLE;
--------------------------------------------------------
--  DDL for Trigger LIBRARIAN_TRG3
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."LIBRARIAN_TRG3" 
BEFORE INSERT ON LIBRARIAN 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."LIBRARIAN_TRG3" ENABLE;
--------------------------------------------------------
--  DDL for Trigger TABLE1_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."TABLE1_TRG" 
BEFORE INSERT ON PATRON 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."TABLE1_TRG" ENABLE;
--------------------------------------------------------
--  DDL for Trigger PATRON_TRG
--------------------------------------------------------

  CREATE OR REPLACE TRIGGER "LIBRARY"."PATRON_TRG" 
BEFORE INSERT ON PATRON 
FOR EACH ROW 
BEGIN
  <<COLUMN_SEQUENCES>>
  BEGIN
    NULL;
  END COLUMN_SEQUENCES;
END;
/
ALTER TRIGGER "LIBRARY"."PATRON_TRG" ENABLE;
--------------------------------------------------------
--  Constraints for Table BOOK
--------------------------------------------------------

  ALTER TABLE "LIBRARY"."BOOK" ADD CONSTRAINT "BOOK_PK" PRIMARY KEY ("BOOK_ISBN")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "LIBRARY"."BOOK" MODIFY ("BOOK_ISBN" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BORROW
--------------------------------------------------------

  ALTER TABLE "LIBRARY"."BORROW" ADD CONSTRAINT "BORROW_PK" PRIMARY KEY ("BORROW_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "LIBRARY"."BORROW" MODIFY ("LIBRARIAN_ID" NOT NULL ENABLE);
  ALTER TABLE "LIBRARY"."BORROW" MODIFY ("PATRON_ID" NOT NULL ENABLE);
  ALTER TABLE "LIBRARY"."BORROW" MODIFY ("BORROW_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table BORROW_BOOK
--------------------------------------------------------

  ALTER TABLE "LIBRARY"."BORROW_BOOK" ADD CONSTRAINT "BORROW_BOOK_PK" PRIMARY KEY ("BORROW_ID", "BOOK_ISBN")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "LIBRARY"."BORROW_BOOK" MODIFY ("BOOK_ISBN" NOT NULL ENABLE);
  ALTER TABLE "LIBRARY"."BORROW_BOOK" MODIFY ("BORROW_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table LIBRARIAN
--------------------------------------------------------

  ALTER TABLE "LIBRARY"."LIBRARIAN" ADD CONSTRAINT "LIBRARIAN_PK" PRIMARY KEY ("LIBRARIAN_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "LIBRARY"."LIBRARIAN" MODIFY ("LIBRARIAN_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table PATRON
--------------------------------------------------------

  ALTER TABLE "LIBRARY"."PATRON" ADD CONSTRAINT "TABLE1_PK" PRIMARY KEY ("PATRON_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "LIBRARY"."PATRON" MODIFY ("PATRON_ID" NOT NULL ENABLE);
--------------------------------------------------------
--  Constraints for Table STUDENT
--------------------------------------------------------

  ALTER TABLE "LIBRARY"."STUDENT" ADD CONSTRAINT "STUDENT_PK" PRIMARY KEY ("PATRON_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
--------------------------------------------------------
--  Constraints for Table TEACHER
--------------------------------------------------------

  ALTER TABLE "LIBRARY"."TEACHER" ADD CONSTRAINT "TEACHER_PK" PRIMARY KEY ("PATRON_ID")
  USING INDEX PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "SYSTEM"  ENABLE;
  ALTER TABLE "LIBRARY"."TEACHER" MODIFY ("PATRON_ID" NOT NULL ENABLE);
