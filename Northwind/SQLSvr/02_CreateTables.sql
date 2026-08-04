/*==============================================================================
  NorthwindDbSampleSpec : テーブル定義（DDL）
  --------------------------------------------------------------------------
  対象  : Microsoft SQL Server
  実行順: 01_CreateDatabase.sql → 02_CreateTables.sql → 03_InsertData.sql

  仕様  : ../../LLD/TableSchema.md および配下のテーブル定義書
          共通仕様（原典への追加）: ../../HLD/Common.md の 9 節

  原典  : microsoft/sql-server-samples の northwind-pubs / instnwnd.sql（MIT）
          https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs

  --------------------------------------------------------------------------
  【制約方針】業務系で使用しない制約は DB に持たせず、アプリケーションで担保する
  --------------------------------------------------------------------------
  DB に持たせないもの                     アプリ側の担保
    1. 外部キー制約（FOREIGN KEY）        VAL-EXISTS（参照先の存在確認）
                                          ERR-FK（被参照データの削除禁止）
    2. CASCADE 更新・削除                 イベント仕様書に手順として明記
                                          （例：受注削除は明細を先に削除）
    3. CHECK 制約                         VAL-NUMERIC / VAL-DATE（入力検証）
    4. UNIQUE 制約                        VAL-DUP（重複確認）
    5. トリガー（TRIGGER）                イベント仕様書の処理内容に明記

  DB に残すもの
    ・PRIMARY KEY  … 行の同一性と索引のために必須
    ・NOT NULL     … 列の定義そのもの
    ・DEFAULT      … 既定値の定義
    ・IDENTITY     … 採番（採番テーブルを作らない方針のため）
    ・INDEX        … 性能。アプリ側の存在確認・削除可否判定も索引を必要とする

  この方針により、参照整合性・値の妥当性の保証責任はすべてアプリケーションにある。
  詳細は ../../LLD/TableSchema.md の「DB に持たせない制約」を参照。

  --------------------------------------------------------------------------
  原典との差分は次の 3 点。列の削除・改名・型変更は行っていない。
    (1) 楽観排他用の [RowVersion] rowversion 列を、更新対象の 9 テーブルへ追加
    (2) パフォーマンス分析のため [SalesTargets] テーブルを追加
    (3) 上記の制約方針により FOREIGN KEY と CHECK 制約を作成しない

  本スクリプトは再実行可能。既存のテーブルを削除してから作成する。
==============================================================================*/

USE [Northwind];
GO

SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO

/*------------------------------------------------------------------------------
  0. 既存テーブルの削除
     外部キー制約を作らないため削除順の制約はないが、参照関係の逆順に並べている。
------------------------------------------------------------------------------*/
PRINT N'--- 既存テーブルを削除します ---';
GO

DROP TABLE IF EXISTS [dbo].[SalesTargets];
DROP TABLE IF EXISTS [dbo].[Order Details];
DROP TABLE IF EXISTS [dbo].[Orders];
DROP TABLE IF EXISTS [dbo].[Products];
DROP TABLE IF EXISTS [dbo].[CustomerCustomerDemo];
DROP TABLE IF EXISTS [dbo].[EmployeeTerritories];
DROP TABLE IF EXISTS [dbo].[Territories];
DROP TABLE IF EXISTS [dbo].[CustomerDemographics];
DROP TABLE IF EXISTS [dbo].[Region];
DROP TABLE IF EXISTS [dbo].[Categories];
DROP TABLE IF EXISTS [dbo].[Suppliers];
DROP TABLE IF EXISTS [dbo].[Shippers];
DROP TABLE IF EXISTS [dbo].[Customers];
DROP TABLE IF EXISTS [dbo].[Employees];
GO

/*==============================================================================
  1. マスタ（被参照側）
==============================================================================*/

