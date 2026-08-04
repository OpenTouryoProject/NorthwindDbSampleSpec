# テーブル定義書：受注管理

[要件定義](../../RDD/Home.md) / [基本設計](../../HLD/Home.md) / [詳細設計](../Home.md)<br>
基本：[共通仕様](../../HLD/Common.md) / [機能一覧](../../HLD/FeatureList.md) / [テーブル一覧](../../HLD/TableList.md) / [画面一覧](../../HLD/UI_List.md) / [画面遷移](../../HLD/UI_FlowList.md)<br>
詳細：[テーブル定義書](../TableSchema.md)（**受注管理**） / [画面定義書](../UI_ElementsAndEventList.md) / [イベント仕様書](../EventSpec.md)

収録テーブル：`Orders`, `Order Details`

---

## Orders（受注）

顧客からの注文 1 件を表すトランザクション テーブル。出荷先の情報を受注時点の値として保持する。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `OrderID` | 受注 ID | `int` IDENTITY(1,1) | 不可 | PK | 自動採番 | 受注の識別子 |
| `CustomerID` | 顧客 ID | `nchar(5)` | 可 | FK → `Customers.CustomerID` | | 注文元の顧客。本システムでは登録時に必須とする（業務ルール参照） |
| `EmployeeID` | 担当社員 ID | `int` | 可 | FK → `Employees.EmployeeID` | | 受注を担当した社員。本システムでは登録時に必須とする |
| `OrderDate` | 受注日 | `datetime` | 可 | | | 注文を受け付けた日。本システムでは登録時に必須とする |
| `RequiredDate` | 要求納期 | `datetime` | 可 | | | 顧客が希望する納品期限 |
| `ShippedDate` | 出荷日 | `datetime` | 可 | | | 出荷した日。**NULL は未出荷**を意味する |
| `ShipVia` | 配送業者 ID | `int` | 可 | FK → `Shippers.ShipperID` | | 出荷を担当する運送会社 |
| `Freight` | 送料 | `money` | 可 | | `0` | 受注 1 件あたりの配送費用 |
| `ShipName` | 出荷先名称 | `nvarchar(40)` | 可 | | | 受注時点の配送先名称 |
| `ShipAddress` | 出荷先住所 | `nvarchar(60)` | 可 | | | |
| `ShipCity` | 出荷先市区町村 | `nvarchar(15)` | 可 | | | |
| `ShipRegion` | 出荷先地域 | `nvarchar(15)` | 可 | | | 州・県相当の自由入力。`Region` テーブルとは無関係 |
| `ShipPostalCode` | 出荷先郵便番号 | `nvarchar(10)` | 可 | | | |
| `ShipCountry` | 出荷先国 | `nvarchar(15)` | 可 | | | 売上分析・配送管理の国別集計に用いる |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Orders` | `OrderID`（クラスタ化） |
| INDEX | `CustomerID` | `CustomerID` |
| INDEX | `EmployeeID` | `EmployeeID` |
| INDEX | `OrderDate` | `OrderDate` |
| INDEX | `ShippedDate` | `ShippedDate` |
| INDEX | `ShipPostalCode` | `ShipPostalCode` |
| INDEX | `ShippersOrders` | `ShipVia`（配送管理の運送会社別集計で用いる） |

### アプリで担保する参照関係

[DB に持たせない制約](../TableSchema.md#db-に持たせない制約)の方針により、外部キー制約を作成しない。

| 列 | 参照先 | 担保 |
| :--- | :--- | :--- |
| `CustomerID` | `Customers.CustomerID` | `VAL-EXISTS`。顧客の削除時は受注の有無を確認し、あれば `ERR-FK` |
| `EmployeeID` | `Employees.EmployeeID` | `VAL-EXISTS`。社員の削除時は受注の有無を確認し、あれば `ERR-FK` |
| `ShipVia` | `Shippers.ShipperID` | `VAL-EXISTS`。運送会社の削除時は受注の有無を確認し、あれば `ERR-FK` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| ORD-T1 | 原典では `CustomerID` / `EmployeeID` / `OrderDate` が NULL 可だが、**本システムからの新規登録では必須**とする（`VAL-REQUIRED`）。既存データに NULL があり得るため、表示側は NULL を許容すること |
| ORD-T2 | `ShippedDate` が NULL の受注を「未出荷」、値を持つ受注を「出荷済」とする |
| ORD-T3 | `OrderDate <= RequiredDate`、`OrderDate <= ShippedDate` であること（`VAL-DATE`） |
| ORD-T4 | 出荷済（`ShippedDate` が NULL でない）の受注は、受注情報・明細を編集できない。出荷を取り消してから編集する |
| ORD-T5 | 受注は必ず 1 件以上の明細を持つ（`ERR-BIZ`） |
| ORD-T6 | 出荷先情報（`Ship*`）の既定値は、選択された顧客の会社名・住所とする。以後は受注ごとに独立して保持し、顧客マスタの変更を遡及させない |
| ORD-T7 | 納期遅延の判定：出荷済は `ShippedDate > RequiredDate`、未出荷は `RequiredDate < 当日`。`RequiredDate` が NULL の受注は遅延判定の対象外 |
| ORD-T8 | 削除は `Order Details` を先に削除してから `Orders` を削除する（同一トランザクション） |

---

## Order Details（受注明細）

受注に含まれる商品 1 行を表す。単価と割引率は**受注時点の値**を保持し、商品マスタの変更を遡及させない。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `OrderID` | 受注 ID | `int` | 不可 | PK / FK → `Orders.OrderID` | | 親の受注 |
| `ProductID` | 商品 ID | `int` | 不可 | PK / FK → `Products.ProductID` | | 対象商品 |
| `UnitPrice` | 単価 | `money` | 不可 | | `0` | 受注時点の単価。CHECK `UnitPrice >= 0` |
| `Quantity` | 数量 | `smallint` | 不可 | | `1` | CHECK `Quantity > 0` |
| `Discount` | 割引率 | `real` | 不可 | | `0` | 0〜1 の実数（0.15 は 15% 引き）。CHECK `Discount >= 0 and Discount <= 1` |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Order_Details` | `OrderID`, `ProductID`（クラスタ化） |
| INDEX | `OrderID` | `OrderID` |
| INDEX | `ProductID` | `ProductID` |

