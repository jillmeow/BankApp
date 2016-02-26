DROP TABLE bank cascade constraints;
DROP TABLE bank_branch cascade constraints;
DROP TABLE account cascade constraints;
DROP TABLE loan cascade constraints;
DROP TABLE customer cascade constraints;
DROP TABLE Account_Customer cascade constraints;
DROP TABLE Loan_Customer cascade constraints;


CREATE TABLE bank
(
  RoutingCode   CHAR(9)        PRIMARY KEY,
  Name          VARCHAR2(15)   NOT NULL,
  Addr          VARCHAR2(40)
);



CREATE TABLE bank_branch
( brcode        CHAR(9)        References bank(RoutingCode),
  BranchNo      CHAR(9)        UNIQUE,
  Branch_Name   VARCHAR2(30)   NOT NULL,
  Branch_Addr   VARCHAR2(40),
  Total_Loan    NUMBER(12,2)   DEFAULT 0,
 PRIMARY KEY(brcode, BranchNo));

CREATE TABLE customer
(
  IRD            CHAR(9)        PRIMARY KEY,
  Name           VARCHAR(15)    NOT NULL,
  Addr           VARCHAR(40),
  Phone          VARCHAR(10),
  TotalBalance   NUMBER(12,2)    DEFAULT 0
);


CREATE TABLE account
(
  AcctNo        CHAR(8)         PRIMARY KEY,
  Type          VARCHAR(20)     NOT NULL,
  Balance       NUMBER(12,2)     NOT NULL,
  bCode         CHAR(9)         REFERENCES Bank(RoutingCode),
  bNum          CHAR(9)         REFERENCES Bank_Branch(branchNo),
 FOREIGN KEY (bCode, bNum) REFERENCES bank_branch(brcode, branchNo)
);

CREATE TABLE Account_Customer
(
  ANum        CHAR(8)         REFERENCES Account(AcctNo),
  IRDnum           CHAR(9)         REFERENCES Customer(IRD),
 PRIMARY KEY(ANum, IRDnum));

CREATE TABLE loan
(
  LoanNo        CHAR(10)        PRIMARY KEY,
  TYPE          VARCHAR(20)     NOT NULL,
  Amount        NUMBER(12,2)     NOT NULL,
  Contract_Date DATE            NOT NULL,
  bCode         CHAR(9)         REFERENCES Bank(RoutingCode),
  bNum          CHAR(9)         REFERENCES Bank_Branch(branchNo),
 FOREIGN KEY (bCode, bNum) REFERENCES bank_branch(brcode, branchNo)
);

@trig.sql;

CREATE TABLE Loan_Customer
(
  LNum        CHAR(10)        REFERENCES Loan(LoanNo),
  IRDnum      CHAR(9)         REFERENCES Customer(IRD),
 PRIMARY KEY(LNum, IRDnum));

/* 4 banks in the database */
INSERT INTO bank VALUES
('123456789', 'BNZ', '5 Abbey Road');
INSERT INTO bank VALUES
('545423442', 'KiwiBank', '13 Penny Lane');
INSERT INTO bank VALUES
('473878432', 'ANZ', '41 Logan Ave');
INSERT INTO bank VALUES
('353424345', 'Westpac', '5 Neville St');
INSERT INTO bank VALUES
('942334541', 'ASB', '5th Avenue');
/* BNZ Branch*/
INSERT INTO bank_branch VALUES
( '123456789', '2345467', 'Dunedin Central', '6 George St',0);
INSERT INTO bank_branch VALUES
( '123456789', '4353454', 'Uni Canterbury', '32 KeriKeri St',0);
INSERT INTO bank_branch VALUES
( '123456789', '1435454', 'Auckland Library', '12 Queens St',0);

/* KiwiBank Branch*/
INSERT INTO bank_branch VALUES
( '545423442', '7534565', 'KiwiBank NZ Post', '94 Surrey Rd',0);
INSERT INTO bank_branch VALUES
( '545423442', '1663242', 'KiwiBank Albany', '32 Albany St',0);

