USE Library_db;

-- ============================================================
-- PART 2.3 — UPDATE, DELETE, AND REFERENTIAL INTEGRITY
-- ============================================================

-- -------------------------------------------------------
-- UPDATE 1: Record the return date for loan #1
-- -------------------------------------------------------
UPDATE BORROWING_RECORDS
SET RETURN_DATE = '2025-01-22'
WHERE RECORD_ID = 1;

-- Verify the update
SELECT RECORD_ID, ID_MEMBERS, RETURN_DATE
FROM BORROWING_RECORDS
WHERE RECORD_ID = 1;

-- -------------------------------------------------------
-- UPDATE 2: Mark fine #2 as paid
-- -------------------------------------------------------
UPDATE FINES
SET PAID = TRUE
WHERE FINE_ID = 2;

-- Verify the update
SELECT FINE_ID, ID_MEMBERS, AMOUNT, PAID
FROM FINES
WHERE FINE_ID = 2;

-- -------------------------------------------------------
-- UPDATE 3: Add 2 more copies of book #1 to the library
-- -------------------------------------------------------
UPDATE BOOKS
SET COPIES_TOTAL      = COPIES_TOTAL + 2,
    COPIES_AVAILABLE  = COPIES_AVAILABLE + 2
WHERE ID_BOOK = 1;

-- Verify the update
SELECT ID_BOOK, TITLE, COPIES_TOTAL, COPIES_AVAILABLE
FROM BOOKS
WHERE ID_BOOK = 1;

-- -------------------------------------------------------
-- DELETE 1: Remove fine #4 (paid and no longer needed)
-- -------------------------------------------------------
DELETE FROM FINES
WHERE FINE_ID = 4;

-- Verify the deletion
SELECT * FROM FINES;

-- -------------------------------------------------------
-- DELETE 2: Remove member #10 and their loan history
-- First, delete their loans to respect the foreign key constraint
-- -------------------------------------------------------
DELETE FROM BORROWING_RECORDS
WHERE ID_MEMBERS = 10;

-- Then, safely delete the member
DELETE FROM MEMBERS
WHERE ID_MEMBERS = 10;

-- Verify the deletion
SELECT ID_MEMBERS, FIRST_NAME, LAST_NAME
FROM MEMBERS;

-- =========================================================================
-- REFERENTIAL INTEGRITY VIOLATION DEMO
-- Intentional error to demonstrate ON DELETE RESTRICT behavior
-- This will trigger:
-- ERROR 1451 (23000): Cannot delete or update a parent row:
-- a foreign key constraint fails
-- Attempting to delete author Victor Hugo (ID = 1)
-- who still has books referencing him in the BOOKS table
-- =========================================================================
DELETE FROM AUTHORS WHERE ID_AUTHOR = 1;
