BEGIN TRANSACTION;
INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250307153912_RenameGradeToFinalGrade', N'9.0.2');

COMMIT;
GO

