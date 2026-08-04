/*==============================================================================
  NorthwindDbSampleSpec : テーブル定義（DDL）
  --------------------------------------------------------------------------
  対象  : Microsoft SQL Server
  実行順: 01_CreateDatabase.sql → 02_CreateTables.sql → 03_InsertData.sql

  仕様  : ../../LLD/TableSchema.md および配下のテーブル定義書
          共通仕様（原典への追加）: ../../HLD/Common.md の 9 節

  原典  : microsoft/sql-server-samples の northwind-pubs / instnwnd.sql（MIT）
          https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs

  原典との差分は次の 2 点のみ。列の削除・改名・型変更は行っていない。
    (1) 楽観排他用の [RowVersion] rowversion 列を、更新対象の 9 テーブルへ追加
          Orders / Order Details / Customers / Products / Categories /
          Suppliers / Employees / Shippers / SalesTargets
        参照または関連の付け外しのみを行う次のテーブルには追加しない。
          Region / Territories / EmployeeTerritories /
          CustomerDemographics / CustomerCustomerDemo
    (2) パフォーマンス分析（目標設定・進捗トラッキング）のため
        [SalesTargets] テーブルを追加

  本スクリプトは再実行可能。既存のテーブルを削除してから作成する。
==============================================================================*/

USE [Northwind];
GO

SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
GO

/*------------------------------------------------------------------------------
  0. 既存テーブルの削除（外部キーの逆順）
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
    CONSTRAINT [PK_Employees] PRIMARY KEY CLUSTERED ([EmployeeID]),
    CONSTRAINT [FK_Employees_Employees] FOREIGN KEY ([ReportsTo])
        REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [CK_Birthdate] CHECK ([BirthDate] < GETDATE())
);
GO

CREATE INDEX [LastName]   ON [dbo].[Employees] ([LastName]);
CREATE INDEX [PostalCode] ON [dbo].[Employees] ([PostalCode]);
GO

/*------------------------------------------------------------------------------
  Categories（カテゴリ）
    Picture は本システムでは表示・更新の対象外（列は原典どおり保持）。
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
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[Territories] (
    [TerritoryID]          [nvarchar] (20) NOT NULL,
    [TerritoryDescription] [nchar] (50) NOT NULL,
    [RegionID]             [int] NOT NULL,
    CONSTRAINT [PK_Territories] PRIMARY KEY NONCLUSTERED ([TerritoryID]),
    CONSTRAINT [FK_Territories_Region] FOREIGN KEY ([RegionID])
        REFERENCES [dbo].[Region] ([RegionID])
);
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
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[EmployeeTerritories] (
    [EmployeeID]  [int] NOT NULL,
    [TerritoryID] [nvarchar] (20) NOT NULL,
    CONSTRAINT [PK_EmployeeTerritories] PRIMARY KEY NONCLUSTERED ([EmployeeID], [TerritoryID]),
    CONSTRAINT [FK_EmployeeTerritories_Employees] FOREIGN KEY ([EmployeeID])
        REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_EmployeeTerritories_Territories] FOREIGN KEY ([TerritoryID])
        REFERENCES [dbo].[Territories] ([TerritoryID])
);
GO

/*------------------------------------------------------------------------------
  CustomerCustomerDemo（顧客・顧客区分関連）
    関連の付け外しのみのため [RowVersion] を追加しない。
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[CustomerCustomerDemo] (
    [CustomerID]     [nchar] (5) NOT NULL,
    [CustomerTypeID] [nchar] (10) NOT NULL,
    CONSTRAINT [PK_CustomerCustomerDemo] PRIMARY KEY NONCLUSTERED ([CustomerID], [CustomerTypeID]),
    CONSTRAINT [FK_CustomerCustomerDemo_Customers] FOREIGN KEY ([CustomerID])
        REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_CustomerCustomerDemo] FOREIGN KEY ([CustomerTypeID])
        REFERENCES [dbo].[CustomerDemographics] ([CustomerTypeID])
);
GO

/*==============================================================================
  3. 商品
==============================================================================*/

