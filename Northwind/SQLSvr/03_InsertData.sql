/*==============================================================================
  NorthwindDbSampleSpec : データ投入（DML）
  --------------------------------------------------------------------------
  対象  : Microsoft SQL Server
  実行順: 01_CreateDatabase.sql -> 02_CreateTables.sql -> 03_InsertData.sql

  出典  : microsoft/sql-server-samples の northwind-pubs / instnwnd.sql（MIT）
          https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs

  原典データとの差分
    (1) Employees.Photo / Categories.Picture の画像バイナリを NULL とした。
        本システムでは画像を表示・更新の対象外としているため（列は保持）。
    (2) 原典が列名を省略していた Customers / Order Details / Region /
        Territories / EmployeeTerritories に、明示的な列リストを付与した。
        RowVersion 列を追加したため、位置指定の INSERT を避ける必要がある。
    (3) 文字列リテラルをすべて N'' とした（照合順序に依存させないため）。
    (4) SalesTargets（追加テーブル）のサンプルデータを新規に作成した。
    上記以外の値は原典のままで、行数・内容を変更していない。

  【制約方針】
  02_CreateTables.sql の方針により、外部キー制約・CHECK 制約を DB に持たせていない。
  したがって投入順に制約はなく、不正なデータも DB は拒否しない。
  投入後に参照整合性と値の妥当性を明示的に検証する（下部の 2. を参照）。

  本スクリプトは再実行可能。既存データを削除してから投入する。
  日付リテラルは mdy 形式のため SET DATEFORMAT mdy が必須。
==============================================================================*/

USE [Northwind];
GO

SET NOCOUNT ON;
SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
SET DATEFORMAT mdy;   -- 原典の日付リテラルは m/d/yyyy 形式
GO

/*------------------------------------------------------------------------------
  0. 既存データの削除（外部キーの逆順）
------------------------------------------------------------------------------*/
PRINT N'--- 既存データを削除します ---';
GO

DELETE FROM [dbo].[SalesTargets];
DELETE FROM [dbo].[Order Details];
DELETE FROM [dbo].[Orders];
DELETE FROM [dbo].[Products];
DELETE FROM [dbo].[CustomerCustomerDemo];
DELETE FROM [dbo].[Customers];
DELETE FROM [dbo].[EmployeeTerritories];
DELETE FROM [dbo].[Territories];
DELETE FROM [dbo].[Region];
DELETE FROM [dbo].[CustomerDemographics];
DELETE FROM [dbo].[Shippers];
DELETE FROM [dbo].[Suppliers];
DELETE FROM [dbo].[Categories];
DELETE FROM [dbo].[Employees];
GO

/*------------------------------------------------------------------------------
  1. 投入順について
     制約方針により外部キー制約を作成していないため、投入順に制約はない。
     ただし参照関係を追いやすくするため、参照先から順に投入している。
     参照整合性は投入後に 2. で検証する（DB は保証しない）。
------------------------------------------------------------------------------*/


/*------------------------------------------------------------------------------
  Region（地域）: 4 件
------------------------------------------------------------------------------*/
PRINT N'Region を投入します...';
GO

INSERT INTO [dbo].[Region] ([RegionID], [RegionDescription]) VALUES (1, N'Eastern');
INSERT INTO [dbo].[Region] ([RegionID], [RegionDescription]) VALUES (2, N'Western');
INSERT INTO [dbo].[Region] ([RegionID], [RegionDescription]) VALUES (3, N'Northern');
INSERT INTO [dbo].[Region] ([RegionID], [RegionDescription]) VALUES (4, N'Southern');
GO

/*------------------------------------------------------------------------------
  Territories（テリトリー）: 53 件
------------------------------------------------------------------------------*/
PRINT N'Territories を投入します...';
GO

INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'01581', N'Westboro', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'01730', N'Bedford', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'01833', N'Georgetow', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'02116', N'Boston', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'02139', N'Cambridge', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'02184', N'Braintree', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'02903', N'Providence', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'03049', N'Hollis', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'03801', N'Portsmouth', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'06897', N'Wilton', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'07960', N'Morristown', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'08837', N'Edison', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'10019', N'New York', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'10038', N'New York', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'11747', N'Mellvile', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'14450', N'Fairport', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'19428', N'Philadelphia', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'19713', N'Neward', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'20852', N'Rockville', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'27403', N'Greensboro', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'27511', N'Cary', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'29202', N'Columbia', 4);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'30346', N'Atlanta', 4);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'31406', N'Savannah', 4);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'32859', N'Orlando', 4);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'33607', N'Tampa', 4);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'40222', N'Louisville', 1);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'44122', N'Beachwood', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'45839', N'Findlay', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'48075', N'Southfield', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'48084', N'Troy', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'48304', N'Bloomfield Hills', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'53404', N'Racine', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'55113', N'Roseville', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'55439', N'Minneapolis', 3);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'60179', N'Hoffman Estates', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'60601', N'Chicago', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'72716', N'Bentonville', 4);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'75234', N'Dallas', 4);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'78759', N'Austin', 4);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'80202', N'Denver', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'80909', N'Colorado Springs', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'85014', N'Phoenix', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'85251', N'Scottsdale', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'90405', N'Santa Monica', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'94025', N'Menlo Park', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'94105', N'San Francisco', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'95008', N'Campbell', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'95054', N'Santa Clara', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'95060', N'Santa Cruz', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'98004', N'Bellevue', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'98052', N'Redmond', 2);
INSERT INTO [dbo].[Territories] ([TerritoryID], [TerritoryDescription], [RegionID]) VALUES (N'98104', N'Seattle', 2);
GO

/*------------------------------------------------------------------------------
  Categories（カテゴリ）: 8 件
------------------------------------------------------------------------------*/
PRINT N'Categories を投入します...';
GO

SET IDENTITY_INSERT [dbo].[Categories] ON;
GO

