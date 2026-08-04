/*==============================================================================
  NorthwindDbSampleSpec : データベース作成
  --------------------------------------------------------------------------
  対象  : Microsoft SQL Server
  実行順: 01_CreateDatabase.sql → 02_CreateTables.sql → 03_InsertData.sql
  備考  : 既存の Northwind データベースがある場合は何もしない。
          作り直す場合は下部のコメントアウトを外して実行すること。
==============================================================================*/

SET NOCOUNT ON;
GO

IF DB_ID(N'Northwind') IS NULL
BEGIN
    PRINT N'データベース [Northwind] を作成します。';
    CREATE DATABASE [Northwind];
END
ELSE
BEGIN
    PRINT N'データベース [Northwind] は既に存在します。作成をスキップしました。';
END
GO

/*------------------------------------------------------------------------------
  データベースを作り直す場合のみ、次のコメントを外して実行する。
  接続中のセッションを強制切断してから削除する。

IF DB_ID(N'Northwind') IS NOT NULL
BEGIN
    ALTER DATABASE [Northwind] SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [Northwind];
    CREATE DATABASE [Northwind];
END
GO
------------------------------------------------------------------------------*/

USE [Northwind];
GO

PRINT N'01_CreateDatabase.sql : 完了';
GO
