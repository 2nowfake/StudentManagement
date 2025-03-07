-- Migrations/State/V5__RenameGradeToFinalGrade.sql

-- This method keeps existing data
EXEC sp_rename 'Enrollments.Grade', 'FinalGrade', 'COLUMN';