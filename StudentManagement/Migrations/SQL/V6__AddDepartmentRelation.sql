BEGIN TRANSACTION;
ALTER TABLE [Courses] ADD [DepartmentId] int NULL;

CREATE TABLE [Department] (
    [Id] int NOT NULL IDENTITY,
    [Name] nvarchar(max) NOT NULL,
    [Budget] decimal(18,2) NOT NULL,
    [StartDate] datetime2 NOT NULL,
    [DepartmentHeadId] int NULL,
    CONSTRAINT [PK_Department] PRIMARY KEY ([Id]),
    CONSTRAINT [FK_Department_Instructor_DepartmentHeadId] FOREIGN KEY ([DepartmentHeadId]) REFERENCES [Instructor] ([Id])
);

CREATE INDEX [IX_Courses_DepartmentId] ON [Courses] ([DepartmentId]);

CREATE INDEX [IX_Department_DepartmentHeadId] ON [Department] ([DepartmentHeadId]);

ALTER TABLE [Courses] ADD CONSTRAINT [FK_Courses_Department_DepartmentId] FOREIGN KEY ([DepartmentId]) REFERENCES [Department] ([Id]);

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250307164240_AddDepartmentRelation', N'9.0.2');

COMMIT;
GO