/*------------------------------------------------------------------------------
  Employees（社員）
    ReportsTo による自己参照で上司・部下の階層を表す。NULL は最上位。
    Photo / PhotoPath は本システムでは表示・更新の対象外（列は原典どおり保持）。

    アプリで担保する制約
      ・ReportsTo は Employees.EmployeeID に存在すること（VAL-EXISTS）
      ・ReportsTo に自分自身を指定できない。上司をたどる経路に自分自身が
        現れる循環参照を作れない（EMP-T2 / ERR-BIZ）
      ・BirthDate は当日より前。BirthDate <= HireDate（EMP-T3 / VAL-DATE）
      ・受注または部下が存在する社員は削除できない（EMP-T4 / ERR-FK）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Employees] (
    [EmployeeID]      [int] IDENTITY (1, 1) NOT NULL,
    [LastName]        [nvarchar] (20) NOT NULL,
    [FirstName]       [nvarchar] (10) NOT NULL,
    [Title]           [nvarchar] (30) NULL,
    [TitleOfCourtesy] [nvarchar] (25) NULL,
    [BirthDate]       [datetime] NULL,
    [HireDate]        [datetime] NULL,
    [Address]         [nvarchar] (60) NULL,
    [City]            [nvarchar] (15) NULL,
    [Region]          [nvarchar] (15) NULL,   -- 州・県相当の自由入力。[Region] テーブルとは無関係
    [PostalCode]      [nvarchar] (10) NULL,
    [Country]         [nvarchar] (15) NULL,
    [HomePhone]       [nvarchar] (24) NULL,
    [Extension]       [nvarchar] (4)  NULL,
    [Photo]           [image] NULL,
    [Notes]           [ntext] NULL,
    [ReportsTo]       [int] NULL,
    [PhotoPath]       [nvarchar] (255) NULL,
    [RowVersion]      [rowversion] NOT NULL,  -- 追加：楽観排他用
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeID])
);
GO

CREATE INDEX [LastName]              ON [dbo].[Employees] ([LastName]);
CREATE INDEX [PostalCode]            ON [dbo].[Employees] ([PostalCode]);
CREATE INDEX [IX_Employees_ReportsTo] ON [dbo].[Employees] ([ReportsTo]);  -- 組織ツリー・部下有無の判定
GO

/*------------------------------------------------------------------------------
  Categories（カテゴリ）
    Picture は本システムでは表示・更新の対象外（列は原典どおり保持）。

    アプリで担保する制約
      ・CategoryName は一意（CAT-T1 / VAL-DUP）
      ・商品が存在するカテゴリは削除できない（CAT-T2 / ERR-FK）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Categories] (
    [CategoryID]   [int] IDENTITY (1, 1) NOT NULL,
    [CategoryName] [nvarchar] (15) NOT NULL,
    [Description]  [ntext] NULL,
    [Picture]      [image] NULL,
    [RowVersion]   [rowversion] NOT NULL,     -- 追加：楽観排他用
    CONSTRAINT [PK_Categories] PRIMARY KEY CLUSTERED ([CategoryID])
);
GO

CREATE INDEX [CategoryName] ON [dbo].[Categories] ([CategoryName]);
GO

/*------------------------------------------------------------------------------
  Customers（顧客）
    主キーは自動採番ではなく、利用者が入力する英大文字 5 桁のコード。

    アプリで担保する制約
      ・CustomerID は英大文字 5 桁（CUS-T1 / VAL-CODE）、既存と重複しない（VAL-DUP）
      ・受注が存在する顧客は削除できない（CUS-T4 / ERR-FK）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Customers] (
    [CustomerID]   [nchar] (5) NOT NULL,
    [CompanyName]  [nvarchar] (40) NOT NULL,
    [ContactName]  [nvarchar] (30) NULL,
    [ContactTitle] [nvarchar] (30) NULL,
    [Address]      [nvarchar] (60) NULL,
    [City]         [nvarchar] (15) NULL,
    [Region]       [nvarchar] (15) NULL,      -- 州・県相当の自由入力。[Region] テーブルとは無関係
    [PostalCode]   [nvarchar] (10) NULL,
    [Country]      [nvarchar] (15) NULL,
    [Phone]        [nvarchar] (24) NULL,
    [Fax]          [nvarchar] (24) NULL,
    [RowVersion]   [rowversion] NOT NULL,     -- 追加：楽観排他用
    CONSTRAINT [PK_Customers] PRIMARY KEY CLUSTERED ([CustomerID])
);
GO

CREATE INDEX [City]        ON [dbo].[Customers] ([City]);
CREATE INDEX [CompanyName] ON [dbo].[Customers] ([CompanyName]);
CREATE INDEX [PostalCode]  ON [dbo].[Customers] ([PostalCode]);
CREATE INDEX [Region]      ON [dbo].[Customers] ([Region]);
GO

/*------------------------------------------------------------------------------
  Shippers（運送会社）

    アプリで担保する制約
      ・受注が存在する運送会社は削除できない（SHP-T1 / ERR-FK）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Shippers] (
    [ShipperID]   [int] IDENTITY (1, 1) NOT NULL,
    [CompanyName] [nvarchar] (40) NOT NULL,
    [Phone]       [nvarchar] (24) NULL,
    [RowVersion]  [rowversion] NOT NULL,      -- 追加：楽観排他用
    CONSTRAINT [PK_Shippers] PRIMARY KEY CLUSTERED ([ShipperID])
);
GO

/*------------------------------------------------------------------------------
  Suppliers（仕入先）

    アプリで担保する制約
      ・商品が存在する仕入先は削除できない（SUP-T1 / ERR-FK）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Suppliers] (
    [SupplierID]   [int] IDENTITY (1, 1) NOT NULL,
    [CompanyName]  [nvarchar] (40) NOT NULL,
    [ContactName]  [nvarchar] (30) NULL,
    [ContactTitle] [nvarchar] (30) NULL,
    [Address]      [nvarchar] (60) NULL,
    [City]         [nvarchar] (15) NULL,
    [Region]       [nvarchar] (15) NULL,      -- 州・県相当の自由入力。[Region] テーブルとは無関係
    [PostalCode]   [nvarchar] (10) NULL,
    [Country]      [nvarchar] (15) NULL,
    [Phone]        [nvarchar] (24) NULL,
    [Fax]          [nvarchar] (24) NULL,
    [HomePage]     [ntext] NULL,
    [RowVersion]   [rowversion] NOT NULL,     -- 追加：楽観排他用
    CONSTRAINT [PK_Suppliers] PRIMARY KEY CLUSTERED ([SupplierID])
);
GO

CREATE INDEX [CompanyName] ON [dbo].[Suppliers] ([CompanyName]);
CREATE INDEX [PostalCode]  ON [dbo].[Suppliers] ([PostalCode]);
GO

/*------------------------------------------------------------------------------
  Region（地域）
    RegionID は自動採番ではない。値を指定して登録する。
    本システムでは参照のみのため [RowVersion] を追加しない。
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Region] (
    [RegionID]          [int] NOT NULL,
    [RegionDescription] [nchar] (50) NOT NULL,
    CONSTRAINT [PK_Region] PRIMARY KEY NONCLUSTERED ([RegionID])
);
GO

/*------------------------------------------------------------------------------
  Territories（テリトリー）
    本システムでは参照のみのため [RowVersion] を追加しない。

    アプリで担保する制約
      ・RegionID は Region.RegionID に存在すること（VAL-EXISTS）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Territories] (
    [TerritoryID]          [nvarchar] (20) NOT NULL,
    [TerritoryDescription] [nchar] (50) NOT NULL,
    [RegionID]             [int] NOT NULL,
    CONSTRAINT [PK_Territories] PRIMARY KEY NONCLUSTERED ([TerritoryID])
);
GO

CREATE INDEX [IX_Territories_RegionID] ON [dbo].[Territories] ([RegionID]);  -- 地域別集計・存在確認
GO

/*------------------------------------------------------------------------------
  CustomerDemographics（顧客区分）
    原典ではデータが投入されていない。本システムでは参照のみ。
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[CustomerDemographics] (
    [CustomerTypeID] [nchar] (10) NOT NULL,
    [CustomerDesc]   [ntext] NULL,
    CONSTRAINT [PK_CustomerDemographics] PRIMARY KEY NONCLUSTERED ([CustomerTypeID])
);
GO

/*==============================================================================
  2. 関連テーブル
==============================================================================*/

