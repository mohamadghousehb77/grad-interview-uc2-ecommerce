-- ============================================================
-- create_database.sql
-- SQL Server / T-SQL
-- Run this first.
-- ============================================================

IF DB_ID('GradInterviewSQL') IS NOT NULL
BEGIN
    ALTER DATABASE GradInterviewSQL SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE GradInterviewSQL;
END
GO

CREATE DATABASE GradInterviewSQL;
GO
