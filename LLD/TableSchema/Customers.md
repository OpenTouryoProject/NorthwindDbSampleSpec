# テーブル定義書：顧客管理

[要件定義](../../RDD/Home.md) / [基本設計](../../HLD/Home.md) / [詳細設計](../Home.md)<br>
[共通仕様](../../HLD/Common.md) / [機能一覧](../../HLD/FeatureList.md) / [テーブル一覧](../../HLD/TableList.md) / [画面一覧](../../HLD/UI_List.md) / [画面遷移](../../HLD/UI_FlowList.md)<br>
[テーブル定義書](../TableSchema.md)（**顧客管理**） / [画面定義書](../UI_ElementsAndEventList.md) / [イベント仕様書](../EventSpec.md)

収録テーブル：`Customers`, `CustomerDemographics`, `CustomerCustomerDemo`

---

## Customers（顧客）

取引先企業のマスタ。主キーは自動採番ではなく、利用者が入力する 5 桁のコード。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `CustomerID` | 顧客 ID | `nchar(5)` | 不可 | PK | | 英大文字 5 桁のコード。**利用者が入力する**（`VAL-CODE`） |
| `CompanyName` | 会社名 | `nvarchar(40)` | 不可 | | | 顧客の正式名称 |
| `ContactName` | 担当者名 | `nvarchar(30)` | 可 | | | 先方の窓口担当者 |
| `ContactTitle` | 担当者役職 | `nvarchar(30)` | 可 | | | |
| `Address` | 住所 | `nvarchar(60)` | 可 | | | |
| `City` | 市区町村 | `nvarchar(15)` | 可 | | | |
| `Region` | 地域 | `nvarchar(15)` | 可 | | | 州・県相当の自由入力。`Region` テーブルとは無関係 |
| `PostalCode` | 郵便番号 | `nvarchar(10)` | 可 | | | |
| `Country` | 国 | `nvarchar(15)` | 可 | | | 顧客一覧の絞り込み・売上分析の国別集計に用いる |
| `Phone` | 電話番号 | `nvarchar(24)` | 可 | | | |
| `Fax` | FAX 番号 | `nvarchar(24)` | 可 | | | |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Customers` | `CustomerID`（クラスタ化） |
| INDEX | `City` | `City` |
| INDEX | `CompanyName` | `CompanyName` |
| INDEX | `PostalCode` | `PostalCode` |
| INDEX | `Region` | `Region` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| CUS-T1 | `CustomerID` は英大文字 5 桁。新規登録時に既存と重複していないことを検証する（`VAL-DUP`） |
| CUS-T2 | `CustomerID` は登録後に変更できない（編集モードでは読み取り専用） |
| CUS-T3 | `nchar(5)` は固定長のため、比較・表示の際は末尾空白を除去する |
| CUS-T4 | 当該顧客を参照する `Orders` が存在する場合は削除できない（`ERR-FK`） |
| CUS-T5 | 削除時は `CustomerCustomerDemo` の関連行をあわせて削除する（同一トランザクション） |
| CUS-T6 | 受注登録時の出荷先既定値として `CompanyName` / `Address` / `City` / `Region` / `PostalCode` / `Country` を用いる |

---

## CustomerDemographics（顧客区分）

顧客の分類マスタ。Northwind 原典ではデータが投入されていない。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `CustomerTypeID` | 顧客区分 ID | `nchar(10)` | 不可 | PK | | 区分コード |
| `CustomerDesc` | 顧客区分説明 | `ntext` | 可 | | | 区分の説明文 |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_CustomerDemographics` | `CustomerTypeID`（非クラスタ化） |

### 業務ルール

| # | ルール |
| :--- | :--- |
| CD-T1 | 本システムでは**参照のみ**とし、区分マスタの保守画面は設けない（`RowVersion` を追加しない） |
| CD-T2 | 顧客詳細画面では、当該顧客に紐づく区分を一覧表示し、割り当て・解除のみ行う |
| CD-T3 | 原典のデータは 0 件のため、区分未登録の状態で正しく動作すること（区分欄が空でも顧客の登録・更新が行えること） |

---

## CustomerCustomerDemo（顧客・顧客区分関連）

顧客と顧客区分の多対多を表す関連テーブル。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `CustomerID` | 顧客 ID | `nchar(5)` | 不可 | PK / FK → `Customers.CustomerID` | | |
| `CustomerTypeID` | 顧客区分 ID | `nchar(10)` | 不可 | PK / FK → `CustomerDemographics.CustomerTypeID` | | |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_CustomerCustomerDemo` | `CustomerID`, `CustomerTypeID`（非クラスタ化） |
| FK | `FK_CustomerCustomerDemo_Customers` | `CustomerID` → `Customers.CustomerID` |
| FK | `FK_CustomerCustomerDemo` | `CustomerTypeID` → `CustomerDemographics.CustomerTypeID` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| CCD-T1 | 関連の付け外しのみを行い、行の項目更新はしない（`RowVersion` を追加しない） |
| CCD-T2 | 顧客の削除時にあわせて削除する |
