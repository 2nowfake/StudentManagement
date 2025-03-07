-- Migrations/State/V7__ModifyCourseCreditsType.sql

-- Create a temporary column with the new type
ALTER TABLE [Courses] ADD [Credits_new] decimal(5,2) NULL;

-- Copy data from the old column to the new one
UPDATE [Courses] SET [Credits_new] = CAST([Credits] AS decimal(5,2));

-- Drop the old column
ALTER TABLE [Courses] DROP COLUMN [Credits];

-- Rename the new column to the original name
EXEC sp_rename 'Courses.Credits_new', 'Credits', 'COLUMN';

-- Set the column as NOT NULL (if needed)
ALTER TABLE [Courses] ALTER COLUMN [Credits] decimal(5,2) NOT NULL;