/* ANZ Branch*/
INSERT INTO bank_branch VALUES
( '473878432', '8785323', 'Wakari Mall', '5 George St',0);
INSERT INTO bank_branch VALUES
( '473878432', '9423571', 'Meridian Supermarket', '22 Reid Rd', 0);

/* Westpac Branch*/
INSERT INTO bank_branch VALUES
( '353424345', '8984219', 'Boston', '5 George St',0);
INSERT INTO bank_branch VALUES
( '353424345', '1043252', 'Fifth Avenue', '22 Reid Rd',0);

/* ASB Branch*/
INSERT INTO bank_branch VALUES
('942334541', '534531', 'Kili Kili', '23 Talong St', 0);


/* CREATE NEW ACCOUNT -- Account No, Type, Balance, Routing Code, Branch No */
/* Logan's Account*/
INSERT INTO account VALUES
( '34594500', 'Cheque', 800.00, '123456789', '2345467');
INSERT INTO account VALUES
( '63435211', 'Saving', 524.31,'123456789', '2345467');
INSERT INTO account VALUES
( '43546462', 'Saving', 90330.31,'123456789', '4353454');

/* Jake's account*/
INSERT INTO account VALUES
( '25345231', 'Cheque', 574.00, '473878432', '8785323');
INSERT INTO account VALUES
( '58498594', 'Saving', 10343.31,'123456789', '4353454');
INSERT INTO account VALUES
( '79952343', 'Saving', 234.31,'473878432', '9423571');
INSERT INTO account VALUES
( '54342134', 'Saving', 534.00, '942334541', '534531');

/* Paul's account*/
INSERT INTO account VALUES
( '98562345', 'Cheque', 800.41, '545423442', '7534565');
INSERT INTO account VALUES
( '24635463', 'Saving', 453000.24,'545423442', '7534565');
INSERT INTO account VALUES
( '62454524', 'Saving', 441530.24,'545423442', '1663242');

/* John's account*/
INSERT INTO account VALUES
( '84252452', 'Cheque', 347832.41, '353424345', '8984219');
INSERT INTO account VALUES
( '34523210', 'Saving', 453000.24,'353424345', '8984219');

/* George's account*/
INSERT INTO account VALUES
( '70135422', 'Cheque', 10050.41, '473878432', '8785323');
INSERT INTO account VALUES
( '62452210', 'Saving', 1030430.24,'545423442', '7534565');

/* Ringo's account*/
INSERT INTO account VALUES
( '24592452', 'Cheque', 54020.41, '353424345', '1043252');
INSERT INTO account VALUES
( '47487522', 'Investment', 3533010.24,'353424345', '1043252');

/* CREATE NEW CUSTOMERS */
INSERT INTO customer VALUES
( '77321234', 'Logan Paul', '3 Westlake St', '324 2421', 0.00);
INSERT INTO customer VALUES
( '82342342', 'Jake Paul', '3 Westlake St', '04312432', 0.00);
INSERT INTO customer VALUES
( '34234322', 'Ringo Starr', '19 Strawberry Fields Rd', '0234321415', 0.00);
INSERT INTO customer VALUES
( '19374743', 'John Lennon', '48 Abbey Rd', '551 2313', 0.00);
INSERT INTO customer VALUES
( '78787871', 'George Harrison', '45 Chicken Curry St', '023143134', 0.00);
INSERT INTO customer VALUES
( '54854314', 'Paul McCartney', '31 Penny Lane', '434 3431', 0.00);

/* Logan's Account*/
INSERT INTO Account_Customer VALUES
( '34594500', '77321234');
INSERT INTO Account_Customer VALUES
( '63435211', '77321234');
INSERT INTO Account_Customer VALUES
( '43546462', '77321234');

/* Jake's account*/
INSERT INTO Account_Customer VALUES
( '25345231', '82342342');
INSERT INTO Account_Customer VALUES
( '58498594', '82342342');
INSERT INTO Account_Customer VALUES
( '79952343', '82342342');
INSERT INTO Account_Customer VALUES
('54342134', '82342342');

/* Paul's account*/
INSERT INTO Account_Customer VALUES
( '98562345', '54854314');
INSERT INTO Account_Customer VALUES
( '24635463', '54854314');
INSERT INTO Account_Customer VALUES
( '62454524', '54854314');

