# Northwind データベース構築スクリプト（SQL Server）

[リポジトリ Home](../../README.md) / [要件定義](../../RDD/Home.md) / [基本設計](../../HLD/Home.md) / [詳細設計](../../LLD/Home.md)<br>
基本：[共通仕様](../../HLD/Common.md) / [テーブル一覧](../../HLD/TableList.md)<br>
詳細：[テーブル定義書](../../LLD/TableSchema.md)

本ディレクトリは、[テーブル定義書](../../LLD/TableSchema.md)の内容を Microsoft SQL Server 上に構築するための DDL と DML を格納する。

## ファイル

| # | ファイル | 種別 | 内容 |
| :--- | :--- | :--- | :--- |
| 1 | [01_CreateDatabase.sql](./01_CreateDatabase.sql) | DDL | データベース `Northwind` の作成（既存ならスキップ） |
| 2 | [02_CreateTables.sql](./02_CreateTables.sql) | DDL | 14 テーブル・制約・インデックスの作成 |
| 3 | [03_InsertData.sql](./03_InsertData.sql) | DML | データ投入（3,453 行） |

いずれも**再実行可能**。`02` は既存テーブルを削除してから作成し、`03` は既存データを削除してから投入する。

## 実行方法

### sqlcmd

```
sqlcmd -S <サーバ名> -E -f 65001 -i 01_CreateDatabase.sql
sqlcmd -S <サーバ名> -E -f 65001 -i 02_CreateTables.sql
sqlcmd -S <サーバ名> -E -f 65001 -i 03_InsertData.sql
```

SQL 認証の場合は `-E` の代わりに `-U <ユーザ> -P <パスワード>` を指定する。
`-f 65001` はコメントの日本語を正しく扱うための指定。ファイルは UTF-8（BOM 付き）で保存している。

### SSMS / Azure Data Studio

`01` → `02` → `03` の順にファイルを開いて実行する。

## 構成

### テーブル（14）

| 区分 | テーブル |
| :--- | :--- |
| マスタ | `Categories`, `Customers`, `CustomerDemographics`, `Employees`, `Products`, `Region`, `Shippers`, `Suppliers`, `Territories` |
| トランザクション | `Orders`, `Order Details`, `SalesTargets` |
| 関連 | `CustomerCustomerDemo`, `EmployeeTerritories` |

### 投入されるデータ

| テーブル | 件数 | 出典 |
| :--- | ---: | :--- |
| `Categories` | 8 | 原典 |
| `Customers` | 91 | 原典 |
| `Employees` | 9 | 原典 |
| `EmployeeTerritories` | 49 | 原典 |
| `Order Details` | 2,155 | 原典 |
| `Orders` | 830 | 原典 |
| `Products` | 77 | 原典 |
| `Region` | 4 | 原典 |
| `Shippers` | 3 | 原典 |
| `Suppliers` | 29 | 原典 |
| `Territories` | 53 | 原典 |
| `CustomerDemographics` | 0 | 原典（原典にデータなし） |
| `CustomerCustomerDemo` | 0 | 原典（原典にデータなし） |
| `SalesTargets` | 145 | **本設計で作成** |
| **合計** | **3,453** | |

- 受注日の範囲：1996-07-04 〜 1998-05-06
- 売上合計（明細金額の合計・送料を含まない）：**1,265,793.29**

`03_InsertData.sql` の末尾で件数と売上合計を出力する。上記と一致すれば投入は正しい。

---

## 原典

Microsoft が MIT ライセンスで提供する Northwind サンプル データベース。

- <https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs>
- `instnwnd.sql`

## 原典との差分

`AGENTS.md` の方針（原典の構造を保ち、Web 化に必要な最小限のみ追加する）に従う。
**列の削除・改名・型変更は行っていない。**

### DDL の差分

