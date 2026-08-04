# テーブル定義書：パフォーマンス分析（追加テーブル）

[要件定義](../../RDD/Home.md) / [基本設計](../../HLD/Home.md) / [詳細設計](../Home.md)<br>
基本：[共通仕様](../../HLD/Common.md) / [機能一覧](../../HLD/FeatureList.md) / [テーブル一覧](../../HLD/TableList.md) / [画面一覧](../../HLD/UI_List.md) / [画面遷移](../../HLD/UI_FlowList.md)<br>
詳細：[テーブル定義書](../TableSchema.md)（**パフォーマンス分析**） / [画面定義書](../UI_ElementsAndEventList.md) / [イベント仕様書](../EventSpec.md)

収録テーブル：`SalesTargets`（**本設計での追加テーブル**）

---

## SalesTargets（売上目標）

要件 `PRF-R4` / `PRF-R5`（目標設定・進捗トラッキング）は Northwind 原典のテーブルだけでは満たせないため、
担当者別・年月別の売上目標を保持するテーブルを 1 つ追加する。

過剰設計を避けるため、**採番用の代理キーを設けず**、業務キーをそのまま主キーとする。

### 列定義

| 列名 | 論理名 | 型 | NULL | キー | 既定値 | 説明・備考 |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| `EmployeeID` | 社員 ID | `int` | 不可 | PK / FK → `Employees.EmployeeID` | | 目標を設定する担当者 |
| `TargetYear` | 対象年 | `smallint` | 不可 | PK | | 西暦 4 桁。CHECK `TargetYear >= 1900` |
| `TargetMonth` | 対象月 | `tinyint` | 不可 | PK | | 1〜12。CHECK `TargetMonth between 1 and 12` |
| `TargetAmount` | 目標金額 | `money` | 不可 | | `0` | 当該年月の売上目標。CHECK `TargetAmount >= 0` |
| `RowVersion` | 行バージョン | `rowversion` | 不可 | | DB 自動 | **追加**。楽観排他用。画面には表示しない |

### キーとインデックス

| 種別 | 名称 | 対象 |
| :--- | :--- | :--- |
| PK | `PK_SalesTargets` | `EmployeeID`, `TargetYear`, `TargetMonth`（クラスタ化） |
| FK | `FK_SalesTargets_Employees` | `EmployeeID` → `Employees.EmployeeID` |
| CHECK | `CK_SalesTargets_Year` | `TargetYear >= 1900` |
| CHECK | `CK_SalesTargets_Month` | `TargetMonth between 1 and 12` |
| CHECK | `CK_SalesTargets_Amount` | `TargetAmount >= 0` |

### 業務ルール

| # | ルール |
| :--- | :--- |
| ST-T1 | 同一社員・同一年月の目標は 1 件のみ（主キー制約。`VAL-DUP`） |
| ST-T2 | 目標が未登録の年月は「目標なし」として扱い、達成率を算出せず「－」と表示する。0 円の目標として扱わない |
| ST-T3 | 実績は「当該社員が担当する受注のうち、受注日が対象年月に含まれるものの明細金額合計」とする（送料を含めない） |
| ST-T4 | 達成率は `実績 ÷ TargetAmount × 100`（小数第 1 位まで）とする。`TargetAmount` が 0 の場合は算出せず「－」と表示する |
| ST-T5 | 社員の削除時にあわせて削除する（同一トランザクション） |
| ST-T6 | 目標金額の 0 円と未登録は意味が異なる。目標設定画面では両者を区別して扱う |
