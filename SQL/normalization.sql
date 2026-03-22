/*==============================================================*/
/* DBMS     : MySQL 8.0                                         */
/* Project  : Library Management System                         */
/* File     : Normalization – Part 1.4                          */
/* Course   : CS27 – The Relational Model & Databases           */
/* Institute: Burkina Institute of Technology                   */
/* Date     : March 2026                                        */
/*==============================================================*/

/*==============================================================*/
/* STEP 0 — UNNORMALIZED TABLE (UNF)                           */
/* We imagine all data has been put into a single table         */
/*==============================================================*/

/*
LIBRARY_ALL (unnormalized table) :

+----------+----------------+-------------------+------------------------+---------------------------+-----------------+------------------+------------------+------------------+------------------+------------+----------+---------+------------+
| RECORD_ID| MEMBER_FNAME   | MEMBER_LNAME      | MEMBER_EMAIL           | BOOK_TITLES               | AUTHOR_FNAME    | AUTHOR_LNAME     | PUBLISHER        | YEAR_PUBLISHED   | COPIES_AVAILABLE | BORROW_DATE| DUE_DATE | AMOUNT  | PAID       |
+----------+----------------+-------------------+------------------------+---------------------------+-----------------+------------------+------------------+------------------+------------------+------------+----------+---------+------------+
| 1        | Aminata        | Ouédraogo         | aminata@email.bf       | Les Misérables            | Victor          | Hugo             | Gallimard        | 1862             | 3                | 2025-01-10 | 2025-01-24| NULL   | NULL       |
| 2        | Souleymane     | Traoré            | souleymane@email.bf    | Cent ans de solitude      | Gabriel         | Garcia Marquez   | Seuil            | 1967             | 1                | 2025-02-01 | 2025-02-15| 500.00 | TRUE       |
| 3        | Fatima         | Kaboré            | fatima@email.bf        | Beloved                   | Toni            | Morrison         | Knopf            | 1987             | 2                | 2025-02-10 | 2025-02-24| NULL   | NULL       |
| 4        | Ibrahim        | Sawadogo          | ibrahim@email.bf       | Les Bouts de bois de Dieu | Ousmane         | Sembène          | Présence Africaine| 1960            | 3                | 2025-03-05 | 2025-03-19| 600.00 | FALSE      |
| 2        | Souleymane     | Traoré            | souleymane@email.bf    | Les Misérables,Beloved    | Victor,Toni     | Hugo,Morrison    | Gallimard,Knopf  | 1862,1987        | 3,2              | 2025-04-01 | 2025-04-15| NULL   | NULL       |
+----------+----------------+-------------------+------------------------+---------------------------+-----------------+------------------+------------------+------------------+------------------+------------+----------+---------+------------+

VISIBLE PROBLEMS:
- The last row contains MULTIPLE values in a single cell
  (BOOK_TITLES = "Les Misérables,Beloved", AUTHOR_FNAME = "Victor,Toni")
- Member information (MEMBER_FNAME, MEMBER_LNAME) is repeated for every loan
- Book information (PUBLISHER, YEAR_PUBLISHED) is repeated for every loan
- AMOUNT and PAID are NULL when there is no fine → mixed data concern
*/

/*==============================================================*/
/* STEP 1 — FIRST NORMAL FORM (1NF)                            */
/*==============================================================*/

