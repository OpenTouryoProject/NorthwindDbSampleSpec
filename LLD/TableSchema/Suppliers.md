# テーブル定義書：仕入先管理

[要件定義](../../RDD/Home.md) / [基本設計](../../HLD/Home.md) / [詳細設計](../Home.md)<br>
基本：[共通仕様](../../HLD/Common.md) / [機能一覧](../../HLD/FeatureList.md) / [テーブル一覧](../../HLD/TableList.md) / [画面一覧](../../HLD/UI_List.md) / [画面遷移](../../HLD/UI_FlowList.md)<br>
詳細：[テーブル定義書](../TableSchema.md)（**仕入先管理**） / [画面定義書](../UI_ElementsAndEventList.md) / [イベント仕様書](../EventSpec.md)

収録テーブル：`Suppliers`

---

## Suppliers（仕入先）

商品の仕入元のマスタ。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `SupplierID` | 仕入先 ID | `int` IDENTITY(1,1) | 不可 | PK | 自動採番 | |
| `CompanyName` | 会社名 | `nvarchar(40)` | 不可 | | | 仕入先の正式名称 |
| `ContactName` | 担当者名 | `nvarchar(30)` | 可 | | | 先方の窓口担当者 |
| `ContactTitle` | 担当者役職 | `nvarchar(30)` | 可 | | | |
| `Address` | 住所 | `nvarchar(60)` | 可 | | | |
| `City` | 市区町村 | `nvarchar(15)` | 可 | | | |
| `Region` | 地域 | `nvarchar(15)` | 可 | | | 州・県相当の自由入力。`Region` テーブルとは無関係 |
| `PostalCode` | 郵便番号 | `nvarchar(10)` | 可 | | | |
| `Country` | 国 | `nvarchar(15)` | 可 | | | 仕入先一覧の国別絞り込みに用いる |
| `Phone` | 電話番号 | `nvarchar(24)` | 可 | | | |
| `Fax` | FAX 番号 | `nvarchar(24)` | 可 | | | |
| `HomePage` | ホームページ | `ntext` | 可 | | | URL を含む自由文。検索条件には用いない |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Suppliers` | `SupplierID`（クラスタ化） |
| INDEX | `CompanyName` | `CompanyName` |
| INDEX | `PostalCode` | `PostalCode` |

### アプリで担保する制約

| 対象 | 規則 | 担保 |
| :--- | :--- | :--- |
| 削除 | 商品が存在する仕入先は削除できない（SUP-T1） | `ERR-FK`。DB に外部キー制約は作成しない |

### 業務ルール

| # | ルール |
| :--- | :--- |
| SUP-T1 | 当該仕入先を参照する `Products` が存在する場合は削除できない（`ERR-FK`） |
| SUP-T2 | 発注書には、当該仕入先の商品のうち発注候補（[Products.md](./Products.md) PRD-T3）に該当するものを出力する |
| SUP-T3 | 発注書の発注数量は「`ReorderLevel × 2 - (UnitsInStock + UnitsOnOrder)`」を初期値とし、1 未満になる場合は出力対象から除く。利用者は出力前に数量を変更できる |
| SUP-T4 | 発注書は印刷用画面として同期表示する。発注内容は DB に保存しない（発注管理は本システムのスコープ外） |