INSERT INTO [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (1, N'Beverages', N'Soft drinks, coffees, teas, beers, and ales', NULL);
INSERT INTO [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (2, N'Condiments', N'Sweet and savory sauces, relishes, spreads, and seasonings', NULL);
INSERT INTO [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (3, N'Confections', N'Desserts, candies, and sweet breads', NULL);
INSERT INTO [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (4, N'Dairy Products', N'Cheeses', NULL);
INSERT INTO [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (5, N'Grains/Cereals', N'Breads, crackers, pasta, and cereal', NULL);
INSERT INTO [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (6, N'Meat/Poultry', N'Prepared meats', NULL);
INSERT INTO [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (7, N'Produce', N'Dried fruit and bean curd', NULL);
INSERT INTO [dbo].[Categories] ([CategoryID], [CategoryName], [Description], [Picture]) VALUES (8, N'Seafood', N'Seaweed and fish', NULL);
GO

SET IDENTITY_INSERT [dbo].[Categories] OFF;
GO

/*------------------------------------------------------------------------------
  Suppliers（仕入先）: 29 件
------------------------------------------------------------------------------*/
PRINT N'Suppliers を投入します...';
GO

SET IDENTITY_INSERT [dbo].[Suppliers] ON;
GO

INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (1, N'Exotic Liquids', N'Charlotte Cooper', N'Purchasing Manager', N'49 Gilbert St.', N'London', NULL, N'EC1 4SD', N'UK', N'(171) 555-2222', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (2, N'New Orleans Cajun Delights', N'Shelley Burke', N'Order Administrator', N'P.O. Box 78934', N'New Orleans', N'LA', N'70117', N'USA', N'(100) 555-4822', NULL, N'#CAJUN.HTM#');
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (3, N'Grandma Kelly''s Homestead', N'Regina Murphy', N'Sales Representative', N'707 Oxford Rd.', N'Ann Arbor', N'MI', N'48104', N'USA', N'(313) 555-5735', N'(313) 555-3349', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (4, N'Tokyo Traders', N'Yoshi Nagase', N'Marketing Manager', N'9-8 Sekimai Musashino-shi', N'Tokyo', NULL, N'100', N'Japan', N'(03) 3555-5011', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (5, N'Cooperativa de Quesos ''Las Cabras''', N'Antonio del Valle Saavedra', N'Export Administrator', N'Calle del Rosal 4', N'Oviedo', N'Asturias', N'33007', N'Spain', N'(98) 598 76 54', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (6, N'Mayumi''s', N'Mayumi Ohno', N'Marketing Representative', N'92 Setsuko Chuo-ku', N'Osaka', NULL, N'545', N'Japan', N'(06) 431-7877', NULL, N'Mayumi''s (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/mayumi.htm#');
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (7, N'Pavlova, Ltd.', N'Ian Devling', N'Marketing Manager', N'74 Rose St. Moonie Ponds', N'Melbourne', N'Victoria', N'3058', N'Australia', N'(03) 444-2343', N'(03) 444-6588', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (8, N'Specialty Biscuits, Ltd.', N'Peter Wilson', N'Sales Representative', N'29 King''s Way', N'Manchester', NULL, N'M14 GSD', N'UK', N'(161) 555-4448', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (9, N'PB Knäckebröd AB', N'Lars Peterson', N'Sales Agent', N'Kaloadagatan 13', N'Göteborg', NULL, N'S-345 67', N'Sweden', N'031-987 65 43', N'031-987 65 91', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (10, N'Refrescos Americanas LTDA', N'Carlos Diaz', N'Marketing Manager', N'Av. das Americanas 12.890', N'Sao Paulo', NULL, N'5442', N'Brazil', N'(11) 555 4640', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (11, N'Heli Süßwaren GmbH & Co. KG', N'Petra Winkler', N'Sales Manager', N'Tiergartenstraße 5', N'Berlin', NULL, N'10785', N'Germany', N'(010) 9984510', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (12, N'Plutzer Lebensmittelgroßmärkte AG', N'Martin Bein', N'International Marketing Mgr.', N'Bogenallee 51', N'Frankfurt', NULL, N'60439', N'Germany', N'(069) 992755', NULL, N'Plutzer (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/plutzer.htm#');
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (13, N'Nord-Ost-Fisch Handelsgesellschaft mbH', N'Sven Petersen', N'Coordinator Foreign Markets', N'Frahmredder 112a', N'Cuxhaven', NULL, N'27478', N'Germany', N'(04721) 8713', N'(04721) 8714', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (14, N'Formaggi Fortini s.r.l.', N'Elio Rossi', N'Sales Representative', N'Viale Dante, 75', N'Ravenna', NULL, N'48100', N'Italy', N'(0544) 60323', N'(0544) 60603', N'#FORMAGGI.HTM#');
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (15, N'Norske Meierier', N'Beate Vileid', N'Marketing Manager', N'Hatlevegen 5', N'Sandvika', NULL, N'1320', N'Norway', N'(0)2-953010', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (16, N'Bigfoot Breweries', N'Cheryl Saylor', N'Regional Account Rep.', N'3400 - 8th Avenue Suite 210', N'Bend', N'OR', N'97101', N'USA', N'(503) 555-9931', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (17, N'Svensk Sjöföda AB', N'Michael Björn', N'Sales Representative', N'Brovallavägen 231', N'Stockholm', NULL, N'S-123 45', N'Sweden', N'08-123 45 67', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (18, N'Aux joyeux ecclésiastiques', N'Guylène Nodier', N'Sales Manager', N'203, Rue des Francs-Bourgeois', N'Paris', NULL, N'75004', N'France', N'(1) 03.83.00.68', N'(1) 03.83.00.62', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (19, N'New England Seafood Cannery', N'Robb Merchant', N'Wholesale Account Agent', N'Order Processing Dept. 2100 Paul Revere Blvd.', N'Boston', N'MA', N'02134', N'USA', N'(617) 555-3267', N'(617) 555-3389', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (20, N'Leka Trading', N'Chandra Leka', N'Owner', N'471 Serangoon Loop, Suite #402', N'Singapore', NULL, N'0512', N'Singapore', N'555-8787', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (21, N'Lyngbysild', N'Niels Petersen', N'Sales Manager', N'Lyngbysild Fiskebakken 10', N'Lyngby', NULL, N'2800', N'Denmark', N'43844108', N'43844115', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (22, N'Zaanse Snoepfabriek', N'Dirk Luchte', N'Accounting Manager', N'Verkoop Rijnweg 22', N'Zaandam', NULL, N'9999 ZZ', N'Netherlands', N'(12345) 1212', N'(12345) 1210', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (23, N'Karkki Oy', N'Anne Heikkonen', N'Product Manager', N'Valtakatu 12', N'Lappeenranta', NULL, N'53120', N'Finland', N'(953) 10956', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (24, N'G''day, Mate', N'Wendy Mackenzie', N'Sales Representative', N'170 Prince Edward Parade Hunter''s Hill', N'Sydney', N'NSW', N'2042', N'Australia', N'(02) 555-5914', N'(02) 555-4873', N'G''day Mate (on the World Wide Web)#http://www.microsoft.com/accessdev/sampleapps/gdaymate.htm#');
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (25, N'Ma Maison', N'Jean-Guy Lauzon', N'Marketing Manager', N'2960 Rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada', N'(514) 555-9022', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (26, N'Pasta Buttini s.r.l.', N'Giovanni Giudici', N'Order Administrator', N'Via dei Gelsomini, 153', N'Salerno', NULL, N'84100', N'Italy', N'(089) 6547665', N'(089) 6547667', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (27, N'Escargots Nouveaux', N'Marie Delamare', N'Sales Manager', N'22, rue H. Voiron', N'Montceau', NULL, N'71300', N'France', N'85.57.00.07', NULL, NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (28, N'Gai pâturage', N'Eliane Noz', N'Sales Representative', N'Bat. B 3, rue des Alpes', N'Annecy', NULL, N'74000', N'France', N'38.76.98.06', N'38.76.98.58', NULL);
INSERT INTO [dbo].[Suppliers] ([SupplierID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax], [HomePage]) VALUES (29, N'Forêts d''érables', N'Chantal Goulet', N'Accounting Manager', N'148 rue Chasseur', N'Ste-Hyacinthe', N'Québec', N'J2S 7S8', N'Canada', N'(514) 555-2955', N'(514) 555-2921', NULL);
GO

SET IDENTITY_INSERT [dbo].[Suppliers] OFF;
GO

/*------------------------------------------------------------------------------
  Shippers（運送会社）: 3 件
------------------------------------------------------------------------------*/
PRINT N'Shippers を投入します...';
GO

SET IDENTITY_INSERT [dbo].[Shippers] ON;
GO

INSERT INTO [dbo].[Shippers] ([ShipperID], [CompanyName], [Phone]) VALUES (1, N'Speedy Express', N'(503) 555-9831');
INSERT INTO [dbo].[Shippers] ([ShipperID], [CompanyName], [Phone]) VALUES (2, N'United Package', N'(503) 555-3199');
INSERT INTO [dbo].[Shippers] ([ShipperID], [CompanyName], [Phone]) VALUES (3, N'Federal Shipping', N'(503) 555-9931');
GO

SET IDENTITY_INSERT [dbo].[Shippers] OFF;
GO

/*------------------------------------------------------------------------------
  Employees（社員）: 9 件
------------------------------------------------------------------------------*/
PRINT N'Employees を投入します...';
GO

SET IDENTITY_INSERT [dbo].[Employees] ON;
GO

INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (1, N'Davolio', N'Nancy', N'Sales Representative', N'Ms.', N'12/08/1948', N'05/01/1992', N'507 - 20th Ave. E.Apt. 2A', N'Seattle', N'WA', N'98122', N'USA', N'(206) 555-9857', N'5467', NULL, N'Education includes a BA in psychology from Colorado State University in 1970. She also completed "The Art of the Cold Call." Nancy is a member of Toastmasters International.', 2, N'http://accweb/emmployees/davolio.bmp');
INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (2, N'Fuller', N'Andrew', N'Vice President, Sales', N'Dr.', N'02/19/1952', N'08/14/1992', N'908 W. Capital Way', N'Tacoma', N'WA', N'98401', N'USA', N'(206) 555-9482', N'3457', NULL, N'Andrew received his BTS commercial in 1974 and a Ph.D. in international marketing from the University of Dallas in 1981. He is fluent in French and Italian and reads German. He joined the company as a sales representative, was promoted to sales manager in January 1992 and to vice president of sales in March 1993. Andrew is a member of the Sales Management Roundtable, the Seattle Chamber of Commerce, and the Pacific Rim Importers Association.', NULL, N'http://accweb/emmployees/fuller.bmp');
INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (3, N'Leverling', N'Janet', N'Sales Representative', N'Ms.', N'08/30/1963', N'04/01/1992', N'722 Moss Bay Blvd.', N'Kirkland', N'WA', N'98033', N'USA', N'(206) 555-3412', N'3355', NULL, N'Janet has a BS degree in chemistry from Boston College (1984). She has also completed a certificate program in food retailing management. Janet was hired as a sales associate in 1991 and promoted to sales representative in February 1992.', 2, N'http://accweb/emmployees/leverling.bmp');
INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (4, N'Peacock', N'Margaret', N'Sales Representative', N'Mrs.', N'09/19/1937', N'05/03/1993', N'4110 Old Redmond Rd.', N'Redmond', N'WA', N'98052', N'USA', N'(206) 555-8122', N'5176', NULL, N'Margaret holds a BA in English literature from Concordia College (1958) and an MA from the American Institute of Culinary Arts (1966). She was assigned to the London office temporarily from July through November 1992.', 2, N'http://accweb/emmployees/peacock.bmp');
INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (5, N'Buchanan', N'Steven', N'Sales Manager', N'Mr.', N'03/04/1955', N'10/17/1993', N'14 Garrett Hill', N'London', NULL, N'SW1 8JR', N'UK', N'(71) 555-4848', N'3453', NULL, N'Steven Buchanan graduated from St. Andrews University, Scotland, with a BSC degree in 1976. Upon joining the company as a sales representative in 1992, he spent 6 months in an orientation program at the Seattle office and then returned to his permanent post in London. He was promoted to sales manager in March 1993. Mr. Buchanan has completed the courses "Successful Telemarketing" and "International Sales Management." He is fluent in French.', 2, N'http://accweb/emmployees/buchanan.bmp');
INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (6, N'Suyama', N'Michael', N'Sales Representative', N'Mr.', N'07/02/1963', N'10/17/1993', N'Coventry House Miner Rd.', N'London', NULL, N'EC2 7JR', N'UK', N'(71) 555-7773', N'428', NULL, N'Michael is a graduate of Sussex University (MA, economics, 1983) and the University of California at Los Angeles (MBA, marketing, 1986). He has also taken the courses "Multi-Cultural Selling" and "Time Management for the Sales Professional." He is fluent in Japanese and can read and write French, Portuguese, and Spanish.', 5, N'http://accweb/emmployees/davolio.bmp');
INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (7, N'King', N'Robert', N'Sales Representative', N'Mr.', N'05/29/1960', N'01/02/1994', N'Edgeham Hollow Winchester Way', N'London', NULL, N'RG1 9SP', N'UK', N'(71) 555-5598', N'465', NULL, N'Robert King served in the Peace Corps and traveled extensively before completing his degree in English at the University of Michigan in 1992, the year he joined the company. After completing a course entitled "Selling in Europe," he was transferred to the London office in March 1993.', 5, N'http://accweb/emmployees/davolio.bmp');
INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (8, N'Callahan', N'Laura', N'Inside Sales Coordinator', N'Ms.', N'01/09/1958', N'03/05/1994', N'4726 - 11th Ave. N.E.', N'Seattle', N'WA', N'98105', N'USA', N'(206) 555-1189', N'2344', NULL, N'Laura received a BA in psychology from the University of Washington. She has also completed a course in business French. She reads and writes French.', 2, N'http://accweb/emmployees/davolio.bmp');
INSERT INTO [dbo].[Employees] ([EmployeeID], [LastName], [FirstName], [Title], [TitleOfCourtesy], [BirthDate], [HireDate], [Address], [City], [Region], [PostalCode], [Country], [HomePhone], [Extension], [Photo], [Notes], [ReportsTo], [PhotoPath]) VALUES (9, N'Dodsworth', N'Anne', N'Sales Representative', N'Ms.', N'01/27/1966', N'11/15/1994', N'7 Houndstooth Rd.', N'London', NULL, N'WG2 7LT', N'UK', N'(71) 555-4444', N'452', NULL, N'Anne has a BA degree in English from St. Lawrence College. She is fluent in French and German.', 5, N'http://accweb/emmployees/davolio.bmp');
GO

SET IDENTITY_INSERT [dbo].[Employees] OFF;
GO

/*------------------------------------------------------------------------------
  EmployeeTerritories（社員・テリトリー関連）: 49 件
------------------------------------------------------------------------------*/
PRINT N'EmployeeTerritories を投入します...';
GO

INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (1, N'06897');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (1, N'19713');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (2, N'01581');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (2, N'01730');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (2, N'01833');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (2, N'02116');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (2, N'02139');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (2, N'02184');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (2, N'40222');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (3, N'30346');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (3, N'31406');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (3, N'32859');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (3, N'33607');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (4, N'20852');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (4, N'27403');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (4, N'27511');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (5, N'02903');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (5, N'07960');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (5, N'08837');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (5, N'10019');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (5, N'10038');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (5, N'11747');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (5, N'14450');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (6, N'85014');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (6, N'85251');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (6, N'98004');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (6, N'98052');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (6, N'98104');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'60179');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'60601');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'80202');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'80909');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'90405');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'94025');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'94105');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'95008');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'95054');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (7, N'95060');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (8, N'19428');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (8, N'44122');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (8, N'45839');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (8, N'53404');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (9, N'03049');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (9, N'03801');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (9, N'48075');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (9, N'48084');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (9, N'48304');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (9, N'55113');
INSERT INTO [dbo].[EmployeeTerritories] ([EmployeeID], [TerritoryID]) VALUES (9, N'55439');
GO

/*------------------------------------------------------------------------------
  Customers（顧客）: 91 件
------------------------------------------------------------------------------*/
PRINT N'Customers を投入します...';
GO

INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'ALFKI', N'Alfreds Futterkiste', N'Maria Anders', N'Sales Representative', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany', N'030-0074321', N'030-0076545');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'ANATR', N'Ana Trujillo Emparedados y helados', N'Ana Trujillo', N'Owner', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico', N'(5) 555-4729', N'(5) 555-3745');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'ANTON', N'Antonio Moreno Taquería', N'Antonio Moreno', N'Owner', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico', N'(5) 555-3932', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'AROUT', N'Around the Horn', N'Thomas Hardy', N'Sales Representative', N'120 Hanover Sq.', N'London', NULL, N'WA1 1DP', N'UK', N'(171) 555-7788', N'(171) 555-6750');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'BERGS', N'Berglunds snabbköp', N'Christina Berglund', N'Order Administrator', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden', N'0921-12 34 65', N'0921-12 34 67');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'BLAUS', N'Blauer See Delikatessen', N'Hanna Moos', N'Sales Representative', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany', N'0621-08460', N'0621-08924');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'BLONP', N'Blondesddsl père et fils', N'Frédérique Citeaux', N'Marketing Manager', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France', N'88.60.15.31', N'88.60.15.32');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'BOLID', N'Bólido Comidas preparadas', N'Martín Sommer', N'Owner', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain', N'(91) 555 22 82', N'(91) 555 91 99');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'BONAP', N'Bon app''', N'Laurence Lebihan', N'Owner', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France', N'91.24.45.40', N'91.24.45.41');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'BOTTM', N'Bottom-Dollar Markets', N'Elizabeth Lincoln', N'Accounting Manager', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada', N'(604) 555-4729', N'(604) 555-3745');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'BSBEV', N'B''s Beverages', N'Victoria Ashworth', N'Sales Representative', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK', N'(171) 555-1212', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'CACTU', N'Cactus Comidas para llevar', N'Patricio Simpson', N'Sales Agent', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina', N'(1) 135-5555', N'(1) 135-4892');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'CENTC', N'Centro comercial Moctezuma', N'Francisco Chang', N'Marketing Manager', N'Sierras de Granada 9993', N'México D.F.', NULL, N'05022', N'Mexico', N'(5) 555-3392', N'(5) 555-7293');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'CHOPS', N'Chop-suey Chinese', N'Yang Wang', N'Owner', N'Hauptstr. 29', N'Bern', NULL, N'3012', N'Switzerland', N'0452-076545', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'COMMI', N'Comércio Mineiro', N'Pedro Afonso', N'Sales Associate', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil', N'(11) 555-7647', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'CONSH', N'Consolidated Holdings', N'Elizabeth Brown', N'Sales Representative', N'Berkeley Gardens 12 Brewery', N'London', NULL, N'WX1 6LT', N'UK', N'(171) 555-2282', N'(171) 555-9199');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'DRACD', N'Drachenblut Delikatessen', N'Sven Ottlieb', N'Order Administrator', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany', N'0241-039123', N'0241-059428');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'DUMON', N'Du monde entier', N'Janine Labrune', N'Owner', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France', N'40.67.88.88', N'40.67.89.89');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'EASTC', N'Eastern Connection', N'Ann Devon', N'Sales Agent', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK', N'(171) 555-0297', N'(171) 555-3373');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'ERNSH', N'Ernst Handel', N'Roland Mendel', N'Sales Manager', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria', N'7675-3425', N'7675-3426');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'FAMIA', N'Familia Arquibaldo', N'Aria Cruz', N'Marketing Assistant', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil', N'(11) 555-9857', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'FISSA', N'FISSA Fabrica Inter. Salchichas S.A.', N'Diego Roel', N'Accounting Manager', N'C/ Moralzarzal, 86', N'Madrid', NULL, N'28034', N'Spain', N'(91) 555 94 44', N'(91) 555 55 93');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'FOLIG', N'Folies gourmandes', N'Martine Rancé', N'Assistant Sales Agent', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'France', N'20.16.10.16', N'20.16.10.17');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'FOLKO', N'Folk och fä HB', N'Maria Larsson', N'Owner', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden', N'0695-34 67 21', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'FRANK', N'Frankenversand', N'Peter Franken', N'Marketing Manager', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany', N'089-0877310', N'089-0877451');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'FRANR', N'France restauration', N'Carine Schmitt', N'Marketing Manager', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France', N'40.32.21.21', N'40.32.21.20');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'FRANS', N'Franchi S.p.A.', N'Paolo Accorti', N'Sales Representative', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy', N'011-4988260', N'011-4988261');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'FURIB', N'Furia Bacalhau e Frutos do Mar', N'Lino Rodriguez', N'Sales Manager', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal', N'(1) 354-2534', N'(1) 354-2535');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'GALED', N'Galería del gastrónomo', N'Eduardo Saavedra', N'Marketing Manager', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'08022', N'Spain', N'(93) 203 4560', N'(93) 203 4561');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'GODOS', N'Godos Cocina Típica', N'José Pedro Freyre', N'Sales Manager', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain', N'(95) 555 82 82', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'GOURL', N'Gourmet Lanchonetes', N'André Fonseca', N'Sales Associate', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil', N'(11) 555-9482', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'GREAL', N'Great Lakes Food Market', N'Howard Snyder', N'Marketing Manager', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA', N'(503) 555-7555', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'GROSR', N'GROSELLA-Restaurante', N'Manuel Pereira', N'Owner', N'5ª Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela', N'(2) 283-2951', N'(2) 283-3397');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'HANAR', N'Hanari Carnes', N'Mario Pontes', N'Accounting Manager', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil', N'(21) 555-0091', N'(21) 555-8765');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'HILAA', N'HILARION-Abastos', N'Carlos Hernández', N'Sales Representative', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela', N'(5) 555-1340', N'(5) 555-1948');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'HUNGC', N'Hungry Coyote Import Store', N'Yoshi Latimer', N'Sales Representative', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA', N'(503) 555-6874', N'(503) 555-2376');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'HUNGO', N'Hungry Owl All-Night Grocers', N'Patricia McKenna', N'Sales Associate', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland', N'2967 542', N'2967 3333');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'ISLAT', N'Island Trading', N'Helen Bennett', N'Marketing Manager', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK', N'(198) 555-8888', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'KOENE', N'Königlich Essen', N'Philip Cramer', N'Sales Associate', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany', N'0555-09876', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LACOR', N'La corne d''abondance', N'Daniel Tonini', N'Sales Representative', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France', N'30.59.84.10', N'30.59.85.11');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LAMAI', N'La maison d''Asie', N'Annette Roulet', N'Sales Manager', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France', N'61.77.61.10', N'61.77.61.11');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LAUGB', N'Laughing Bacchus Wine Cellars', N'Yoshi Tannamuri', N'Marketing Assistant', N'1900 Oak St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada', N'(604) 555-3392', N'(604) 555-7293');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LAZYK', N'Lazy K Kountry Store', N'John Steel', N'Marketing Manager', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA', N'(509) 555-7969', N'(509) 555-6221');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LEHMS', N'Lehmanns Marktstand', N'Renate Messner', N'Sales Representative', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany', N'069-0245984', N'069-0245874');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LETSS', N'Let''s Stop N Shop', N'Jaime Yorres', N'Owner', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA', N'(415) 555-5938', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LILAS', N'LILA-Supermercado', N'Carlos González', N'Accounting Manager', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela', N'(9) 331-6954', N'(9) 331-7256');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LINOD', N'LINO-Delicateses', N'Felipe Izquierdo', N'Owner', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela', N'(8) 34-56-12', N'(8) 34-93-93');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'LONEP', N'Lonesome Pine Restaurant', N'Fran Wilson', N'Sales Manager', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA', N'(503) 555-9573', N'(503) 555-9646');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'MAGAA', N'Magazzini Alimentari Riuniti', N'Giovanni Rovelli', N'Marketing Manager', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy', N'035-640230', N'035-640231');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'MAISD', N'Maison Dewey', N'Catherine Dewey', N'Sales Agent', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium', N'(02) 201 24 67', N'(02) 201 24 68');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'MEREP', N'Mère Paillarde', N'Jean Fresnière', N'Marketing Assistant', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada', N'(514) 555-8054', N'(514) 555-8055');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'MORGK', N'Morgenstern Gesundkost', N'Alexander Feuer', N'Marketing Assistant', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany', N'0342-023176', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'NORTS', N'North/South', N'Simon Crowther', N'Sales Associate', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK', N'(171) 555-7733', N'(171) 555-2530');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'OCEAN', N'Océano Atlántico Ltda.', N'Yvonne Moncada', N'Sales Agent', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina', N'(1) 135-5333', N'(1) 135-5535');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'OLDWO', N'Old World Delicatessen', N'Rene Phillips', N'Sales Representative', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA', N'(907) 555-7584', N'(907) 555-2880');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'OTTIK', N'Ottilies Käseladen', N'Henriette Pfalzheim', N'Owner', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany', N'0221-0644327', N'0221-0765721');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'PARIS', N'Paris spécialités', N'Marie Bertrand', N'Owner', N'265, boulevard Charonne', N'Paris', NULL, N'75012', N'France', N'(1) 42.34.22.66', N'(1) 42.34.22.77');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'PERIC', N'Pericles Comidas clásicas', N'Guillermo Fernández', N'Sales Representative', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'Mexico', N'(5) 552-3745', N'(5) 545-3745');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'PICCO', N'Piccolo und mehr', N'Georg Pipps', N'Sales Manager', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria', N'6562-9722', N'6562-9723');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'PRINI', N'Princesa Isabel Vinhos', N'Isabel de Castro', N'Sales Representative', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal', N'(1) 356-5634', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'QUEDE', N'Que Delícia', N'Bernardo Batista', N'Accounting Manager', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil', N'(21) 555-4252', N'(21) 555-4545');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'QUEEN', N'Queen Cozinha', N'Lúcia Carvalho', N'Marketing Assistant', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil', N'(11) 555-1189', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'QUICK', N'QUICK-Stop', N'Horst Kloss', N'Accounting Manager', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany', N'0372-035188', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'RANCH', N'Rancho grande', N'Sergio Gutiérrez', N'Sales Representative', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina', N'(1) 123-5555', N'(1) 123-5556');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'RATTC', N'Rattlesnake Canyon Grocery', N'Paula Wilson', N'Assistant Sales Representative', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA', N'(505) 555-5939', N'(505) 555-3620');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'REGGC', N'Reggiani Caseifici', N'Maurizio Moroni', N'Sales Associate', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy', N'0522-556721', N'0522-556722');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'RICAR', N'Ricardo Adocicados', N'Janete Limeira', N'Assistant Sales Agent', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil', N'(21) 555-3412', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'RICSU', N'Richter Supermarkt', N'Michael Holz', N'Sales Manager', N'Grenzacherweg 237', N'Genève', NULL, N'1203', N'Switzerland', N'0897-034214', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'ROMEY', N'Romero y tomillo', N'Alejandra Camino', N'Accounting Manager', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'Spain', N'(91) 745 6200', N'(91) 745 6210');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'SANTG', N'Santé Gourmet', N'Jonas Bergulfsen', N'Owner', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway', N'07-98 92 35', N'07-98 92 47');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'SAVEA', N'Save-a-lot Markets', N'Jose Pavarotti', N'Sales Representative', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA', N'(208) 555-8097', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'SEVES', N'Seven Seas Imports', N'Hari Kumar', N'Sales Manager', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK', N'(171) 555-1717', N'(171) 555-5646');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'SIMOB', N'Simons bistro', N'Jytte Petersen', N'Owner', N'Vinbæltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark', N'31 12 34 56', N'31 13 35 57');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'SPECD', N'Spécialités du monde', N'Dominique Perrier', N'Marketing Manager', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France', N'(1) 47.55.60.10', N'(1) 47.55.60.20');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'SPLIR', N'Split Rail Beer & Ale', N'Art Braunschweiger', N'Sales Manager', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA', N'(307) 555-4680', N'(307) 555-6525');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'SUPRD', N'Suprêmes délices', N'Pascale Cartrain', N'Accounting Manager', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium', N'(071) 23 67 22 20', N'(071) 23 67 22 21');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'THEBI', N'The Big Cheese', N'Liz Nixon', N'Marketing Manager', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA', N'(503) 555-3612', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'THECR', N'The Cracker Box', N'Liu Wong', N'Marketing Assistant', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA', N'(406) 555-5834', N'(406) 555-8083');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'TOMSP', N'Toms Spezialitäten', N'Karin Josephs', N'Marketing Manager', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Germany', N'0251-031259', N'0251-035695');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'TORTU', N'Tortuga Restaurante', N'Miguel Angel Paolino', N'Owner', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico', N'(5) 555-2933', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'TRADH', N'Tradição Hipermercados', N'Anabela Domingues', N'Sales Representative', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil', N'(11) 555-2167', N'(11) 555-2168');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'TRAIH', N'Trail''s Head Gourmet Provisioners', N'Helvetius Nagy', N'Sales Associate', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA', N'(206) 555-8257', N'(206) 555-2174');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'VAFFE', N'Vaffeljernet', N'Palle Ibsen', N'Sales Manager', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark', N'86 21 32 43', N'86 22 33 44');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'VICTE', N'Victuailles en stock', N'Mary Saveley', N'Sales Agent', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France', N'78.32.54.86', N'78.32.54.87');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'VINET', N'Vins et alcools Chevalier', N'Paul Henriot', N'Accounting Manager', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France', N'26.47.15.10', N'26.47.15.11');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'WANDK', N'Die Wandernde Kuh', N'Rita Müller', N'Sales Representative', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany', N'0711-020361', N'0711-035428');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'WARTH', N'Wartian Herkku', N'Pirkko Koskitalo', N'Accounting Manager', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland', N'981-443655', N'981-443655');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'WELLI', N'Wellington Importadora', N'Paula Parente', N'Sales Manager', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil', N'(14) 555-8122', NULL);
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'WHITC', N'White Clover Markets', N'Karl Jablonski', N'Owner', N'305 - 14th Ave. S. Suite 3B', N'Seattle', N'WA', N'98128', N'USA', N'(206) 555-4112', N'(206) 555-4115');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'WILMK', N'Wilman Kala', N'Matti Karttunen', N'Owner/Marketing Assistant', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland', N'90-224 8858', N'90-224 8858');
INSERT INTO [dbo].[Customers] ([CustomerID], [CompanyName], [ContactName], [ContactTitle], [Address], [City], [Region], [PostalCode], [Country], [Phone], [Fax]) VALUES (N'WOLZA', N'Wolski Zajazd', N'Zbyszek Piestrzeniewicz', N'Owner', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland', N'(26) 642-7012', N'(26) 642-7012');
GO

/*------------------------------------------------------------------------------
  Products（商品）: 77 件
------------------------------------------------------------------------------*/
PRINT N'Products を投入します...';
GO

SET IDENTITY_INSERT [dbo].[Products] ON;
GO

INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (1, N'Chai', 1, 1, N'10 boxes x 20 bags', 18, 39, 0, 10, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (2, N'Chang', 1, 1, N'24 - 12 oz bottles', 19, 17, 40, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (3, N'Aniseed Syrup', 1, 2, N'12 - 550 ml bottles', 10, 13, 70, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (4, N'Chef Anton''s Cajun Seasoning', 2, 2, N'48 - 6 oz jars', 22, 53, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (5, N'Chef Anton''s Gumbo Mix', 2, 2, N'36 boxes', 21.35, 0, 0, 0, 1);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (6, N'Grandma''s Boysenberry Spread', 3, 2, N'12 - 8 oz jars', 25, 120, 0, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (7, N'Uncle Bob''s Organic Dried Pears', 3, 7, N'12 - 1 lb pkgs.', 30, 15, 0, 10, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (8, N'Northwoods Cranberry Sauce', 3, 2, N'12 - 12 oz jars', 40, 6, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (9, N'Mishi Kobe Niku', 4, 6, N'18 - 500 g pkgs.', 97, 29, 0, 0, 1);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (10, N'Ikura', 4, 8, N'12 - 200 ml jars', 31, 31, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (11, N'Queso Cabrales', 5, 4, N'1 kg pkg.', 21, 22, 30, 30, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (12, N'Queso Manchego La Pastora', 5, 4, N'10 - 500 g pkgs.', 38, 86, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (13, N'Konbu', 6, 8, N'2 kg box', 6, 24, 0, 5, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (14, N'Tofu', 6, 7, N'40 - 100 g pkgs.', 23.25, 35, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (15, N'Genen Shouyu', 6, 2, N'24 - 250 ml bottles', 15.5, 39, 0, 5, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (16, N'Pavlova', 7, 3, N'32 - 500 g boxes', 17.45, 29, 0, 10, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (17, N'Alice Mutton', 7, 6, N'20 - 1 kg tins', 39, 0, 0, 0, 1);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (18, N'Carnarvon Tigers', 7, 8, N'16 kg pkg.', 62.5, 42, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (19, N'Teatime Chocolate Biscuits', 8, 3, N'10 boxes x 12 pieces', 9.2, 25, 0, 5, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (20, N'Sir Rodney''s Marmalade', 8, 3, N'30 gift boxes', 81, 40, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (21, N'Sir Rodney''s Scones', 8, 3, N'24 pkgs. x 4 pieces', 10, 3, 40, 5, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (22, N'Gustaf''s Knäckebröd', 9, 5, N'24 - 500 g pkgs.', 21, 104, 0, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (23, N'Tunnbröd', 9, 5, N'12 - 250 g pkgs.', 9, 61, 0, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (24, N'Guaraná Fantástica', 10, 1, N'12 - 355 ml cans', 4.5, 20, 0, 0, 1);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (25, N'NuNuCa Nuß-Nougat-Creme', 11, 3, N'20 - 450 g glasses', 14, 76, 0, 30, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (26, N'Gumbär Gummibärchen', 11, 3, N'100 - 250 g bags', 31.23, 15, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (27, N'Schoggi Schokolade', 11, 3, N'100 - 100 g pieces', 43.9, 49, 0, 30, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (28, N'Rössle Sauerkraut', 12, 7, N'25 - 825 g cans', 45.6, 26, 0, 0, 1);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (29, N'Thüringer Rostbratwurst', 12, 6, N'50 bags x 30 sausgs.', 123.79, 0, 0, 0, 1);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (30, N'Nord-Ost Matjeshering', 13, 8, N'10 - 200 g glasses', 25.89, 10, 0, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (31, N'Gorgonzola Telino', 14, 4, N'12 - 100 g pkgs', 12.5, 0, 70, 20, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (32, N'Mascarpone Fabioli', 14, 4, N'24 - 200 g pkgs.', 32, 9, 40, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (33, N'Geitost', 15, 4, N'500 g', 2.5, 112, 0, 20, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (34, N'Sasquatch Ale', 16, 1, N'24 - 12 oz bottles', 14, 111, 0, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (35, N'Steeleye Stout', 16, 1, N'24 - 12 oz bottles', 18, 20, 0, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (36, N'Inlagd Sill', 17, 8, N'24 - 250 g jars', 19, 112, 0, 20, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (37, N'Gravad lax', 17, 8, N'12 - 500 g pkgs.', 26, 11, 50, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (38, N'Côte de Blaye', 18, 1, N'12 - 75 cl bottles', 263.5, 17, 0, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (39, N'Chartreuse verte', 18, 1, N'750 cc per bottle', 18, 69, 0, 5, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (40, N'Boston Crab Meat', 19, 8, N'24 - 4 oz tins', 18.4, 123, 0, 30, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (41, N'Jack''s New England Clam Chowder', 19, 8, N'12 - 12 oz cans', 9.65, 85, 0, 10, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (42, N'Singaporean Hokkien Fried Mee', 20, 5, N'32 - 1 kg pkgs.', 14, 26, 0, 0, 1);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (43, N'Ipoh Coffee', 20, 1, N'16 - 500 g tins', 46, 17, 10, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (44, N'Gula Malacca', 20, 2, N'20 - 2 kg bags', 19.45, 27, 0, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (45, N'Rogede sild', 21, 8, N'1k pkg.', 9.5, 5, 70, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (46, N'Spegesild', 21, 8, N'4 - 450 g glasses', 12, 95, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (47, N'Zaanse koeken', 22, 3, N'10 - 4 oz boxes', 9.5, 36, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (48, N'Chocolade', 22, 3, N'10 pkgs.', 12.75, 15, 70, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (49, N'Maxilaku', 23, 3, N'24 - 50 g pkgs.', 20, 10, 60, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (50, N'Valkoinen suklaa', 23, 3, N'12 - 100 g bars', 16.25, 65, 0, 30, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (51, N'Manjimup Dried Apples', 24, 7, N'50 - 300 g pkgs.', 53, 20, 0, 10, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (52, N'Filo Mix', 24, 5, N'16 - 2 kg boxes', 7, 38, 0, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (53, N'Perth Pasties', 24, 6, N'48 pieces', 32.8, 0, 0, 0, 1);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (54, N'Tourtière', 25, 6, N'16 pies', 7.45, 21, 0, 10, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (55, N'Pâté chinois', 25, 6, N'24 boxes x 2 pies', 24, 115, 0, 20, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (56, N'Gnocchi di nonna Alice', 26, 5, N'24 - 250 g pkgs.', 38, 21, 10, 30, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (57, N'Ravioli Angelo', 26, 5, N'24 - 250 g pkgs.', 19.5, 36, 0, 20, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (58, N'Escargots de Bourgogne', 27, 8, N'24 pieces', 13.25, 62, 0, 20, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (59, N'Raclette Courdavault', 28, 4, N'5 kg pkg.', 55, 79, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (60, N'Camembert Pierrot', 28, 4, N'15 - 300 g rounds', 34, 19, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (61, N'Sirop d''érable', 29, 2, N'24 - 500 ml bottles', 28.5, 113, 0, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (62, N'Tarte au sucre', 29, 3, N'48 pies', 49.3, 17, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (63, N'Vegie-spread', 7, 2, N'15 - 625 g jars', 43.9, 24, 0, 5, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (64, N'Wimmers gute Semmelknödel', 12, 5, N'20 bags x 4 pieces', 33.25, 22, 80, 30, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (65, N'Louisiana Fiery Hot Pepper Sauce', 2, 2, N'32 - 8 oz bottles', 21.05, 76, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (66, N'Louisiana Hot Spiced Okra', 2, 2, N'24 - 8 oz jars', 17, 4, 100, 20, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (67, N'Laughing Lumberjack Lager', 16, 1, N'24 - 12 oz bottles', 14, 52, 0, 10, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (68, N'Scottish Longbreads', 8, 3, N'10 boxes x 8 pieces', 12.5, 6, 10, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (69, N'Gudbrandsdalsost', 15, 4, N'10 kg pkg.', 36, 26, 0, 15, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (70, N'Outback Lager', 7, 1, N'24 - 355 ml bottles', 15, 15, 10, 30, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (71, N'Flotemysost', 15, 4, N'10 - 500 g pkgs.', 21.5, 26, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (72, N'Mozzarella di Giovanni', 14, 4, N'24 - 200 g pkgs.', 34.8, 14, 0, 0, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (73, N'Röd Kaviar', 17, 8, N'24 - 150 g jars', 15, 101, 0, 5, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (74, N'Longlife Tofu', 4, 7, N'5 kg pkg.', 10, 4, 20, 5, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (75, N'Rhönbräu Klosterbier', 12, 1, N'24 - 0.5 l bottles', 7.75, 125, 0, 25, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (76, N'Lakkalikööri', 23, 1, N'500 ml', 18, 57, 0, 20, 0);
INSERT INTO [dbo].[Products] ([ProductID], [ProductName], [SupplierID], [CategoryID], [QuantityPerUnit], [UnitPrice], [UnitsInStock], [UnitsOnOrder], [ReorderLevel], [Discontinued]) VALUES (77, N'Original Frankfurter grüne Soße', 12, 2, N'12 boxes', 13, 32, 0, 15, 0);
GO

SET IDENTITY_INSERT [dbo].[Products] OFF;
GO

/*------------------------------------------------------------------------------
  Orders（受注）: 830 件
------------------------------------------------------------------------------*/
PRINT N'Orders を投入します...';
GO

SET IDENTITY_INSERT [dbo].[Orders] ON;
GO

INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10248, N'VINET', 5, N'7/4/1996', N'8/1/1996', N'7/16/1996', 3, 32.38, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10249, N'TOMSP', 6, N'7/5/1996', N'8/16/1996', N'7/10/1996', 1, 11.61, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10250, N'HANAR', 4, N'7/8/1996', N'8/5/1996', N'7/12/1996', 2, 65.83, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10251, N'VICTE', 3, N'7/8/1996', N'8/5/1996', N'7/15/1996', 1, 41.34, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10252, N'SUPRD', 4, N'7/9/1996', N'8/6/1996', N'7/11/1996', 2, 51.30, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10253, N'HANAR', 3, N'7/10/1996', N'7/24/1996', N'7/16/1996', 2, 58.17, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10254, N'CHOPS', 5, N'7/11/1996', N'8/8/1996', N'7/23/1996', 2, 22.98, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10255, N'RICSU', 9, N'7/12/1996', N'8/9/1996', N'7/15/1996', 3, 148.33, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10256, N'WELLI', 3, N'7/15/1996', N'8/12/1996', N'7/17/1996', 2, 13.97, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10257, N'HILAA', 4, N'7/16/1996', N'8/13/1996', N'7/22/1996', 3, 81.91, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10258, N'ERNSH', 1, N'7/17/1996', N'8/14/1996', N'7/23/1996', 1, 140.51, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10259, N'CENTC', 4, N'7/18/1996', N'8/15/1996', N'7/25/1996', 3, 3.25, N'Centro comercial Moctezuma', N'Sierras de Granada 9993', N'México D.F.', NULL, N'05022', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10260, N'OTTIK', 4, N'7/19/1996', N'8/16/1996', N'7/29/1996', 1, 55.09, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10261, N'QUEDE', 4, N'7/19/1996', N'8/16/1996', N'7/30/1996', 2, 3.05, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10262, N'RATTC', 8, N'7/22/1996', N'8/19/1996', N'7/25/1996', 3, 48.29, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10263, N'ERNSH', 9, N'7/23/1996', N'8/20/1996', N'7/31/1996', 3, 146.06, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10264, N'FOLKO', 6, N'7/24/1996', N'8/21/1996', N'8/23/1996', 3, 3.67, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10265, N'BLONP', 2, N'7/25/1996', N'8/22/1996', N'8/12/1996', 1, 55.28, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10266, N'WARTH', 3, N'7/26/1996', N'9/6/1996', N'7/31/1996', 3, 25.73, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10267, N'FRANK', 4, N'7/29/1996', N'8/26/1996', N'8/6/1996', 1, 208.58, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10268, N'GROSR', 8, N'7/30/1996', N'8/27/1996', N'8/2/1996', 3, 66.29, N'GROSELLA-Restaurante', N'5ª Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10269, N'WHITC', 5, N'7/31/1996', N'8/14/1996', N'8/9/1996', 1, 4.56, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10270, N'WARTH', 1, N'8/1/1996', N'8/29/1996', N'8/2/1996', 1, 136.54, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10271, N'SPLIR', 6, N'8/1/1996', N'8/29/1996', N'8/30/1996', 2, 4.54, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10272, N'RATTC', 6, N'8/2/1996', N'8/30/1996', N'8/6/1996', 2, 98.03, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10273, N'QUICK', 3, N'8/5/1996', N'9/2/1996', N'8/12/1996', 3, 76.07, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10274, N'VINET', 6, N'8/6/1996', N'9/3/1996', N'8/16/1996', 1, 6.01, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10275, N'MAGAA', 1, N'8/7/1996', N'9/4/1996', N'8/9/1996', 1, 26.93, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10276, N'TORTU', 8, N'8/8/1996', N'8/22/1996', N'8/14/1996', 3, 13.84, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10277, N'MORGK', 2, N'8/9/1996', N'9/6/1996', N'8/13/1996', 3, 125.77, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10278, N'BERGS', 8, N'8/12/1996', N'9/9/1996', N'8/16/1996', 2, 92.69, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10279, N'LEHMS', 8, N'8/13/1996', N'9/10/1996', N'8/16/1996', 2, 25.83, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10280, N'BERGS', 2, N'8/14/1996', N'9/11/1996', N'9/12/1996', 1, 8.98, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10281, N'ROMEY', 4, N'8/14/1996', N'8/28/1996', N'8/21/1996', 1, 2.94, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10282, N'ROMEY', 4, N'8/15/1996', N'9/12/1996', N'8/21/1996', 1, 12.69, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10283, N'LILAS', 3, N'8/16/1996', N'9/13/1996', N'8/23/1996', 3, 84.81, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10284, N'LEHMS', 4, N'8/19/1996', N'9/16/1996', N'8/27/1996', 1, 76.56, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10285, N'QUICK', 1, N'8/20/1996', N'9/17/1996', N'8/26/1996', 2, 76.83, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10286, N'QUICK', 8, N'8/21/1996', N'9/18/1996', N'8/30/1996', 3, 229.24, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10287, N'RICAR', 8, N'8/22/1996', N'9/19/1996', N'8/28/1996', 3, 12.76, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10288, N'REGGC', 4, N'8/23/1996', N'9/20/1996', N'9/3/1996', 1, 7.45, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10289, N'BSBEV', 7, N'8/26/1996', N'9/23/1996', N'8/28/1996', 3, 22.77, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10290, N'COMMI', 8, N'8/27/1996', N'9/24/1996', N'9/3/1996', 1, 79.70, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10291, N'QUEDE', 6, N'8/27/1996', N'9/24/1996', N'9/4/1996', 2, 6.40, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10292, N'TRADH', 1, N'8/28/1996', N'9/25/1996', N'9/2/1996', 2, 1.35, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10293, N'TORTU', 1, N'8/29/1996', N'9/26/1996', N'9/11/1996', 3, 21.18, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10294, N'RATTC', 4, N'8/30/1996', N'9/27/1996', N'9/5/1996', 2, 147.26, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10295, N'VINET', 2, N'9/2/1996', N'9/30/1996', N'9/10/1996', 2, 1.15, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10296, N'LILAS', 6, N'9/3/1996', N'10/1/1996', N'9/11/1996', 1, 0.12, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10297, N'BLONP', 5, N'9/4/1996', N'10/16/1996', N'9/10/1996', 2, 5.74, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10298, N'HUNGO', 6, N'9/5/1996', N'10/3/1996', N'9/11/1996', 2, 168.22, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10299, N'RICAR', 4, N'9/6/1996', N'10/4/1996', N'9/13/1996', 2, 29.76, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10300, N'MAGAA', 2, N'9/9/1996', N'10/7/1996', N'9/18/1996', 2, 17.68, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10301, N'WANDK', 8, N'9/9/1996', N'10/7/1996', N'9/17/1996', 2, 45.08, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10302, N'SUPRD', 4, N'9/10/1996', N'10/8/1996', N'10/9/1996', 2, 6.27, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10303, N'GODOS', 7, N'9/11/1996', N'10/9/1996', N'9/18/1996', 2, 107.83, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10304, N'TORTU', 1, N'9/12/1996', N'10/10/1996', N'9/17/1996', 2, 63.79, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10305, N'OLDWO', 8, N'9/13/1996', N'10/11/1996', N'10/9/1996', 3, 257.62, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10306, N'ROMEY', 1, N'9/16/1996', N'10/14/1996', N'9/23/1996', 3, 7.56, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10307, N'LONEP', 2, N'9/17/1996', N'10/15/1996', N'9/25/1996', 2, 0.56, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10308, N'ANATR', 7, N'9/18/1996', N'10/16/1996', N'9/24/1996', 3, 1.61, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10309, N'HUNGO', 3, N'9/19/1996', N'10/17/1996', N'10/23/1996', 1, 47.30, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10310, N'THEBI', 8, N'9/20/1996', N'10/18/1996', N'9/27/1996', 2, 17.52, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10311, N'DUMON', 1, N'9/20/1996', N'10/4/1996', N'9/26/1996', 3, 24.69, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10312, N'WANDK', 2, N'9/23/1996', N'10/21/1996', N'10/3/1996', 2, 40.26, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10313, N'QUICK', 2, N'9/24/1996', N'10/22/1996', N'10/4/1996', 2, 1.96, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10314, N'RATTC', 1, N'9/25/1996', N'10/23/1996', N'10/4/1996', 2, 74.16, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10315, N'ISLAT', 4, N'9/26/1996', N'10/24/1996', N'10/3/1996', 2, 41.76, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10316, N'RATTC', 1, N'9/27/1996', N'10/25/1996', N'10/8/1996', 3, 150.15, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10317, N'LONEP', 6, N'9/30/1996', N'10/28/1996', N'10/10/1996', 1, 12.69, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10318, N'ISLAT', 8, N'10/1/1996', N'10/29/1996', N'10/4/1996', 2, 4.73, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10319, N'TORTU', 7, N'10/2/1996', N'10/30/1996', N'10/11/1996', 3, 64.50, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10320, N'WARTH', 5, N'10/3/1996', N'10/17/1996', N'10/18/1996', 3, 34.57, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10321, N'ISLAT', 3, N'10/3/1996', N'10/31/1996', N'10/11/1996', 2, 3.43, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10322, N'PERIC', 7, N'10/4/1996', N'11/1/1996', N'10/23/1996', 3, 0.40, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10323, N'KOENE', 4, N'10/7/1996', N'11/4/1996', N'10/14/1996', 1, 4.88, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10324, N'SAVEA', 9, N'10/8/1996', N'11/5/1996', N'10/10/1996', 1, 214.27, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10325, N'KOENE', 1, N'10/9/1996', N'10/23/1996', N'10/14/1996', 3, 64.86, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10326, N'BOLID', 4, N'10/10/1996', N'11/7/1996', N'10/14/1996', 2, 77.92, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10327, N'FOLKO', 2, N'10/11/1996', N'11/8/1996', N'10/14/1996', 1, 63.36, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10328, N'FURIB', 4, N'10/14/1996', N'11/11/1996', N'10/17/1996', 3, 87.03, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10329, N'SPLIR', 4, N'10/15/1996', N'11/26/1996', N'10/23/1996', 2, 191.67, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10330, N'LILAS', 3, N'10/16/1996', N'11/13/1996', N'10/28/1996', 1, 12.75, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10331, N'BONAP', 9, N'10/16/1996', N'11/27/1996', N'10/21/1996', 1, 10.19, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10332, N'MEREP', 3, N'10/17/1996', N'11/28/1996', N'10/21/1996', 2, 52.84, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10333, N'WARTH', 5, N'10/18/1996', N'11/15/1996', N'10/25/1996', 3, 0.59, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10334, N'VICTE', 8, N'10/21/1996', N'11/18/1996', N'10/28/1996', 2, 8.56, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10335, N'HUNGO', 7, N'10/22/1996', N'11/19/1996', N'10/24/1996', 2, 42.11, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10336, N'PRINI', 7, N'10/23/1996', N'11/20/1996', N'10/25/1996', 2, 15.51, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10337, N'FRANK', 4, N'10/24/1996', N'11/21/1996', N'10/29/1996', 3, 108.26, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10338, N'OLDWO', 4, N'10/25/1996', N'11/22/1996', N'10/29/1996', 3, 84.21, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10339, N'MEREP', 2, N'10/28/1996', N'11/25/1996', N'11/4/1996', 2, 15.66, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10340, N'BONAP', 1, N'10/29/1996', N'11/26/1996', N'11/8/1996', 3, 166.31, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10341, N'SIMOB', 7, N'10/29/1996', N'11/26/1996', N'11/5/1996', 3, 26.78, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10342, N'FRANK', 4, N'10/30/1996', N'11/13/1996', N'11/4/1996', 2, 54.83, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10343, N'LEHMS', 4, N'10/31/1996', N'11/28/1996', N'11/6/1996', 1, 110.37, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10344, N'WHITC', 4, N'11/1/1996', N'11/29/1996', N'11/5/1996', 2, 23.29, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10345, N'QUICK', 2, N'11/4/1996', N'12/2/1996', N'11/11/1996', 2, 249.06, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10346, N'RATTC', 3, N'11/5/1996', N'12/17/1996', N'11/8/1996', 3, 142.08, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10347, N'FAMIA', 4, N'11/6/1996', N'12/4/1996', N'11/8/1996', 3, 3.10, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10348, N'WANDK', 4, N'11/7/1996', N'12/5/1996', N'11/15/1996', 2, 0.78, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10349, N'SPLIR', 7, N'11/8/1996', N'12/6/1996', N'11/15/1996', 1, 8.63, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10350, N'LAMAI', 6, N'11/11/1996', N'12/9/1996', N'12/3/1996', 2, 64.19, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10351, N'ERNSH', 1, N'11/11/1996', N'12/9/1996', N'11/20/1996', 1, 162.33, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10352, N'FURIB', 3, N'11/12/1996', N'11/26/1996', N'11/18/1996', 3, 1.30, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10353, N'PICCO', 7, N'11/13/1996', N'12/11/1996', N'11/25/1996', 3, 360.63, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10354, N'PERIC', 8, N'11/14/1996', N'12/12/1996', N'11/20/1996', 3, 53.80, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10355, N'AROUT', 6, N'11/15/1996', N'12/13/1996', N'11/20/1996', 1, 41.95, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10356, N'WANDK', 6, N'11/18/1996', N'12/16/1996', N'11/27/1996', 2, 36.71, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10357, N'LILAS', 1, N'11/19/1996', N'12/17/1996', N'12/2/1996', 3, 34.88, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10358, N'LAMAI', 5, N'11/20/1996', N'12/18/1996', N'11/27/1996', 1, 19.64, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10359, N'SEVES', 5, N'11/21/1996', N'12/19/1996', N'11/26/1996', 3, 288.43, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10360, N'BLONP', 4, N'11/22/1996', N'12/20/1996', N'12/2/1996', 3, 131.70, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10361, N'QUICK', 1, N'11/22/1996', N'12/20/1996', N'12/3/1996', 2, 183.17, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10362, N'BONAP', 3, N'11/25/1996', N'12/23/1996', N'11/28/1996', 1, 96.04, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10363, N'DRACD', 4, N'11/26/1996', N'12/24/1996', N'12/4/1996', 3, 30.54, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10364, N'EASTC', 1, N'11/26/1996', N'1/7/1997', N'12/4/1996', 1, 71.97, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10365, N'ANTON', 3, N'11/27/1996', N'12/25/1996', N'12/2/1996', 2, 22.00, N'Antonio Moreno Taquería', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10366, N'GALED', 8, N'11/28/1996', N'1/9/1997', N'12/30/1996', 2, 10.14, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10367, N'VAFFE', 7, N'11/28/1996', N'12/26/1996', N'12/2/1996', 3, 13.55, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10368, N'ERNSH', 2, N'11/29/1996', N'12/27/1996', N'12/2/1996', 2, 101.95, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10369, N'SPLIR', 8, N'12/2/1996', N'12/30/1996', N'12/9/1996', 2, 195.68, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10370, N'CHOPS', 6, N'12/3/1996', N'12/31/1996', N'12/27/1996', 2, 1.17, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10371, N'LAMAI', 1, N'12/3/1996', N'12/31/1996', N'12/24/1996', 1, 0.45, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10372, N'QUEEN', 5, N'12/4/1996', N'1/1/1997', N'12/9/1996', 2, 890.78, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10373, N'HUNGO', 4, N'12/5/1996', N'1/2/1997', N'12/11/1996', 3, 124.12, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10374, N'WOLZA', 1, N'12/5/1996', N'1/2/1997', N'12/9/1996', 3, 3.94, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10375, N'HUNGC', 3, N'12/6/1996', N'1/3/1997', N'12/9/1996', 2, 20.12, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10376, N'MEREP', 1, N'12/9/1996', N'1/6/1997', N'12/13/1996', 2, 20.39, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10377, N'SEVES', 1, N'12/9/1996', N'1/6/1997', N'12/13/1996', 3, 22.21, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10378, N'FOLKO', 5, N'12/10/1996', N'1/7/1997', N'12/19/1996', 3, 5.44, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10379, N'QUEDE', 2, N'12/11/1996', N'1/8/1997', N'12/13/1996', 1, 45.03, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10380, N'HUNGO', 8, N'12/12/1996', N'1/9/1997', N'1/16/1997', 3, 35.03, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10381, N'LILAS', 3, N'12/12/1996', N'1/9/1997', N'12/13/1996', 3, 7.99, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10382, N'ERNSH', 4, N'12/13/1996', N'1/10/1997', N'12/16/1996', 1, 94.77, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10383, N'AROUT', 8, N'12/16/1996', N'1/13/1997', N'12/18/1996', 3, 34.24, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10384, N'BERGS', 3, N'12/16/1996', N'1/13/1997', N'12/20/1996', 3, 168.64, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10385, N'SPLIR', 1, N'12/17/1996', N'1/14/1997', N'12/23/1996', 2, 30.96, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10386, N'FAMIA', 9, N'12/18/1996', N'1/1/1997', N'12/25/1996', 3, 13.99, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10387, N'SANTG', 1, N'12/18/1996', N'1/15/1997', N'12/20/1996', 2, 93.63, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10388, N'SEVES', 2, N'12/19/1996', N'1/16/1997', N'12/20/1996', 1, 34.86, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10389, N'BOTTM', 4, N'12/20/1996', N'1/17/1997', N'12/24/1996', 2, 47.42, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10390, N'ERNSH', 6, N'12/23/1996', N'1/20/1997', N'12/26/1996', 1, 126.38, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10391, N'DRACD', 3, N'12/23/1996', N'1/20/1997', N'12/31/1996', 3, 5.45, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10392, N'PICCO', 2, N'12/24/1996', N'1/21/1997', N'1/1/1997', 3, 122.46, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10393, N'SAVEA', 1, N'12/25/1996', N'1/22/1997', N'1/3/1997', 3, 126.56, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10394, N'HUNGC', 1, N'12/25/1996', N'1/22/1997', N'1/3/1997', 3, 30.34, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10395, N'HILAA', 6, N'12/26/1996', N'1/23/1997', N'1/3/1997', 1, 184.41, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10396, N'FRANK', 1, N'12/27/1996', N'1/10/1997', N'1/6/1997', 3, 135.35, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10397, N'PRINI', 5, N'12/27/1996', N'1/24/1997', N'1/2/1997', 1, 60.26, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10398, N'SAVEA', 2, N'12/30/1996', N'1/27/1997', N'1/9/1997', 3, 89.16, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10399, N'VAFFE', 8, N'12/31/1996', N'1/14/1997', N'1/8/1997', 3, 27.36, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10400, N'EASTC', 1, N'1/1/1997', N'1/29/1997', N'1/16/1997', 3, 83.93, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10401, N'RATTC', 1, N'1/1/1997', N'1/29/1997', N'1/10/1997', 1, 12.51, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10402, N'ERNSH', 8, N'1/2/1997', N'2/13/1997', N'1/10/1997', 2, 67.88, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10403, N'ERNSH', 4, N'1/3/1997', N'1/31/1997', N'1/9/1997', 3, 73.79, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10404, N'MAGAA', 2, N'1/3/1997', N'1/31/1997', N'1/8/1997', 1, 155.97, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10405, N'LINOD', 1, N'1/6/1997', N'2/3/1997', N'1/22/1997', 1, 34.82, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10406, N'QUEEN', 7, N'1/7/1997', N'2/18/1997', N'1/13/1997', 1, 108.04, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10407, N'OTTIK', 2, N'1/7/1997', N'2/4/1997', N'1/30/1997', 2, 91.48, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10408, N'FOLIG', 8, N'1/8/1997', N'2/5/1997', N'1/14/1997', 1, 11.26, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10409, N'OCEAN', 3, N'1/9/1997', N'2/6/1997', N'1/14/1997', 1, 29.83, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10410, N'BOTTM', 3, N'1/10/1997', N'2/7/1997', N'1/15/1997', 3, 2.40, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10411, N'BOTTM', 9, N'1/10/1997', N'2/7/1997', N'1/21/1997', 3, 23.65, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10412, N'WARTH', 8, N'1/13/1997', N'2/10/1997', N'1/15/1997', 2, 3.77, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10413, N'LAMAI', 3, N'1/14/1997', N'2/11/1997', N'1/16/1997', 2, 95.66, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10414, N'FAMIA', 2, N'1/14/1997', N'2/11/1997', N'1/17/1997', 3, 21.48, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10415, N'HUNGC', 3, N'1/15/1997', N'2/12/1997', N'1/24/1997', 1, 0.20, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10416, N'WARTH', 8, N'1/16/1997', N'2/13/1997', N'1/27/1997', 3, 22.72, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10417, N'SIMOB', 4, N'1/16/1997', N'2/13/1997', N'1/28/1997', 3, 70.29, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10418, N'QUICK', 4, N'1/17/1997', N'2/14/1997', N'1/24/1997', 1, 17.55, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10419, N'RICSU', 4, N'1/20/1997', N'2/17/1997', N'1/30/1997', 2, 137.35, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10420, N'WELLI', 3, N'1/21/1997', N'2/18/1997', N'1/27/1997', 1, 44.12, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10421, N'QUEDE', 8, N'1/21/1997', N'3/4/1997', N'1/27/1997', 1, 99.23, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10422, N'FRANS', 2, N'1/22/1997', N'2/19/1997', N'1/31/1997', 1, 3.02, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10423, N'GOURL', 6, N'1/23/1997', N'2/6/1997', N'2/24/1997', 3, 24.50, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10424, N'MEREP', 7, N'1/23/1997', N'2/20/1997', N'1/27/1997', 2, 370.61, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10425, N'LAMAI', 6, N'1/24/1997', N'2/21/1997', N'2/14/1997', 2, 7.93, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10426, N'GALED', 4, N'1/27/1997', N'2/24/1997', N'2/6/1997', 1, 18.69, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10427, N'PICCO', 4, N'1/27/1997', N'2/24/1997', N'3/3/1997', 2, 31.29, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10428, N'REGGC', 7, N'1/28/1997', N'2/25/1997', N'2/4/1997', 1, 11.09, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10429, N'HUNGO', 3, N'1/29/1997', N'3/12/1997', N'2/7/1997', 2, 56.63, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10430, N'ERNSH', 4, N'1/30/1997', N'2/13/1997', N'2/3/1997', 1, 458.78, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10431, N'BOTTM', 4, N'1/30/1997', N'2/13/1997', N'2/7/1997', 2, 44.17, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10432, N'SPLIR', 3, N'1/31/1997', N'2/14/1997', N'2/7/1997', 2, 4.34, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10433, N'PRINI', 3, N'2/3/1997', N'3/3/1997', N'3/4/1997', 3, 73.83, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10434, N'FOLKO', 3, N'2/3/1997', N'3/3/1997', N'2/13/1997', 2, 17.92, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10435, N'CONSH', 8, N'2/4/1997', N'3/18/1997', N'2/7/1997', 2, 9.21, N'Consolidated Holdings', N'Berkeley Gardens 12 Brewery', N'London', NULL, N'WX1 6LT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10436, N'BLONP', 3, N'2/5/1997', N'3/5/1997', N'2/11/1997', 2, 156.66, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10437, N'WARTH', 8, N'2/5/1997', N'3/5/1997', N'2/12/1997', 1, 19.97, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10438, N'TOMSP', 3, N'2/6/1997', N'3/6/1997', N'2/14/1997', 2, 8.24, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10439, N'MEREP', 6, N'2/7/1997', N'3/7/1997', N'2/10/1997', 3, 4.07, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10440, N'SAVEA', 4, N'2/10/1997', N'3/10/1997', N'2/28/1997', 2, 86.53, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10441, N'OLDWO', 3, N'2/10/1997', N'3/24/1997', N'3/14/1997', 2, 73.02, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10442, N'ERNSH', 3, N'2/11/1997', N'3/11/1997', N'2/18/1997', 2, 47.94, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10443, N'REGGC', 8, N'2/12/1997', N'3/12/1997', N'2/14/1997', 1, 13.95, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10444, N'BERGS', 3, N'2/12/1997', N'3/12/1997', N'2/21/1997', 3, 3.50, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10445, N'BERGS', 3, N'2/13/1997', N'3/13/1997', N'2/20/1997', 1, 9.30, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10446, N'TOMSP', 6, N'2/14/1997', N'3/14/1997', N'2/19/1997', 1, 14.68, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10447, N'RICAR', 4, N'2/14/1997', N'3/14/1997', N'3/7/1997', 2, 68.66, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10448, N'RANCH', 4, N'2/17/1997', N'3/17/1997', N'2/24/1997', 2, 38.82, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10449, N'BLONP', 3, N'2/18/1997', N'3/18/1997', N'2/27/1997', 2, 53.30, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10450, N'VICTE', 8, N'2/19/1997', N'3/19/1997', N'3/11/1997', 2, 7.23, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10451, N'QUICK', 4, N'2/19/1997', N'3/5/1997', N'3/12/1997', 3, 189.09, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10452, N'SAVEA', 8, N'2/20/1997', N'3/20/1997', N'2/26/1997', 1, 140.26, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10453, N'AROUT', 1, N'2/21/1997', N'3/21/1997', N'2/26/1997', 2, 25.36, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10454, N'LAMAI', 4, N'2/21/1997', N'3/21/1997', N'2/25/1997', 3, 2.74, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10455, N'WARTH', 8, N'2/24/1997', N'4/7/1997', N'3/3/1997', 2, 180.45, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10456, N'KOENE', 8, N'2/25/1997', N'4/8/1997', N'2/28/1997', 2, 8.12, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10457, N'KOENE', 2, N'2/25/1997', N'3/25/1997', N'3/3/1997', 1, 11.57, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10458, N'SUPRD', 7, N'2/26/1997', N'3/26/1997', N'3/4/1997', 3, 147.06, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10459, N'VICTE', 4, N'2/27/1997', N'3/27/1997', N'2/28/1997', 2, 25.09, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10460, N'FOLKO', 8, N'2/28/1997', N'3/28/1997', N'3/3/1997', 1, 16.27, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10461, N'LILAS', 1, N'2/28/1997', N'3/28/1997', N'3/5/1997', 3, 148.61, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10462, N'CONSH', 2, N'3/3/1997', N'3/31/1997', N'3/18/1997', 1, 6.17, N'Consolidated Holdings', N'Berkeley Gardens 12 Brewery', N'London', NULL, N'WX1 6LT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10463, N'SUPRD', 5, N'3/4/1997', N'4/1/1997', N'3/6/1997', 3, 14.78, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10464, N'FURIB', 4, N'3/4/1997', N'4/1/1997', N'3/14/1997', 2, 89.00, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10465, N'VAFFE', 1, N'3/5/1997', N'4/2/1997', N'3/14/1997', 3, 145.04, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10466, N'COMMI', 4, N'3/6/1997', N'4/3/1997', N'3/13/1997', 1, 11.93, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10467, N'MAGAA', 8, N'3/6/1997', N'4/3/1997', N'3/11/1997', 2, 4.93, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10468, N'KOENE', 3, N'3/7/1997', N'4/4/1997', N'3/12/1997', 3, 44.12, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10469, N'WHITC', 1, N'3/10/1997', N'4/7/1997', N'3/14/1997', 1, 60.18, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10470, N'BONAP', 4, N'3/11/1997', N'4/8/1997', N'3/14/1997', 2, 64.56, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10471, N'BSBEV', 2, N'3/11/1997', N'4/8/1997', N'3/18/1997', 3, 45.59, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10472, N'SEVES', 8, N'3/12/1997', N'4/9/1997', N'3/19/1997', 1, 4.20, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10473, N'ISLAT', 1, N'3/13/1997', N'3/27/1997', N'3/21/1997', 3, 16.37, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10474, N'PERIC', 5, N'3/13/1997', N'4/10/1997', N'3/21/1997', 2, 83.49, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10475, N'SUPRD', 9, N'3/14/1997', N'4/11/1997', N'4/4/1997', 1, 68.52, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10476, N'HILAA', 8, N'3/17/1997', N'4/14/1997', N'3/24/1997', 3, 4.41, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10477, N'PRINI', 5, N'3/17/1997', N'4/14/1997', N'3/25/1997', 2, 13.02, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10478, N'VICTE', 2, N'3/18/1997', N'4/1/1997', N'3/26/1997', 3, 4.81, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10479, N'RATTC', 3, N'3/19/1997', N'4/16/1997', N'3/21/1997', 3, 708.95, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10480, N'FOLIG', 6, N'3/20/1997', N'4/17/1997', N'3/24/1997', 2, 1.35, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10481, N'RICAR', 8, N'3/20/1997', N'4/17/1997', N'3/25/1997', 2, 64.33, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10482, N'LAZYK', 1, N'3/21/1997', N'4/18/1997', N'4/10/1997', 3, 7.48, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10483, N'WHITC', 7, N'3/24/1997', N'4/21/1997', N'4/25/1997', 2, 15.28, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10484, N'BSBEV', 3, N'3/24/1997', N'4/21/1997', N'4/1/1997', 3, 6.88, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10485, N'LINOD', 4, N'3/25/1997', N'4/8/1997', N'3/31/1997', 2, 64.45, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10486, N'HILAA', 1, N'3/26/1997', N'4/23/1997', N'4/2/1997', 2, 30.53, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10487, N'QUEEN', 2, N'3/26/1997', N'4/23/1997', N'3/28/1997', 2, 71.07, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10488, N'FRANK', 8, N'3/27/1997', N'4/24/1997', N'4/2/1997', 2, 4.93, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10489, N'PICCO', 6, N'3/28/1997', N'4/25/1997', N'4/9/1997', 2, 5.29, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10490, N'HILAA', 7, N'3/31/1997', N'4/28/1997', N'4/3/1997', 2, 210.19, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10491, N'FURIB', 8, N'3/31/1997', N'4/28/1997', N'4/8/1997', 3, 16.96, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10492, N'BOTTM', 3, N'4/1/1997', N'4/29/1997', N'4/11/1997', 1, 62.89, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10493, N'LAMAI', 4, N'4/2/1997', N'4/30/1997', N'4/10/1997', 3, 10.64, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10494, N'COMMI', 4, N'4/2/1997', N'4/30/1997', N'4/9/1997', 2, 65.99, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10495, N'LAUGB', 3, N'4/3/1997', N'5/1/1997', N'4/11/1997', 3, 4.65, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10496, N'TRADH', 7, N'4/4/1997', N'5/2/1997', N'4/7/1997', 2, 46.77, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10497, N'LEHMS', 7, N'4/4/1997', N'5/2/1997', N'4/7/1997', 1, 36.21, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10498, N'HILAA', 8, N'4/7/1997', N'5/5/1997', N'4/11/1997', 2, 29.75, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10499, N'LILAS', 4, N'4/8/1997', N'5/6/1997', N'4/16/1997', 2, 102.02, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10500, N'LAMAI', 6, N'4/9/1997', N'5/7/1997', N'4/17/1997', 1, 42.68, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10501, N'BLAUS', 9, N'4/9/1997', N'5/7/1997', N'4/16/1997', 3, 8.85, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10502, N'PERIC', 2, N'4/10/1997', N'5/8/1997', N'4/29/1997', 1, 69.32, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10503, N'HUNGO', 6, N'4/11/1997', N'5/9/1997', N'4/16/1997', 2, 16.74, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10504, N'WHITC', 4, N'4/11/1997', N'5/9/1997', N'4/18/1997', 3, 59.13, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10505, N'MEREP', 3, N'4/14/1997', N'5/12/1997', N'4/21/1997', 3, 7.13, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10506, N'KOENE', 9, N'4/15/1997', N'5/13/1997', N'5/2/1997', 2, 21.19, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10507, N'ANTON', 7, N'4/15/1997', N'5/13/1997', N'4/22/1997', 1, 47.45, N'Antonio Moreno Taquería', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10508, N'OTTIK', 1, N'4/16/1997', N'5/14/1997', N'5/13/1997', 2, 4.99, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10509, N'BLAUS', 4, N'4/17/1997', N'5/15/1997', N'4/29/1997', 1, 0.15, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10510, N'SAVEA', 6, N'4/18/1997', N'5/16/1997', N'4/28/1997', 3, 367.63, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10511, N'BONAP', 4, N'4/18/1997', N'5/16/1997', N'4/21/1997', 3, 350.64, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10512, N'FAMIA', 7, N'4/21/1997', N'5/19/1997', N'4/24/1997', 2, 3.53, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10513, N'WANDK', 7, N'4/22/1997', N'6/3/1997', N'4/28/1997', 1, 105.65, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10514, N'ERNSH', 3, N'4/22/1997', N'5/20/1997', N'5/16/1997', 2, 789.95, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10515, N'QUICK', 2, N'4/23/1997', N'5/7/1997', N'5/23/1997', 1, 204.47, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10516, N'HUNGO', 2, N'4/24/1997', N'5/22/1997', N'5/1/1997', 3, 62.78, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10517, N'NORTS', 3, N'4/24/1997', N'5/22/1997', N'4/29/1997', 3, 32.07, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10518, N'TORTU', 4, N'4/25/1997', N'5/9/1997', N'5/5/1997', 2, 218.15, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10519, N'CHOPS', 6, N'4/28/1997', N'5/26/1997', N'5/1/1997', 3, 91.76, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10520, N'SANTG', 7, N'4/29/1997', N'5/27/1997', N'5/1/1997', 1, 13.37, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10521, N'CACTU', 8, N'4/29/1997', N'5/27/1997', N'5/2/1997', 2, 17.22, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10522, N'LEHMS', 4, N'4/30/1997', N'5/28/1997', N'5/6/1997', 1, 45.33, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10523, N'SEVES', 7, N'5/1/1997', N'5/29/1997', N'5/30/1997', 2, 77.63, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10524, N'BERGS', 1, N'5/1/1997', N'5/29/1997', N'5/7/1997', 2, 244.79, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10525, N'BONAP', 1, N'5/2/1997', N'5/30/1997', N'5/23/1997', 2, 11.06, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10526, N'WARTH', 4, N'5/5/1997', N'6/2/1997', N'5/15/1997', 2, 58.59, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10527, N'QUICK', 7, N'5/5/1997', N'6/2/1997', N'5/7/1997', 1, 41.90, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10528, N'GREAL', 6, N'5/6/1997', N'5/20/1997', N'5/9/1997', 2, 3.35, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10529, N'MAISD', 5, N'5/7/1997', N'6/4/1997', N'5/9/1997', 2, 66.69, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10530, N'PICCO', 3, N'5/8/1997', N'6/5/1997', N'5/12/1997', 2, 339.22, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10531, N'OCEAN', 7, N'5/8/1997', N'6/5/1997', N'5/19/1997', 1, 8.12, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10532, N'EASTC', 7, N'5/9/1997', N'6/6/1997', N'5/12/1997', 3, 74.46, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10533, N'FOLKO', 8, N'5/12/1997', N'6/9/1997', N'5/22/1997', 1, 188.04, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10534, N'LEHMS', 8, N'5/12/1997', N'6/9/1997', N'5/14/1997', 2, 27.94, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10535, N'ANTON', 4, N'5/13/1997', N'6/10/1997', N'5/21/1997', 1, 15.64, N'Antonio Moreno Taquería', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10536, N'LEHMS', 3, N'5/14/1997', N'6/11/1997', N'6/6/1997', 2, 58.88, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10537, N'RICSU', 1, N'5/14/1997', N'5/28/1997', N'5/19/1997', 1, 78.85, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10538, N'BSBEV', 9, N'5/15/1997', N'6/12/1997', N'5/16/1997', 3, 4.87, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10539, N'BSBEV', 6, N'5/16/1997', N'6/13/1997', N'5/23/1997', 3, 12.36, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10540, N'QUICK', 3, N'5/19/1997', N'6/16/1997', N'6/13/1997', 3, 1007.64, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10541, N'HANAR', 2, N'5/19/1997', N'6/16/1997', N'5/29/1997', 1, 68.65, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10542, N'KOENE', 1, N'5/20/1997', N'6/17/1997', N'5/26/1997', 3, 10.95, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10543, N'LILAS', 8, N'5/21/1997', N'6/18/1997', N'5/23/1997', 2, 48.17, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10544, N'LONEP', 4, N'5/21/1997', N'6/18/1997', N'5/30/1997', 1, 24.91, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10545, N'LAZYK', 8, N'5/22/1997', N'6/19/1997', N'6/26/1997', 2, 11.92, N'Lazy K Kountry Store', N'12 Orchestra Terrace', N'Walla Walla', N'WA', N'99362', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10546, N'VICTE', 1, N'5/23/1997', N'6/20/1997', N'5/27/1997', 3, 194.72, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10547, N'SEVES', 3, N'5/23/1997', N'6/20/1997', N'6/2/1997', 2, 178.43, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10548, N'TOMSP', 3, N'5/26/1997', N'6/23/1997', N'6/2/1997', 2, 1.43, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10549, N'QUICK', 5, N'5/27/1997', N'6/10/1997', N'5/30/1997', 1, 171.24, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10550, N'GODOS', 7, N'5/28/1997', N'6/25/1997', N'6/6/1997', 3, 4.32, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10551, N'FURIB', 4, N'5/28/1997', N'7/9/1997', N'6/6/1997', 3, 72.95, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10552, N'HILAA', 2, N'5/29/1997', N'6/26/1997', N'6/5/1997', 1, 83.22, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10553, N'WARTH', 2, N'5/30/1997', N'6/27/1997', N'6/3/1997', 2, 149.49, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10554, N'OTTIK', 4, N'5/30/1997', N'6/27/1997', N'6/5/1997', 3, 120.97, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10555, N'SAVEA', 6, N'6/2/1997', N'6/30/1997', N'6/4/1997', 3, 252.49, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10556, N'SIMOB', 2, N'6/3/1997', N'7/15/1997', N'6/13/1997', 1, 9.80, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10557, N'LEHMS', 9, N'6/3/1997', N'6/17/1997', N'6/6/1997', 2, 96.72, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10558, N'AROUT', 1, N'6/4/1997', N'7/2/1997', N'6/10/1997', 2, 72.97, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10559, N'BLONP', 6, N'6/5/1997', N'7/3/1997', N'6/13/1997', 1, 8.05, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10560, N'FRANK', 8, N'6/6/1997', N'7/4/1997', N'6/9/1997', 1, 36.65, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10561, N'FOLKO', 2, N'6/6/1997', N'7/4/1997', N'6/9/1997', 2, 242.21, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10562, N'REGGC', 1, N'6/9/1997', N'7/7/1997', N'6/12/1997', 1, 22.95, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10563, N'RICAR', 2, N'6/10/1997', N'7/22/1997', N'6/24/1997', 2, 60.43, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10564, N'RATTC', 4, N'6/10/1997', N'7/8/1997', N'6/16/1997', 3, 13.75, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10565, N'MEREP', 8, N'6/11/1997', N'7/9/1997', N'6/18/1997', 2, 7.15, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10566, N'BLONP', 9, N'6/12/1997', N'7/10/1997', N'6/18/1997', 1, 88.40, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10567, N'HUNGO', 1, N'6/12/1997', N'7/10/1997', N'6/17/1997', 1, 33.97, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10568, N'GALED', 3, N'6/13/1997', N'7/11/1997', N'7/9/1997', 3, 6.54, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10569, N'RATTC', 5, N'6/16/1997', N'7/14/1997', N'7/11/1997', 1, 58.98, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10570, N'MEREP', 3, N'6/17/1997', N'7/15/1997', N'6/19/1997', 3, 188.99, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10571, N'ERNSH', 8, N'6/17/1997', N'7/29/1997', N'7/4/1997', 3, 26.06, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10572, N'BERGS', 3, N'6/18/1997', N'7/16/1997', N'6/25/1997', 2, 116.43, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10573, N'ANTON', 7, N'6/19/1997', N'7/17/1997', N'6/20/1997', 3, 84.84, N'Antonio Moreno Taquería', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10574, N'TRAIH', 4, N'6/19/1997', N'7/17/1997', N'6/30/1997', 2, 37.60, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10575, N'MORGK', 5, N'6/20/1997', N'7/4/1997', N'6/30/1997', 1, 127.34, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10576, N'TORTU', 3, N'6/23/1997', N'7/7/1997', N'6/30/1997', 3, 18.56, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10577, N'TRAIH', 9, N'6/23/1997', N'8/4/1997', N'6/30/1997', 2, 25.41, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10578, N'BSBEV', 4, N'6/24/1997', N'7/22/1997', N'7/25/1997', 3, 29.60, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10579, N'LETSS', 1, N'6/25/1997', N'7/23/1997', N'7/4/1997', 2, 13.73, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10580, N'OTTIK', 4, N'6/26/1997', N'7/24/1997', N'7/1/1997', 3, 75.89, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10581, N'FAMIA', 3, N'6/26/1997', N'7/24/1997', N'7/2/1997', 1, 3.01, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10582, N'BLAUS', 3, N'6/27/1997', N'7/25/1997', N'7/14/1997', 2, 27.71, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10583, N'WARTH', 2, N'6/30/1997', N'7/28/1997', N'7/4/1997', 2, 7.28, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10584, N'BLONP', 4, N'6/30/1997', N'7/28/1997', N'7/4/1997', 1, 59.14, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10585, N'WELLI', 7, N'7/1/1997', N'7/29/1997', N'7/10/1997', 1, 13.41, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10586, N'REGGC', 9, N'7/2/1997', N'7/30/1997', N'7/9/1997', 1, 0.48, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10587, N'QUEDE', 1, N'7/2/1997', N'7/30/1997', N'7/9/1997', 1, 62.52, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10588, N'QUICK', 2, N'7/3/1997', N'7/31/1997', N'7/10/1997', 3, 194.67, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10589, N'GREAL', 8, N'7/4/1997', N'8/1/1997', N'7/14/1997', 2, 4.42, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10590, N'MEREP', 4, N'7/7/1997', N'8/4/1997', N'7/14/1997', 3, 44.77, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10591, N'VAFFE', 1, N'7/7/1997', N'7/21/1997', N'7/16/1997', 1, 55.92, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10592, N'LEHMS', 3, N'7/8/1997', N'8/5/1997', N'7/16/1997', 1, 32.10, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10593, N'LEHMS', 7, N'7/9/1997', N'8/6/1997', N'8/13/1997', 2, 174.20, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10594, N'OLDWO', 3, N'7/9/1997', N'8/6/1997', N'7/16/1997', 2, 5.24, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10595, N'ERNSH', 2, N'7/10/1997', N'8/7/1997', N'7/14/1997', 1, 96.78, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10596, N'WHITC', 8, N'7/11/1997', N'8/8/1997', N'8/12/1997', 1, 16.34, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10597, N'PICCO', 7, N'7/11/1997', N'8/8/1997', N'7/18/1997', 3, 35.12, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10598, N'RATTC', 1, N'7/14/1997', N'8/11/1997', N'7/18/1997', 3, 44.42, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10599, N'BSBEV', 6, N'7/15/1997', N'8/26/1997', N'7/21/1997', 3, 29.98, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10600, N'HUNGC', 4, N'7/16/1997', N'8/13/1997', N'7/21/1997', 1, 45.13, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10601, N'HILAA', 7, N'7/16/1997', N'8/27/1997', N'7/22/1997', 1, 58.30, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10602, N'VAFFE', 8, N'7/17/1997', N'8/14/1997', N'7/22/1997', 2, 2.92, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10603, N'SAVEA', 8, N'7/18/1997', N'8/15/1997', N'8/8/1997', 2, 48.77, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10604, N'FURIB', 1, N'7/18/1997', N'8/15/1997', N'7/29/1997', 1, 7.46, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10605, N'MEREP', 1, N'7/21/1997', N'8/18/1997', N'7/29/1997', 2, 379.13, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10606, N'TRADH', 4, N'7/22/1997', N'8/19/1997', N'7/31/1997', 3, 79.40, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10607, N'SAVEA', 5, N'7/22/1997', N'8/19/1997', N'7/25/1997', 1, 200.24, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10608, N'TOMSP', 4, N'7/23/1997', N'8/20/1997', N'8/1/1997', 2, 27.79, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10609, N'DUMON', 7, N'7/24/1997', N'8/21/1997', N'7/30/1997', 2, 1.85, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10610, N'LAMAI', 8, N'7/25/1997', N'8/22/1997', N'8/6/1997', 1, 26.78, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10611, N'WOLZA', 6, N'7/25/1997', N'8/22/1997', N'8/1/1997', 2, 80.65, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10612, N'SAVEA', 1, N'7/28/1997', N'8/25/1997', N'8/1/1997', 2, 544.08, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10613, N'HILAA', 4, N'7/29/1997', N'8/26/1997', N'8/1/1997', 2, 8.11, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10614, N'BLAUS', 8, N'7/29/1997', N'8/26/1997', N'8/1/1997', 3, 1.93, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10615, N'WILMK', 2, N'7/30/1997', N'8/27/1997', N'8/6/1997', 3, 0.75, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10616, N'GREAL', 1, N'7/31/1997', N'8/28/1997', N'8/5/1997', 2, 116.53, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10617, N'GREAL', 4, N'7/31/1997', N'8/28/1997', N'8/4/1997', 2, 18.53, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10618, N'MEREP', 1, N'8/1/1997', N'9/12/1997', N'8/8/1997', 1, 154.68, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10619, N'MEREP', 3, N'8/4/1997', N'9/1/1997', N'8/7/1997', 3, 91.05, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10620, N'LAUGB', 2, N'8/5/1997', N'9/2/1997', N'8/14/1997', 3, 0.94, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10621, N'ISLAT', 4, N'8/5/1997', N'9/2/1997', N'8/11/1997', 2, 23.73, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10622, N'RICAR', 4, N'8/6/1997', N'9/3/1997', N'8/11/1997', 3, 50.97, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10623, N'FRANK', 8, N'8/7/1997', N'9/4/1997', N'8/12/1997', 2, 97.18, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10624, N'THECR', 4, N'8/7/1997', N'9/4/1997', N'8/19/1997', 2, 94.80, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10625, N'ANATR', 3, N'8/8/1997', N'9/5/1997', N'8/14/1997', 1, 43.90, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10626, N'BERGS', 1, N'8/11/1997', N'9/8/1997', N'8/20/1997', 2, 138.69, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10627, N'SAVEA', 8, N'8/11/1997', N'9/22/1997', N'8/21/1997', 3, 107.46, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10628, N'BLONP', 4, N'8/12/1997', N'9/9/1997', N'8/20/1997', 3, 30.36, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10629, N'GODOS', 4, N'8/12/1997', N'9/9/1997', N'8/20/1997', 3, 85.46, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10630, N'KOENE', 1, N'8/13/1997', N'9/10/1997', N'8/19/1997', 2, 32.35, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10631, N'LAMAI', 8, N'8/14/1997', N'9/11/1997', N'8/15/1997', 1, 0.87, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10632, N'WANDK', 8, N'8/14/1997', N'9/11/1997', N'8/19/1997', 1, 41.38, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10633, N'ERNSH', 7, N'8/15/1997', N'9/12/1997', N'8/18/1997', 3, 477.90, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10634, N'FOLIG', 4, N'8/15/1997', N'9/12/1997', N'8/21/1997', 3, 487.38, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10635, N'MAGAA', 8, N'8/18/1997', N'9/15/1997', N'8/21/1997', 3, 47.46, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10636, N'WARTH', 4, N'8/19/1997', N'9/16/1997', N'8/26/1997', 1, 1.15, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10637, N'QUEEN', 6, N'8/19/1997', N'9/16/1997', N'8/26/1997', 1, 201.29, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10638, N'LINOD', 3, N'8/20/1997', N'9/17/1997', N'9/1/1997', 1, 158.44, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10639, N'SANTG', 7, N'8/20/1997', N'9/17/1997', N'8/27/1997', 3, 38.64, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10640, N'WANDK', 4, N'8/21/1997', N'9/18/1997', N'8/28/1997', 1, 23.55, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10641, N'HILAA', 4, N'8/22/1997', N'9/19/1997', N'8/26/1997', 2, 179.61, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10642, N'SIMOB', 7, N'8/22/1997', N'9/19/1997', N'9/5/1997', 3, 41.89, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10643, N'ALFKI', 6, N'8/25/1997', N'9/22/1997', N'9/2/1997', 1, 29.46, N'Alfreds Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10644, N'WELLI', 3, N'8/25/1997', N'9/22/1997', N'9/1/1997', 2, 0.14, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10645, N'HANAR', 4, N'8/26/1997', N'9/23/1997', N'9/2/1997', 1, 12.41, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10646, N'HUNGO', 9, N'8/27/1997', N'10/8/1997', N'9/3/1997', 3, 142.33, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10647, N'QUEDE', 4, N'8/27/1997', N'9/10/1997', N'9/3/1997', 2, 45.54, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10648, N'RICAR', 5, N'8/28/1997', N'10/9/1997', N'9/9/1997', 2, 14.25, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10649, N'MAISD', 5, N'8/28/1997', N'9/25/1997', N'8/29/1997', 3, 6.20, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10650, N'FAMIA', 5, N'8/29/1997', N'9/26/1997', N'9/3/1997', 3, 176.81, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10651, N'WANDK', 8, N'9/1/1997', N'9/29/1997', N'9/11/1997', 2, 20.60, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10652, N'GOURL', 4, N'9/1/1997', N'9/29/1997', N'9/8/1997', 2, 7.14, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10653, N'FRANK', 1, N'9/2/1997', N'9/30/1997', N'9/19/1997', 1, 93.25, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10654, N'BERGS', 5, N'9/2/1997', N'9/30/1997', N'9/11/1997', 1, 55.26, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10655, N'REGGC', 1, N'9/3/1997', N'10/1/1997', N'9/11/1997', 2, 4.41, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10656, N'GREAL', 6, N'9/4/1997', N'10/2/1997', N'9/10/1997', 1, 57.15, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10657, N'SAVEA', 2, N'9/4/1997', N'10/2/1997', N'9/15/1997', 2, 352.69, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10658, N'QUICK', 4, N'9/5/1997', N'10/3/1997', N'9/8/1997', 1, 364.15, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10659, N'QUEEN', 7, N'9/5/1997', N'10/3/1997', N'9/10/1997', 2, 105.81, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10660, N'HUNGC', 8, N'9/8/1997', N'10/6/1997', N'10/15/1997', 1, 111.29, N'Hungry Coyote Import Store', N'City Center Plaza 516 Main St.', N'Elgin', N'OR', N'97827', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10661, N'HUNGO', 7, N'9/9/1997', N'10/7/1997', N'9/15/1997', 3, 17.55, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10662, N'LONEP', 3, N'9/9/1997', N'10/7/1997', N'9/18/1997', 2, 1.28, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10663, N'BONAP', 2, N'9/10/1997', N'9/24/1997', N'10/3/1997', 2, 113.15, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10664, N'FURIB', 1, N'9/10/1997', N'10/8/1997', N'9/19/1997', 3, 1.27, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10665, N'LONEP', 1, N'9/11/1997', N'10/9/1997', N'9/17/1997', 2, 26.31, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10666, N'RICSU', 7, N'9/12/1997', N'10/10/1997', N'9/22/1997', 2, 232.42, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10667, N'ERNSH', 7, N'9/12/1997', N'10/10/1997', N'9/19/1997', 1, 78.09, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10668, N'WANDK', 1, N'9/15/1997', N'10/13/1997', N'9/23/1997', 2, 47.22, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10669, N'SIMOB', 2, N'9/15/1997', N'10/13/1997', N'9/22/1997', 1, 24.39, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10670, N'FRANK', 4, N'9/16/1997', N'10/14/1997', N'9/18/1997', 1, 203.48, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10671, N'FRANR', 1, N'9/17/1997', N'10/15/1997', N'9/24/1997', 1, 30.34, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10672, N'BERGS', 9, N'9/17/1997', N'10/1/1997', N'9/26/1997', 2, 95.75, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10673, N'WILMK', 2, N'9/18/1997', N'10/16/1997', N'9/19/1997', 1, 22.76, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10674, N'ISLAT', 4, N'9/18/1997', N'10/16/1997', N'9/30/1997', 2, 0.90, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10675, N'FRANK', 5, N'9/19/1997', N'10/17/1997', N'9/23/1997', 2, 31.85, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10676, N'TORTU', 2, N'9/22/1997', N'10/20/1997', N'9/29/1997', 2, 2.01, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10677, N'ANTON', 1, N'9/22/1997', N'10/20/1997', N'9/26/1997', 3, 4.03, N'Antonio Moreno Taquería', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10678, N'SAVEA', 7, N'9/23/1997', N'10/21/1997', N'10/16/1997', 3, 388.98, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10679, N'BLONP', 8, N'9/23/1997', N'10/21/1997', N'9/30/1997', 3, 27.94, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10680, N'OLDWO', 1, N'9/24/1997', N'10/22/1997', N'9/26/1997', 1, 26.61, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10681, N'GREAL', 3, N'9/25/1997', N'10/23/1997', N'9/30/1997', 3, 76.13, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10682, N'ANTON', 3, N'9/25/1997', N'10/23/1997', N'10/1/1997', 2, 36.13, N'Antonio Moreno Taquería', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10683, N'DUMON', 2, N'9/26/1997', N'10/24/1997', N'10/1/1997', 1, 4.40, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10684, N'OTTIK', 3, N'9/26/1997', N'10/24/1997', N'9/30/1997', 1, 145.63, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10685, N'GOURL', 4, N'9/29/1997', N'10/13/1997', N'10/3/1997', 2, 33.75, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10686, N'PICCO', 2, N'9/30/1997', N'10/28/1997', N'10/8/1997', 1, 96.50, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10687, N'HUNGO', 9, N'9/30/1997', N'10/28/1997', N'10/30/1997', 2, 296.43, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10688, N'VAFFE', 4, N'10/1/1997', N'10/15/1997', N'10/7/1997', 2, 299.09, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10689, N'BERGS', 1, N'10/1/1997', N'10/29/1997', N'10/7/1997', 2, 13.42, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10690, N'HANAR', 1, N'10/2/1997', N'10/30/1997', N'10/3/1997', 1, 15.80, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10691, N'QUICK', 2, N'10/3/1997', N'11/14/1997', N'10/22/1997', 2, 810.05, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10692, N'ALFKI', 4, N'10/3/1997', N'10/31/1997', N'10/13/1997', 2, 61.02, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10693, N'WHITC', 3, N'10/6/1997', N'10/20/1997', N'10/10/1997', 3, 139.34, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10694, N'QUICK', 8, N'10/6/1997', N'11/3/1997', N'10/9/1997', 3, 398.36, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10695, N'WILMK', 7, N'10/7/1997', N'11/18/1997', N'10/14/1997', 1, 16.72, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10696, N'WHITC', 8, N'10/8/1997', N'11/19/1997', N'10/14/1997', 3, 102.55, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10697, N'LINOD', 3, N'10/8/1997', N'11/5/1997', N'10/14/1997', 1, 45.52, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10698, N'ERNSH', 4, N'10/9/1997', N'11/6/1997', N'10/17/1997', 1, 272.47, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10699, N'MORGK', 3, N'10/9/1997', N'11/6/1997', N'10/13/1997', 3, 0.58, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10700, N'SAVEA', 3, N'10/10/1997', N'11/7/1997', N'10/16/1997', 1, 65.10, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10701, N'HUNGO', 6, N'10/13/1997', N'10/27/1997', N'10/15/1997', 3, 220.31, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10702, N'ALFKI', 4, N'10/13/1997', N'11/24/1997', N'10/21/1997', 1, 23.94, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10703, N'FOLKO', 6, N'10/14/1997', N'11/11/1997', N'10/20/1997', 2, 152.30, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10704, N'QUEEN', 6, N'10/14/1997', N'11/11/1997', N'11/7/1997', 1, 4.78, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10705, N'HILAA', 9, N'10/15/1997', N'11/12/1997', N'11/18/1997', 2, 3.52, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10706, N'OLDWO', 8, N'10/16/1997', N'11/13/1997', N'10/21/1997', 3, 135.63, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10707, N'AROUT', 4, N'10/16/1997', N'10/30/1997', N'10/23/1997', 3, 21.74, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10708, N'THEBI', 6, N'10/17/1997', N'11/28/1997', N'11/5/1997', 2, 2.96, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10709, N'GOURL', 1, N'10/17/1997', N'11/14/1997', N'11/20/1997', 3, 210.80, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10710, N'FRANS', 1, N'10/20/1997', N'11/17/1997', N'10/23/1997', 1, 4.98, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10711, N'SAVEA', 5, N'10/21/1997', N'12/2/1997', N'10/29/1997', 2, 52.41, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10712, N'HUNGO', 3, N'10/21/1997', N'11/18/1997', N'10/31/1997', 1, 89.93, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10713, N'SAVEA', 1, N'10/22/1997', N'11/19/1997', N'10/24/1997', 1, 167.05, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10714, N'SAVEA', 5, N'10/22/1997', N'11/19/1997', N'10/27/1997', 3, 24.49, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10715, N'BONAP', 3, N'10/23/1997', N'11/6/1997', N'10/29/1997', 1, 63.20, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10716, N'RANCH', 4, N'10/24/1997', N'11/21/1997', N'10/27/1997', 2, 22.57, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10717, N'FRANK', 1, N'10/24/1997', N'11/21/1997', N'10/29/1997', 2, 59.25, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10718, N'KOENE', 1, N'10/27/1997', N'11/24/1997', N'10/29/1997', 3, 170.88, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10719, N'LETSS', 8, N'10/27/1997', N'11/24/1997', N'11/5/1997', 2, 51.44, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10720, N'QUEDE', 8, N'10/28/1997', N'11/11/1997', N'11/5/1997', 2, 9.53, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10721, N'QUICK', 5, N'10/29/1997', N'11/26/1997', N'10/31/1997', 3, 48.92, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10722, N'SAVEA', 8, N'10/29/1997', N'12/10/1997', N'11/4/1997', 1, 74.58, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10723, N'WHITC', 3, N'10/30/1997', N'11/27/1997', N'11/25/1997', 1, 21.72, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10724, N'MEREP', 8, N'10/30/1997', N'12/11/1997', N'11/5/1997', 2, 57.75, N'Mère Paillarde', N'43 rue St. Laurent', N'Montréal', N'Québec', N'H1J 1C3', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10725, N'FAMIA', 4, N'10/31/1997', N'11/28/1997', N'11/5/1997', 3, 10.83, N'Familia Arquibaldo', N'Rua Orós, 92', N'Sao Paulo', N'SP', N'05442-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10726, N'EASTC', 4, N'11/3/1997', N'11/17/1997', N'12/5/1997', 1, 16.56, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10727, N'REGGC', 2, N'11/3/1997', N'12/1/1997', N'12/5/1997', 1, 89.90, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10728, N'QUEEN', 4, N'11/4/1997', N'12/2/1997', N'11/11/1997', 2, 58.33, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10729, N'LINOD', 8, N'11/4/1997', N'12/16/1997', N'11/14/1997', 3, 141.06, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10730, N'BONAP', 5, N'11/5/1997', N'12/3/1997', N'11/14/1997', 1, 20.12, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10731, N'CHOPS', 7, N'11/6/1997', N'12/4/1997', N'11/14/1997', 1, 96.65, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10732, N'BONAP', 3, N'11/6/1997', N'12/4/1997', N'11/7/1997', 1, 16.97, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10733, N'BERGS', 1, N'11/7/1997', N'12/5/1997', N'11/10/1997', 3, 110.11, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10734, N'GOURL', 2, N'11/7/1997', N'12/5/1997', N'11/12/1997', 3, 1.63, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10735, N'LETSS', 6, N'11/10/1997', N'12/8/1997', N'11/21/1997', 2, 45.97, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10736, N'HUNGO', 9, N'11/11/1997', N'12/9/1997', N'11/21/1997', 2, 44.10, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10737, N'VINET', 2, N'11/11/1997', N'12/9/1997', N'11/18/1997', 2, 7.79, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10738, N'SPECD', 2, N'11/12/1997', N'12/10/1997', N'11/18/1997', 1, 2.91, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10739, N'VINET', 3, N'11/12/1997', N'12/10/1997', N'11/17/1997', 3, 11.08, N'Vins et alcools Chevalier', N'59 rue de l''Abbaye', N'Reims', NULL, N'51100', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10740, N'WHITC', 4, N'11/13/1997', N'12/11/1997', N'11/25/1997', 2, 81.88, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10741, N'AROUT', 4, N'11/14/1997', N'11/28/1997', N'11/18/1997', 3, 10.96, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10742, N'BOTTM', 3, N'11/14/1997', N'12/12/1997', N'11/18/1997', 3, 243.73, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10743, N'AROUT', 1, N'11/17/1997', N'12/15/1997', N'11/21/1997', 2, 23.72, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10744, N'VAFFE', 6, N'11/17/1997', N'12/15/1997', N'11/24/1997', 1, 69.19, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10745, N'QUICK', 9, N'11/18/1997', N'12/16/1997', N'11/27/1997', 1, 3.52, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10746, N'CHOPS', 1, N'11/19/1997', N'12/17/1997', N'11/21/1997', 3, 31.43, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10747, N'PICCO', 6, N'11/19/1997', N'12/17/1997', N'11/26/1997', 1, 117.33, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10748, N'SAVEA', 3, N'11/20/1997', N'12/18/1997', N'11/28/1997', 1, 232.55, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10749, N'ISLAT', 4, N'11/20/1997', N'12/18/1997', N'12/19/1997', 2, 61.53, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10750, N'WARTH', 9, N'11/21/1997', N'12/19/1997', N'11/24/1997', 1, 79.30, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10751, N'RICSU', 3, N'11/24/1997', N'12/22/1997', N'12/3/1997', 3, 130.79, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10752, N'NORTS', 2, N'11/24/1997', N'12/22/1997', N'11/28/1997', 3, 1.39, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10753, N'FRANS', 3, N'11/25/1997', N'12/23/1997', N'11/27/1997', 1, 7.70, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10754, N'MAGAA', 6, N'11/25/1997', N'12/23/1997', N'11/27/1997', 3, 2.38, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10755, N'BONAP', 4, N'11/26/1997', N'12/24/1997', N'11/28/1997', 2, 16.71, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10756, N'SPLIR', 8, N'11/27/1997', N'12/25/1997', N'12/2/1997', 2, 73.21, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10757, N'SAVEA', 6, N'11/27/1997', N'12/25/1997', N'12/15/1997', 1, 8.19, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10758, N'RICSU', 3, N'11/28/1997', N'12/26/1997', N'12/4/1997', 3, 138.17, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10759, N'ANATR', 3, N'11/28/1997', N'12/26/1997', N'12/12/1997', 3, 11.99, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10760, N'MAISD', 4, N'12/1/1997', N'12/29/1997', N'12/10/1997', 1, 155.64, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10761, N'RATTC', 5, N'12/2/1997', N'12/30/1997', N'12/8/1997', 2, 18.66, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10762, N'FOLKO', 3, N'12/2/1997', N'12/30/1997', N'12/9/1997', 1, 328.74, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10763, N'FOLIG', 3, N'12/3/1997', N'12/31/1997', N'12/8/1997', 3, 37.35, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10764, N'ERNSH', 6, N'12/3/1997', N'12/31/1997', N'12/8/1997', 3, 145.45, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10765, N'QUICK', 3, N'12/4/1997', N'1/1/1998', N'12/9/1997', 3, 42.74, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10766, N'OTTIK', 4, N'12/5/1997', N'1/2/1998', N'12/9/1997', 1, 157.55, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10767, N'SUPRD', 4, N'12/5/1997', N'1/2/1998', N'12/15/1997', 3, 1.59, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10768, N'AROUT', 3, N'12/8/1997', N'1/5/1998', N'12/15/1997', 2, 146.32, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10769, N'VAFFE', 3, N'12/8/1997', N'1/5/1998', N'12/12/1997', 1, 65.06, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10770, N'HANAR', 8, N'12/9/1997', N'1/6/1998', N'12/17/1997', 3, 5.32, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10771, N'ERNSH', 9, N'12/10/1997', N'1/7/1998', N'1/2/1998', 2, 11.19, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10772, N'LEHMS', 3, N'12/10/1997', N'1/7/1998', N'12/19/1997', 2, 91.28, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10773, N'ERNSH', 1, N'12/11/1997', N'1/8/1998', N'12/16/1997', 3, 96.43, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10774, N'FOLKO', 4, N'12/11/1997', N'12/25/1997', N'12/12/1997', 1, 48.20, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10775, N'THECR', 7, N'12/12/1997', N'1/9/1998', N'12/26/1997', 1, 20.25, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10776, N'ERNSH', 1, N'12/15/1997', N'1/12/1998', N'12/18/1997', 3, 351.53, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10777, N'GOURL', 7, N'12/15/1997', N'12/29/1997', N'1/21/1998', 2, 3.01, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10778, N'BERGS', 3, N'12/16/1997', N'1/13/1998', N'12/24/1997', 1, 6.79, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10779, N'MORGK', 3, N'12/16/1997', N'1/13/1998', N'1/14/1998', 2, 58.13, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10780, N'LILAS', 2, N'12/16/1997', N'12/30/1997', N'12/25/1997', 1, 42.13, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10781, N'WARTH', 2, N'12/17/1997', N'1/14/1998', N'12/19/1997', 3, 73.16, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10782, N'CACTU', 9, N'12/17/1997', N'1/14/1998', N'12/22/1997', 3, 1.10, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10783, N'HANAR', 4, N'12/18/1997', N'1/15/1998', N'12/19/1997', 2, 124.98, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10784, N'MAGAA', 4, N'12/18/1997', N'1/15/1998', N'12/22/1997', 3, 70.09, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10785, N'GROSR', 1, N'12/18/1997', N'1/15/1998', N'12/24/1997', 3, 1.51, N'GROSELLA-Restaurante', N'5ª Ave. Los Palos Grandes', N'Caracas', N'DF', N'1081', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10786, N'QUEEN', 8, N'12/19/1997', N'1/16/1998', N'12/23/1997', 1, 110.87, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10787, N'LAMAI', 2, N'12/19/1997', N'1/2/1998', N'12/26/1997', 1, 249.93, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10788, N'QUICK', 1, N'12/22/1997', N'1/19/1998', N'1/19/1998', 2, 42.70, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10789, N'FOLIG', 1, N'12/22/1997', N'1/19/1998', N'12/31/1997', 2, 100.60, N'Folies gourmandes', N'184, chaussée de Tournai', N'Lille', NULL, N'59000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10790, N'GOURL', 6, N'12/22/1997', N'1/19/1998', N'12/26/1997', 1, 28.23, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10791, N'FRANK', 6, N'12/23/1997', N'1/20/1998', N'1/1/1998', 2, 16.85, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10792, N'WOLZA', 1, N'12/23/1997', N'1/20/1998', N'12/31/1997', 3, 23.79, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10793, N'AROUT', 3, N'12/24/1997', N'1/21/1998', N'1/8/1998', 3, 4.52, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10794, N'QUEDE', 6, N'12/24/1997', N'1/21/1998', N'1/2/1998', 1, 21.49, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10795, N'ERNSH', 8, N'12/24/1997', N'1/21/1998', N'1/20/1998', 2, 126.66, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10796, N'HILAA', 3, N'12/25/1997', N'1/22/1998', N'1/14/1998', 1, 26.52, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10797, N'DRACD', 7, N'12/25/1997', N'1/22/1998', N'1/5/1998', 2, 33.35, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10798, N'ISLAT', 2, N'12/26/1997', N'1/23/1998', N'1/5/1998', 1, 2.33, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10799, N'KOENE', 9, N'12/26/1997', N'2/6/1998', N'1/5/1998', 3, 30.76, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10800, N'SEVES', 1, N'12/26/1997', N'1/23/1998', N'1/5/1998', 3, 137.44, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10801, N'BOLID', 4, N'12/29/1997', N'1/26/1998', N'12/31/1997', 2, 97.09, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10802, N'SIMOB', 4, N'12/29/1997', N'1/26/1998', N'1/2/1998', 2, 257.26, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10803, N'WELLI', 4, N'12/30/1997', N'1/27/1998', N'1/6/1998', 1, 55.23, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10804, N'SEVES', 6, N'12/30/1997', N'1/27/1998', N'1/7/1998', 2, 27.33, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10805, N'THEBI', 2, N'12/30/1997', N'1/27/1998', N'1/9/1998', 3, 237.34, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10806, N'VICTE', 3, N'12/31/1997', N'1/28/1998', N'1/5/1998', 2, 22.11, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10807, N'FRANS', 4, N'12/31/1997', N'1/28/1998', N'1/30/1998', 1, 1.36, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10808, N'OLDWO', 2, N'1/1/1998', N'1/29/1998', N'1/9/1998', 3, 45.53, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10809, N'WELLI', 7, N'1/1/1998', N'1/29/1998', N'1/7/1998', 1, 4.87, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10810, N'LAUGB', 2, N'1/1/1998', N'1/29/1998', N'1/7/1998', 3, 4.33, N'Laughing Bacchus Wine Cellars', N'2319 Elm St.', N'Vancouver', N'BC', N'V3F 2K1', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10811, N'LINOD', 8, N'1/2/1998', N'1/30/1998', N'1/8/1998', 1, 31.22, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10812, N'REGGC', 5, N'1/2/1998', N'1/30/1998', N'1/12/1998', 1, 59.78, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10813, N'RICAR', 1, N'1/5/1998', N'2/2/1998', N'1/9/1998', 1, 47.38, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10814, N'VICTE', 3, N'1/5/1998', N'2/2/1998', N'1/14/1998', 3, 130.94, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10815, N'SAVEA', 2, N'1/5/1998', N'2/2/1998', N'1/14/1998', 3, 14.62, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10816, N'GREAL', 4, N'1/6/1998', N'2/3/1998', N'2/4/1998', 2, 719.78, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10817, N'KOENE', 3, N'1/6/1998', N'1/20/1998', N'1/13/1998', 2, 306.07, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10818, N'MAGAA', 7, N'1/7/1998', N'2/4/1998', N'1/12/1998', 3, 65.48, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10819, N'CACTU', 2, N'1/7/1998', N'2/4/1998', N'1/16/1998', 3, 19.76, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10820, N'RATTC', 3, N'1/7/1998', N'2/4/1998', N'1/13/1998', 2, 37.52, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10821, N'SPLIR', 1, N'1/8/1998', N'2/5/1998', N'1/15/1998', 1, 36.68, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10822, N'TRAIH', 6, N'1/8/1998', N'2/5/1998', N'1/16/1998', 3, 7.00, N'Trail''s Head Gourmet Provisioners', N'722 DaVinci Blvd.', N'Kirkland', N'WA', N'98034', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10823, N'LILAS', 5, N'1/9/1998', N'2/6/1998', N'1/13/1998', 2, 163.97, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10824, N'FOLKO', 8, N'1/9/1998', N'2/6/1998', N'1/30/1998', 1, 1.23, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10825, N'DRACD', 1, N'1/9/1998', N'2/6/1998', N'1/14/1998', 1, 79.25, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10826, N'BLONP', 6, N'1/12/1998', N'2/9/1998', N'2/6/1998', 1, 7.09, N'Blondel père et fils', N'24, place Kléber', N'Strasbourg', NULL, N'67000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10827, N'BONAP', 1, N'1/12/1998', N'1/26/1998', N'2/6/1998', 2, 63.54, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10828, N'RANCH', 9, N'1/13/1998', N'1/27/1998', N'2/4/1998', 1, 90.85, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10829, N'ISLAT', 9, N'1/13/1998', N'2/10/1998', N'1/23/1998', 1, 154.72, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10830, N'TRADH', 4, N'1/13/1998', N'2/24/1998', N'1/21/1998', 2, 81.83, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10831, N'SANTG', 3, N'1/14/1998', N'2/11/1998', N'1/23/1998', 2, 72.19, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10832, N'LAMAI', 2, N'1/14/1998', N'2/11/1998', N'1/19/1998', 2, 43.26, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10833, N'OTTIK', 6, N'1/15/1998', N'2/12/1998', N'1/23/1998', 2, 71.49, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10834, N'TRADH', 1, N'1/15/1998', N'2/12/1998', N'1/19/1998', 3, 29.78, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10835, N'ALFKI', 1, N'1/15/1998', N'2/12/1998', N'1/21/1998', 3, 69.53, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10836, N'ERNSH', 7, N'1/16/1998', N'2/13/1998', N'1/21/1998', 1, 411.88, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10837, N'BERGS', 9, N'1/16/1998', N'2/13/1998', N'1/23/1998', 3, 13.32, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10838, N'LINOD', 3, N'1/19/1998', N'2/16/1998', N'1/23/1998', 3, 59.28, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10839, N'TRADH', 3, N'1/19/1998', N'2/16/1998', N'1/22/1998', 3, 35.43, N'Tradiçao Hipermercados', N'Av. Inês de Castro, 414', N'Sao Paulo', N'SP', N'05634-030', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10840, N'LINOD', 4, N'1/19/1998', N'3/2/1998', N'2/16/1998', 2, 2.71, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10841, N'SUPRD', 5, N'1/20/1998', N'2/17/1998', N'1/29/1998', 2, 424.30, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10842, N'TORTU', 1, N'1/20/1998', N'2/17/1998', N'1/29/1998', 3, 54.42, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10843, N'VICTE', 4, N'1/21/1998', N'2/18/1998', N'1/26/1998', 2, 9.26, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10844, N'PICCO', 8, N'1/21/1998', N'2/18/1998', N'1/26/1998', 2, 25.22, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10845, N'QUICK', 8, N'1/21/1998', N'2/4/1998', N'1/30/1998', 1, 212.98, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10846, N'SUPRD', 2, N'1/22/1998', N'3/5/1998', N'1/23/1998', 3, 56.46, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10847, N'SAVEA', 4, N'1/22/1998', N'2/5/1998', N'2/10/1998', 3, 487.57, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10848, N'CONSH', 7, N'1/23/1998', N'2/20/1998', N'1/29/1998', 2, 38.24, N'Consolidated Holdings', N'Berkeley Gardens 12 Brewery', N'London', NULL, N'WX1 6LT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10849, N'KOENE', 9, N'1/23/1998', N'2/20/1998', N'1/30/1998', 2, 0.56, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10850, N'VICTE', 1, N'1/23/1998', N'3/6/1998', N'1/30/1998', 1, 49.19, N'Victuailles en stock', N'2, rue du Commerce', N'Lyon', NULL, N'69004', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10851, N'RICAR', 5, N'1/26/1998', N'2/23/1998', N'2/2/1998', 1, 160.55, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10852, N'RATTC', 8, N'1/26/1998', N'2/9/1998', N'1/30/1998', 1, 174.05, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10853, N'BLAUS', 9, N'1/27/1998', N'2/24/1998', N'2/3/1998', 2, 53.83, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10854, N'ERNSH', 3, N'1/27/1998', N'2/24/1998', N'2/5/1998', 2, 100.22, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10855, N'OLDWO', 3, N'1/27/1998', N'2/24/1998', N'2/4/1998', 1, 170.97, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10856, N'ANTON', 3, N'1/28/1998', N'2/25/1998', N'2/10/1998', 2, 58.43, N'Antonio Moreno Taquería', N'Mataderos 2312', N'México D.F.', NULL, N'05023', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10857, N'BERGS', 8, N'1/28/1998', N'2/25/1998', N'2/6/1998', 2, 188.85, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10858, N'LACOR', 2, N'1/29/1998', N'2/26/1998', N'2/3/1998', 1, 52.51, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10859, N'FRANK', 1, N'1/29/1998', N'2/26/1998', N'2/2/1998', 2, 76.10, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10860, N'FRANR', 3, N'1/29/1998', N'2/26/1998', N'2/4/1998', 3, 19.26, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10861, N'WHITC', 4, N'1/30/1998', N'2/27/1998', N'2/17/1998', 2, 14.93, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10862, N'LEHMS', 8, N'1/30/1998', N'3/13/1998', N'2/2/1998', 2, 53.23, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10863, N'HILAA', 4, N'2/2/1998', N'3/2/1998', N'2/17/1998', 2, 30.26, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10864, N'AROUT', 4, N'2/2/1998', N'3/2/1998', N'2/9/1998', 2, 3.04, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10865, N'QUICK', 2, N'2/2/1998', N'2/16/1998', N'2/12/1998', 1, 348.14, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10866, N'BERGS', 5, N'2/3/1998', N'3/3/1998', N'2/12/1998', 1, 109.11, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10867, N'LONEP', 6, N'2/3/1998', N'3/17/1998', N'2/11/1998', 1, 1.93, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10868, N'QUEEN', 7, N'2/4/1998', N'3/4/1998', N'2/23/1998', 2, 191.27, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10869, N'SEVES', 5, N'2/4/1998', N'3/4/1998', N'2/9/1998', 1, 143.28, N'Seven Seas Imports', N'90 Wadhurst Rd.', N'London', NULL, N'OX15 4NB', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10870, N'WOLZA', 5, N'2/4/1998', N'3/4/1998', N'2/13/1998', 3, 12.04, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10871, N'BONAP', 9, N'2/5/1998', N'3/5/1998', N'2/10/1998', 2, 112.27, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10872, N'GODOS', 5, N'2/5/1998', N'3/5/1998', N'2/9/1998', 2, 175.32, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10873, N'WILMK', 4, N'2/6/1998', N'3/6/1998', N'2/9/1998', 1, 0.82, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10874, N'GODOS', 5, N'2/6/1998', N'3/6/1998', N'2/11/1998', 2, 19.58, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10875, N'BERGS', 4, N'2/6/1998', N'3/6/1998', N'3/3/1998', 2, 32.37, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10876, N'BONAP', 7, N'2/9/1998', N'3/9/1998', N'2/12/1998', 3, 60.42, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10877, N'RICAR', 1, N'2/9/1998', N'3/9/1998', N'2/19/1998', 1, 38.06, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10878, N'QUICK', 4, N'2/10/1998', N'3/10/1998', N'2/12/1998', 1, 46.69, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10879, N'WILMK', 3, N'2/10/1998', N'3/10/1998', N'2/12/1998', 3, 8.50, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10880, N'FOLKO', 7, N'2/10/1998', N'3/24/1998', N'2/18/1998', 1, 88.01, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10881, N'CACTU', 4, N'2/11/1998', N'3/11/1998', N'2/18/1998', 1, 2.84, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10882, N'SAVEA', 4, N'2/11/1998', N'3/11/1998', N'2/20/1998', 3, 23.10, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10883, N'LONEP', 8, N'2/12/1998', N'3/12/1998', N'2/20/1998', 3, 0.53, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10884, N'LETSS', 4, N'2/12/1998', N'3/12/1998', N'2/13/1998', 2, 90.97, N'Let''s Stop N Shop', N'87 Polk St. Suite 5', N'San Francisco', N'CA', N'94117', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10885, N'SUPRD', 6, N'2/12/1998', N'3/12/1998', N'2/18/1998', 3, 5.64, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10886, N'HANAR', 1, N'2/13/1998', N'3/13/1998', N'3/2/1998', 1, 4.99, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10887, N'GALED', 8, N'2/13/1998', N'3/13/1998', N'2/16/1998', 3, 1.25, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10888, N'GODOS', 1, N'2/16/1998', N'3/16/1998', N'2/23/1998', 2, 51.87, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10889, N'RATTC', 9, N'2/16/1998', N'3/16/1998', N'2/23/1998', 3, 280.61, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10890, N'DUMON', 7, N'2/16/1998', N'3/16/1998', N'2/18/1998', 1, 32.76, N'Du monde entier', N'67, rue des Cinquante Otages', N'Nantes', NULL, N'44000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10891, N'LEHMS', 7, N'2/17/1998', N'3/17/1998', N'2/19/1998', 2, 20.37, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10892, N'MAISD', 4, N'2/17/1998', N'3/17/1998', N'2/19/1998', 2, 120.27, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10893, N'KOENE', 9, N'2/18/1998', N'3/18/1998', N'2/20/1998', 2, 77.78, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10894, N'SAVEA', 1, N'2/18/1998', N'3/18/1998', N'2/20/1998', 1, 116.13, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10895, N'ERNSH', 3, N'2/18/1998', N'3/18/1998', N'2/23/1998', 1, 162.75, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10896, N'MAISD', 7, N'2/19/1998', N'3/19/1998', N'2/27/1998', 3, 32.45, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10897, N'HUNGO', 3, N'2/19/1998', N'3/19/1998', N'2/25/1998', 2, 603.54, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10898, N'OCEAN', 4, N'2/20/1998', N'3/20/1998', N'3/6/1998', 2, 1.27, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10899, N'LILAS', 5, N'2/20/1998', N'3/20/1998', N'2/26/1998', 3, 1.21, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10900, N'WELLI', 1, N'2/20/1998', N'3/20/1998', N'3/4/1998', 2, 1.66, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10901, N'HILAA', 4, N'2/23/1998', N'3/23/1998', N'2/26/1998', 1, 62.09, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10902, N'FOLKO', 1, N'2/23/1998', N'3/23/1998', N'3/3/1998', 1, 44.15, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10903, N'HANAR', 3, N'2/24/1998', N'3/24/1998', N'3/4/1998', 3, 36.71, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10904, N'WHITC', 3, N'2/24/1998', N'3/24/1998', N'2/27/1998', 3, 162.95, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10905, N'WELLI', 9, N'2/24/1998', N'3/24/1998', N'3/6/1998', 2, 13.72, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10906, N'WOLZA', 4, N'2/25/1998', N'3/11/1998', N'3/3/1998', 3, 26.29, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10907, N'SPECD', 6, N'2/25/1998', N'3/25/1998', N'2/27/1998', 3, 9.19, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10908, N'REGGC', 4, N'2/26/1998', N'3/26/1998', N'3/6/1998', 2, 32.96, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10909, N'SANTG', 1, N'2/26/1998', N'3/26/1998', N'3/10/1998', 2, 53.05, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10910, N'WILMK', 1, N'2/26/1998', N'3/26/1998', N'3/4/1998', 3, 38.11, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10911, N'GODOS', 3, N'2/26/1998', N'3/26/1998', N'3/5/1998', 1, 38.19, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10912, N'HUNGO', 2, N'2/26/1998', N'3/26/1998', N'3/18/1998', 2, 580.91, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10913, N'QUEEN', 4, N'2/26/1998', N'3/26/1998', N'3/4/1998', 1, 33.05, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10914, N'QUEEN', 6, N'2/27/1998', N'3/27/1998', N'3/2/1998', 1, 21.19, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10915, N'TORTU', 2, N'2/27/1998', N'3/27/1998', N'3/2/1998', 2, 3.51, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10916, N'RANCH', 1, N'2/27/1998', N'3/27/1998', N'3/9/1998', 2, 63.77, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10917, N'ROMEY', 4, N'3/2/1998', N'3/30/1998', N'3/11/1998', 2, 8.29, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10918, N'BOTTM', 3, N'3/2/1998', N'3/30/1998', N'3/11/1998', 3, 48.83, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10919, N'LINOD', 2, N'3/2/1998', N'3/30/1998', N'3/4/1998', 2, 19.80, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10920, N'AROUT', 4, N'3/3/1998', N'3/31/1998', N'3/9/1998', 2, 29.61, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10921, N'VAFFE', 1, N'3/3/1998', N'4/14/1998', N'3/9/1998', 1, 176.48, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10922, N'HANAR', 5, N'3/3/1998', N'3/31/1998', N'3/5/1998', 3, 62.74, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10923, N'LAMAI', 7, N'3/3/1998', N'4/14/1998', N'3/13/1998', 3, 68.26, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10924, N'BERGS', 3, N'3/4/1998', N'4/1/1998', N'4/8/1998', 2, 151.52, N'Berglunds snabbköp', N'Berguvsvägen 8', N'Luleå', NULL, N'S-958 22', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10925, N'HANAR', 3, N'3/4/1998', N'4/1/1998', N'3/13/1998', 1, 2.27, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10926, N'ANATR', 4, N'3/4/1998', N'4/1/1998', N'3/11/1998', 3, 39.92, N'Ana Trujillo Emparedados y helados', N'Avda. de la Constitución 2222', N'México D.F.', NULL, N'05021', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10927, N'LACOR', 4, N'3/5/1998', N'4/2/1998', N'4/8/1998', 1, 19.79, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10928, N'GALED', 1, N'3/5/1998', N'4/2/1998', N'3/18/1998', 1, 1.36, N'Galería del gastronómo', N'Rambla de Cataluña, 23', N'Barcelona', NULL, N'8022', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10929, N'FRANK', 6, N'3/5/1998', N'4/2/1998', N'3/12/1998', 1, 33.93, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10930, N'SUPRD', 4, N'3/6/1998', N'4/17/1998', N'3/18/1998', 3, 15.55, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10931, N'RICSU', 4, N'3/6/1998', N'3/20/1998', N'3/19/1998', 2, 13.60, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10932, N'BONAP', 8, N'3/6/1998', N'4/3/1998', N'3/24/1998', 1, 134.64, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10933, N'ISLAT', 6, N'3/6/1998', N'4/3/1998', N'3/16/1998', 3, 54.15, N'Island Trading', N'Garden House Crowther Way', N'Cowes', N'Isle of Wight', N'PO31 7PJ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10934, N'LEHMS', 3, N'3/9/1998', N'4/6/1998', N'3/12/1998', 3, 32.01, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10935, N'WELLI', 4, N'3/9/1998', N'4/6/1998', N'3/18/1998', 3, 47.59, N'Wellington Importadora', N'Rua do Mercado, 12', N'Resende', N'SP', N'08737-363', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10936, N'GREAL', 3, N'3/9/1998', N'4/6/1998', N'3/18/1998', 2, 33.68, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10937, N'CACTU', 7, N'3/10/1998', N'3/24/1998', N'3/13/1998', 3, 31.51, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10938, N'QUICK', 3, N'3/10/1998', N'4/7/1998', N'3/16/1998', 2, 31.89, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10939, N'MAGAA', 2, N'3/10/1998', N'4/7/1998', N'3/13/1998', 2, 76.33, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10940, N'BONAP', 8, N'3/11/1998', N'4/8/1998', N'3/23/1998', 3, 19.77, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10941, N'SAVEA', 7, N'3/11/1998', N'4/8/1998', N'3/20/1998', 2, 400.81, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10942, N'REGGC', 9, N'3/11/1998', N'4/8/1998', N'3/18/1998', 3, 17.95, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10943, N'BSBEV', 4, N'3/11/1998', N'4/8/1998', N'3/19/1998', 2, 2.17, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10944, N'BOTTM', 6, N'3/12/1998', N'3/26/1998', N'3/13/1998', 3, 52.92, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10945, N'MORGK', 4, N'3/12/1998', N'4/9/1998', N'3/18/1998', 1, 10.22, N'Morgenstern Gesundkost', N'Heerstr. 22', N'Leipzig', NULL, N'04179', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10946, N'VAFFE', 1, N'3/12/1998', N'4/9/1998', N'3/19/1998', 2, 27.20, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10947, N'BSBEV', 3, N'3/13/1998', N'4/10/1998', N'3/16/1998', 2, 3.26, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10948, N'GODOS', 3, N'3/13/1998', N'4/10/1998', N'3/19/1998', 3, 23.39, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10949, N'BOTTM', 2, N'3/13/1998', N'4/10/1998', N'3/17/1998', 3, 74.44, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10950, N'MAGAA', 1, N'3/16/1998', N'4/13/1998', N'3/23/1998', 2, 2.50, N'Magazzini Alimentari Riuniti', N'Via Ludovico il Moro 22', N'Bergamo', NULL, N'24100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10951, N'RICSU', 9, N'3/16/1998', N'4/27/1998', N'4/7/1998', 2, 30.85, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10952, N'ALFKI', 1, N'3/16/1998', N'4/27/1998', N'3/24/1998', 1, 40.42, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10953, N'AROUT', 9, N'3/16/1998', N'3/30/1998', N'3/25/1998', 2, 23.72, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10954, N'LINOD', 5, N'3/17/1998', N'4/28/1998', N'3/20/1998', 1, 27.91, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10955, N'FOLKO', 8, N'3/17/1998', N'4/14/1998', N'3/20/1998', 2, 3.26, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10956, N'BLAUS', 6, N'3/17/1998', N'4/28/1998', N'3/20/1998', 2, 44.65, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10957, N'HILAA', 8, N'3/18/1998', N'4/15/1998', N'3/27/1998', 3, 105.36, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10958, N'OCEAN', 7, N'3/18/1998', N'4/15/1998', N'3/27/1998', 2, 49.56, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10959, N'GOURL', 6, N'3/18/1998', N'4/29/1998', N'3/23/1998', 2, 4.98, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10960, N'HILAA', 3, N'3/19/1998', N'4/2/1998', N'4/8/1998', 1, 2.08, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10961, N'QUEEN', 8, N'3/19/1998', N'4/16/1998', N'3/30/1998', 1, 104.47, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10962, N'QUICK', 8, N'3/19/1998', N'4/16/1998', N'3/23/1998', 2, 275.79, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10963, N'FURIB', 9, N'3/19/1998', N'4/16/1998', N'3/26/1998', 3, 2.70, N'Furia Bacalhau e Frutos do Mar', N'Jardim das rosas n. 32', N'Lisboa', NULL, N'1675', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10964, N'SPECD', 3, N'3/20/1998', N'4/17/1998', N'3/24/1998', 2, 87.38, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10965, N'OLDWO', 6, N'3/20/1998', N'4/17/1998', N'3/30/1998', 3, 144.38, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10966, N'CHOPS', 4, N'3/20/1998', N'4/17/1998', N'4/8/1998', 1, 27.19, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10967, N'TOMSP', 2, N'3/23/1998', N'4/20/1998', N'4/2/1998', 2, 62.22, N'Toms Spezialitäten', N'Luisenstr. 48', N'Münster', NULL, N'44087', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10968, N'ERNSH', 1, N'3/23/1998', N'4/20/1998', N'4/1/1998', 3, 74.60, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10969, N'COMMI', 1, N'3/23/1998', N'4/20/1998', N'3/30/1998', 2, 0.21, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10970, N'BOLID', 9, N'3/24/1998', N'4/7/1998', N'4/24/1998', 1, 16.16, N'Bólido Comidas preparadas', N'C/ Araquil, 67', N'Madrid', NULL, N'28023', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10971, N'FRANR', 2, N'3/24/1998', N'4/21/1998', N'4/2/1998', 2, 121.82, N'France restauration', N'54, rue Royale', N'Nantes', NULL, N'44000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10972, N'LACOR', 4, N'3/24/1998', N'4/21/1998', N'3/26/1998', 2, 0.02, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10973, N'LACOR', 6, N'3/24/1998', N'4/21/1998', N'3/27/1998', 2, 15.17, N'La corne d''abondance', N'67, avenue de l''Europe', N'Versailles', NULL, N'78000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10974, N'SPLIR', 3, N'3/25/1998', N'4/8/1998', N'4/3/1998', 3, 12.96, N'Split Rail Beer & Ale', N'P.O. Box 555', N'Lander', N'WY', N'82520', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10975, N'BOTTM', 1, N'3/25/1998', N'4/22/1998', N'3/27/1998', 3, 32.27, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10976, N'HILAA', 1, N'3/25/1998', N'5/6/1998', N'4/3/1998', 1, 37.97, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10977, N'FOLKO', 8, N'3/26/1998', N'4/23/1998', N'4/10/1998', 3, 208.50, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10978, N'MAISD', 9, N'3/26/1998', N'4/23/1998', N'4/23/1998', 2, 32.82, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10979, N'ERNSH', 8, N'3/26/1998', N'4/23/1998', N'3/31/1998', 2, 353.07, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10980, N'FOLKO', 4, N'3/27/1998', N'5/8/1998', N'4/17/1998', 1, 1.26, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10981, N'HANAR', 1, N'3/27/1998', N'4/24/1998', N'4/2/1998', 2, 193.37, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10982, N'BOTTM', 2, N'3/27/1998', N'4/24/1998', N'4/8/1998', 1, 14.01, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10983, N'SAVEA', 2, N'3/27/1998', N'4/24/1998', N'4/6/1998', 2, 657.54, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10984, N'SAVEA', 1, N'3/30/1998', N'4/27/1998', N'4/3/1998', 3, 211.22, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10985, N'HUNGO', 2, N'3/30/1998', N'4/27/1998', N'4/2/1998', 1, 91.51, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10986, N'OCEAN', 8, N'3/30/1998', N'4/27/1998', N'4/21/1998', 2, 217.86, N'Océano Atlántico Ltda.', N'Ing. Gustavo Moncada 8585 Piso 20-A', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10987, N'EASTC', 8, N'3/31/1998', N'4/28/1998', N'4/6/1998', 1, 185.48, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10988, N'RATTC', 3, N'3/31/1998', N'4/28/1998', N'4/10/1998', 2, 61.14, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10989, N'QUEDE', 2, N'3/31/1998', N'4/28/1998', N'4/2/1998', 1, 34.76, N'Que Delícia', N'Rua da Panificadora, 12', N'Rio de Janeiro', N'RJ', N'02389-673', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10990, N'ERNSH', 2, N'4/1/1998', N'5/13/1998', N'4/7/1998', 3, 117.61, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10991, N'QUICK', 1, N'4/1/1998', N'4/29/1998', N'4/7/1998', 1, 38.51, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10992, N'THEBI', 1, N'4/1/1998', N'4/29/1998', N'4/3/1998', 3, 4.27, N'The Big Cheese', N'89 Jefferson Way Suite 2', N'Portland', N'OR', N'97201', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10993, N'FOLKO', 7, N'4/1/1998', N'4/29/1998', N'4/10/1998', 3, 8.81, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10994, N'VAFFE', 2, N'4/2/1998', N'4/16/1998', N'4/9/1998', 3, 65.53, N'Vaffeljernet', N'Smagsloget 45', N'Århus', NULL, N'8200', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10995, N'PERIC', 1, N'4/2/1998', N'4/30/1998', N'4/6/1998', 3, 46.00, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10996, N'QUICK', 4, N'4/2/1998', N'4/30/1998', N'4/10/1998', 2, 1.12, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10997, N'LILAS', 8, N'4/3/1998', N'5/15/1998', N'4/13/1998', 2, 73.91, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10998, N'WOLZA', 8, N'4/3/1998', N'4/17/1998', N'4/17/1998', 2, 20.31, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (10999, N'OTTIK', 6, N'4/3/1998', N'5/1/1998', N'4/10/1998', 2, 96.35, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11000, N'RATTC', 2, N'4/6/1998', N'5/4/1998', N'4/14/1998', 3, 55.12, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11001, N'FOLKO', 2, N'4/6/1998', N'5/4/1998', N'4/14/1998', 2, 197.30, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11002, N'SAVEA', 4, N'4/6/1998', N'5/4/1998', N'4/16/1998', 1, 141.16, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11003, N'THECR', 3, N'4/6/1998', N'5/4/1998', N'4/8/1998', 3, 14.91, N'The Cracker Box', N'55 Grizzly Peak Rd.', N'Butte', N'MT', N'59801', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11004, N'MAISD', 3, N'4/7/1998', N'5/5/1998', N'4/20/1998', 1, 44.84, N'Maison Dewey', N'Rue Joseph-Bens 532', N'Bruxelles', NULL, N'B-1180', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11005, N'WILMK', 2, N'4/7/1998', N'5/5/1998', N'4/10/1998', 1, 0.75, N'Wilman Kala', N'Keskuskatu 45', N'Helsinki', NULL, N'21240', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11006, N'GREAL', 3, N'4/7/1998', N'5/5/1998', N'4/15/1998', 2, 25.19, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11007, N'PRINI', 8, N'4/8/1998', N'5/6/1998', N'4/13/1998', 2, 202.24, N'Princesa Isabel Vinhos', N'Estrada da saúde n. 58', N'Lisboa', NULL, N'1756', N'Portugal');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11008, N'ERNSH', 7, N'4/8/1998', N'5/6/1998', NULL, 3, 79.46, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11009, N'GODOS', 2, N'4/8/1998', N'5/6/1998', N'4/10/1998', 1, 59.11, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11010, N'REGGC', 2, N'4/9/1998', N'5/7/1998', N'4/21/1998', 2, 28.71, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11011, N'ALFKI', 3, N'4/9/1998', N'5/7/1998', N'4/13/1998', 1, 1.21, N'Alfred''s Futterkiste', N'Obere Str. 57', N'Berlin', NULL, N'12209', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11012, N'FRANK', 1, N'4/9/1998', N'4/23/1998', N'4/17/1998', 3, 242.95, N'Frankenversand', N'Berliner Platz 43', N'München', NULL, N'80805', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11013, N'ROMEY', 2, N'4/9/1998', N'5/7/1998', N'4/10/1998', 1, 32.99, N'Romero y tomillo', N'Gran Vía, 1', N'Madrid', NULL, N'28001', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11014, N'LINOD', 2, N'4/10/1998', N'5/8/1998', N'4/15/1998', 3, 23.60, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11015, N'SANTG', 2, N'4/10/1998', N'4/24/1998', N'4/20/1998', 2, 4.62, N'Santé Gourmet', N'Erling Skakkes gate 78', N'Stavern', NULL, N'4110', N'Norway');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11016, N'AROUT', 9, N'4/10/1998', N'5/8/1998', N'4/13/1998', 2, 33.80, N'Around the Horn', N'Brook Farm Stratford St. Mary', N'Colchester', N'Essex', N'CO7 6JX', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11017, N'ERNSH', 9, N'4/13/1998', N'5/11/1998', N'4/20/1998', 2, 754.26, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11018, N'LONEP', 4, N'4/13/1998', N'5/11/1998', N'4/16/1998', 2, 11.65, N'Lonesome Pine Restaurant', N'89 Chiaroscuro Rd.', N'Portland', N'OR', N'97219', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11019, N'RANCH', 6, N'4/13/1998', N'5/11/1998', NULL, 3, 3.17, N'Rancho grande', N'Av. del Libertador 900', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11020, N'OTTIK', 2, N'4/14/1998', N'5/12/1998', N'4/16/1998', 2, 43.30, N'Ottilies Käseladen', N'Mehrheimerstr. 369', N'Köln', NULL, N'50739', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11021, N'QUICK', 3, N'4/14/1998', N'5/12/1998', N'4/21/1998', 1, 297.18, N'QUICK-Stop', N'Taucherstraße 10', N'Cunewalde', NULL, N'01307', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11022, N'HANAR', 9, N'4/14/1998', N'5/12/1998', N'5/4/1998', 2, 6.27, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11023, N'BSBEV', 1, N'4/14/1998', N'4/28/1998', N'4/24/1998', 2, 123.83, N'B''s Beverages', N'Fauntleroy Circus', N'London', NULL, N'EC2 5NT', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11024, N'EASTC', 4, N'4/15/1998', N'5/13/1998', N'4/20/1998', 1, 74.36, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11025, N'WARTH', 6, N'4/15/1998', N'5/13/1998', N'4/24/1998', 3, 29.17, N'Wartian Herkku', N'Torikatu 38', N'Oulu', NULL, N'90110', N'Finland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11026, N'FRANS', 4, N'4/15/1998', N'5/13/1998', N'4/28/1998', 1, 47.09, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11027, N'BOTTM', 1, N'4/16/1998', N'5/14/1998', N'4/20/1998', 1, 52.52, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11028, N'KOENE', 2, N'4/16/1998', N'5/14/1998', N'4/22/1998', 1, 29.59, N'Königlich Essen', N'Maubelstr. 90', N'Brandenburg', NULL, N'14776', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11029, N'CHOPS', 4, N'4/16/1998', N'5/14/1998', N'4/27/1998', 1, 47.84, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11030, N'SAVEA', 7, N'4/17/1998', N'5/15/1998', N'4/27/1998', 2, 830.75, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11031, N'SAVEA', 6, N'4/17/1998', N'5/15/1998', N'4/24/1998', 2, 227.22, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11032, N'WHITC', 2, N'4/17/1998', N'5/15/1998', N'4/23/1998', 3, 606.19, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11033, N'RICSU', 7, N'4/17/1998', N'5/15/1998', N'4/23/1998', 3, 84.74, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11034, N'OLDWO', 8, N'4/20/1998', N'6/1/1998', N'4/27/1998', 1, 40.32, N'Old World Delicatessen', N'2743 Bering St.', N'Anchorage', N'AK', N'99508', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11035, N'SUPRD', 2, N'4/20/1998', N'5/18/1998', N'4/24/1998', 2, 0.17, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11036, N'DRACD', 8, N'4/20/1998', N'5/18/1998', N'4/22/1998', 3, 149.47, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11037, N'GODOS', 7, N'4/21/1998', N'5/19/1998', N'4/27/1998', 1, 3.20, N'Godos Cocina Típica', N'C/ Romero, 33', N'Sevilla', NULL, N'41101', N'Spain');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11038, N'SUPRD', 1, N'4/21/1998', N'5/19/1998', N'4/30/1998', 2, 29.59, N'Suprêmes délices', N'Boulevard Tirou, 255', N'Charleroi', NULL, N'B-6000', N'Belgium');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11039, N'LINOD', 1, N'4/21/1998', N'5/19/1998', NULL, 2, 65.00, N'LINO-Delicateses', N'Ave. 5 de Mayo Porlamar', N'I. de Margarita', N'Nueva Esparta', N'4980', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11040, N'GREAL', 4, N'4/22/1998', N'5/20/1998', NULL, 3, 18.84, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11041, N'CHOPS', 3, N'4/22/1998', N'5/20/1998', N'4/28/1998', 2, 48.22, N'Chop-suey Chinese', N'Hauptstr. 31', N'Bern', NULL, N'3012', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11042, N'COMMI', 2, N'4/22/1998', N'5/6/1998', N'5/1/1998', 1, 29.99, N'Comércio Mineiro', N'Av. dos Lusíadas, 23', N'Sao Paulo', N'SP', N'05432-043', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11043, N'SPECD', 5, N'4/22/1998', N'5/20/1998', N'4/29/1998', 2, 8.80, N'Spécialités du monde', N'25, rue Lauriston', N'Paris', NULL, N'75016', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11044, N'WOLZA', 4, N'4/23/1998', N'5/21/1998', N'5/1/1998', 1, 8.72, N'Wolski Zajazd', N'ul. Filtrowa 68', N'Warszawa', NULL, N'01-012', N'Poland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11045, N'BOTTM', 6, N'4/23/1998', N'5/21/1998', NULL, 2, 70.58, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11046, N'WANDK', 8, N'4/23/1998', N'5/21/1998', N'4/24/1998', 2, 71.64, N'Die Wandernde Kuh', N'Adenauerallee 900', N'Stuttgart', NULL, N'70563', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11047, N'EASTC', 7, N'4/24/1998', N'5/22/1998', N'5/1/1998', 3, 46.62, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11048, N'BOTTM', 7, N'4/24/1998', N'5/22/1998', N'4/30/1998', 3, 24.12, N'Bottom-Dollar Markets', N'23 Tsawassen Blvd.', N'Tsawassen', N'BC', N'T2F 8M4', N'Canada');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11049, N'GOURL', 3, N'4/24/1998', N'5/22/1998', N'5/4/1998', 1, 8.34, N'Gourmet Lanchonetes', N'Av. Brasil, 442', N'Campinas', N'SP', N'04876-786', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11050, N'FOLKO', 8, N'4/27/1998', N'5/25/1998', N'5/5/1998', 2, 59.41, N'Folk och fä HB', N'Åkergatan 24', N'Bräcke', NULL, N'S-844 67', N'Sweden');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11051, N'LAMAI', 7, N'4/27/1998', N'5/25/1998', NULL, 3, 2.79, N'La maison d''Asie', N'1 rue Alsace-Lorraine', N'Toulouse', NULL, N'31000', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11052, N'HANAR', 3, N'4/27/1998', N'5/25/1998', N'5/1/1998', 1, 67.26, N'Hanari Carnes', N'Rua do Paço, 67', N'Rio de Janeiro', N'RJ', N'05454-876', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11053, N'PICCO', 2, N'4/27/1998', N'5/25/1998', N'4/29/1998', 2, 53.05, N'Piccolo und mehr', N'Geislweg 14', N'Salzburg', NULL, N'5020', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11054, N'CACTU', 8, N'4/28/1998', N'5/26/1998', NULL, 1, 0.33, N'Cactus Comidas para llevar', N'Cerrito 333', N'Buenos Aires', NULL, N'1010', N'Argentina');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11055, N'HILAA', 7, N'4/28/1998', N'5/26/1998', N'5/5/1998', 2, 120.92, N'HILARION-Abastos', N'Carrera 22 con Ave. Carlos Soublette #8-35', N'San Cristóbal', N'Táchira', N'5022', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11056, N'EASTC', 8, N'4/28/1998', N'5/12/1998', N'5/1/1998', 2, 278.96, N'Eastern Connection', N'35 King George', N'London', NULL, N'WX3 6FW', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11057, N'NORTS', 3, N'4/29/1998', N'5/27/1998', N'5/1/1998', 3, 4.13, N'North/South', N'South House 300 Queensbridge', N'London', NULL, N'SW7 1RZ', N'UK');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11058, N'BLAUS', 9, N'4/29/1998', N'5/27/1998', NULL, 3, 31.14, N'Blauer See Delikatessen', N'Forsterstr. 57', N'Mannheim', NULL, N'68306', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11059, N'RICAR', 2, N'4/29/1998', N'6/10/1998', NULL, 2, 85.80, N'Ricardo Adocicados', N'Av. Copacabana, 267', N'Rio de Janeiro', N'RJ', N'02389-890', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11060, N'FRANS', 2, N'4/30/1998', N'5/28/1998', N'5/4/1998', 2, 10.98, N'Franchi S.p.A.', N'Via Monte Bianco 34', N'Torino', NULL, N'10100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11061, N'GREAL', 4, N'4/30/1998', N'6/11/1998', NULL, 3, 14.01, N'Great Lakes Food Market', N'2732 Baker Blvd.', N'Eugene', N'OR', N'97403', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11062, N'REGGC', 4, N'4/30/1998', N'5/28/1998', NULL, 2, 29.93, N'Reggiani Caseifici', N'Strada Provinciale 124', N'Reggio Emilia', NULL, N'42100', N'Italy');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11063, N'HUNGO', 3, N'4/30/1998', N'5/28/1998', N'5/6/1998', 2, 81.73, N'Hungry Owl All-Night Grocers', N'8 Johnstown Road', N'Cork', N'Co. Cork', NULL, N'Ireland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11064, N'SAVEA', 1, N'5/1/1998', N'5/29/1998', N'5/4/1998', 1, 30.09, N'Save-a-lot Markets', N'187 Suffolk Ln.', N'Boise', N'ID', N'83720', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11065, N'LILAS', 8, N'5/1/1998', N'5/29/1998', NULL, 1, 12.91, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11066, N'WHITC', 7, N'5/1/1998', N'5/29/1998', N'5/4/1998', 2, 44.72, N'White Clover Markets', N'1029 - 12th Ave. S.', N'Seattle', N'WA', N'98124', N'USA');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11067, N'DRACD', 1, N'5/4/1998', N'5/18/1998', N'5/6/1998', 2, 7.98, N'Drachenblut Delikatessen', N'Walserweg 21', N'Aachen', NULL, N'52066', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11068, N'QUEEN', 8, N'5/4/1998', N'6/1/1998', NULL, 2, 81.75, N'Queen Cozinha', N'Alameda dos Canàrios, 891', N'Sao Paulo', N'SP', N'05487-020', N'Brazil');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11069, N'TORTU', 1, N'5/4/1998', N'6/1/1998', N'5/6/1998', 2, 15.67, N'Tortuga Restaurante', N'Avda. Azteca 123', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11070, N'LEHMS', 2, N'5/5/1998', N'6/2/1998', NULL, 1, 136.00, N'Lehmanns Marktstand', N'Magazinweg 7', N'Frankfurt a.M.', NULL, N'60528', N'Germany');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11071, N'LILAS', 1, N'5/5/1998', N'6/2/1998', NULL, 1, 0.93, N'LILA-Supermercado', N'Carrera 52 con Ave. Bolívar #65-98 Llano Largo', N'Barquisimeto', N'Lara', N'3508', N'Venezuela');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11072, N'ERNSH', 4, N'5/5/1998', N'6/2/1998', NULL, 2, 258.64, N'Ernst Handel', N'Kirchgasse 6', N'Graz', NULL, N'8010', N'Austria');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11073, N'PERIC', 2, N'5/5/1998', N'6/2/1998', NULL, 2, 24.95, N'Pericles Comidas clásicas', N'Calle Dr. Jorge Cash 321', N'México D.F.', NULL, N'05033', N'Mexico');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11074, N'SIMOB', 7, N'5/6/1998', N'6/3/1998', NULL, 2, 18.44, N'Simons bistro', N'Vinbæltet 34', N'Kobenhavn', NULL, N'1734', N'Denmark');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11075, N'RICSU', 8, N'5/6/1998', N'6/3/1998', NULL, 2, 6.19, N'Richter Supermarkt', N'Starenweg 5', N'Genève', NULL, N'1204', N'Switzerland');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11076, N'BONAP', 4, N'5/6/1998', N'6/3/1998', NULL, 2, 38.28, N'Bon app''', N'12, rue des Bouchers', N'Marseille', NULL, N'13008', N'France');
INSERT INTO [dbo].[Orders] ([OrderID], [CustomerID], [EmployeeID], [OrderDate], [RequiredDate], [ShippedDate], [ShipVia], [Freight], [ShipName], [ShipAddress], [ShipCity], [ShipRegion], [ShipPostalCode], [ShipCountry]) VALUES (11077, N'RATTC', 1, N'5/6/1998', N'6/3/1998', NULL, 2, 8.53, N'Rattlesnake Canyon Grocery', N'2817 Milton Dr.', N'Albuquerque', N'NM', N'87110', N'USA');
GO

SET IDENTITY_INSERT [dbo].[Orders] OFF;
GO

/*------------------------------------------------------------------------------
  Order Details（受注明細）: 2155 件
------------------------------------------------------------------------------*/
PRINT N'Order Details を投入します...';
GO

INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10248, 11, 14, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10248, 42, 9.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10248, 72, 34.8, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10249, 14, 18.6, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10249, 51, 42.4, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10250, 41, 7.7, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10250, 51, 42.4, 35, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10250, 65, 16.8, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10251, 22, 16.8, 6, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10251, 57, 15.6, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10251, 65, 16.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10252, 20, 64.8, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10252, 33, 2, 25, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10252, 60, 27.2, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10253, 31, 10, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10253, 39, 14.4, 42, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10253, 49, 16, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10254, 24, 3.6, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10254, 55, 19.2, 21, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10254, 74, 8, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10255, 2, 15.2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10255, 16, 13.9, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10255, 36, 15.2, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10255, 59, 44, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10256, 53, 26.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10256, 77, 10.4, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10257, 27, 35.1, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10257, 39, 14.4, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10257, 77, 10.4, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10258, 2, 15.2, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10258, 5, 17, 65, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10258, 32, 25.6, 6, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10259, 21, 8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10259, 37, 20.8, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10260, 41, 7.7, 16, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10260, 57, 15.6, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10260, 62, 39.4, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10260, 70, 12, 21, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10261, 21, 8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10261, 35, 14.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10262, 5, 17, 12, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10262, 7, 24, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10262, 56, 30.4, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10263, 16, 13.9, 60, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10263, 24, 3.6, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10263, 30, 20.7, 60, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10263, 74, 8, 36, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10264, 2, 15.2, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10264, 41, 7.7, 25, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10265, 17, 31.2, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10265, 70, 12, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10266, 12, 30.4, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10267, 40, 14.7, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10267, 59, 44, 70, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10267, 76, 14.4, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10268, 29, 99, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10268, 72, 27.8, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10269, 33, 2, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10269, 72, 27.8, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10270, 36, 15.2, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10270, 43, 36.8, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10271, 33, 2, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10272, 20, 64.8, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10272, 31, 10, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10272, 72, 27.8, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10273, 10, 24.8, 24, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10273, 31, 10, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10273, 33, 2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10273, 40, 14.7, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10273, 76, 14.4, 33, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10274, 71, 17.2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10274, 72, 27.8, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10275, 24, 3.6, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10275, 59, 44, 6, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10276, 10, 24.8, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10276, 13, 4.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10277, 28, 36.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10277, 62, 39.4, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10278, 44, 15.5, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10278, 59, 44, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10278, 63, 35.1, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10278, 73, 12, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10279, 17, 31.2, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10280, 24, 3.6, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10280, 55, 19.2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10280, 75, 6.2, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10281, 19, 7.3, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10281, 24, 3.6, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10281, 35, 14.4, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10282, 30, 20.7, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10282, 57, 15.6, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10283, 15, 12.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10283, 19, 7.3, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10283, 60, 27.2, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10283, 72, 27.8, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10284, 27, 35.1, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10284, 44, 15.5, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10284, 60, 27.2, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10284, 67, 11.2, 5, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10285, 1, 14.4, 45, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10285, 40, 14.7, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10285, 53, 26.2, 36, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10286, 35, 14.4, 100, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10286, 62, 39.4, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10287, 16, 13.9, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10287, 34, 11.2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10287, 46, 9.6, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10288, 54, 5.9, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10288, 68, 10, 3, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10289, 3, 8, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10289, 64, 26.6, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10290, 5, 17, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10290, 29, 99, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10290, 49, 16, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10290, 77, 10.4, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10291, 13, 4.8, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10291, 44, 15.5, 24, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10291, 51, 42.4, 2, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10292, 20, 64.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10293, 18, 50, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10293, 24, 3.6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10293, 63, 35.1, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10293, 75, 6.2, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10294, 1, 14.4, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10294, 17, 31.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10294, 43, 36.8, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10294, 60, 27.2, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10294, 75, 6.2, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10295, 56, 30.4, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10296, 11, 16.8, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10296, 16, 13.9, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10296, 69, 28.8, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10297, 39, 14.4, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10297, 72, 27.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10298, 2, 15.2, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10298, 36, 15.2, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10298, 59, 44, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10298, 62, 39.4, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10299, 19, 7.3, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10299, 70, 12, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10300, 66, 13.6, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10300, 68, 10, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10301, 40, 14.7, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10301, 56, 30.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10302, 17, 31.2, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10302, 28, 36.4, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10302, 43, 36.8, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10303, 40, 14.7, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10303, 65, 16.8, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10303, 68, 10, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10304, 49, 16, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10304, 59, 44, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10304, 71, 17.2, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10305, 18, 50, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10305, 29, 99, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10305, 39, 14.4, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10306, 30, 20.7, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10306, 53, 26.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10306, 54, 5.9, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10307, 62, 39.4, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10307, 68, 10, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10308, 69, 28.8, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10308, 70, 12, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10309, 4, 17.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10309, 6, 20, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10309, 42, 11.2, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10309, 43, 36.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10309, 71, 17.2, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10310, 16, 13.9, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10310, 62, 39.4, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10311, 42, 11.2, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10311, 69, 28.8, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10312, 28, 36.4, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10312, 43, 36.8, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10312, 53, 26.2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10312, 75, 6.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10313, 36, 15.2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10314, 32, 25.6, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10314, 58, 10.6, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10314, 62, 39.4, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10315, 34, 11.2, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10315, 70, 12, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10316, 41, 7.7, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10316, 62, 39.4, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10317, 1, 14.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10318, 41, 7.7, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10318, 76, 14.4, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10319, 17, 31.2, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10319, 28, 36.4, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10319, 76, 14.4, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10320, 71, 17.2, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10321, 35, 14.4, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10322, 52, 5.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10323, 15, 12.4, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10323, 25, 11.2, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10323, 39, 14.4, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10324, 16, 13.9, 21, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10324, 35, 14.4, 70, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10324, 46, 9.6, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10324, 59, 44, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10324, 63, 35.1, 80, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10325, 6, 20, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10325, 13, 4.8, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10325, 14, 18.6, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10325, 31, 10, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10325, 72, 27.8, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10326, 4, 17.6, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10326, 57, 15.6, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10326, 75, 6.2, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10327, 2, 15.2, 25, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10327, 11, 16.8, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10327, 30, 20.7, 35, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10327, 58, 10.6, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10328, 59, 44, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10328, 65, 16.8, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10328, 68, 10, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10329, 19, 7.3, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10329, 30, 20.7, 8, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10329, 38, 210.8, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10329, 56, 30.4, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10330, 26, 24.9, 50, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10330, 72, 27.8, 25, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10331, 54, 5.9, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10332, 18, 50, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10332, 42, 11.2, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10332, 47, 7.6, 16, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10333, 14, 18.6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10333, 21, 8, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10333, 71, 17.2, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10334, 52, 5.6, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10334, 68, 10, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10335, 2, 15.2, 7, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10335, 31, 10, 25, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10335, 32, 25.6, 6, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10335, 51, 42.4, 48, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10336, 4, 17.6, 18, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10337, 23, 7.2, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10337, 26, 24.9, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10337, 36, 15.2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10337, 37, 20.8, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10337, 72, 27.8, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10338, 17, 31.2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10338, 30, 20.7, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10339, 4, 17.6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10339, 17, 31.2, 70, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10339, 62, 39.4, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10340, 18, 50, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10340, 41, 7.7, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10340, 43, 36.8, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10341, 33, 2, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10341, 59, 44, 9, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10342, 2, 15.2, 24, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10342, 31, 10, 56, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10342, 36, 15.2, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10342, 55, 19.2, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10343, 64, 26.6, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10343, 68, 10, 4, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10343, 76, 14.4, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10344, 4, 17.6, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10344, 8, 32, 70, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10345, 8, 32, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10345, 19, 7.3, 80, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10345, 42, 11.2, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10346, 17, 31.2, 36, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10346, 56, 30.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10347, 25, 11.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10347, 39, 14.4, 50, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10347, 40, 14.7, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10347, 75, 6.2, 6, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10348, 1, 14.4, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10348, 23, 7.2, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10349, 54, 5.9, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10350, 50, 13, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10350, 69, 28.8, 18, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10351, 38, 210.8, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10351, 41, 7.7, 13, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10351, 44, 15.5, 77, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10351, 65, 16.8, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10352, 24, 3.6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10352, 54, 5.9, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10353, 11, 16.8, 12, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10353, 38, 210.8, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10354, 1, 14.4, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10354, 29, 99, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10355, 24, 3.6, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10355, 57, 15.6, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10356, 31, 10, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10356, 55, 19.2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10356, 69, 28.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10357, 10, 24.8, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10357, 26, 24.9, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10357, 60, 27.2, 8, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10358, 24, 3.6, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10358, 34, 11.2, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10358, 36, 15.2, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10359, 16, 13.9, 56, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10359, 31, 10, 70, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10359, 60, 27.2, 80, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10360, 28, 36.4, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10360, 29, 99, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10360, 38, 210.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10360, 49, 16, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10360, 54, 5.9, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10361, 39, 14.4, 54, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10361, 60, 27.2, 55, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10362, 25, 11.2, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10362, 51, 42.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10362, 54, 5.9, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10363, 31, 10, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10363, 75, 6.2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10363, 76, 14.4, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10364, 69, 28.8, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10364, 71, 17.2, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10365, 11, 16.8, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10366, 65, 16.8, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10366, 77, 10.4, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10367, 34, 11.2, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10367, 54, 5.9, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10367, 65, 16.8, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10367, 77, 10.4, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10368, 21, 8, 5, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10368, 28, 36.4, 13, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10368, 57, 15.6, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10368, 64, 26.6, 35, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10369, 29, 99, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10369, 56, 30.4, 18, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10370, 1, 14.4, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10370, 64, 26.6, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10370, 74, 8, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10371, 36, 15.2, 6, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10372, 20, 64.8, 12, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10372, 38, 210.8, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10372, 60, 27.2, 70, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10372, 72, 27.8, 42, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10373, 58, 10.6, 80, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10373, 71, 17.2, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10374, 31, 10, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10374, 58, 10.6, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10375, 14, 18.6, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10375, 54, 5.9, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10376, 31, 10, 42, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10377, 28, 36.4, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10377, 39, 14.4, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10378, 71, 17.2, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10379, 41, 7.7, 8, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10379, 63, 35.1, 16, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10379, 65, 16.8, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10380, 30, 20.7, 18, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10380, 53, 26.2, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10380, 60, 27.2, 6, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10380, 70, 12, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10381, 74, 8, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10382, 5, 17, 32, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10382, 18, 50, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10382, 29, 99, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10382, 33, 2, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10382, 74, 8, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10383, 13, 4.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10383, 50, 13, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10383, 56, 30.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10384, 20, 64.8, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10384, 60, 27.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10385, 7, 24, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10385, 60, 27.2, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10385, 68, 10, 8, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10386, 24, 3.6, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10386, 34, 11.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10387, 24, 3.6, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10387, 28, 36.4, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10387, 59, 44, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10387, 71, 17.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10388, 45, 7.6, 15, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10388, 52, 5.6, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10388, 53, 26.2, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10389, 10, 24.8, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10389, 55, 19.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10389, 62, 39.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10389, 70, 12, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10390, 31, 10, 60, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10390, 35, 14.4, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10390, 46, 9.6, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10390, 72, 27.8, 24, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10391, 13, 4.8, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10392, 69, 28.8, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10393, 2, 15.2, 25, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10393, 14, 18.6, 42, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10393, 25, 11.2, 7, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10393, 26, 24.9, 70, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10393, 31, 10, 32, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10394, 13, 4.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10394, 62, 39.4, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10395, 46, 9.6, 28, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10395, 53, 26.2, 70, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10395, 69, 28.8, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10396, 23, 7.2, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10396, 71, 17.2, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10396, 72, 27.8, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10397, 21, 8, 10, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10397, 51, 42.4, 18, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10398, 35, 14.4, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10398, 55, 19.2, 120, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10399, 68, 10, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10399, 71, 17.2, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10399, 76, 14.4, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10399, 77, 10.4, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10400, 29, 99, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10400, 35, 14.4, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10400, 49, 16, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10401, 30, 20.7, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10401, 56, 30.4, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10401, 65, 16.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10401, 71, 17.2, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10402, 23, 7.2, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10402, 63, 35.1, 65, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10403, 16, 13.9, 21, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10403, 48, 10.2, 70, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10404, 26, 24.9, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10404, 42, 11.2, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10404, 49, 16, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10405, 3, 8, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10406, 1, 14.4, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10406, 21, 8, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10406, 28, 36.4, 42, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10406, 36, 15.2, 5, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10406, 40, 14.7, 2, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10407, 11, 16.8, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10407, 69, 28.8, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10407, 71, 17.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10408, 37, 20.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10408, 54, 5.9, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10408, 62, 39.4, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10409, 14, 18.6, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10409, 21, 8, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10410, 33, 2, 49, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10410, 59, 44, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10411, 41, 7.7, 25, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10411, 44, 15.5, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10411, 59, 44, 9, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10412, 14, 18.6, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10413, 1, 14.4, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10413, 62, 39.4, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10413, 76, 14.4, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10414, 19, 7.3, 18, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10414, 33, 2, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10415, 17, 31.2, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10415, 33, 2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10416, 19, 7.3, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10416, 53, 26.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10416, 57, 15.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10417, 38, 210.8, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10417, 46, 9.6, 2, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10417, 68, 10, 36, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10417, 77, 10.4, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10418, 2, 15.2, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10418, 47, 7.6, 55, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10418, 61, 22.8, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10418, 74, 8, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10419, 60, 27.2, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10419, 69, 28.8, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10420, 9, 77.6, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10420, 13, 4.8, 2, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10420, 70, 12, 8, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10420, 73, 12, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10421, 19, 7.3, 4, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10421, 26, 24.9, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10421, 53, 26.2, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10421, 77, 10.4, 10, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10422, 26, 24.9, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10423, 31, 10, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10423, 59, 44, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10424, 35, 14.4, 60, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10424, 38, 210.8, 49, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10424, 68, 10, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10425, 55, 19.2, 10, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10425, 76, 14.4, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10426, 56, 30.4, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10426, 64, 26.6, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10427, 14, 18.6, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10428, 46, 9.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10429, 50, 13, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10429, 63, 35.1, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10430, 17, 31.2, 45, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10430, 21, 8, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10430, 56, 30.4, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10430, 59, 44, 70, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10431, 17, 31.2, 50, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10431, 40, 14.7, 50, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10431, 47, 7.6, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10432, 26, 24.9, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10432, 54, 5.9, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10433, 56, 30.4, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10434, 11, 16.8, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10434, 76, 14.4, 18, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10435, 2, 15.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10435, 22, 16.8, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10435, 72, 27.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10436, 46, 9.6, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10436, 56, 30.4, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10436, 64, 26.6, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10436, 75, 6.2, 24, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10437, 53, 26.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10438, 19, 7.3, 15, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10438, 34, 11.2, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10438, 57, 15.6, 15, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10439, 12, 30.4, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10439, 16, 13.9, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10439, 64, 26.6, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10439, 74, 8, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10440, 2, 15.2, 45, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10440, 16, 13.9, 49, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10440, 29, 99, 24, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10440, 61, 22.8, 90, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10441, 27, 35.1, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10442, 11, 16.8, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10442, 54, 5.9, 80, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10442, 66, 13.6, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10443, 11, 16.8, 6, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10443, 28, 36.4, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10444, 17, 31.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10444, 26, 24.9, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10444, 35, 14.4, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10444, 41, 7.7, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10445, 39, 14.4, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10445, 54, 5.9, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10446, 19, 7.3, 12, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10446, 24, 3.6, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10446, 31, 10, 3, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10446, 52, 5.6, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10447, 19, 7.3, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10447, 65, 16.8, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10447, 71, 17.2, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10448, 26, 24.9, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10448, 40, 14.7, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10449, 10, 24.8, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10449, 52, 5.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10449, 62, 39.4, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10450, 10, 24.8, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10450, 54, 5.9, 6, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10451, 55, 19.2, 120, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10451, 64, 26.6, 35, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10451, 65, 16.8, 28, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10451, 77, 10.4, 55, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10452, 28, 36.4, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10452, 44, 15.5, 100, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10453, 48, 10.2, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10453, 70, 12, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10454, 16, 13.9, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10454, 33, 2, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10454, 46, 9.6, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10455, 39, 14.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10455, 53, 26.2, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10455, 61, 22.8, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10455, 71, 17.2, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10456, 21, 8, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10456, 49, 16, 21, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10457, 59, 44, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10458, 26, 24.9, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10458, 28, 36.4, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10458, 43, 36.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10458, 56, 30.4, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10458, 71, 17.2, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10459, 7, 24, 16, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10459, 46, 9.6, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10459, 72, 27.8, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10460, 68, 10, 21, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10460, 75, 6.2, 4, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10461, 21, 8, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10461, 30, 20.7, 28, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10461, 55, 19.2, 60, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10462, 13, 4.8, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10462, 23, 7.2, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10463, 19, 7.3, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10463, 42, 11.2, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10464, 4, 17.6, 16, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10464, 43, 36.8, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10464, 56, 30.4, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10464, 60, 27.2, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10465, 24, 3.6, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10465, 29, 99, 18, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10465, 40, 14.7, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10465, 45, 7.6, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10465, 50, 13, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10466, 11, 16.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10466, 46, 9.6, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10467, 24, 3.6, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10467, 25, 11.2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10468, 30, 20.7, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10468, 43, 36.8, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10469, 2, 15.2, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10469, 16, 13.9, 35, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10469, 44, 15.5, 2, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10470, 18, 50, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10470, 23, 7.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10470, 64, 26.6, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10471, 7, 24, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10471, 56, 30.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10472, 24, 3.6, 80, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10472, 51, 42.4, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10473, 33, 2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10473, 71, 17.2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10474, 14, 18.6, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10474, 28, 36.4, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10474, 40, 14.7, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10474, 75, 6.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10475, 31, 10, 35, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10475, 66, 13.6, 60, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10475, 76, 14.4, 42, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10476, 55, 19.2, 2, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10476, 70, 12, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10477, 1, 14.4, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10477, 21, 8, 21, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10477, 39, 14.4, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10478, 10, 24.8, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10479, 38, 210.8, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10479, 53, 26.2, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10479, 59, 44, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10479, 64, 26.6, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10480, 47, 7.6, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10480, 59, 44, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10481, 49, 16, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10481, 60, 27.2, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10482, 40, 14.7, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10483, 34, 11.2, 35, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10483, 77, 10.4, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10484, 21, 8, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10484, 40, 14.7, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10484, 51, 42.4, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10485, 2, 15.2, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10485, 3, 8, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10485, 55, 19.2, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10485, 70, 12, 60, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10486, 11, 16.8, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10486, 51, 42.4, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10486, 74, 8, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10487, 19, 7.3, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10487, 26, 24.9, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10487, 54, 5.9, 24, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10488, 59, 44, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10488, 73, 12, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10489, 11, 16.8, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10489, 16, 13.9, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10490, 59, 44, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10490, 68, 10, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10490, 75, 6.2, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10491, 44, 15.5, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10491, 77, 10.4, 7, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10492, 25, 11.2, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10492, 42, 11.2, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10493, 65, 16.8, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10493, 66, 13.6, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10493, 69, 28.8, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10494, 56, 30.4, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10495, 23, 7.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10495, 41, 7.7, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10495, 77, 10.4, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10496, 31, 10, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10497, 56, 30.4, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10497, 72, 27.8, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10497, 77, 10.4, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10498, 24, 4.5, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10498, 40, 18.4, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10498, 42, 14, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10499, 28, 45.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10499, 49, 20, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10500, 15, 15.5, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10500, 28, 45.6, 8, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10501, 54, 7.45, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10502, 45, 9.5, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10502, 53, 32.8, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10502, 67, 14, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10503, 14, 23.25, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10503, 65, 21.05, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10504, 2, 19, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10504, 21, 10, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10504, 53, 32.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10504, 61, 28.5, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10505, 62, 49.3, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10506, 25, 14, 18, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10506, 70, 15, 14, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10507, 43, 46, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10507, 48, 12.75, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10508, 13, 6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10508, 39, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10509, 28, 45.6, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10510, 29, 123.79, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10510, 75, 7.75, 36, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10511, 4, 22, 50, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10511, 7, 30, 50, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10511, 8, 40, 10, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10512, 24, 4.5, 10, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10512, 46, 12, 9, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10512, 47, 9.5, 6, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10512, 60, 34, 12, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10513, 21, 10, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10513, 32, 32, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10513, 61, 28.5, 15, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10514, 20, 81, 39, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10514, 28, 45.6, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10514, 56, 38, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10514, 65, 21.05, 39, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10514, 75, 7.75, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10515, 9, 97, 16, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10515, 16, 17.45, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10515, 27, 43.9, 120, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10515, 33, 2.5, 16, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10515, 60, 34, 84, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10516, 18, 62.5, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10516, 41, 9.65, 80, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10516, 42, 14, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10517, 52, 7, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10517, 59, 55, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10517, 70, 15, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10518, 24, 4.5, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10518, 38, 263.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10518, 44, 19.45, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10519, 10, 31, 16, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10519, 56, 38, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10519, 60, 34, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10520, 24, 4.5, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10520, 53, 32.8, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10521, 35, 18, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10521, 41, 9.65, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10521, 68, 12.5, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10522, 1, 18, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10522, 8, 40, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10522, 30, 25.89, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10522, 40, 18.4, 25, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10523, 17, 39, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10523, 20, 81, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10523, 37, 26, 18, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10523, 41, 9.65, 6, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10524, 10, 31, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10524, 30, 25.89, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10524, 43, 46, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10524, 54, 7.45, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10525, 36, 19, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10525, 40, 18.4, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10526, 1, 18, 8, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10526, 13, 6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10526, 56, 38, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10527, 4, 22, 50, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10527, 36, 19, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10528, 11, 21, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10528, 33, 2.5, 8, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10528, 72, 34.8, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10529, 55, 24, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10529, 68, 12.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10529, 69, 36, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10530, 17, 39, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10530, 43, 46, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10530, 61, 28.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10530, 76, 18, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10531, 59, 55, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10532, 30, 25.89, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10532, 66, 17, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10533, 4, 22, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10533, 72, 34.8, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10533, 73, 15, 24, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10534, 30, 25.89, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10534, 40, 18.4, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10534, 54, 7.45, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10535, 11, 21, 50, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10535, 40, 18.4, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10535, 57, 19.5, 5, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10535, 59, 55, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10536, 12, 38, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10536, 31, 12.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10536, 33, 2.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10536, 60, 34, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10537, 31, 12.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10537, 51, 53, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10537, 58, 13.25, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10537, 72, 34.8, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10537, 73, 15, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10538, 70, 15, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10538, 72, 34.8, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10539, 13, 6, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10539, 21, 10, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10539, 33, 2.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10539, 49, 20, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10540, 3, 10, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10540, 26, 31.23, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10540, 38, 263.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10540, 68, 12.5, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10541, 24, 4.5, 35, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10541, 38, 263.5, 4, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10541, 65, 21.05, 36, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10541, 71, 21.5, 9, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10542, 11, 21, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10542, 54, 7.45, 24, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10543, 12, 38, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10543, 23, 9, 70, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10544, 28, 45.6, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10544, 67, 14, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10545, 11, 21, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10546, 7, 30, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10546, 35, 18, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10546, 62, 49.3, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10547, 32, 32, 24, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10547, 36, 19, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10548, 34, 14, 10, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10548, 41, 9.65, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10549, 31, 12.5, 55, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10549, 45, 9.5, 100, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10549, 51, 53, 48, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10550, 17, 39, 8, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10550, 19, 9.2, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10550, 21, 10, 6, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10550, 61, 28.5, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10551, 16, 17.45, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10551, 35, 18, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10551, 44, 19.45, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10552, 69, 36, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10552, 75, 7.75, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10553, 11, 21, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10553, 16, 17.45, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10553, 22, 21, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10553, 31, 12.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10553, 35, 18, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10554, 16, 17.45, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10554, 23, 9, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10554, 62, 49.3, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10554, 77, 13, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10555, 14, 23.25, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10555, 19, 9.2, 35, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10555, 24, 4.5, 18, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10555, 51, 53, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10555, 56, 38, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10556, 72, 34.8, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10557, 64, 33.25, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10557, 75, 7.75, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10558, 47, 9.5, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10558, 51, 53, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10558, 52, 7, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10558, 53, 32.8, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10558, 73, 15, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10559, 41, 9.65, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10559, 55, 24, 18, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10560, 30, 25.89, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10560, 62, 49.3, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10561, 44, 19.45, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10561, 51, 53, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10562, 33, 2.5, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10562, 62, 49.3, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10563, 36, 19, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10563, 52, 7, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10564, 17, 39, 16, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10564, 31, 12.5, 6, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10564, 55, 24, 25, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10565, 24, 4.5, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10565, 64, 33.25, 18, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10566, 11, 21, 35, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10566, 18, 62.5, 18, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10566, 76, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10567, 31, 12.5, 60, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10567, 51, 53, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10567, 59, 55, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10568, 10, 31, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10569, 31, 12.5, 35, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10569, 76, 18, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10570, 11, 21, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10570, 56, 38, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10571, 14, 23.25, 11, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10571, 42, 14, 28, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10572, 16, 17.45, 12, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10572, 32, 32, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10572, 40, 18.4, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10572, 75, 7.75, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10573, 17, 39, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10573, 34, 14, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10573, 53, 32.8, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10574, 33, 2.5, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10574, 40, 18.4, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10574, 62, 49.3, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10574, 64, 33.25, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10575, 59, 55, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10575, 63, 43.9, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10575, 72, 34.8, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10575, 76, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10576, 1, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10576, 31, 12.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10576, 44, 19.45, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10577, 39, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10577, 75, 7.75, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10577, 77, 13, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10578, 35, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10578, 57, 19.5, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10579, 15, 15.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10579, 75, 7.75, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10580, 14, 23.25, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10580, 41, 9.65, 9, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10580, 65, 21.05, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10581, 75, 7.75, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10582, 57, 19.5, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10582, 76, 18, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10583, 29, 123.79, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10583, 60, 34, 24, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10583, 69, 36, 10, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10584, 31, 12.5, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10585, 47, 9.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10586, 52, 7, 4, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10587, 26, 31.23, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10587, 35, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10587, 77, 13, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10588, 18, 62.5, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10588, 42, 14, 100, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10589, 35, 18, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10590, 1, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10590, 77, 13, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10591, 3, 10, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10591, 7, 30, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10591, 54, 7.45, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10592, 15, 15.5, 25, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10592, 26, 31.23, 5, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10593, 20, 81, 21, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10593, 69, 36, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10593, 76, 18, 4, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10594, 52, 7, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10594, 58, 13.25, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10595, 35, 18, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10595, 61, 28.5, 120, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10595, 69, 36, 65, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10596, 56, 38, 5, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10596, 63, 43.9, 24, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10596, 75, 7.75, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10597, 24, 4.5, 35, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10597, 57, 19.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10597, 65, 21.05, 12, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10598, 27, 43.9, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10598, 71, 21.5, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10599, 62, 49.3, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10600, 54, 7.45, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10600, 73, 15, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10601, 13, 6, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10601, 59, 55, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10602, 77, 13, 5, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10603, 22, 21, 48, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10603, 49, 20, 25, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10604, 48, 12.75, 6, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10604, 76, 18, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10605, 16, 17.45, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10605, 59, 55, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10605, 60, 34, 70, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10605, 71, 21.5, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10606, 4, 22, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10606, 55, 24, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10606, 62, 49.3, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10607, 7, 30, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10607, 17, 39, 100, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10607, 33, 2.5, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10607, 40, 18.4, 42, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10607, 72, 34.8, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10608, 56, 38, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10609, 1, 18, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10609, 10, 31, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10609, 21, 10, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10610, 36, 19, 21, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10611, 1, 18, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10611, 2, 19, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10611, 60, 34, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10612, 10, 31, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10612, 36, 19, 55, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10612, 49, 20, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10612, 60, 34, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10612, 76, 18, 80, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10613, 13, 6, 8, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10613, 75, 7.75, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10614, 11, 21, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10614, 21, 10, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10614, 39, 18, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10615, 55, 24, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10616, 38, 263.5, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10616, 56, 38, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10616, 70, 15, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10616, 71, 21.5, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10617, 59, 55, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10618, 6, 25, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10618, 56, 38, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10618, 68, 12.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10619, 21, 10, 42, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10619, 22, 21, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10620, 24, 4.5, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10620, 52, 7, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10621, 19, 9.2, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10621, 23, 9, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10621, 70, 15, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10621, 71, 21.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10622, 2, 19, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10622, 68, 12.5, 18, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10623, 14, 23.25, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10623, 19, 9.2, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10623, 21, 10, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10623, 24, 4.5, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10623, 35, 18, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10624, 28, 45.6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10624, 29, 123.79, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10624, 44, 19.45, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10625, 14, 23.25, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10625, 42, 14, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10625, 60, 34, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10626, 53, 32.8, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10626, 60, 34, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10626, 71, 21.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10627, 62, 49.3, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10627, 73, 15, 35, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10628, 1, 18, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10629, 29, 123.79, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10629, 64, 33.25, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10630, 55, 24, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10630, 76, 18, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10631, 75, 7.75, 8, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10632, 2, 19, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10632, 33, 2.5, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10633, 12, 38, 36, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10633, 13, 6, 13, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10633, 26, 31.23, 35, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10633, 62, 49.3, 80, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10634, 7, 30, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10634, 18, 62.5, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10634, 51, 53, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10634, 75, 7.75, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10635, 4, 22, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10635, 5, 21.35, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10635, 22, 21, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10636, 4, 22, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10636, 58, 13.25, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10637, 11, 21, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10637, 50, 16.25, 25, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10637, 56, 38, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10638, 45, 9.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10638, 65, 21.05, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10638, 72, 34.8, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10639, 18, 62.5, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10640, 69, 36, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10640, 70, 15, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10641, 2, 19, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10641, 40, 18.4, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10642, 21, 10, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10642, 61, 28.5, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10643, 28, 45.6, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10643, 39, 18, 21, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10643, 46, 12, 2, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10644, 18, 62.5, 4, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10644, 43, 46, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10644, 46, 12, 21, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10645, 18, 62.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10645, 36, 19, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10646, 1, 18, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10646, 10, 31, 18, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10646, 71, 21.5, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10646, 77, 13, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10647, 19, 9.2, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10647, 39, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10648, 22, 21, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10648, 24, 4.5, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10649, 28, 45.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10649, 72, 34.8, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10650, 30, 25.89, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10650, 53, 32.8, 25, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10650, 54, 7.45, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10651, 19, 9.2, 12, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10651, 22, 21, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10652, 30, 25.89, 2, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10652, 42, 14, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10653, 16, 17.45, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10653, 60, 34, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10654, 4, 22, 12, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10654, 39, 18, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10654, 54, 7.45, 6, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10655, 41, 9.65, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10656, 14, 23.25, 3, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10656, 44, 19.45, 28, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10656, 47, 9.5, 6, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10657, 15, 15.5, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10657, 41, 9.65, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10657, 46, 12, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10657, 47, 9.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10657, 56, 38, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10657, 60, 34, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10658, 21, 10, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10658, 40, 18.4, 70, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10658, 60, 34, 55, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10658, 77, 13, 70, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10659, 31, 12.5, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10659, 40, 18.4, 24, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10659, 70, 15, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10660, 20, 81, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10661, 39, 18, 3, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10661, 58, 13.25, 49, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10662, 68, 12.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10663, 40, 18.4, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10663, 42, 14, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10663, 51, 53, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10664, 10, 31, 24, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10664, 56, 38, 12, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10664, 65, 21.05, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10665, 51, 53, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10665, 59, 55, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10665, 76, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10666, 29, 123.79, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10666, 65, 21.05, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10667, 69, 36, 45, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10667, 71, 21.5, 14, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10668, 31, 12.5, 8, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10668, 55, 24, 4, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10668, 64, 33.25, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10669, 36, 19, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10670, 23, 9, 32, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10670, 46, 12, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10670, 67, 14, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10670, 73, 15, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10670, 75, 7.75, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10671, 16, 17.45, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10671, 62, 49.3, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10671, 65, 21.05, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10672, 38, 263.5, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10672, 71, 21.5, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10673, 16, 17.45, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10673, 42, 14, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10673, 43, 46, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10674, 23, 9, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10675, 14, 23.25, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10675, 53, 32.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10675, 58, 13.25, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10676, 10, 31, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10676, 19, 9.2, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10676, 44, 19.45, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10677, 26, 31.23, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10677, 33, 2.5, 8, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10678, 12, 38, 100, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10678, 33, 2.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10678, 41, 9.65, 120, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10678, 54, 7.45, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10679, 59, 55, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10680, 16, 17.45, 50, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10680, 31, 12.5, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10680, 42, 14, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10681, 19, 9.2, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10681, 21, 10, 12, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10681, 64, 33.25, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10682, 33, 2.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10682, 66, 17, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10682, 75, 7.75, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10683, 52, 7, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10684, 40, 18.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10684, 47, 9.5, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10684, 60, 34, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10685, 10, 31, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10685, 41, 9.65, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10685, 47, 9.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10686, 17, 39, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10686, 26, 31.23, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10687, 9, 97, 50, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10687, 29, 123.79, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10687, 36, 19, 6, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10688, 10, 31, 18, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10688, 28, 45.6, 60, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10688, 34, 14, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10689, 1, 18, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10690, 56, 38, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10690, 77, 13, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10691, 1, 18, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10691, 29, 123.79, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10691, 43, 46, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10691, 44, 19.45, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10691, 62, 49.3, 48, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10692, 63, 43.9, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10693, 9, 97, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10693, 54, 7.45, 60, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10693, 69, 36, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10693, 73, 15, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10694, 7, 30, 90, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10694, 59, 55, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10694, 70, 15, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10695, 8, 40, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10695, 12, 38, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10695, 24, 4.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10696, 17, 39, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10696, 46, 12, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10697, 19, 9.2, 7, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10697, 35, 18, 9, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10697, 58, 13.25, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10697, 70, 15, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10698, 11, 21, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10698, 17, 39, 8, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10698, 29, 123.79, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10698, 65, 21.05, 65, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10698, 70, 15, 8, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10699, 47, 9.5, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10700, 1, 18, 5, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10700, 34, 14, 12, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10700, 68, 12.5, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10700, 71, 21.5, 60, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10701, 59, 55, 42, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10701, 71, 21.5, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10701, 76, 18, 35, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10702, 3, 10, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10702, 76, 18, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10703, 2, 19, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10703, 59, 55, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10703, 73, 15, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10704, 4, 22, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10704, 24, 4.5, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10704, 48, 12.75, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10705, 31, 12.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10705, 32, 32, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10706, 16, 17.45, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10706, 43, 46, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10706, 59, 55, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10707, 55, 24, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10707, 57, 19.5, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10707, 70, 15, 28, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10708, 5, 21.35, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10708, 36, 19, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10709, 8, 40, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10709, 51, 53, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10709, 60, 34, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10710, 19, 9.2, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10710, 47, 9.5, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10711, 19, 9.2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10711, 41, 9.65, 42, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10711, 53, 32.8, 120, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10712, 53, 32.8, 3, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10712, 56, 38, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10713, 10, 31, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10713, 26, 31.23, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10713, 45, 9.5, 110, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10713, 46, 12, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10714, 2, 19, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10714, 17, 39, 27, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10714, 47, 9.5, 50, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10714, 56, 38, 18, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10714, 58, 13.25, 12, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10715, 10, 31, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10715, 71, 21.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10716, 21, 10, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10716, 51, 53, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10716, 61, 28.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10717, 21, 10, 32, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10717, 54, 7.45, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10717, 69, 36, 25, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10718, 12, 38, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10718, 16, 17.45, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10718, 36, 19, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10718, 62, 49.3, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10719, 18, 62.5, 12, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10719, 30, 25.89, 3, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10719, 54, 7.45, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10720, 35, 18, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10720, 71, 21.5, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10721, 44, 19.45, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10722, 2, 19, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10722, 31, 12.5, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10722, 68, 12.5, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10722, 75, 7.75, 42, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10723, 26, 31.23, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10724, 10, 31, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10724, 61, 28.5, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10725, 41, 9.65, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10725, 52, 7, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10725, 55, 24, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10726, 4, 22, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10726, 11, 21, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10727, 17, 39, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10727, 56, 38, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10727, 59, 55, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10728, 30, 25.89, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10728, 40, 18.4, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10728, 55, 24, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10728, 60, 34, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10729, 1, 18, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10729, 21, 10, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10729, 50, 16.25, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10730, 16, 17.45, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10730, 31, 12.5, 3, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10730, 65, 21.05, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10731, 21, 10, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10731, 51, 53, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10732, 76, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10733, 14, 23.25, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10733, 28, 45.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10733, 52, 7, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10734, 6, 25, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10734, 30, 25.89, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10734, 76, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10735, 61, 28.5, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10735, 77, 13, 2, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10736, 65, 21.05, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10736, 75, 7.75, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10737, 13, 6, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10737, 41, 9.65, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10738, 16, 17.45, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10739, 36, 19, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10739, 52, 7, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10740, 28, 45.6, 5, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10740, 35, 18, 35, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10740, 45, 9.5, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10740, 56, 38, 14, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10741, 2, 19, 15, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10742, 3, 10, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10742, 60, 34, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10742, 72, 34.8, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10743, 46, 12, 28, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10744, 40, 18.4, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10745, 18, 62.5, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10745, 44, 19.45, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10745, 59, 55, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10745, 72, 34.8, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10746, 13, 6, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10746, 42, 14, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10746, 62, 49.3, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10746, 69, 36, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10747, 31, 12.5, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10747, 41, 9.65, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10747, 63, 43.9, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10747, 69, 36, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10748, 23, 9, 44, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10748, 40, 18.4, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10748, 56, 38, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10749, 56, 38, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10749, 59, 55, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10749, 76, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10750, 14, 23.25, 5, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10750, 45, 9.5, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10750, 59, 55, 25, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10751, 26, 31.23, 12, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10751, 30, 25.89, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10751, 50, 16.25, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10751, 73, 15, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10752, 1, 18, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10752, 69, 36, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10753, 45, 9.5, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10753, 74, 10, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10754, 40, 18.4, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10755, 47, 9.5, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10755, 56, 38, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10755, 57, 19.5, 14, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10755, 69, 36, 25, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10756, 18, 62.5, 21, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10756, 36, 19, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10756, 68, 12.5, 6, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10756, 69, 36, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10757, 34, 14, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10757, 59, 55, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10757, 62, 49.3, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10757, 64, 33.25, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10758, 26, 31.23, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10758, 52, 7, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10758, 70, 15, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10759, 32, 32, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10760, 25, 14, 12, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10760, 27, 43.9, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10760, 43, 46, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10761, 25, 14, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10761, 75, 7.75, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10762, 39, 18, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10762, 47, 9.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10762, 51, 53, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10762, 56, 38, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10763, 21, 10, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10763, 22, 21, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10763, 24, 4.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10764, 3, 10, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10764, 39, 18, 130, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10765, 65, 21.05, 80, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10766, 2, 19, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10766, 7, 30, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10766, 68, 12.5, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10767, 42, 14, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10768, 22, 21, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10768, 31, 12.5, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10768, 60, 34, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10768, 71, 21.5, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10769, 41, 9.65, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10769, 52, 7, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10769, 61, 28.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10769, 62, 49.3, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10770, 11, 21, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10771, 71, 21.5, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10772, 29, 123.79, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10772, 59, 55, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10773, 17, 39, 33, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10773, 31, 12.5, 70, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10773, 75, 7.75, 7, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10774, 31, 12.5, 2, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10774, 66, 17, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10775, 10, 31, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10775, 67, 14, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10776, 31, 12.5, 16, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10776, 42, 14, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10776, 45, 9.5, 27, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10776, 51, 53, 120, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10777, 42, 14, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10778, 41, 9.65, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10779, 16, 17.45, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10779, 62, 49.3, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10780, 70, 15, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10780, 77, 13, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10781, 54, 7.45, 3, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10781, 56, 38, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10781, 74, 10, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10782, 31, 12.5, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10783, 31, 12.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10783, 38, 263.5, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10784, 36, 19, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10784, 39, 18, 2, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10784, 72, 34.8, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10785, 10, 31, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10785, 75, 7.75, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10786, 8, 40, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10786, 30, 25.89, 15, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10786, 75, 7.75, 42, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10787, 2, 19, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10787, 29, 123.79, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10788, 19, 9.2, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10788, 75, 7.75, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10789, 18, 62.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10789, 35, 18, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10789, 63, 43.9, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10789, 68, 12.5, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10790, 7, 30, 3, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10790, 56, 38, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10791, 29, 123.79, 14, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10791, 41, 9.65, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10792, 2, 19, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10792, 54, 7.45, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10792, 68, 12.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10793, 41, 9.65, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10793, 52, 7, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10794, 14, 23.25, 15, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10794, 54, 7.45, 6, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10795, 16, 17.45, 65, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10795, 17, 39, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10796, 26, 31.23, 21, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10796, 44, 19.45, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10796, 64, 33.25, 35, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10796, 69, 36, 24, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10797, 11, 21, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10798, 62, 49.3, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10798, 72, 34.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10799, 13, 6, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10799, 24, 4.5, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10799, 59, 55, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10800, 11, 21, 50, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10800, 51, 53, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10800, 54, 7.45, 7, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10801, 17, 39, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10801, 29, 123.79, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10802, 30, 25.89, 25, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10802, 51, 53, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10802, 55, 24, 60, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10802, 62, 49.3, 5, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10803, 19, 9.2, 24, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10803, 25, 14, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10803, 59, 55, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10804, 10, 31, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10804, 28, 45.6, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10804, 49, 20, 4, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10805, 34, 14, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10805, 38, 263.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10806, 2, 19, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10806, 65, 21.05, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10806, 74, 10, 15, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10807, 40, 18.4, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10808, 56, 38, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10808, 76, 18, 50, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10809, 52, 7, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10810, 13, 6, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10810, 25, 14, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10810, 70, 15, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10811, 19, 9.2, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10811, 23, 9, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10811, 40, 18.4, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10812, 31, 12.5, 16, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10812, 72, 34.8, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10812, 77, 13, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10813, 2, 19, 12, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10813, 46, 12, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10814, 41, 9.65, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10814, 43, 46, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10814, 48, 12.75, 8, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10814, 61, 28.5, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10815, 33, 2.5, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10816, 38, 263.5, 30, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10816, 62, 49.3, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10817, 26, 31.23, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10817, 38, 263.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10817, 40, 18.4, 60, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10817, 62, 49.3, 25, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10818, 32, 32, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10818, 41, 9.65, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10819, 43, 46, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10819, 75, 7.75, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10820, 56, 38, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10821, 35, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10821, 51, 53, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10822, 62, 49.3, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10822, 70, 15, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10823, 11, 21, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10823, 57, 19.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10823, 59, 55, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10823, 77, 13, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10824, 41, 9.65, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10824, 70, 15, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10825, 26, 31.23, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10825, 53, 32.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10826, 31, 12.5, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10826, 57, 19.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10827, 10, 31, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10827, 39, 18, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10828, 20, 81, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10828, 38, 263.5, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10829, 2, 19, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10829, 8, 40, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10829, 13, 6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10829, 60, 34, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10830, 6, 25, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10830, 39, 18, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10830, 60, 34, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10830, 68, 12.5, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10831, 19, 9.2, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10831, 35, 18, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10831, 38, 263.5, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10831, 43, 46, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10832, 13, 6, 3, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10832, 25, 14, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10832, 44, 19.45, 16, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10832, 64, 33.25, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10833, 7, 30, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10833, 31, 12.5, 9, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10833, 53, 32.8, 9, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10834, 29, 123.79, 8, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10834, 30, 25.89, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10835, 59, 55, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10835, 77, 13, 2, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10836, 22, 21, 52, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10836, 35, 18, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10836, 57, 19.5, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10836, 60, 34, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10836, 64, 33.25, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10837, 13, 6, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10837, 40, 18.4, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10837, 47, 9.5, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10837, 76, 18, 21, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10838, 1, 18, 4, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10838, 18, 62.5, 25, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10838, 36, 19, 50, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10839, 58, 13.25, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10839, 72, 34.8, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10840, 25, 14, 6, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10840, 39, 18, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10841, 10, 31, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10841, 56, 38, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10841, 59, 55, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10841, 77, 13, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10842, 11, 21, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10842, 43, 46, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10842, 68, 12.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10842, 70, 15, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10843, 51, 53, 4, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10844, 22, 21, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10845, 23, 9, 70, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10845, 35, 18, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10845, 42, 14, 42, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10845, 58, 13.25, 60, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10845, 64, 33.25, 48, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10846, 4, 22, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10846, 70, 15, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10846, 74, 10, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10847, 1, 18, 80, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10847, 19, 9.2, 12, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10847, 37, 26, 60, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10847, 45, 9.5, 36, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10847, 60, 34, 45, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10847, 71, 21.5, 55, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10848, 5, 21.35, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10848, 9, 97, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10849, 3, 10, 49, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10849, 26, 31.23, 18, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10850, 25, 14, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10850, 33, 2.5, 4, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10850, 70, 15, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10851, 2, 19, 5, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10851, 25, 14, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10851, 57, 19.5, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10851, 59, 55, 42, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10852, 2, 19, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10852, 17, 39, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10852, 62, 49.3, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10853, 18, 62.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10854, 10, 31, 100, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10854, 13, 6, 65, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10855, 16, 17.45, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10855, 31, 12.5, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10855, 56, 38, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10855, 65, 21.05, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10856, 2, 19, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10856, 42, 14, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10857, 3, 10, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10857, 26, 31.23, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10857, 29, 123.79, 10, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10858, 7, 30, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10858, 27, 43.9, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10858, 70, 15, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10859, 24, 4.5, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10859, 54, 7.45, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10859, 64, 33.25, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10860, 51, 53, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10860, 76, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10861, 17, 39, 42, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10861, 18, 62.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10861, 21, 10, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10861, 33, 2.5, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10861, 62, 49.3, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10862, 11, 21, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10862, 52, 7, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10863, 1, 18, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10863, 58, 13.25, 12, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10864, 35, 18, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10864, 67, 14, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10865, 38, 263.5, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10865, 39, 18, 80, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10866, 2, 19, 21, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10866, 24, 4.5, 6, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10866, 30, 25.89, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10867, 53, 32.8, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10868, 26, 31.23, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10868, 35, 18, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10868, 49, 20, 42, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10869, 1, 18, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10869, 11, 21, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10869, 23, 9, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10869, 68, 12.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10870, 35, 18, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10870, 51, 53, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10871, 6, 25, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10871, 16, 17.45, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10871, 17, 39, 16, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10872, 55, 24, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10872, 62, 49.3, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10872, 64, 33.25, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10872, 65, 21.05, 21, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10873, 21, 10, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10873, 28, 45.6, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10874, 10, 31, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10875, 19, 9.2, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10875, 47, 9.5, 21, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10875, 49, 20, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10876, 46, 12, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10876, 64, 33.25, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10877, 16, 17.45, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10877, 18, 62.5, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10878, 20, 81, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10879, 40, 18.4, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10879, 65, 21.05, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10879, 76, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10880, 23, 9, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10880, 61, 28.5, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10880, 70, 15, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10881, 73, 15, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10882, 42, 14, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10882, 49, 20, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10882, 54, 7.45, 32, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10883, 24, 4.5, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10884, 21, 10, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10884, 56, 38, 21, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10884, 65, 21.05, 12, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10885, 2, 19, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10885, 24, 4.5, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10885, 70, 15, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10885, 77, 13, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10886, 10, 31, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10886, 31, 12.5, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10886, 77, 13, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10887, 25, 14, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10888, 2, 19, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10888, 68, 12.5, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10889, 11, 21, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10889, 38, 263.5, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10890, 17, 39, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10890, 34, 14, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10890, 41, 9.65, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10891, 30, 25.89, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10892, 59, 55, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10893, 8, 40, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10893, 24, 4.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10893, 29, 123.79, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10893, 30, 25.89, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10893, 36, 19, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10894, 13, 6, 28, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10894, 69, 36, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10894, 75, 7.75, 120, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10895, 24, 4.5, 110, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10895, 39, 18, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10895, 40, 18.4, 91, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10895, 60, 34, 100, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10896, 45, 9.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10896, 56, 38, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10897, 29, 123.79, 80, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10897, 30, 25.89, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10898, 13, 6, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10899, 39, 18, 8, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10900, 70, 15, 3, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10901, 41, 9.65, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10901, 71, 21.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10902, 55, 24, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10902, 62, 49.3, 6, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10903, 13, 6, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10903, 65, 21.05, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10903, 68, 12.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10904, 58, 13.25, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10904, 62, 49.3, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10905, 1, 18, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10906, 61, 28.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10907, 75, 7.75, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10908, 7, 30, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10908, 52, 7, 14, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10909, 7, 30, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10909, 16, 17.45, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10909, 41, 9.65, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10910, 19, 9.2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10910, 49, 20, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10910, 61, 28.5, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10911, 1, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10911, 17, 39, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10911, 67, 14, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10912, 11, 21, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10912, 29, 123.79, 60, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10913, 4, 22, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10913, 33, 2.5, 40, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10913, 58, 13.25, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10914, 71, 21.5, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10915, 17, 39, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10915, 33, 2.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10915, 54, 7.45, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10916, 16, 17.45, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10916, 32, 32, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10916, 57, 19.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10917, 30, 25.89, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10917, 60, 34, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10918, 1, 18, 60, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10918, 60, 34, 25, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10919, 16, 17.45, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10919, 25, 14, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10919, 40, 18.4, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10920, 50, 16.25, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10921, 35, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10921, 63, 43.9, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10922, 17, 39, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10922, 24, 4.5, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10923, 42, 14, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10923, 43, 46, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10923, 67, 14, 24, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10924, 10, 31, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10924, 28, 45.6, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10924, 75, 7.75, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10925, 36, 19, 25, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10925, 52, 7, 12, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10926, 11, 21, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10926, 13, 6, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10926, 19, 9.2, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10926, 72, 34.8, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10927, 20, 81, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10927, 52, 7, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10927, 76, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10928, 47, 9.5, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10928, 76, 18, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10929, 21, 10, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10929, 75, 7.75, 49, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10929, 77, 13, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10930, 21, 10, 36, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10930, 27, 43.9, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10930, 55, 24, 25, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10930, 58, 13.25, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10931, 13, 6, 42, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10931, 57, 19.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10932, 16, 17.45, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10932, 62, 49.3, 14, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10932, 72, 34.8, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10932, 75, 7.75, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10933, 53, 32.8, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10933, 61, 28.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10934, 6, 25, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10935, 1, 18, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10935, 18, 62.5, 4, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10935, 23, 9, 8, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10936, 36, 19, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10937, 28, 45.6, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10937, 34, 14, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10938, 13, 6, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10938, 43, 46, 24, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10938, 60, 34, 49, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10938, 71, 21.5, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10939, 2, 19, 10, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10939, 67, 14, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10940, 7, 30, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10940, 13, 6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10941, 31, 12.5, 44, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10941, 62, 49.3, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10941, 68, 12.5, 80, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10941, 72, 34.8, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10942, 49, 20, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10943, 13, 6, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10943, 22, 21, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10943, 46, 12, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10944, 11, 21, 5, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10944, 44, 19.45, 18, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10944, 56, 38, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10945, 13, 6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10945, 31, 12.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10946, 10, 31, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10946, 24, 4.5, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10946, 77, 13, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10947, 59, 55, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10948, 50, 16.25, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10948, 51, 53, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10948, 55, 24, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10949, 6, 25, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10949, 10, 31, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10949, 17, 39, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10949, 62, 49.3, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10950, 4, 22, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10951, 33, 2.5, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10951, 41, 9.65, 6, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10951, 75, 7.75, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10952, 6, 25, 16, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10952, 28, 45.6, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10953, 20, 81, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10953, 31, 12.5, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10954, 16, 17.45, 28, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10954, 31, 12.5, 25, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10954, 45, 9.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10954, 60, 34, 24, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10955, 75, 7.75, 12, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10956, 21, 10, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10956, 47, 9.5, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10956, 51, 53, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10957, 30, 25.89, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10957, 35, 18, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10957, 64, 33.25, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10958, 5, 21.35, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10958, 7, 30, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10958, 72, 34.8, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10959, 75, 7.75, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10960, 24, 4.5, 10, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10960, 41, 9.65, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10961, 52, 7, 6, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10961, 76, 18, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10962, 7, 30, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10962, 13, 6, 77, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10962, 53, 32.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10962, 69, 36, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10962, 76, 18, 44, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10963, 60, 34, 2, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10964, 18, 62.5, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10964, 38, 263.5, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10964, 69, 36, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10965, 51, 53, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10966, 37, 26, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10966, 56, 38, 12, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10966, 62, 49.3, 12, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10967, 19, 9.2, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10967, 49, 20, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10968, 12, 38, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10968, 24, 4.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10968, 64, 33.25, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10969, 46, 12, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10970, 52, 7, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10971, 29, 123.79, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10972, 17, 39, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10972, 33, 2.5, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10973, 26, 31.23, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10973, 41, 9.65, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10973, 75, 7.75, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10974, 63, 43.9, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10975, 8, 40, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10975, 75, 7.75, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10976, 28, 45.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10977, 39, 18, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10977, 47, 9.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10977, 51, 53, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10977, 63, 43.9, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10978, 8, 40, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10978, 21, 10, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10978, 40, 18.4, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10978, 44, 19.45, 6, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10979, 7, 30, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10979, 12, 38, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10979, 24, 4.5, 80, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10979, 27, 43.9, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10979, 31, 12.5, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10979, 63, 43.9, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10980, 75, 7.75, 40, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10981, 38, 263.5, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10982, 7, 30, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10982, 43, 46, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10983, 13, 6, 84, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10983, 57, 19.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10984, 16, 17.45, 55, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10984, 24, 4.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10984, 36, 19, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10985, 16, 17.45, 36, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10985, 18, 62.5, 8, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10985, 32, 32, 35, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10986, 11, 21, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10986, 20, 81, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10986, 76, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10986, 77, 13, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10987, 7, 30, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10987, 43, 46, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10987, 72, 34.8, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10988, 7, 30, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10988, 62, 49.3, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10989, 6, 25, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10989, 11, 21, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10989, 41, 9.65, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10990, 21, 10, 65, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10990, 34, 14, 60, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10990, 55, 24, 65, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10990, 61, 28.5, 66, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10991, 2, 19, 50, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10991, 70, 15, 20, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10991, 76, 18, 90, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10992, 72, 34.8, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10993, 29, 123.79, 50, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10993, 41, 9.65, 35, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10994, 59, 55, 18, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10995, 51, 53, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10995, 60, 34, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10996, 42, 14, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10997, 32, 32, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10997, 46, 12, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10997, 52, 7, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10998, 24, 4.5, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10998, 61, 28.5, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10998, 74, 10, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10998, 75, 7.75, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10999, 41, 9.65, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10999, 51, 53, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (10999, 77, 13, 21, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11000, 4, 22, 25, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11000, 24, 4.5, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11000, 77, 13, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11001, 7, 30, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11001, 22, 21, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11001, 46, 12, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11001, 55, 24, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11002, 13, 6, 56, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11002, 35, 18, 15, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11002, 42, 14, 24, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11002, 55, 24, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11003, 1, 18, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11003, 40, 18.4, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11003, 52, 7, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11004, 26, 31.23, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11004, 76, 18, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11005, 1, 18, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11005, 59, 55, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11006, 1, 18, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11006, 29, 123.79, 2, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11007, 8, 40, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11007, 29, 123.79, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11007, 42, 14, 14, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11008, 28, 45.6, 70, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11008, 34, 14, 90, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11008, 71, 21.5, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11009, 24, 4.5, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11009, 36, 19, 18, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11009, 60, 34, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11010, 7, 30, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11010, 24, 4.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11011, 58, 13.25, 40, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11011, 71, 21.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11012, 19, 9.2, 50, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11012, 60, 34, 36, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11012, 71, 21.5, 60, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11013, 23, 9, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11013, 42, 14, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11013, 45, 9.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11013, 68, 12.5, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11014, 41, 9.65, 28, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11015, 30, 25.89, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11015, 77, 13, 18, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11016, 31, 12.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11016, 36, 19, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11017, 3, 10, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11017, 59, 55, 110, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11017, 70, 15, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11018, 12, 38, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11018, 18, 62.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11018, 56, 38, 5, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11019, 46, 12, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11019, 49, 20, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11020, 10, 31, 24, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11021, 2, 19, 11, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11021, 20, 81, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11021, 26, 31.23, 63, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11021, 51, 53, 44, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11021, 72, 34.8, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11022, 19, 9.2, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11022, 69, 36, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11023, 7, 30, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11023, 43, 46, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11024, 26, 31.23, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11024, 33, 2.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11024, 65, 21.05, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11024, 71, 21.5, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11025, 1, 18, 10, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11025, 13, 6, 20, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11026, 18, 62.5, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11026, 51, 53, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11027, 24, 4.5, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11027, 62, 49.3, 21, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11028, 55, 24, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11028, 59, 55, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11029, 56, 38, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11029, 63, 43.9, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11030, 2, 19, 100, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11030, 5, 21.35, 70, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11030, 29, 123.79, 60, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11030, 59, 55, 100, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11031, 1, 18, 45, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11031, 13, 6, 80, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11031, 24, 4.5, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11031, 64, 33.25, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11031, 71, 21.5, 16, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11032, 36, 19, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11032, 38, 263.5, 25, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11032, 59, 55, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11033, 53, 32.8, 70, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11033, 69, 36, 36, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11034, 21, 10, 15, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11034, 44, 19.45, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11034, 61, 28.5, 6, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11035, 1, 18, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11035, 35, 18, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11035, 42, 14, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11035, 54, 7.45, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11036, 13, 6, 7, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11036, 59, 55, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11037, 70, 15, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11038, 40, 18.4, 5, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11038, 52, 7, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11038, 71, 21.5, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11039, 28, 45.6, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11039, 35, 18, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11039, 49, 20, 60, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11039, 57, 19.5, 28, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11040, 21, 10, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11041, 2, 19, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11041, 63, 43.9, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11042, 44, 19.45, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11042, 61, 28.5, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11043, 11, 21, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11044, 62, 49.3, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11045, 33, 2.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11045, 51, 53, 24, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11046, 12, 38, 20, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11046, 32, 32, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11046, 35, 18, 18, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11047, 1, 18, 25, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11047, 5, 21.35, 30, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11048, 68, 12.5, 42, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11049, 2, 19, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11049, 12, 38, 4, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11050, 76, 18, 50, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11051, 24, 4.5, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11052, 43, 46, 30, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11052, 61, 28.5, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11053, 18, 62.5, 35, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11053, 32, 32, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11053, 64, 33.25, 25, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11054, 33, 2.5, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11054, 67, 14, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11055, 24, 4.5, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11055, 25, 14, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11055, 51, 53, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11055, 57, 19.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11056, 7, 30, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11056, 55, 24, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11056, 60, 34, 50, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11057, 70, 15, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11058, 21, 10, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11058, 60, 34, 21, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11058, 61, 28.5, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11059, 13, 6, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11059, 17, 39, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11059, 60, 34, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11060, 60, 34, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11060, 77, 13, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11061, 60, 34, 15, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11062, 53, 32.8, 10, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11062, 70, 15, 12, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11063, 34, 14, 30, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11063, 40, 18.4, 40, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11063, 41, 9.65, 30, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11064, 17, 39, 77, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11064, 41, 9.65, 12, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11064, 53, 32.8, 25, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11064, 55, 24, 4, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11064, 68, 12.5, 55, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11065, 30, 25.89, 4, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11065, 54, 7.45, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11066, 16, 17.45, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11066, 19, 9.2, 42, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11066, 34, 14, 35, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11067, 41, 9.65, 9, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11068, 28, 45.6, 8, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11068, 43, 46, 36, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11068, 77, 13, 28, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11069, 39, 18, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11070, 1, 18, 40, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11070, 2, 19, 20, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11070, 16, 17.45, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11070, 31, 12.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11071, 7, 30, 15, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11071, 13, 6, 10, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11072, 2, 19, 8, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11072, 41, 9.65, 40, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11072, 50, 16.25, 22, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11072, 64, 33.25, 130, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11073, 11, 21, 10, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11073, 24, 4.5, 20, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11074, 16, 17.45, 14, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11075, 2, 19, 10, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11075, 46, 12, 30, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11075, 76, 18, 2, 0.15);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11076, 6, 25, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11076, 14, 23.25, 20, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11076, 19, 9.2, 10, 0.25);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 2, 19, 24, 0.2);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 3, 10, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 4, 22, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 6, 25, 1, 0.02);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 7, 30, 1, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 8, 40, 2, 0.1);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 10, 31, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 12, 38, 2, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 13, 6, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 14, 23.25, 1, 0.03);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 16, 17.45, 2, 0.03);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 20, 81, 1, 0.04);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 23, 9, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 32, 32, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 39, 18, 2, 0.05);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 41, 9.65, 3, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 46, 12, 3, 0.02);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 52, 7, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 55, 24, 2, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 60, 34, 2, 0.06);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 64, 33.25, 2, 0.03);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 66, 17, 1, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 73, 15, 2, 0.01);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 75, 7.75, 4, 0);
INSERT INTO [dbo].[Order Details] ([OrderID], [ProductID], [UnitPrice], [Quantity], [Discount]) VALUES (11077, 77, 13, 2, 0);
GO

/*------------------------------------------------------------------------------
  SalesTargets（売上目標）: 145 件  ※ 本設計での追加テーブル

  サンプル値の作り方
    対象期間 : 1997-01 〜 1998-05
    目標金額 : 当該社員・当該年月の実績（明細金額合計・送料を含まない）に
               0.85 / 0.95 / 1.00 / 1.10 / 1.20 の係数を順に掛け、100 円単位で丸めた値。
               達成率は 57.5% 〜 124.6% に分布する
               （実績が小さい月は 100 円単位の丸めにより係数から乖離する）。
               未達・達成の双方が含まれ、進捗トラッキングを確認できる。
    未登録   : 実績が 0 の年月は目標を登録していない。
               「目標なし」（達成率を算出せず「－」と表示）の確認用。
               目標金額 0 円の動作を確認する場合は、任意の行を UPDATE して 0 にすること。
               0 円と未登録は意味が異なる。
------------------------------------------------------------------------------*/
PRINT N'SalesTargets を投入します...';
GO

-- 社員 1
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 1, 7000);   -- 実績   7,331.60 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 2, 1900);   -- 実績   1,946.40 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 3, 5600);   -- 実績   5,124.08 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 4, 300);   -- 実績     240.00 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 5, 7700);   -- 実績   9,115.96 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 6, 5200);   -- 実績   5,468.35 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 7, 19500);   -- 実績  19,530.95 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 8, 5600);   -- 実績   5,104.70 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 9, 8900);   -- 実績   7,441.57 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 10, 10600);   -- 実績  12,414.15 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 11, 3900);   -- 実績   4,089.90 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1997, 12, 15300);   -- 実績  15,340.47 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1998, 1, 8900);   -- 実績   8,115.36 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1998, 2, 13400);   -- 実績  11,147.51 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1998, 3, 21100);   -- 実績  24,827.45 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1998, 4, 12000);   -- 実績  12,587.23 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (1, 1998, 5, 6500);   -- 実績   6,517.47 x 1.00
-- 社員 2
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 1, 3100);   -- 実績   3,059.88 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 2, 1700);   -- 実績   1,584.00 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 3, 3400);   -- 実績   2,844.90 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 4, 11200);   -- 実績  13,118.65 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 5, 4200);   -- 実績   4,373.32 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 6, 6900);   -- 実績   6,882.20 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 7, 8800);   -- 実績   7,965.00 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 8, 100);   -- 実績      57.50 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 9, 7900);   -- 実績   9,286.65 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 10, 9700);   -- 実績  10,164.80 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 11, 3600);   -- 実績   3,567.00 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1997, 12, 8300);   -- 実績   7,540.24 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1998, 1, 5200);   -- 実績   4,351.11 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1998, 2, 19700);   -- 実績  23,127.55 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1998, 3, 13200);   -- 実績  13,937.64 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1998, 4, 31000);   -- 実績  30,990.28 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (2, 1998, 5, 2100);   -- 実績   1,929.98 x 1.10
-- 社員 3
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 1, 7700);   -- 実績   6,981.02 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 2, 12300);   -- 実績  10,212.64 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 3, 9900);   -- 実績  11,599.40 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 4, 9700);   -- 実績  10,252.55 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 5, 18000);   -- 実績  18,049.60 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 6, 6200);   -- 実績   5,599.79 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 7, 1300);   -- 実績   1,081.97 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 8, 5000);   -- 実績   5,831.60 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 9, 3400);   -- 実績   3,555.90 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 10, 7600);   -- 実績   7,626.96 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 11, 10600);   -- 実績   9,598.08 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1997, 12, 21200);   -- 実績  17,636.66 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1998, 1, 21800);   -- 実績  25,705.02 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1998, 2, 20500);   -- 実績  21,540.24 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1998, 3, 16400);   -- 実績  16,360.13 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (3, 1998, 4, 14300);   -- 実績  12,957.36 x 1.10
-- 社員 4
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 1, 28500);   -- 実績  23,736.47 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 2, 10300);   -- 実績  12,122.00 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 3, 5000);   -- 実績   5,230.08 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 4, 13500);   -- 実績  13,475.99 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 5, 7600);   -- 実績   6,915.28 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 6, 4900);   -- 実績   4,082.85 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 7, 4700);   -- 実績   5,530.90 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 8, 15700);   -- 実績  16,485.54 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 9, 7900);   -- 実績   7,931.29 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 10, 11500);   -- 実績  10,439.85 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 11, 7900);   -- 実績   6,624.25 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1997, 12, 13800);   -- 実績  16,235.33 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1998, 1, 18300);   -- 実績  19,245.97 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1998, 2, 10600);   -- 実績  10,643.06 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1998, 3, 9100);   -- 実績   8,298.45 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1998, 4, 11900);   -- 実績   9,937.71 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (4, 1998, 5, 5100);   -- 実績   6,010.75 x 0.85
-- 社員 5
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 3, 2500);   -- 実績   2,520.40 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 5, 5400);   -- 実績   4,500.28 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 6, 2600);   -- 実績   3,037.40 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 7, 6200);   -- 実績   6,475.40 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 8, 3600);   -- 実績   3,585.58 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 9, 2200);   -- 実績   2,024.83 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 10, 9100);   -- 実績   7,581.33 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 11, 400);   -- 実績     484.27 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1997, 12, 500);   -- 実績     507.00 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1998, 1, 11700);   -- 実績  11,702.80 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1998, 2, 5900);   -- 実績   5,377.06 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1998, 3, 2900);   -- 実績   2,402.04 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (5, 1998, 4, 200);   -- 実績     210.00 x 0.85
-- 社員 6
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 1, 1300);   -- 実績   1,380.00 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 2, 1300);   -- 実績   1,324.24 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 3, 1300);   -- 実績   1,195.20 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 4, 11500);   -- 実績   9,593.50 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 5, 600);   -- 実績     747.70 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 6, 3300);   -- 実績   3,464.81 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 7, 1300);   -- 実績   1,301.00 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 8, 3900);   -- 実績   3,576.44 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 9, 700);   -- 実績     604.22 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 10, 5300);   -- 実績   6,185.40 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 11, 6000);   -- 実績   6,322.45 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1997, 12, 7400);   -- 実績   7,431.42 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1998, 1, 2100);   -- 実績   1,874.83 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1998, 2, 2300);   -- 実績   1,953.40 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1998, 3, 4300);   -- 実績   5,068.98 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (6, 1998, 4, 5000);   -- 実績   5,246.95 x 0.95
-- 社員 7
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 1, 11200);   -- 実績  11,217.34 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 2, 4300);   -- 実績   3,891.00 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 3, 4600);   -- 実績   3,832.00 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 4, 4200);   -- 実績   4,986.96 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 5, 5300);   -- 実績   5,536.96 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 6, 2100);   -- 実績   2,082.00 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 7, 6100);   -- 実績   5,563.98 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 8, 8000);   -- 実績   6,706.59 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 9, 11300);   -- 実績  13,249.86 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 10, 600);   -- 実績     642.00 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 11, 1900);   -- 実績   1,890.50 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1997, 12, 1000);   -- 実績     872.00 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1998, 1, 7900);   -- 実績   6,610.00 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1998, 2, 5400);   -- 実績   6,317.13 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1998, 3, 5900);   -- 実績   6,186.35 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1998, 4, 28600);   -- 実績  28,590.57 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (7, 1998, 5, 1300);   -- 実績   1,160.84 x 1.10
-- 社員 8
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 1, 7200);   -- 実績   6,584.97 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 2, 8900);   -- 実績   7,403.36 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 3, 4000);   -- 実績   4,695.99 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 4, 800);   -- 実績     800.50 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 5, 4400);   -- 実績   4,402.40 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 6, 2500);   -- 実績   2,262.92 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 7, 4300);   -- 実績   3,547.88 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 8, 3800);   -- 実績   4,493.73 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 9, 2600);   -- 実績   2,758.80 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 10, 11300);   -- 実績  11,316.75 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 11, 4200);   -- 実績   3,840.00 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1997, 12, 4700);   -- 実績   3,925.33 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1998, 1, 9600);   -- 実績  11,263.72 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1998, 2, 100);   -- 実績     106.00 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1998, 3, 20700);   -- 実績  20,728.13 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1998, 4, 15200);   -- 実績  13,777.10 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (8, 1998, 5, 3300);   -- 実績   2,714.60 x 1.20
-- 社員 9
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 1, 1200);   -- 実績     966.80 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 3, 1400);   -- 実績   1,505.18 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 4, 600);   -- 実績     564.80 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 5, 200);   -- 実績     139.80 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 6, 4200);   -- 実績   3,482.50 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 7, 0);   -- 実績      23.80 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 8, 1400);   -- 実績   1,446.00 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 9, 8800);   -- 実績   8,776.15 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 10, 400);   -- 実績     378.00 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 11, 8500);   -- 実績   7,117.36 x 1.20
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1997, 12, 1600);   -- 実績   1,910.00 x 0.85
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1998, 1, 5100);   -- 実績   5,353.32 x 0.95
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1998, 2, 19200);   -- 実績  19,203.34 x 1.00
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1998, 3, 7700);   -- 実績   7,045.02 x 1.10
INSERT INTO [dbo].[SalesTargets] ([EmployeeID], [TargetYear], [TargetMonth], [TargetAmount]) VALUES (9, 1998, 4, 11400);   -- 実績   9,501.50 x 1.20
GO