/*
1NF RULE:
  - Each cell must contain ONE single atomic value
  - No repeating groups
  - Each row must be unique (primary key)

VIOLATION IN OUR TABLE:
  The row with RECORD_ID = 2 (Souleymane) contains:
    BOOK_TITLES       = "Les Misérables, Beloved"     <- 2 values in 1 cell ❌
    AUTHOR_FNAME      = "Victor, Toni"                <- 2 values in 1 cell ❌
    YEAR_PUBLISHED    = "1862, 1987"                  <- 2 values in 1 cell ❌

1NF FIX:
  We split each multi-value into separate rows.
  Each row represents ONE loan for ONE book.

LIBRARY_1NF (after fix):

+----------+----------------+-------------------+------------------------+---------------------------+-----------------+------------------+------------------+------------------+------------------+------------+----------+---------+-------+
| RECORD_ID| MEMBER_FNAME   | MEMBER_LNAME      | MEMBER_EMAIL           | BOOK_TITLE                | AUTHOR_FNAME    | AUTHOR_LNAME     | PUBLISHER        | YEAR_PUBLISHED   | COPIES_AVAILABLE | BORROW_DATE| DUE_DATE | AMOUNT  | PAID  |
+----------+----------------+-------------------+------------------------+---------------------------+-----------------+------------------+------------------+------------------+------------------+------------+----------+---------+-------+
| 1        | Aminata        | Ouédraogo         | aminata@email.bf       | Les Misérables            | Victor          | Hugo             | Gallimard        | 1862             | 3                | 2025-01-10 | 2025-01-24| NULL  | NULL  |
| 2        | Souleymane     | Traoré            | souleymane@email.bf    | Cent ans de solitude      | Gabriel         | Garcia Marquez   | Seuil            | 1967             | 1                | 2025-02-01 | 2025-02-15| 500   | TRUE  |
| 3        | Fatima         | Kaboré            | fatima@email.bf        | Beloved                   | Toni            | Morrison         | Knopf            | 1987             | 2                | 2025-02-10 | 2025-02-24| NULL  | NULL  |
| 4        | Ibrahim        | Sawadogo          | ibrahim@email.bf       | Les Bouts de bois de Dieu | Ousmane         | Sembène          | Présence Africaine| 1960            | 3                | 2025-03-05 | 2025-03-19| 600   | FALSE |
| 5        | Souleymane     | Traoré            | souleymane@email.bf    | Les Misérables            | Victor          | Hugo             | Gallimard        | 1862             | 3                | 2025-04-01 | 2025-04-15| NULL  | NULL  |
| 6        | Souleymane     | Traoré            | souleymane@email.bf    | Beloved                   | Toni            | Morrison         | Knopf            | 1987             | 2                | 2025-04-01 | 2025-04-15| NULL  | NULL  |
+----------+----------------+-------------------+------------------------+---------------------------+-----------------+------------------+------------------+------------------+------------------+------------+----------+---------+-------+

✅ Now each cell contains a single value → 1NF satisfied
❌ BUT: member and book information is still duplicated across multiple rows
*/

/*==============================================================*/
/* STEP 2 — SECOND NORMAL FORM (2NF)                           */
/*==============================================================*/

/*
2NF RULE:
  - Must be in 1NF
  - Every non-key column must depend on THE WHOLE primary key
    (not just part of it — eliminates partial dependencies)

VIOLATION IN LIBRARY_1NF:
  Assume a composite key: (RECORD_ID, BOOK_TITLE)

  - MEMBER_FNAME, MEMBER_LNAME, MEMBER_EMAIL
    -> depend only on RECORD_ID (not on BOOK_TITLE) ❌
  - AUTHOR_FNAME, AUTHOR_LNAME, PUBLISHER, YEAR_PUBLISHED, COPIES_AVAILABLE
    -> depend only on BOOK_TITLE (not on RECORD_ID) ❌
  - BORROW_DATE, DUE_DATE, AMOUNT, PAID
    -> depend on the full key (RECORD_ID + BOOK_TITLE) ✅

2NF FIX:
  We separate the data into distinct tables based on their dependencies.

TABLE MEMBERS_2NF:
+----------+----------------+-------------------+------------------------+
| MEMBER_ID| MEMBER_FNAME   | MEMBER_LNAME      | MEMBER_EMAIL           |
+----------+----------------+-------------------+------------------------+
| 1        | Aminata        | Ouédraogo         | aminata@email.bf       |
| 2        | Souleymane     | Traoré            | souleymane@email.bf    |
| 3        | Fatima         | Kaboré            | fatima@email.bf        |
| 4        | Ibrahim        | Sawadogo          | ibrahim@email.bf       |
+----------+----------------+-------------------+------------------------+

TABLE BOOKS_2NF:
+---------+---------------------------+-----------------+------------------+------------------+------------------+
| BOOK_ID | BOOK_TITLE                | AUTHOR_FNAME    | AUTHOR_LNAME     | PUBLISHER        | YEAR_PUBLISHED   |
+---------+---------------------------+-----------------+------------------+------------------+------------------+
| 1       | Les Misérables            | Victor          | Hugo             | Gallimard        | 1862             |
| 2       | Cent ans de solitude      | Gabriel         | Garcia Marquez   | Seuil            | 1967             |
| 3       | Beloved                   | Toni            | Morrison         | Knopf            | 1987             |
| 4       | Les Bouts de bois de Dieu | Ousmane         | Sembène          | Présence Africaine| 1960            |
+---------+---------------------------+-----------------+------------------+------------------+------------------+

TABLE BORROWING_2NF:
+----------+-----------+---------+------------+------------+--------+------+
| RECORD_ID| MEMBER_ID | BOOK_ID | BORROW_DATE| DUE_DATE   | AMOUNT | PAID |
+----------+-----------+---------+------------+------------+--------+------+
| 1        | 1         | 1       | 2025-01-10 | 2025-01-24 | NULL   | NULL |
| 2        | 2         | 2       | 2025-02-01 | 2025-02-15 | 500    | TRUE |
| 3        | 3         | 3       | 2025-02-10 | 2025-02-24 | NULL   | NULL |
| 4        | 4         | 4       | 2025-03-05 | 2025-03-19 | 600    | FALSE|
| 5        | 2         | 1       | 2025-04-01 | 2025-04-15 | NULL   | NULL |
| 6        | 2         | 3       | 2025-04-01 | 2025-04-15 | NULL   | NULL |
+----------+-----------+---------+------------+------------+--------+------+

✅ No more partial dependencies → 2NF satisfied
❌ BUT: in BOOKS_2NF, AUTHOR_FNAME and AUTHOR_LNAME depend on
   a non-key attribute (AUTHOR_FNAME -> AUTHOR_LNAME) -> 3NF violation
❌ In BORROWING_2NF, AMOUNT and PAID relate to fines,
   not directly to the loan itself -> 3NF violation
*/