### アプリで担保する制約

[DB に持たせない制約](../TableSchema.md#db-に持たせない制約)の方針により、外部キー制約・CHECK 制約を作成しない。

| 対象 | 規則 | 担保 |
| :--- | :--- | :--- |
| `OrderID` | `Orders.OrderID` に存在すること | `VAL-EXISTS` |
| `ProductID` | `Products.ProductID` に存在すること | `VAL-EXISTS`。商品の削除時は明細の有無を確認し、あれば `ERR-FK` |
| `UnitPrice` | 0 以上 | `VAL-NUMERIC` |
| `Quantity` | 1 以上の整数 | `VAL-NUMERIC` |
| `Discount` | 0 以上 1 以下 | `VAL-NUMERIC` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| OD-T1 | 主キーが `(OrderID, ProductID)` であるため、**同一受注内に同じ商品を 2 行登録できない**。既に存在する商品を追加しようとした場合は `ERR-BIZ`（「この商品は既に明細に存在します」）とし、数量の変更で対応する |
| OD-T2 | `UnitPrice` の初期値は明細追加時点の `Products.UnitPrice` とする。以後は明細ごとに独立して保持する |
| OD-T3 | 廃番商品（`Products.Discontinued` が真）は新規明細に指定できない（`ERR-BIZ`）。既存明細の廃番商品はそのまま保持・表示する |
| OD-T4 | 金額の算出式は[共通仕様 3 節](../../HLD/Common.md#金額の算出式)に従う |
| OD-T5 | 出荷確定時、明細の `Quantity` を `Products.UnitsInStock` から減算する。出荷取消時は加算して戻す |
| OD-T6 | 楽観排他は親の `Orders.RowVersion` で判定する。明細の `RowVersion` は明細単位の更新検知用に保持するが、受注の保存は「明細を全削除して再登録」ではなく、追加・更新・削除を行として個別に適用する |