/*------------------------------------------------------------------------------
  2. 参照整合性の検証（DB は保証しないため、ここで明示的に確認する）
     外部キー制約を作らない方針のため、投入したデータの整合性は
     このクエリで担保する。すべて 0 件であること。
------------------------------------------------------------------------------*/
PRINT N'--- 参照整合性（すべて 0 件であること） ---';
GO

SELECT N'Orders.CustomerID -> Customers' AS [参照], COUNT(*) AS [不整合]
FROM [dbo].[Orders] o WHERE o.[CustomerID] IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Customers] c WHERE c.[CustomerID] = o.[CustomerID])
UNION ALL SELECT N'Orders.EmployeeID -> Employees', COUNT(*)
FROM [dbo].[Orders] o WHERE o.[EmployeeID] IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Employees] e WHERE e.[EmployeeID] = o.[EmployeeID])
UNION ALL SELECT N'Orders.ShipVia -> Shippers', COUNT(*)
FROM [dbo].[Orders] o WHERE o.[ShipVia] IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Shippers] s WHERE s.[ShipperID] = o.[ShipVia])
UNION ALL SELECT N'Order Details.OrderID -> Orders', COUNT(*)
FROM [dbo].[Order Details] od
 WHERE NOT EXISTS (SELECT 1 FROM [dbo].[Orders] o WHERE o.[OrderID] = od.[OrderID])
