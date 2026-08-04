# テーブル定義書：配送管理

[要件定義](../../RDD/Home.md) / [基本設計](../../HLD/Home.md) / [詳細設計](../Home.md)<br>
基本：[共通仕様](../../HLD/Common.md) / [機能一覧](../../HLD/FeatureList.md) / [テーブル一覧](../../HLD/TableList.md) / [画面一覧](../../HLD/UI_List.md) / [画面遷移](../../HLD/UI_FlowList.md)<br>
詳細：[テーブル定義書](../TableSchema.md)（**配送管理**） / [画面定義書](../UI_ElementsAndEventList.md) / [イベント仕様書](../EventSpec.md)

収録テーブル：`Shippers`

---

## Shippers（運送会社）

出荷を担当する運送会社のマスタ。`Orders.ShipVia` から参照される。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `ShipperID` | 運送会社 ID | `int` IDENTITY(1,1) | 不可 | PK | 自動採番 | |
| `CompanyName` | 会社名 | `nvarchar(40)` | 不可 | | | 運送会社の名称 |
| `Phone` | 電話番号 | `nvarchar(24)` | 可 | | | |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_Shippers` | `ShipperID`（クラスタ化） |

### アプリで担保する制約

| 対象 | 規則 | 担保 |
| :--- | :--- | :--- |
| 削除 | `ShipVia` に当該運送会社を指す受注が存在する場合は削除できない（SHP-T1） | `ERR-FK`。DB に外部キー制約は作成しない |

### 業務ルール

| # | ルール |
| :--- | :--- |
| SHP-T1 | `ShipVia` に当該運送会社を指す `Orders` が存在する場合は削除できない（`ERR-FK`） |
| SHP-T2 | 配送実績の集計対象は「`ShipVia` が当該運送会社の受注」とし、未出荷（`ShippedDate` が NULL）の受注も件数に含める。ただし平均出荷日数の算出からは除く |
| SHP-T3 | 配送コスト合計は `Σ Orders.Freight`、平均送料は `Σ Orders.Freight ÷ 受注件数` とする |
| SHP-T4 | 納期遅延率は「納期遅延の受注件数 ÷ `RequiredDate` が設定された受注件数」とする。遅延の定義は [Orders.md](./Orders.md) ORD-T7 に従う |
| SHP-T5 | 平均出荷日数は `Σ (ShippedDate - OrderDate) ÷ 出荷済受注件数`（日数）とする |