/*------------------------------------------------------------------------------
  EmployeeTerritories（社員・テリトリー関連）
    関連の付け外しのみのため [RowVersion] を追加しない。

    アプリで担保する制約
      ・EmployeeID / TerritoryID がそれぞれのマスタに存在すること（VAL-EXISTS）
      ・同一の組み合わせを重複して登録しない（ET-T3 / VAL-DUP。主キーでも防がれる）
      ・社員の削除時にあわせて削除する（ET-T2）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[EmployeeTerritories] (
    [EmployeeID]  [int] NOT NULL,
    [TerritoryID] [nvarchar] (20) NOT NULL,
    CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED ([EmployeeID], [TerritoryID])
);
GO

-- EmployeeID は主キーの先頭列で代替できるため索引を追加しない
CREATE INDEX [IX_EmployeeTerritories_TerritoryID] ON [dbo].[EmployeeTerritories] ([TerritoryID]);
GO

/*------------------------------------------------------------------------------
  CustomerCustomerDemo（顧客・顧客区分関連）
    関連の付け外しのみのため [RowVersion] を追加しない。

    アプリで担保する制約
      ・CustomerID / CustomerTypeID がそれぞれのマスタに存在すること（VAL-EXISTS）
      ・顧客の削除時にあわせて削除する（CCD-T2）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[CustomerCustomerDemo] (
    [CustomerID]     [nchar] (5) NOT NULL,
    [CustomerTypeID] [nchar] (10) NOT NULL,
    CONSTRAINT [PK_CustomerCustomerDemo] PRIMARY KEY NONCLUSTERED ([CustomerID], [CustomerTypeID])
);
GO

CREATE INDEX [IX_CustomerCustomerDemo_CustomerTypeID]
    ON [dbo].[CustomerCustomerDemo] ([CustomerTypeID]);
GO

/*==============================================================================
  3. 商品
==============================================================================*/