UNION ALL SELECT N'Order Details.ProductID -> Products', COUNT(*)
FROM [dbo].[Order Details] od
 WHERE NOT EXISTS (SELECT 1 FROM [dbo].[Products] p WHERE p.[ProductID] = od.[ProductID])
UNION ALL SELECT N'Products.SupplierID -> Suppliers', COUNT(*)
FROM [dbo].[Products] p WHERE p.[SupplierID] IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Suppliers] s WHERE s.[SupplierID] = p.[SupplierID])
UNION ALL SELECT N'Products.CategoryID -> Categories', COUNT(*)
FROM [dbo].[Products] p WHERE p.[CategoryID] IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Categories] c WHERE c.[CategoryID] = p.[CategoryID])
UNION ALL SELECT N'Employees.ReportsTo -> Employees', COUNT(*)
FROM [dbo].[Employees] e WHERE e.[ReportsTo] IS NOT NULL
  AND NOT EXISTS (SELECT 1 FROM [dbo].[Employees] m WHERE m.[EmployeeID] = e.[ReportsTo])
UNION ALL SELECT N'Territories.RegionID -> Region', COUNT(*)
FROM [dbo].[Territories] t
 WHERE NOT EXISTS (SELECT 1 FROM [dbo].[Region] r WHERE r.[RegionID] = t.[RegionID])