/*------------------------------------------------------------------------------
  Products（商品）
    Discontinued（廃番）が真のとき新規受注に使用できない。
    低在庫の判定は UnitsInStock <= ReorderLevel。
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
    CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED ([ProductID]),
    CONSTRAINT [FK_Products_Suppliers] FOREIGN KEY ([SupplierID])
        REFERENCES [dbo].[Suppliers] ([SupplierID]),
    CONSTRAINT [FK_Products_Categories] FOREIGN KEY ([CategoryID])
        REFERENCES [dbo].[Categories] ([CategoryID]),
    CONSTRAINT [CK_Products_UnitPrice] CHECK ([UnitPrice] >= 0),
    CONSTRAINT [CK_UnitsInStock]       CHECK ([UnitsInStock] >= 0),
    CONSTRAINT [CK_UnitsOnOrder]       CHECK ([UnitsOnOrder] >= 0),
    CONSTRAINT [CK_ReorderLevel]       CHECK ([ReorderLevel] >= 0)
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
    CONSTRAINT [PK_Orders] PRIMARY KEY CLUSTERED ([OrderID]),
    CONSTRAINT [FK_Orders_Customers] FOREIGN KEY ([CustomerID])
        REFERENCES [dbo].[Customers] ([CustomerID]),
    CONSTRAINT [FK_Orders_Employees] FOREIGN KEY ([EmployeeID])
        REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [FK_Orders_Shippers] FOREIGN KEY ([ShipVia])
        REFERENCES [dbo].[Shippers] ([ShipperID])
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
    CONSTRAINT [PK_Order_Details] PRIMARY KEY CLUSTERED ([OrderID], [ProductID]),
    CONSTRAINT [FK_Order_Details_Orders] FOREIGN KEY ([OrderID])
        REFERENCES [dbo].[Orders] ([OrderID]),
    CONSTRAINT [FK_Order_Details_Products] FOREIGN KEY ([ProductID])
        REFERENCES [dbo].[Products] ([ProductID]),
    CONSTRAINT [CK_UnitPrice] CHECK ([UnitPrice] >= 0),
    CONSTRAINT [CK_Quantity]  CHECK ([Quantity] > 0),
    CONSTRAINT [CK_Discount]  CHECK ([Discount] >= 0 AND [Discount] <= 1)
);
GO

CREATE INDEX [OrderID]   ON [dbo].[Order Details] ([OrderID]);
CREATE INDEX [ProductID] ON [dbo].[Order Details] ([ProductID]);
GO

/*==============================================================================
  5. 追加テーブル
==============================================================================*/

/*------------------------------------------------------------------------------
  SalesTargets（売上目標）※ 本設計での追加テーブル
    パフォーマンス分析の「目標設定・進捗トラッキング」要件は原典のテーブルだけ
    では満たせないため追加する。採番用の代理キーは設けず、業務キーを主キーとする。

    ・目標が未登録の年月は「目標なし」として扱い、達成率を算出しない。
      0 円の目標とは意味が異なる。
    ・実績は「当該社員が担当する受注のうち、受注日が対象年月に含まれるものの
      明細金額合計」（送料を含まない）。
------------------------------------------------------------------------------*/
CREATE TABLE [dbo].[SalesTargets] (
    [EmployeeID]   [int] NOT NULL,
    [TargetYear]   [smallint] NOT NULL,
    [TargetMonth]  [tinyint] NOT NULL,
    [TargetAmount] [money] NOT NULL
        CONSTRAINT [DF_SalesTargets_TargetAmount] DEFAULT (0),
    [RowVersion]   [rowversion] NOT NULL,     -- 追加：楽観排他用
    CONSTRAINT [PK_SalesTargets] PRIMARY KEY CLUSTERED
        ([EmployeeID], [TargetYear], [TargetMonth]),
    CONSTRAINT [FK_SalesTargets_Employees] FOREIGN KEY ([EmployeeID])
        REFERENCES [dbo].[Employees] ([EmployeeID]),
    CONSTRAINT [CK_SalesTargets_Year]   CHECK ([TargetYear] >= 1900),
    CONSTRAINT [CK_SalesTargets_Month]  CHECK ([TargetMonth] BETWEEN 1 AND 12),
    CONSTRAINT [CK_SalesTargets_Amount] CHECK ([TargetAmount] >= 0)
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

PRINT N'02_CreateTables.sql : 完了（14 テーブル）';
GO
