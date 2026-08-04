# テーブル定義書：商品管理

[要件定義](../../RDD/Home.md) / [基本設計](../../HLD/Home.md) / [詳細設計](../Home.md)<br>
基本：[共通仕様](../../HLD/Common.md) / [機能一覧](../../HLD/FeatureList.md) / [テーブル一覧](../../HLD/TableList.md) / [画面一覧](../../HLD/UI_List.md) / [画面遷移](../../HLD/UI_FlowList.md)<br>
詳細：[テーブル定義書](../TableSchema.md)（**商品管理**） / [画面定義書](../UI_ElementsAndEventList.md) / [イベント仕様書](../EventSpec.md)

収録テーブル：`Products`, `Categories`

---

## Products（商品）

販売する商品のマスタ。在庫数・発注点を保持し、在庫分析の基礎データとなる。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `ProductID` | 商品 ID | `int` IDENTITY(1,1) | 不可 | PK | 自動採番 | 商品の識別子 |
| `ProductName` | 商品名 | `nvarchar(40)` | 不可 | | | |
| `SupplierID` | 仕入先 ID | `int` | 可 | FK → `Suppliers.SupplierID` | | 仕入元 |
| `CategoryID` | カテゴリ ID | `int` | 可 | FK → `Categories.CategoryID` | | 商品分類 |
| `QuantityPerUnit` | 単位あたり数量 | `nvarchar(20)` | 可 | | | 「10 boxes x 20 bags」のような荷姿の記述。文字列であり計算に用いない |
| `UnitPrice` | 単価 | `money` | 可 | | `0` | CHECK `UnitPrice >= 0` |
| `UnitsInStock` | 在庫数 | `smallint` | 可 | | `0` | CHECK `UnitsInStock >= 0` |
| `UnitsOnOrder` | 発注済数 | `smallint` | 可 | | `0` | 仕入先へ発注中の数量。CHECK `UnitsOnOrder >= 0` |
| `ReorderLevel` | 発注点 | `smallint` | 可 | | `0` | 補充を要すると判断する在庫数の閾値。CHECK `ReorderLevel >= 0` |
| `Discontinued` | 廃番 | `bit` | 不可 | | `0` | 真のとき新規受注に使用できない |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Products` | `ProductID`（クラスタ化） |
| INDEX | `CategoryID` | `CategoryID` |
| INDEX | `SupplierID` | `SupplierID` |
| INDEX | `ProductName` | `ProductName` |

### アプリで担保する制約

[DB に持たせない制約](../TableSchema.md#db-に持たせない制約)の方針により、外部キー制約・CHECK 制約を作成しない。

| 対象 | 規則 | 担保 |
| :--- | :--- | :--- |
| `SupplierID` | `Suppliers.SupplierID` に存在すること | `VAL-EXISTS`。仕入先の削除時は商品の有無を確認し、あれば `ERR-FK` |
| `CategoryID` | `Categories.CategoryID` に存在すること | `VAL-EXISTS`。カテゴリの削除時は商品の有無を確認し、あれば `ERR-FK` |
| `UnitPrice` | 0 以上 | `VAL-NUMERIC` |
| `UnitsInStock` | 0 以上（在庫引落後も負にしない） | `VAL-NUMERIC` / `ERR-BIZ`（PRD-T5） |
| `UnitsOnOrder` | 0 以上 | `VAL-NUMERIC` |
| `ReorderLevel` | 0 以上 | `VAL-NUMERIC` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| PRD-T1 | 廃番（`Discontinued` が真）の商品は、受注の新規明細に指定できない（`ERR-BIZ`）。既存明細はそのまま保持・表示する |
| PRD-T2 | 低在庫の判定は `UnitsInStock <= ReorderLevel`、在庫切れの判定は `UnitsInStock = 0` とする |
| PRD-T3 | 発注候補の判定は `UnitsInStock + UnitsOnOrder <= ReorderLevel` かつ `Discontinued` が偽とする |
| PRD-T4 | 在庫金額は `UnitPrice × UnitsInStock` とする |
| PRD-T5 | 在庫数は受注の出荷確定時に減算し、出荷取消時に加算する（[Orders.md](./Orders.md) OD-T5）。減算後に負となる場合は出荷確定を行わず `ERR-BIZ`（「在庫が不足しています」）とする |
| PRD-T6 | 当該商品を参照する `Order Details` が存在する場合は削除できない（`ERR-FK`）。販売実績のある商品は廃番設定で運用する |
| PRD-T7 | 在庫回転率は「指定期間の出荷済受注に含まれる当該商品の数量合計 ÷ 現在庫数」とする。現在庫数が 0 の場合は算出せず「－」と表示する |
| PRD-T8 | 滞留在庫は「指定期間に出荷実績がなく、かつ `UnitsInStock > 0`」の商品とする |

---

## Categories（カテゴリ）

商品分類のマスタ。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `CategoryID` | カテゴリ ID | `int` IDENTITY(1,1) | 不可 | PK | 自動採番 | |
| `CategoryName` | カテゴリ名 | `nvarchar(15)` | 不可 | | | |
| `Description` | 説明 | `ntext` | 可 | | | 検索条件には用いない |
| `Picture` | 画像 | `image` | 可 | | | 本システムでは**表示・更新の対象外**。画面に出さず、更新時も値を変更しない |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Categories` | `CategoryID`（クラスタ化） |
| INDEX | `CategoryName` | `CategoryName` |

### アプリで担保する制約

| 対象 | 規則 | 担保 |
| :--- | :--- | :--- |
| `CategoryName` | カテゴリ内で一意（CAT-T1） | `VAL-DUP`。DB に `UNIQUE` 制約は作成しない |
| 削除 | 商品が存在するカテゴリは削除できない（CAT-T2） | `ERR-FK` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| CAT-T1 | `CategoryName` はカテゴリ内で一意とする（`VAL-DUP`） |
| CAT-T2 | 当該カテゴリを参照する `Products` が存在する場合は削除できない（`ERR-FK`） |
| CAT-T3 | `Picture` は更新対象外のため、カテゴリ更新の SQL に含めない |