UNION ALL SELECT N'EmployeeTerritories -> Employees', COUNT(*)
FROM [dbo].[EmployeeTerritories] et
 WHERE NOT EXISTS (SELECT 1 FROM [dbo].[Employees] e WHERE e.[EmployeeID] = et.[EmployeeID])
UNION ALL SELECT N'EmployeeTerritories -> Territories', COUNT(*)
FROM [dbo].[EmployeeTerritories] et
 WHERE NOT EXISTS (SELECT 1 FROM [dbo].[Territories] t WHERE t.[TerritoryID] = et.[TerritoryID])
UNION ALL SELECT N'CustomerCustomerDemo -> Customers', COUNT(*)
FROM [dbo].[CustomerCustomerDemo] cd
 WHERE NOT EXISTS (SELECT 1 FROM [dbo].[Customers] c WHERE c.[CustomerID] = cd.[CustomerID])
UNION ALL SELECT N'CustomerCustomerDemo -> CustomerDemographics', COUNT(*)
FROM [dbo].[CustomerCustomerDemo] cd
 WHERE NOT EXISTS (SELECT 1 FROM [dbo].[CustomerDemographics] d
                    WHERE d.[CustomerTypeID] = cd.[CustomerTypeID])
UNION ALL SELECT N'SalesTargets.EmployeeID -> Employees', COUNT(*)
FROM [dbo].[SalesTargets] st
 WHERE NOT EXISTS (SELECT 1 FROM [dbo].[Employees] e WHERE e.[EmployeeID] = st.[EmployeeID]);