/*------------------------------------------------------------------------------
  Products（商品）
    Discontinued（廃番）が真のとき新規受注に使用できない。
    低在庫の判定は UnitsInStock <= ReorderLevel。

    アプリで担保する制約
      ・SupplierID / CategoryID がそれぞれのマスタに存在すること（VAL-EXISTS）
      ・UnitPrice >= 0、UnitsInStock >= 0、UnitsOnOrder >= 0、ReorderLevel >= 0
        （VAL-NUMERIC）
      ・出荷確定時の在庫引落で負にならないこと（PRD-T5 / ERR-BIZ）
      ・受注明細が存在する商品は削除できない（PRD-T6 / ERR-FK）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Products] (
    [ProductID]       [int] IDENTITY (1, 1) NOT NULL,
    [ProductName]     [nvarchar] (40) NOT NULL,
    [SupplierID]      [int] NULL,
    [CategoryID]      [int] NULL,
    [QuantityPerUnit] [nvarchar] (20) NULL,   -- 荷姿の記述。文字列であり計算に用いない
    [UnitPrice]       [money] NULL
        CONSTRAINT [DF_Products_UnitPrice]    DEFAULT (0),
    [UnitsInStock]    [smallint] NULL
        CONSTRAINT [DF_Products_UnitsInStock] DEFAULT (0),
    [UnitsOnOrder]    [smallint] NULL
        CONSTRAINT [DF_Products_UnitsOnOrder] DEFAULT (0),
    [ReorderLevel]    [smallint] NULL
        CONSTRAINT [DF_Products_ReorderLevel] DEFAULT (0),
    [Discontinued]    [bit] NOT NULL
        CONSTRAINT [DF_Products_Discontinued] DEFAULT (0),
    [RowVersion]      [rowversion] NOT NULL,  -- 追加：楽観排他用
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID])
);
GO

CREATE INDEX [CategoryID]  ON [dbo].[Products] ([CategoryID]);
CREATE INDEX [SupplierID]  ON [dbo].[Products] ([SupplierID]);
CREATE INDEX [ProductName] ON [dbo].[Products] ([ProductName]);
GO

/*==============================================================================
  4. 受注
==============================================================================*/