/*==============================================================*/
/* STEP 3 — THIRD NORMAL FORM (3NF)                            */
/*==============================================================*/

/*
3NF RULE:
  - Must be in 2NF
  - No non-key column must depend on another non-key column
    (eliminates transitive dependencies)

VIOLATION IN BOOKS_2NF:
  BOOK_ID -> AUTHOR_FNAME -> AUTHOR_LNAME
  The author depends on the book, but the author's details (first name, last name)
  depend on the author themselves, not directly on the book ❌

VIOLATION IN BORROWING_2NF:
  RECORD_ID -> AMOUNT and PAID
  These columns relate to the fine, not the loan itself.
  They create a transitive dependency through the late return ❌

3NF FIX:
  We extract AUTHORS into its own table
  We extract FINES into its own table

FINAL NORMALIZED SCHEMA (3NF):
═══════════════════════════════

AUTHORS          BOOKS               MEMBERS
──────────       ──────────────      ──────────────
ID_AUTHOR  PK    ID_BOOK      PK     ID_MEMBERS  PK
FIRST_NAME       ID_AUTHOR    FK->   FIRST_NAME
LAST_NAME        TITLE        AUTHORS LAST_NAME
EMAIL            PUBLISHER           EMAIL
NATIONALITY      YEAR_PUBLISHED      PHONE
                 COPIES_TOTAL        MEMBERSHIP_DATE
                 COPIES_AVAILABLE

        BORROWING_RECORDS           FINES
        ─────────────────           ──────────────
        RECORD_ID      PK           FINE_ID     PK
        ID_BOOK        FK->BOOKS    RECORD_ID   FK->BORROWING
        ID_MEMBERS     FK->MEMBERS  ID_MEMBERS  FK->MEMBERS
        BORROW_DATE                 AMOUNT
        DUE_DATE                    PAID
        RETURN_DATE                 FINE_DATE

✅ No partial dependencies
✅ No transitive dependencies
✅ Schema fully in 3NF -> this is exactly our MySQL implementation!
*/

/*==============================================================*/
/* NORMALIZATION STEPS SUMMARY                                  */
/*==============================================================*/

/*
┌─────────┬──────────────────────────────────────────────────────────────────┐
│ Step    │ Problem fixed                                                     │
├─────────┼──────────────────────────────────────────────────────────────────┤
│ UNF->1NF│ Multiple values in one cell (several books per row)              │
│         │ -> One atomic value per cell, one row per loan                   │
├─────────┼──────────────────────────────────────────────────────────────────┤
│ 1NF->2NF│ Member and book info repeated for every loan                     │
│         │ -> Separated into tables MEMBERS, BOOKS, BORROWING_RECORDS       │
├─────────┼──────────────────────────────────────────────────────────────────┤
│ 2NF->3NF│ Author info depending on the book, fines mixed with loans        │
│         │ -> Separated into tables AUTHORS and FINES                       │
└─────────┴──────────────────────────────────────────────────────────────────┘

FINAL RESULT: 5 clean tables, no redundancy, no anomalies
-> AUTHORS, BOOKS, MEMBERS, BORROWING_RECORDS, FINES
*/
