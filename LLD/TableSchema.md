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

本書の内容を SQL Server 上に構築する DDL / DML を [../Northwind/SQLSvr](../Northwind/SQLSvr/README.md) に用意している。

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

### DB に持たせない制約

**業務系で使用しない制約は DB に定義せず、アプリケーションで担保する。**
参照整合性と値の妥当性を保証する責任は、DB ではなく**アプリケーションにある**。

| # | DB に持たせないもの | アプリ側の担保 |
| :--- | :--- | :--- |
| 1 | 外部キー制約（`FOREIGN KEY`） | [`VAL-EXISTS`](../HLD/Common.md#6-共通検証ルール)（参照先の存在確認）／[`ERR-FK`](../HLD/Common.md#7-共通エラーハンドリング)（被参照データの削除禁止） |
| 2 | CASCADE 更新・削除（`ON DELETE/UPDATE CASCADE`） | イベント仕様書に削除手順を明記する（例：受注削除は `Order Details` を先に削除。[`EV-ORD-203`](./EventSpec/Orders.md#ev-ord-203-受注の削除)） |
| 3 | `CHECK` 制約 | [`VAL-NUMERIC`](../HLD/Common.md#6-共通検証ルール) / [`VAL-DATE`](../HLD/Common.md#6-共通検証ルール)（入力検証） |
| 4 | `UNIQUE` 制約 | [`VAL-DUP`](../HLD/Common.md#6-共通検証ルール)（重複確認） |
| 5 | トリガー（`TRIGGER`） | イベント仕様書の処理内容に手順として明記する |

DB に残すものは **`PRIMARY KEY` / `NOT NULL` / `DEFAULT` / `IDENTITY` / `INDEX`** のみ。

| 残すもの | 理由 |
| :--- | :--- |
| `PRIMARY KEY` | 行の同一性とクラスタ化インデックスのために必須。制約というより構造の定義 |
| `NOT NULL` | 列の定義そのもの |
| `DEFAULT` | 既定値の定義 |
| `IDENTITY` | 採番。採番テーブルを作らない方針のため |
| `INDEX` | 性能。**アプリ側の存在確認・削除可否判定も索引を必要とする** |

#### 各テーブルの記載

各テーブル定義書の「キーとインデックス」には主キーと索引のみを記載し、
外部キー・CHECK に相当する規則は「**アプリで担保する制約**」として、
参照する `VAL-*` / `ERR-*` / 業務ルール ID とともに記載する。

#### 索引に関する補足

外部キー制約を作らないため、参照先の存在確認と被参照データの削除可否判定は
アプリが発行する問い合わせになる。その対象列に索引がないと全表走査になるため、
原典に索引がない次の列へ索引を追加している。

| 索引 | 対象 | 用途 |
| :--- | :--- | :--- |
| `IX_Employees_ReportsTo` | `Employees.ReportsTo` | 組織ツリーの構築、部下の有無の判定（EMP-T4） |
| `IX_Territories_RegionID` | `Territories.RegionID` | 地域別集計、`Region` の存在確認 |
| `IX_EmployeeTerritories_TerritoryID` | `EmployeeTerritories.TerritoryID` | テリトリー別集計。`EmployeeID` は主キーの先頭列で代替できる |
| `IX_CustomerCustomerDemo_CustomerTypeID` | `CustomerCustomerDemo.CustomerTypeID` | 顧客区分からの逆引き。`CustomerID` は主キーの先頭列で代替できる |

### 原典との関係

- 列名・型・NULL 可否・既定値・CHECK 制約は、Northwind 原典の DDL（`instnwnd.sql`）に忠実とする。
- 原典の列の**削除・改名・型変更は行わない**。
- 追加は次の 2 点のみ（[共通仕様 9 節](../HLD/Common.md#9-northwind-原典への追加)）。
  - 楽観排他用の `RowVersion` 列
  - 売上目標テーブル `SalesTargets`
- 原典が持つ外部キー制約・CHECK 制約は、上記「DB に持たせない制約」の方針により**作成しない**。
  制約の内容自体は業務ルールとして各テーブル定義書に残し、アプリで担保する。

### 型の読み替え

原典は SQL Server の型で定義されている。本設計書では原典の型をそのまま記載し、アプリケーション側での扱いを次のとおりとする。

| DB 型 | アプリケーションでの扱い | 備考 |
| :--- | :--- | :--- |
| `int` | 32bit 整数 | |
| `smallint` | 16bit 整数 | 数量・在庫数に用いられる |
| `money` | 10 進数（小数 4 桁精度） | 金額計算は 10 進数で行い、浮動小数点で扱わない |
| `real` | 単精度浮動小数点 | `Order Details.Discount` のみ。**比較・計算の前に必ず 10 進数へ変換する**（下記） |
| `bit` | 真偽値 | |
| `datetime` | 日時 | 本システムでは日付部分のみを扱う（時刻は 00:00:00） |
| `nchar(n)` / `nvarchar(n)` | 文字列（Unicode、n 文字） | `nchar` は固定長。比較時は末尾空白を除去する |
| `ntext` | 長文文字列 | 原典どおり。検索条件には用いない |
| `image` | バイナリ（画像） | 本システムでは**表示・更新の対象外**とし、画面に出さない |
| `rowversion` | バイト列（8 バイト） | 楽観排他専用。画面に表示しない |

#### `Discount`（`real`）の扱い ※ 実装時の注意

`Order Details.Discount` は原典どおり `real`（単精度浮動小数点）であり、**格納値は指定した 10 進数と一致しない**。

| 見かけの値 | 実際の格納値 |
| :--- | :--- |
| `0.01` | `0.009999999776482582` |
| `0.02` | `0.019999999552965164` |
| `0.05` | `0.050000000745058060` |

このため `real` のまま金額を計算すると誤差が蓄積する。実データ（受注明細 2,155 行）での検証結果は次のとおり。

| 計算方法 | 売上合計 |
| :--- | ---: |
| `real` のまま計算 | 1,265,793.10 |
| **10 進数へ変換してから計算** | **1,265,793.29** ← 正 |

**金額計算では、割引率を必ず 10 進数へ変換してから用いること。** SQL では次のようにする。

```sql
-- 誤り：real のまま計算している
ROUND(od.[UnitPrice] * (1 - od.[Discount]) * od.[Quantity], 2)

-- 正しい：10 進数へ変換してから計算する
ROUND(od.[UnitPrice] * (1 - CAST(od.[Discount] AS decimal(5,4))) * od.[Quantity], 2)
```

アプリケーション側も同様に、浮動小数点型ではなく 10 進数型（`decimal` / `BigDecimal` 等）で計算する。
算出式そのものは[共通仕様 3 節](../HLD/Common.md#金額の算出式)に従う。

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
