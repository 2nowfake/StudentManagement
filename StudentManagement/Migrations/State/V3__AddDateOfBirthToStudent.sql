-- Migrations/State/V3__AddDateOfBirthToStudent.sql
-- This script represents the full desired state after adding DateOfBirth

-- Drop existing foreign keys
ALTER TABLE [Enrollments] DROP CONSTRAINT [FK_Enrollments_Students_StudentId];

-- Drop existing tables
DROP TABLE IF EXISTS [Enrollments];
DROP TABLE IF EXISTS [Students];
DROP TABLE IF EXISTS [Courses];

-- Recreate tables with the new schema
CREATE TABLE [Courses] (
    [Id] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NOT NULL,
    [Credits] int NOT NULL,
    CONSTRAINT [PK_Courses] PRIMARY KEY ([Id])
    );

CREATE TABLE [Students] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [MiddleName] nvarchar(max) NULL,
    [Email] nvarchar(max) NOT NULL,
    [EnrollmentDate] datetime2 NOT NULL,
    [DateOfBirth] datetime2 NULL,
    CONSTRAINT [PK_Students] PRIMARY KEY ([Id])
    );

CREATE TABLE [Enrollments] (
    [Id] int NOT NULL IDENTITY,
    [StudentId] int NOT NULL,
    [CourseId] int NOT NULL,
    [Grade] nvarchar(max) NOT NULL,
    CONSTRAINT [PK_Enrollments] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Enrollments_Courses_CourseId] FOREIGN KEY ([CourseId]) REFERENCES [Courses] ([Id]) ON DELETE CASCADE,
    CONSTRAINT [FK_Enrollments_Students_StudentId] FOREIGN KEY ([StudentId]) REFERENCES [Students] ([Id]) ON DELETE CASCADE
    );

CREATE INDEX [IX_Enrollments_CourseId] ON [Enrollments] ([CourseId]);
CREATE INDEX [IX_Enrollments_StudentId] ON [Enrollments] ([StudentId]);