/* John's account*/
INSERT INTO Account_Customer VALUES
( '84252452', '19374743');
INSERT INTO Account_Customer VALUES
( '34523210', '19374743');

/* George's account*/
INSERT INTO Account_Customer VALUES
( '70135422', '78787871');
INSERT INTO Account_Customer VALUES
( '62452210', '78787871');

/* Ringo's account*/
INSERT INTO Account_Customer VALUES
( '24592452', '34234322');
INSERT INTO Account_Customer VALUES
( '47487522', '34234322');


UPDATE CUSTOMER
SET TotalBalance=
  (SELECT SUM(A.BALANCE) FROM ACCOUNT A,
   ACCOUNT_CUSTOMER AC
   WHERE AC.ANUM = A.ACCTNO AND
   AC.IRDNUM = '77321234')
WHERE IRD = '77321234';

UPDATE CUSTOMER
SET TotalBalance=
  (SELECT SUM(A.BALANCE) FROM ACCOUNT A,
   ACCOUNT_CUSTOMER AC
   WHERE AC.ANUM = A.ACCTNO AND
   AC.IRDNUM = '82342342')
WHERE IRD = '82342342';

UPDATE CUSTOMER
SET TotalBalance=
  (SELECT SUM(A.BALANCE) FROM ACCOUNT A,
   ACCOUNT_CUSTOMER AC
   WHERE AC.ANUM = A.ACCTNO AND
   AC.IRDNUM = '54854314')
WHERE IRD = '54854314';

UPDATE CUSTOMER
SET TotalBalance=
  (SELECT SUM(A.BALANCE) FROM ACCOUNT A,
   ACCOUNT_CUSTOMER AC
   WHERE AC.ANUM = A.ACCTNO AND
   AC.IRDNUM = '19374743')
WHERE IRD = '19374743';

UPDATE CUSTOMER
SET TotalBalance=
  (SELECT SUM(A.BALANCE) FROM ACCOUNT A,
   ACCOUNT_CUSTOMER AC
   WHERE AC.ANUM = A.ACCTNO AND
   AC.IRDNUM = '78787871')
WHERE IRD = '78787871';

UPDATE CUSTOMER
SET TotalBalance=
  (SELECT SUM(A.BALANCE) FROM ACCOUNT A,
   ACCOUNT_CUSTOMER AC
   WHERE AC.ANUM = A.ACCTNO AND
   AC.IRDNUM = '34234322')
WHERE IRD = '34234322';

/* Create Loan - LoanNo, TYPE, Amount, Contract_Date, Routing Code, Branch No*/
/* Jake's loan*/
INSERT INTO loan VALUES
( '90135346', 'Student Loan', 5342.00, 
  TO_DATE('15-08-2014', 'DD-MM-YYYY'), 
  '123456789', '2345467');
INSERT INTO loan VALUES
( '53458931', 'Home Loan', 45214.00, 
  TO_DATE('28-04-2011', 'DD-MM-YYYY'), 
  '353424345', '1043252');

/* Ringo's loan*/
INSERT INTO loan VALUES
( '765376753', 'Home Loan', 91242.00, 
  TO_DATE('15-08-2014', 'DD-MM-YYYY'), 
  '545423442', '1663242');

/* John's loan*/
INSERT INTO loan VALUES
( '32363257', 'Car loan', 5342.00, 
  TO_DATE('08-03-2009', 'DD-MM-YYYY'), 
  '123456789', '2345467');
INSERT INTO loan VALUES
( '43265432', 'Home Loan', 30234.00, 
  TO_DATE('01-07-2011', 'DD-MM-YYYY'), 
  '353424345', '1043252');

/* Jake's loan*/
INSERT INTO Loan_Customer VALUES
( '90135346', '82342342');
INSERT INTO Loan_Customer VALUES
( '53458931', '82342342');

/* Ringo's loan*/
INSERT INTO Loan_Customer VALUES
( '765376753','34234322');

INSERT INTO Loan_Customer VALUES
( '32363257','19374743');
INSERT INTO Loan_Customer VALUES
( '43265432','19374743');