# テーブル定義書：担当者管理

[要件定義](../../RDD/Home.md) / [基本設計](../../HLD/Home.md) / [詳細設計](../Home.md)<br>
[共通仕様](../../HLD/Common.md) / [機能一覧](../../HLD/FeatureList.md) / [テーブル一覧](../../HLD/TableList.md) / [画面一覧](../../HLD/UI_List.md) / [画面遷移](../../HLD/UI_FlowList.md)<br>
[テーブル定義書](../TableSchema.md)（**担当者管理**） / [画面定義書](../UI_ElementsAndEventList.md) / [イベント仕様書](../EventSpec.md)

収録テーブル：`Employees`, `Region`, `Territories`, `EmployeeTerritories`

---

## Employees（社員）

自社社員のマスタ。`ReportsTo` による自己参照で上司・部下の階層を表す。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `EmployeeID` | 社員 ID | `int` IDENTITY(1,1) | 不可 | PK | 自動採番 | |
| `LastName` | 姓 | `nvarchar(20)` | 不可 | | | |
| `FirstName` | 名 | `nvarchar(10)` | 不可 | | | |
| `Title` | 役職 | `nvarchar(30)` | 可 | | | |
| `TitleOfCourtesy` | 敬称 | `nvarchar(25)` | 可 | | | Mr. / Ms. 等 |
| `BirthDate` | 生年月日 | `datetime` | 可 | | | CHECK `BirthDate < getdate()` |
| `HireDate` | 入社日 | `datetime` | 可 | | | |
| `Address` | 住所 | `nvarchar(60)` | 可 | | | |
| `City` | 市区町村 | `nvarchar(15)` | 可 | | | |
| `Region` | 地域 | `nvarchar(15)` | 可 | | | 州・県相当の自由入力。`Region` テーブルとは無関係 |
| `PostalCode` | 郵便番号 | `nvarchar(10)` | 可 | | | |
| `Country` | 国 | `nvarchar(15)` | 可 | | | |
| `HomePhone` | 自宅電話番号 | `nvarchar(24)` | 可 | | | |
| `Extension` | 内線番号 | `nvarchar(4)` | 可 | | | |
| `Photo` | 顔写真 | `image` | 可 | | | 本システムでは**表示・更新の対象外**。画面に出さず、更新時も値を変更しない |
| `Notes` | 備考 | `ntext` | 可 | | | 経歴等の自由文。検索条件には用いない |
| `ReportsTo` | 上司社員 ID | `int` | 可 | FK → `Employees.EmployeeID` | | NULL は最上位（上司なし） |
| `PhotoPath` | 顔写真パス | `nvarchar(255)` | 可 | | | 本システムでは表示・更新の対象外 |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Employees` | `EmployeeID`（クラスタ化） |
| FK | `FK_Employees_Employees` | `ReportsTo` → `Employees.EmployeeID` |
| CHECK | `CK_Birthdate` | `BirthDate < getdate()` |
| INDEX | `LastName` | `LastName` |
| INDEX | `PostalCode` | `PostalCode` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| EMP-T1 | 画面上の社員名は「`LastName` + 半角空白 + `FirstName`」で表示する |
| EMP-T2 | `ReportsTo` に自分自身を指定できない。また、上司をたどった経路に自分自身が現れる循環参照を作れない（`ERR-BIZ`） |
| EMP-T3 | `BirthDate` は当日より前の日付であること（`VAL-DATE`）。`BirthDate <= HireDate` であること |
| EMP-T4 | 当該社員を参照する `Orders` が存在する場合、または `ReportsTo` が当該社員を指す `Employees` が存在する場合は削除できない（`ERR-FK`） |
| EMP-T5 | 削除時は `EmployeeTerritories` の関連行をあわせて削除する（同一トランザクション） |
| EMP-T6 | `Photo` / `PhotoPath` は更新対象外のため、社員更新の SQL に含めない |
| EMP-T7 | 組織ツリーは `ReportsTo` が NULL の社員を根として構築する |

---

## Region（地域）

テリトリーの上位区分マスタ。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `RegionID` | 地域 ID | `int` | 不可 | PK | | **自動採番ではない**。原典どおり値を指定して登録する |
| `RegionDescription` | 地域名 | `nchar(50)` | 不可 | | | 固定長。比較・表示の際は末尾空白を除去する |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Region` | `RegionID`（非クラスタ化） |

### 業務ルール

| # | ルール |
| :--- | :--- |
| REG-T1 | 本システムでは**参照のみ**とし、保守画面は設けない（`RowVersion` を追加しない） |
| REG-T2 | 顧客・仕入先・社員・受注の `Region` 列（自由入力の州・県）とは**無関係**であり、結合してはならない |

---

## Territories（テリトリー）

社員に割り当てる営業担当区域のマスタ。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `TerritoryID` | テリトリー ID | `nvarchar(20)` | 不可 | PK | | コード（原典では郵便番号相当の数字文字列） |
| `TerritoryDescription` | テリトリー名 | `nchar(50)` | 不可 | | | 固定長。比較・表示の際は末尾空白を除去する |
| `RegionID` | 地域 ID | `int` | 不可 | FK → `Region.RegionID` | | 所属する地域 |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Territories` | `TerritoryID`（非クラスタ化） |
| FK | `FK_Territories_Region` | `RegionID` → `Region.RegionID` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| TER-T1 | 本システムでは**参照のみ**とし、保守画面は設けない（`RowVersion` を追加しない） |
| TER-T2 | テリトリー別の実績集計は `EmployeeTerritories` を介して社員の受注を集計する。1 社員が複数テリトリーを担当する場合、その社員の実績は担当する各テリトリーに重複計上される。集計画面にはその旨を注記する |

---

## EmployeeTerritories（社員・テリトリー関連）

社員とテリトリーの多対多を表す関連テーブル。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `EmployeeID` | 社員 ID | `int` | 不可 | PK / FK → `Employees.EmployeeID` | | |
| `TerritoryID` | テリトリー ID | `nvarchar(20)` | 不可 | PK / FK → `Territories.TerritoryID` | | |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_EmployeeTerritories` | `EmployeeID`, `TerritoryID`（非クラスタ化） |
| FK | `FK_EmployeeTerritories_Employees` | `EmployeeID` → `Employees.EmployeeID` |
| FK | `FK_EmployeeTerritories_Territories` | `TerritoryID` → `Territories.TerritoryID` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| ET-T1 | 関連の付け外しのみを行い、行の項目更新はしない（`RowVersion` を追加しない） |
| ET-T2 | 社員の削除時にあわせて削除する |
| ET-T3 | 同一の組み合わせを重複して登録できない（主キー制約。`VAL-DUP`） |