GO

PRINT N'--- 値の妥当性（旧 CHECK 制約に相当。すべて 0 件であること） ---';
GO

SELECT N'Order Details.Quantity > 0' AS [検証], COUNT(*) AS [違反]
FROM [dbo].[Order Details] WHERE [Quantity] <= 0
UNION ALL SELECT N'Order Details.UnitPrice >= 0', COUNT(*)
FROM [dbo].[Order Details] WHERE [UnitPrice] < 0
UNION ALL SELECT N'Order Details.Discount 0..1', COUNT(*)
FROM [dbo].[Order Details] WHERE [Discount] < 0 OR [Discount] > 1
UNION ALL SELECT N'Products.UnitPrice >= 0', COUNT(*)
FROM [dbo].[Products] WHERE [UnitPrice] < 0
UNION ALL SELECT N'Products 数量系 >= 0', COUNT(*)
FROM [dbo].[Products] WHERE [UnitsInStock] < 0 OR [UnitsOnOrder] < 0 OR [ReorderLevel] < 0
UNION ALL SELECT N'Employees.BirthDate < 当日', COUNT(*)
FROM [dbo].[Employees] WHERE [BirthDate] >= GETDATE()
UNION ALL SELECT N'SalesTargets.TargetMonth 1..12', COUNT(*)
FROM [dbo].[SalesTargets] WHERE [TargetMonth] NOT BETWEEN 1 AND 12
UNION ALL SELECT N'SalesTargets.TargetYear >= 1900', COUNT(*)
FROM [dbo].[SalesTargets] WHERE [TargetYear] < 1900
UNION ALL SELECT N'SalesTargets.TargetAmount >= 0', COUNT(*)
FROM [dbo].[SalesTargets] WHERE [TargetAmount] < 0;
GO