/*------------------------------------------------------------------------------
  Orders（受注）
    ShippedDate が NULL の受注を「未出荷」とする。
    出荷先情報（Ship*）は受注時点の値を保持し、顧客マスタの変更を遡及させない。

    アプリで担保する制約
      ・CustomerID / EmployeeID / ShipVia がそれぞれのマスタに存在すること（VAL-EXISTS）
      ・新規登録では CustomerID / EmployeeID / OrderDate を必須とする
        （ORD-T1 / VAL-REQUIRED。原典では NULL 可のため DB では強制しない）
      ・OrderDate <= RequiredDate、OrderDate <= ShippedDate（ORD-T3 / VAL-DATE）
      ・受注は 1 件以上の明細を持つ（ORD-T5 / ERR-BIZ）
      ・削除は Order Details を先に削除してから Orders を削除する
        （ORD-T8。CASCADE を使わず、同一トランザクションでアプリが順に実行する）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Orders] (
    [OrderID]        [int] IDENTITY (1, 1) NOT NULL,
    [CustomerID]     [nchar] (5) NULL,
    [EmployeeID]     [int] NULL,
    [OrderDate]      [datetime] NULL,
    [RequiredDate]   [datetime] NULL,
    [ShippedDate]    [datetime] NULL,         -- NULL は未出荷を意味する
    [ShipVia]        [int] NULL,
    [Freight]        [money] NULL
        CONSTRAINT [DF_Orders_Freight] DEFAULT (0),
    [ShipName]       [nvarchar] (40) NULL,
    [ShipAddress]    [nvarchar] (60) NULL,
    [ShipCity]       [nvarchar] (15) NULL,
    [ShipRegion]     [nvarchar] (15) NULL,    -- 州・県相当の自由入力。[Region] テーブルとは無関係
    [ShipPostalCode] [nvarchar] (10) NULL,
    [ShipCountry]    [nvarchar] (15) NULL,
    [RowVersion]     [rowversion] NOT NULL,   -- 追加：楽観排他用
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID])
);
GO

CREATE INDEX [CustomerID]      ON [dbo].[Orders] ([CustomerID]);
CREATE INDEX [EmployeeID]      ON [dbo].[Orders] ([EmployeeID]);
CREATE INDEX [OrderDate]       ON [dbo].[Orders] ([OrderDate]);
CREATE INDEX [ShippedDate]     ON [dbo].[Orders] ([ShippedDate]);
CREATE INDEX [ShipPostalCode]  ON [dbo].[Orders] ([ShipPostalCode]);
CREATE INDEX [ShippersOrders]  ON [dbo].[Orders] ([ShipVia]);   -- 配送管理の運送会社別集計用
GO

/*------------------------------------------------------------------------------
  Order Details（受注明細）
    主キーが (OrderID, ProductID) のため、同一受注内に同じ商品を 2 行登録できない。
    UnitPrice / Discount は受注時点の値を保持する。

    アプリで担保する制約
      ・OrderID / ProductID がそれぞれのマスタに存在すること（VAL-EXISTS）
      ・UnitPrice >= 0、Quantity > 0、Discount は 0〜1（VAL-NUMERIC）
      ・同一受注内で商品が重複しないこと（OD-T1 / ERR-BIZ。主キーでも防がれる）
      ・廃番商品を新規明細に指定しないこと（OD-T3 / ERR-BIZ）
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Order Details] (
    [OrderID]    [int] NOT NULL,
    [ProductID]  [int] NOT NULL,
    [UnitPrice]  [money] NOT NULL
        CONSTRAINT [DF_Order_Details_UnitPrice] DEFAULT (0),
    [Quantity]   [smallint] NOT NULL
        CONSTRAINT [DF_Order_Details_Quantity] DEFAULT (1),
    [Discount]   [real] NOT NULL
        CONSTRAINT [DF_Order_Details_Discount] DEFAULT (0),
    [RowVersion] [rowversion] NOT NULL,       -- 追加：楽観排他用
    CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED ([OrderID], [ProductID])
);
GO

-- OrderID は主キーの先頭列で代替できるが、原典の索引構成を踏襲して残す
CREATE INDEX [OrderID]   ON [dbo].[Order Details] ([OrderID]);
CREATE INDEX [ProductID] ON [dbo].[Order Details] ([ProductID]);
GO

/*==============================================================================
  5. 追加テーブル
==============================================================================*/

