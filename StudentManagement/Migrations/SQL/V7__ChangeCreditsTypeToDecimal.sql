BEGIN TRANSACTION;
INSERT INTO [__EFMigrationsHistory] ([MigrationId], [ProductVersion])
VALUES (N'20250307170200_ChangeCreditsTypeToDecimal', N'9.0.2');

COMMIT;
GO