/*------------------------------------------------------------------------------
  3. IDENTITY の現在値を再計算
------------------------------------------------------------------------------*/
DBCC CHECKIDENT (N'[dbo].[Categories]', RESEED) WITH NO_INFOMSGS;
DBCC CHECKIDENT (N'[dbo].[Suppliers]',  RESEED) WITH NO_INFOMSGS;
DBCC CHECKIDENT (N'[dbo].[Shippers]',   RESEED) WITH NO_INFOMSGS;
DBCC CHECKIDENT (N'[dbo].[Employees]',  RESEED) WITH NO_INFOMSGS;
DBCC CHECKIDENT (N'[dbo].[Products]',   RESEED) WITH NO_INFOMSGS;
DBCC CHECKIDENT (N'[dbo].[Orders]',     RESEED) WITH NO_INFOMSGS;
GO

/*==============================================================================
  4. 投入結果の確認
==============================================================================*/
PRINT N'--- 件数 ---';
GO

SELECT N'Categories'           AS [テーブル], COUNT(*) AS [件数], 8    AS [期待] FROM [dbo].[Categories]
UNION ALL SELECT N'CustomerCustomerDemo',     COUNT(*), 0    FROM [dbo].[CustomerCustomerDemo]
UNION ALL SELECT N'CustomerDemographics',     COUNT(*), 0    FROM [dbo].[CustomerDemographics]
UNION ALL SELECT N'Customers',                COUNT(*), 91   FROM [dbo].[Customers]
UNION ALL SELECT N'EmployeeTerritories',      COUNT(*), 49   FROM [dbo].[EmployeeTerritories]
UNION ALL SELECT N'Employees',                COUNT(*), 9    FROM [dbo].[Employees]
UNION ALL SELECT N'Order Details',            COUNT(*), 2155 FROM [dbo].[Order Details]
UNION ALL SELECT N'Orders',                   COUNT(*), 830  FROM [dbo].[Orders]
UNION ALL SELECT N'Products',                 COUNT(*), 77   FROM [dbo].[Products]
UNION ALL SELECT N'Region',                   COUNT(*), 4    FROM [dbo].[Region]
UNION ALL SELECT N'SalesTargets',             COUNT(*), 145 FROM [dbo].[SalesTargets]
UNION ALL SELECT N'Shippers',                 COUNT(*), 3    FROM [dbo].[Shippers]
UNION ALL SELECT N'Suppliers',                COUNT(*), 29   FROM [dbo].[Suppliers]
UNION ALL SELECT N'Territories',              COUNT(*), 53   FROM [dbo].[Territories];
GO

PRINT N'--- 売上合計（明細金額の合計・送料を含まない）: 1265793.29 が期待値 ---';
GO

/*  [Discount] は real（単精度浮動小数点）であり、0.01 は実際には
    0.009999999776... として格納されている。real のまま計算すると誤差が蓄積し、
    合計が 1265793.10 となって 0.19 ずれる。
    テーブル定義書「型の読み替え」のとおり、計算前に 10 進数へ変換すること。 */
SELECT  CAST(SUM(ROUND(od.[UnitPrice]
                       * (1 - CAST(od.[Discount] AS decimal(5,4)))
                       * od.[Quantity], 2)) AS decimal(18,2))
            AS [売上合計]
      , MIN(o.[OrderDate]) AS [最初の受注日]
      , MAX(o.[OrderDate]) AS [最後の受注日]
FROM    [dbo].[Order Details] AS od
        INNER JOIN [dbo].[Orders] AS o ON o.[OrderID] = od.[OrderID];
GO

PRINT N'03_InsertData.sql : 完了';
GO