/*------------------------------------------------------------------------------
  SalesTargets（売上目標）※ 本設計での追加テーブル

    アプリで担保する制約
      ・EmployeeID が Employees に存在すること（VAL-EXISTS）
      ・TargetYear >= 1900、TargetMonth は 1〜12、TargetAmount >= 0（VAL-NUMERIC）
      ・同一社員・同一年月は 1 件のみ（ST-T1 / VAL-DUP。主キーでも防がれる）
      ・社員の削除時にあわせて削除する（ST-T5）

    ・目標が未登録の年月は「目標なし」として扱い、達成率を算出しない。
      0 円の目標とは意味が異なる。
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[SalesTargets] (
    [EmployeeID]   [int] NOT NULL,
    [TargetYear]   [smallint] NOT NULL,
    [TargetMonth]  [tinyint] NOT NULL,
    [TargetAmount] [money] NOT NULL
        CONSTRAINT [DF_SalesTargets_TargetAmount] DEFAULT (0),
    [RowVersion]   [rowversion] NOT NULL,     -- 追加：楽観排他用
    CONSTRAINT [PK_SalesTargets] PRIMARY KEY CLUSTERED
        ([EmployeeID], [TargetYear], [TargetMonth])
);
GO

/*==============================================================================
  6. 作成結果の確認
==============================================================================*/
PRINT N'--- 作成されたテーブル ---';
GO

SELECT  t.name                                       AS [テーブル]
      , (SELECT COUNT(*) FROM sys.columns c
           WHERE c.object_id = t.object_id)          AS [列数]
      , CASE WHEN EXISTS (SELECT 1 FROM sys.columns c
                           WHERE c.object_id = t.object_id
                             AND c.name = N'RowVersion')
             THEN N'あり' ELSE N'なし' END           AS [RowVersion]
FROM    sys.tables AS t
WHERE   t.schema_id = SCHEMA_ID(N'dbo')
ORDER BY t.name;
GO

PRINT N'--- 制約方針の確認（1〜5 はすべて 0 件であること） ---';
GO

SELECT N'1. 外部キー制約'   AS [制約], CAST(COUNT(*) AS varchar(10)) AS [件数], N'0' AS [期待]
FROM sys.foreign_keys
UNION ALL SELECT N'2. CASCADE 動作',  CAST(COUNT(*) AS varchar(10)), N'0'
FROM sys.foreign_keys WHERE delete_referential_action <> 0 OR update_referential_action <> 0
UNION ALL SELECT N'3. CHECK 制約',    CAST(COUNT(*) AS varchar(10)), N'0'
FROM sys.check_constraints
UNION ALL SELECT N'4. UNIQUE 制約',   CAST(COUNT(*) AS varchar(10)), N'0'
FROM sys.key_constraints WHERE type = 'UQ'
UNION ALL SELECT N'5. トリガー',      CAST(COUNT(*) AS varchar(10)), N'0'
FROM sys.triggers WHERE is_ms_shipped = 0
UNION ALL SELECT N'（残すもの）主キー',   CAST(COUNT(*) AS varchar(10)), N'14'
FROM sys.key_constraints WHERE type = 'PK'
UNION ALL SELECT N'（残すもの）既定値',   CAST(COUNT(*) AS varchar(10)), N'10'
FROM sys.default_constraints
UNION ALL SELECT N'（残すもの）索引',     CAST(COUNT(*) AS varchar(10)), N'24'
FROM sys.indexes i JOIN sys.tables t ON t.object_id = i.object_id
WHERE i.is_primary_key = 0 AND i.type > 0;
GO

PRINT N'02_CreateTables.sql : 完了（14 テーブル）';
GO