| # | 差分 | 理由 |
| :--- | :--- | :--- |
| 1 | 更新対象の 9 テーブルに `[RowVersion] rowversion NOT NULL` を追加 | 楽観排他（[共通仕様 9.1](../../HLD/Common.md#91-楽観排他用の行バージョン列rowversion)）。対象は `Orders`, `Order Details`, `Customers`, `Products`, `Categories`, `Suppliers`, `Employees`, `Shippers`, `SalesTargets`。参照または関連の付け外しのみを行う `Region`, `Territories`, `EmployeeTerritories`, `CustomerDemographics`, `CustomerCustomerDemo` には追加しない |
| 2 | `SalesTargets` テーブルを追加 | パフォーマンス分析の目標設定・進捗トラッキング要件（[共通仕様 9.2](../../HLD/Common.md#92-売上目標テーブルsalestargets)）。採番用の代理キーは設けず業務キーを主キーとする |
| 3 | 重複していたインデックスを整理 | 原典は同一列に 2 本のインデックスを持つ箇所がある（例：`Orders.CustomerID` に `CustomerID` と `CustomersOrders`）。同義のものは 1 本に統合した。`Orders.ShipVia` の `ShippersOrders` は配送管理の集計で使うため残している |
| 4 | 区切り識別子を `"..."` から `[...]` に変更 | `SET QUOTED_IDENTIFIER` の設定に依存させないため。`Order Details` のように空白を含む名前があるため区切りは必須 |
| 5 | ビュー・ストアドプロシージャを作成しない | 本システムの設計に含まれないため（[要件定義 3.2](../../RDD/Home.md#32-スコープ外)） |

### DML の差分

| # | 差分 | 理由 |
| :--- | :--- | :--- |
| 1 | `Employees.Photo` / `Categories.Picture` の画像バイナリを `NULL` とした | 本システムでは画像を表示・更新の対象外としている（列自体は原典どおり保持）。原典ではこの 17 行だけでファイルの大半を占めるため |
| 2 | 列名リストを明示的に付与 | 原典は `Customers` / `Order Details` / `Region` / `Territories` / `EmployeeTerritories` で列名を省略した位置指定 `INSERT` を使っている。`RowVersion` 列を追加した本設計では位置指定は避けるべきため |
| 3 | 文字列リテラルをすべて `N'...'` とした | データベースの照合順序に依存せず Unicode として解釈させるため |
| 4 | `SalesTargets` のサンプルデータを新規作成 | 原典に存在しないテーブルのため |

**上記以外の値は原典のままで、行数・内容を変更していない。**

## `SalesTargets` のサンプルデータ

原典に存在しないため、実績から機械的に生成した。

| 項目 | 内容 |
| :--- | :--- |
| 対象期間 | 1997-01 〜 1998-05 |
| 目標金額 | 当該社員・当該年月の実績に `0.85` / `0.95` / `1.00` / `1.10` / `1.20` の係数を順に掛け、100 円単位で丸めた値 |
| 達成率の分布 | 57.5% 〜 124.6%（実績が小さい月は 100 円単位の丸めにより係数から乖離する）。未達・達成の双方を含む |
| 未登録の月 | 実績が 0 の年月は**目標を登録していない** |

未登録の月を残しているのは、[テーブル定義書 ST-T2](../../LLD/TableSchema/Analysis.md#業務ルール) の
「目標が未登録の年月は『目標なし』として扱い、達成率を算出せず『－』と表示する」動作を確認するため。

目標金額 0 円（ST-T4：達成率を算出せず「－」）の動作を確認する場合は、任意の行を更新する。
**0 円と未登録は意味が異なる**（ST-T6）。

```sql
UPDATE [dbo].[SalesTargets]
   SET [TargetAmount] = 0
 WHERE [EmployeeID] = 1 AND [TargetYear] = 1997 AND [TargetMonth] = 1;
```

## 確認用クエリ

構築後の動作確認に使える例。

```sql
-- 未出荷・納期遅延の受注（受注一覧画面 SC-ORD-01 の「状況」列に相当）
SELECT  o.[OrderID], c.[CompanyName] AS [顧客], o.[OrderDate], o.[RequiredDate], o.[ShippedDate]
      , CASE WHEN o.[ShippedDate] IS NULL AND o.[RequiredDate] < GETDATE() THEN N'納期遅延'
             WHEN o.[ShippedDate] IS NULL                                  THEN N'未出荷'
             WHEN o.[ShippedDate] > o.[RequiredDate]                       THEN N'納期遅延'
             ELSE N'出荷済' END AS [状況]
FROM    [dbo].[Orders] AS o
        LEFT JOIN [dbo].[Customers] AS c ON c.[CustomerID] = o.[CustomerID]
WHERE   o.[ShippedDate] IS NULL
ORDER BY o.[OrderDate] DESC;

-- 受注 1 件の金額（受注詳細画面 SC-ORD-02 の小計・送料・合計）
-- [Discount] は real のため、計算前に decimal へ変換する（後述の「割引率の注意」）
DECLARE @OrderID int = 10248;
SELECT  SUM(ROUND(od.[UnitPrice] * (1 - CAST(od.[Discount] AS decimal(5,4))) * od.[Quantity], 2))
            AS [小計]
      , MAX(o.[Freight]) AS [送料]
      , SUM(ROUND(od.[UnitPrice] * (1 - CAST(od.[Discount] AS decimal(5,4))) * od.[Quantity], 2))
        + MAX(o.[Freight]) AS [合計]
FROM    [dbo].[Order Details] AS od
        INNER JOIN [dbo].[Orders] AS o ON o.[OrderID] = od.[OrderID]
WHERE   od.[OrderID] = @OrderID;

-- 低在庫・発注候補（在庫分析 FN-INV-01 / FN-INV-05）
SELECT  p.[ProductID], p.[ProductName], p.[UnitsInStock], p.[UnitsOnOrder], p.[ReorderLevel]
      , CASE WHEN p.[UnitsInStock] = 0 THEN N'在庫切れ' ELSE N'低在庫' END AS [区分]
FROM    [dbo].[Products] AS p
WHERE   p.[Discontinued] = 0 AND p.[UnitsInStock] <= p.[ReorderLevel]
ORDER BY p.[UnitsInStock];

-- 担当者別の目標と実績（パフォーマンス分析 FN-PRF-05）
SELECT  t.[EmployeeID], e.[LastName] + N' ' + e.[FirstName] AS [担当者]
      , t.[TargetYear], t.[TargetMonth], t.[TargetAmount]   AS [目標]
      , a.[実績]
      , CASE WHEN t.[TargetAmount] = 0 THEN NULL
             ELSE ROUND(a.[実績] * 100.0 / t.[TargetAmount], 1) END AS [達成率]
FROM    [dbo].[SalesTargets] AS t
        INNER JOIN [dbo].[Employees] AS e ON e.[EmployeeID] = t.[EmployeeID]
        OUTER APPLY (
            SELECT SUM(ROUND(od.[UnitPrice]
                             * (1 - CAST(od.[Discount] AS decimal(5,4)))
                             * od.[Quantity], 2)) AS [実績]
            FROM   [dbo].[Orders] AS o
                   INNER JOIN [dbo].[Order Details] AS od ON od.[OrderID] = o.[OrderID]
            WHERE  o.[EmployeeID] = t.[EmployeeID]
              AND  YEAR(o.[OrderDate])  = t.[TargetYear]
              AND  MONTH(o.[OrderDate]) = t.[TargetMonth]
        ) AS a
ORDER BY t.[EmployeeID], t.[TargetYear], t.[TargetMonth];
```

## 注意

### 割引率の注意（金額が合わない原因になる）

`Order Details.Discount` は原典どおり `real`（単精度浮動小数点）であり、格納値は指定した 10 進数と一致しない（`0.01` は実際には `0.009999999776...`）。
**`real` のまま計算すると誤差が蓄積する。** 実データでの検証結果は次のとおり。

| 計算方法 | 売上合計 |
| :--- | ---: |
| `real` のまま計算 | 1,265,793.10 |
| **`decimal` へ変換してから計算** | **1,265,793.29** ← 正 |

金額計算では必ず `CAST(od.[Discount] AS decimal(5,4))` のように 10 進数へ変換すること。
詳細は[テーブル定義書の「`Discount`（`real`）の扱い」](../../LLD/TableSchema.md#discountrealの扱い--実装時の注意)を参照。

### その他

- `Region` 列（`Customers` / `Suppliers` / `Employees` / `Orders.ShipRegion`）は州・県相当の**自由入力文字列**であり、`Region` テーブルとは無関係。結合してはならない。
- `Orders.ShippedDate` が `NULL` の受注は「未出荷」を意味する。
- 原典の日付リテラルは `m/d/yyyy` 形式のため、`03_InsertData.sql` は `SET DATEFORMAT mdy` を指定している。
- `Employees.ReportsTo` は自己参照のため、`03_InsertData.sql` は投入中のみ `FK_Employees_Employees` を無効化し、投入後に `WITH CHECK` で再有効化して全データを検証する。
