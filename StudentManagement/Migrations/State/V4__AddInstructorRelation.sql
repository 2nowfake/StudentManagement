-- Migrations/State/V4__AddInstructorRelation.sql

-- Drop existing foreign keys
ALTER TABLE [Enrollments] DROP CONSTRAINT [FK_Enrollments_Courses_CourseId];
ALTER TABLE [Enrollments] DROP CONSTRAINT [FK_Enrollments_Students_StudentId];

-- Drop existing tables
DROP TABLE IF EXISTS [Enrollments];
DROP TABLE IF EXISTS [Courses];
DROP TABLE IF EXISTS [Students];
DROP TABLE IF EXISTS [Instructors];

-- Create all tables with the new schema
CREATE TABLE [Instructors] (
    [Id] int NOT NULL IDENTITY,
    [FirstName] nvarchar(max) NOT NULL,
    [LastName] nvarchar(max) NOT NULL,
    [Email] nvarchar(max) NOT NULL,
    [HireDate] datetime2 NOT NULL,
    CONSTRAINT [PK_Instructors] PRIMARY KEY ([Id])
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

CREATE TABLE [Courses] (
    [Id] int NOT NULL IDENTITY,
    [Title] nvarchar(max) NOT NULL,
    [Credits] int NOT NULL,
    [InstructorId] int NULL,
    CONSTRAINT [PK_Courses] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Courses_Instructors_InstructorId] FOREIGN KEY ([InstructorId]) REFERENCES [Instructors] ([Id])
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

CREATE INDEX [IX_Courses_InstructorId] ON [Courses] ([InstructorId]);
CREATE INDEX [IX_Enrollments_CourseId] ON [Enrollments] ([CourseId]);
CREATE INDEX [IX_Enrollments_StudentId] ON [Enrollments] ([StudentId]);