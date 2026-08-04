# テーブル定義書

[要件定義](../RDD/Home.md) / [基本設計](../HLD/Home.md) / [詳細設計](./Home.md)<br>
基本：[共通仕様](../HLD/Common.md) / [機能一覧](../HLD/FeatureList.md) / [テーブル一覧](../HLD/TableList.md) / [画面一覧](../HLD/UI_List.md) / [画面遷移](../HLD/UI_FlowList.md)<br>
詳細：**テーブル定義書** / [画面定義書](./UI_ElementsAndEventList.md) / [イベント仕様書](./EventSpec.md)

本書は索引と共通ルールを定める。各テーブルの定義はモジュール別のファイルに分割している。

## 索引

| ファイル | 収録テーブル |
| :--- | :--- |
| [Orders.md](./TableSchema/Orders.md) | `Orders`, `Order Details` |
| [Customers.md](./TableSchema/Customers.md) | `Customers`, `CustomerDemographics`, `CustomerCustomerDemo` |
| [Products.md](./TableSchema/Products.md) | `Products`, `Categories` |
| [Suppliers.md](./TableSchema/Suppliers.md) | `Suppliers` |
| [Employees.md](./TableSchema/Employees.md) | `Employees`, `Region`, `Territories`, `EmployeeTerritories` |
| [Shippers.md](./TableSchema/Shippers.md) | `Shippers` |
| [Analysis.md](./TableSchema/Analysis.md) | `SalesTargets`（追加テーブル） |

---

## 共通ルール

### 記載形式

各テーブルは次の構成で記述する。

1. 概要
2. 列定義表：`列名 / 論理名 / 型 / NULL / キー / 既定値 / 説明・備考`
3. キーとインデックス
4. 業務ルール

列定義表の凡例：

| 記号 | 意味 |
| :--- | :--- |
| キー欄 `PK` | 主キー |
| キー欄 `FK` | 外部キー |
| NULL 欄 `可` / `不可` | `NULL` を許容するか |
| 説明欄の **追加** | Northwind 原典に対して本設計で追加した列 |

### 原典との関係

- 列名・型・NULL 可否・既定値・CHECK 制約は、Northwind 原典の DDL（`instnwnd.sql`）に忠実とする。
- 原典の列の**削除・改名・型変更は行わない**。
- 追加は次の 2 点のみ（[共通仕様 9 節](../HLD/Common.md#9-northwind-原典への追加)）。
  - 楽観排他用の `RowVersion` 列
  - 売上目標テーブル `SalesTargets`

### 型の読み替え

原典は SQL Server の型で定義されている。本設計書では原典の型をそのまま記載し、アプリケーション側での扱いを次のとおりとする。

| DB 型 | アプリケーションでの扱い | 備考 |
| :--- | :--- | :--- |
| `int` | 32bit 整数 | |
| `smallint` | 16bit 整数 | 数量・在庫数に用いられる |
| `money` | 10 進数（小数 4 桁精度） | 金額計算は 10 進数で行い、浮動小数点で扱わない |
| `real` | 単精度浮動小数点 | `Order Details.Discount` のみ。比較・計算時は 10 進数へ変換する |
| `bit` | 真偽値 | |
| `datetime` | 日時 | 本システムでは日付部分のみを扱う（時刻は 00:00:00） |
| `nchar(n)` / `nvarchar(n)` | 文字列（Unicode、n 文字） | `nchar` は固定長。比較時は末尾空白を除去する |
| `ntext` | 長文文字列 | 原典どおり。検索条件には用いない |
| `image` | バイナリ（画像） | 本システムでは**表示・更新の対象外**とし、画面に出さない |
| `rowversion` | バイト列（8 バイト） | 楽観排他専用。画面に表示しない |

### `RowVersion` 列（追加）

- 定義：`RowVersion rowversion NOT NULL`
- 値は DB が自動的に採番・更新する。アプリケーションから値を設定しない。
- 追加対象：`Orders`, `Order Details`, `Customers`, `Products`, `Categories`, `Suppliers`, `Employees`, `Shippers`, `SalesTargets`
- 追加対象外：`Region`, `Territories`, `EmployeeTerritories`, `CustomerDemographics`, `CustomerCustomerDemo`
- 使用方法：更新・削除の `WHERE` 句に「主キー ＝ 値 AND RowVersion ＝ 読み込み時の値」を指定し、更新件数が 0 件のときは `ERR-CONFLICT` とする。

### 命名

- テーブル名・列名は原典どおり（`Order Details` のように空白を含むものがある。SQL 中では区切り識別子で囲む）。
- インデックス名は原典に存在するものを記載し、本設計で追加するものは `IX_<テーブル名>_<列名>` とする。

### 共通の扱い

- すべての日付列は日付のみを保持し、時刻は 00:00:00 とする。
- `Region`（地域名）を表す列が `Customers` / `Suppliers` / `Employees` / `Orders` にあるが、これらは州・県相当の**自由入力文字列**であり、`Region` テーブルとは無関係である。混同しないこと。
