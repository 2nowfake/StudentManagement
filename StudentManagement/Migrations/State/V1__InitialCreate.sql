﻿-- Migrations/State/V1__InitialCreate.sql
-- This script represents the full desired state for the initial schema

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
    [Email] nvarchar(max) NOT NULL,
    [EnrollmentDate] datetime2 NOT NULL,
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