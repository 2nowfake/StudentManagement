BEGIN TRANSACTION;
ALTER TABLE [Students] ADD [DateOfBirth] datetime2 NULL;

INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250307140459_AddDateOfBirthToStudent', N'9.0.2');

COMMIT;
GO

