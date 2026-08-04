# 機能一覧

[要件定義](../RDD/Home.md) / [基本設計](./Home.md) / [詳細設計](../LLD/Home.md)<br>
[共通仕様](./Common.md) / **機能一覧** / [テーブル一覧](./TableList.md) / [画面一覧](./UI_List.md) / [画面遷移](./UI_FlowList.md)<br>
[テーブル定義書](../LLD/TableSchema.md) / [画面定義書](../LLD/UI_ElementsAndEventList.md) / [イベント仕様書](../LLD/EventSpec.md)

全 9 モジュールの機能を機能 ID 単位で列挙する。要件との対応は [要件定義](../RDD/Home.md) の各モジュール節を参照。

## 凡例

| 欄 | 内容 |
| :--- | :--- |
| 機能 ID | `FN-<モジュールコード>-<連番>` |
| 種別 | 参照／登録／更新／削除／集計／印刷 |
| 関連画面 | 当該機能を実現する画面 ID（[画面一覧](./UI_List.md)） |
| 主要テーブル | 当該機能が読み書きするテーブル |

---

## 共通（`CMN`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-CMN-01` | メニュー表示 | 参照 | 全モジュールの入口を一覧表示し、各モジュールの先頭画面へ遷移する | `SC-CMN-01` | － |

---

## 受注管理（`ORD`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-ORD-01` | 受注一覧表示・検索 | 参照 | 顧客・担当者・受注日範囲・出荷状況で絞り込み、ページ単位に一覧表示する | `SC-ORD-01` | `Orders`, `Customers`, `Employees`, `Shippers` |
| `FN-ORD-02` | 受注詳細照会 | 参照 | 受注 1 件の受注情報・明細・小計・送料・合計を表示する | `SC-ORD-02` | `Orders`, `Order Details`, `Products`, `Customers`, `Employees`, `Shippers` |
| `FN-ORD-03` | 受注新規登録 | 登録 | 受注情報と明細を入力して登録する | `SC-ORD-03` | `Orders`, `Order Details`, `Products` |
| `FN-ORD-04` | 受注編集 | 更新 | 未出荷の受注について、受注情報と明細を更新する | `SC-ORD-03` | `Orders`, `Order Details`, `Products` |
| `FN-ORD-05` | 受注削除 | 削除 | 明細とあわせて受注を削除する | `SC-ORD-02` | `Orders`, `Order Details` |
| `FN-ORD-06` | 出荷ステータス更新 | 更新 | 出荷日・配送業者・送料を設定して出荷を確定する。出荷の取消も行う | `SC-ORD-04` | `Orders`, `Order Details`, `Products` |
| `FN-ORD-07` | 受注帳票出力 | 印刷 | 納品書・請求書を印刷用に表示する | `SC-ORD-05` | `Orders`, `Order Details`, `Products`, `Customers`, `Shippers` |

---

## 顧客管理（`CUS`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-CUS-01` | 顧客一覧表示・検索 | 参照 | 会社名・担当者名・国・地域で絞り込み、ページ単位に一覧表示する | `SC-CUS-01` | `Customers` |
| `FN-CUS-02` | 顧客詳細照会 | 参照 | 会社情報・連絡先・所属する顧客区分を表示する | `SC-CUS-02` | `Customers`, `CustomerCustomerDemo`, `CustomerDemographics` |
| `FN-CUS-03` | 顧客新規登録 | 登録 | 顧客 ID を入力して顧客を登録する | `SC-CUS-03` | `Customers`, `CustomerCustomerDemo` |
| `FN-CUS-04` | 顧客編集 | 更新 | 顧客情報と顧客区分の割り当てを更新する | `SC-CUS-03` | `Customers`, `CustomerCustomerDemo` |
| `FN-CUS-05` | 顧客削除 | 削除 | 受注のない顧客を削除する | `SC-CUS-02` | `Customers`, `CustomerCustomerDemo` |
| `FN-CUS-06` | 購買履歴表示 | 集計 | 受注一覧と取引サマリ（累計受注件数・累計売上・最終受注日）を表示する | `SC-CUS-04` | `Orders`, `Order Details` |
| `FN-CUS-07` | 顧客ランキング分析 | 集計 | 期間を指定し、売上金額の降順に顧客を順位付けする | `SC-CUS-05` | `Orders`, `Order Details`, `Customers` |

---

## 商品管理（`PRD`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-PRD-01` | 商品一覧表示・検索 | 参照 | 商品名・カテゴリ・仕入先・廃番区分で絞り込み、発注点以下の商品を識別可能に一覧表示する | `SC-PRD-01` | `Products`, `Categories`, `Suppliers` |
| `FN-PRD-02` | 商品詳細照会 | 参照 | 仕入先情報・カテゴリ・単価・在庫数・発注済数・発注点を表示する | `SC-PRD-02` | `Products`, `Categories`, `Suppliers` |
| `FN-PRD-03` | 商品新規登録 | 登録 | 商品を登録する | `SC-PRD-03` | `Products` |
| `FN-PRD-04` | 商品編集 | 更新 | 商品情報を更新する | `SC-PRD-03` | `Products` |
| `FN-PRD-05` | 商品削除 | 削除 | 受注明細のない商品を削除する | `SC-PRD-02` | `Products` |
| `FN-PRD-06` | 廃番設定・解除 | 更新 | 商品の廃番区分を切り替える | `SC-PRD-02`, `SC-PRD-03` | `Products` |
| `FN-PRD-07` | カテゴリ保守 | 参照／登録／更新／削除 | カテゴリの一覧表示と登録・更新・削除を行う | `SC-PRD-04` | `Categories`, `Products` |

---

## 仕入先管理（`SUP`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-SUP-01` | 仕入先一覧表示・検索 | 参照 | 会社名・国で絞り込み、ページ単位に一覧表示する | `SC-SUP-01` | `Suppliers` |
| `FN-SUP-02` | 仕入先詳細照会 | 参照 | 担当者・連絡先・ホームページを表示する | `SC-SUP-02` | `Suppliers` |
| `FN-SUP-03` | 仕入先新規登録 | 登録 | 仕入先を登録する | `SC-SUP-03` | `Suppliers` |
| `FN-SUP-04` | 仕入先編集 | 更新 | 仕入先情報を更新する | `SC-SUP-03` | `Suppliers` |
| `FN-SUP-05` | 仕入先削除 | 削除 | 商品のない仕入先を削除する | `SC-SUP-02` | `Suppliers`, `Products` |
| `FN-SUP-06` | 取扱商品一覧表示 | 参照 | 当該仕入先の商品を在庫数・発注点とあわせて一覧表示する | `SC-SUP-04` | `Products`, `Categories` |
| `FN-SUP-07` | 発注書出力 | 印刷 | 発注候補の商品を対象に、仕入先単位の発注書を印刷用に表示する | `SC-SUP-05` | `Suppliers`, `Products` |

---

## 担当者管理（`EMP`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-EMP-01` | 社員一覧表示・検索 | 参照 | 氏名・役職・上司で絞り込み、ページ単位に一覧表示する | `SC-EMP-01` | `Employees` |
| `FN-EMP-02` | 社員詳細照会 | 参照 | 連絡先・入社日・上司・担当テリトリーを表示する | `SC-EMP-02` | `Employees`, `EmployeeTerritories`, `Territories`, `Region` |
| `FN-EMP-03` | 社員新規登録 | 登録 | 社員を登録する | `SC-EMP-03` | `Employees` |
| `FN-EMP-04` | 社員編集 | 更新 | 社員情報と上司を更新する | `SC-EMP-03` | `Employees` |
| `FN-EMP-05` | 社員削除 | 削除 | 受注と部下のない社員を削除する | `SC-EMP-02` | `Employees`, `EmployeeTerritories`, `SalesTargets` |
| `FN-EMP-06` | 組織ツリー表示 | 参照 | 上司・部下の関係を木構造で表示する | `SC-EMP-04` | `Employees` |
| `FN-EMP-07` | 担当受注・実績表示 | 集計 | 当該社員が担当する受注一覧と売上実績を表示する | `SC-EMP-02` | `Orders`, `Order Details` |
| `FN-EMP-08` | テリトリー割当管理 | 更新 | 社員へのテリトリーの割り当て・解除を行う | `SC-EMP-05` | `EmployeeTerritories`, `Territories`, `Region` |

---

## 配送管理（`SHP`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-SHP-01` | 運送会社一覧表示 | 参照 | 運送会社を一覧表示する | `SC-SHP-01` | `Shippers` |
| `FN-SHP-02` | 運送会社詳細照会 | 参照 | 運送会社の情報を表示する | `SC-SHP-02` | `Shippers` |
| `FN-SHP-03` | 運送会社新規登録 | 登録 | 運送会社を登録する | `SC-SHP-03` | `Shippers` |
| `FN-SHP-04` | 運送会社編集 | 更新 | 運送会社情報を更新する | `SC-SHP-03` | `Shippers` |
| `FN-SHP-05` | 運送会社削除 | 削除 | 受注のない運送会社を削除する | `SC-SHP-02` | `Shippers`, `Orders` |
| `FN-SHP-06` | 出荷ステータス追跡 | 参照 | 未出荷・出荷済・納期遅延の別で受注を追跡表示する | `SC-SHP-04` | `Orders`, `Customers`, `Shippers` |
| `FN-SHP-07` | 配送実績分析 | 集計 | 運送会社別の取扱件数・配送コスト・平均送料・納期遅延率・平均出荷日数、および配送先国別の実績を集計表示する | `SC-SHP-05` | `Orders`, `Shippers` |

---

## 売上分析（`SLS`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-SLS-01` | 売上サマリ表示 | 集計 | 期間を指定し、売上合計・受注件数・平均受注単価を表示する | `SC-SLS-01` | `Orders`, `Order Details` |
| `FN-SLS-02` | 期間別売上推移 | 集計 | 月次・四半期・年次の粒度で売上推移を表示する | `SC-SLS-02` | `Orders`, `Order Details` |
| `FN-SLS-03` | カテゴリ別売上構成 | 集計 | 商品カテゴリ別の売上と構成比を表示する | `SC-SLS-03` | `Orders`, `Order Details`, `Products`, `Categories` |
| `FN-SLS-04` | 国別・地域別売上集計 | 集計 | 出荷先の国別・地域別に売上を集計表示する | `SC-SLS-04` | `Orders`, `Order Details` |
| `FN-SLS-05` | 前年同期比分析 | 集計 | 前年同期の売上との差額と成長率を表示する | `SC-SLS-01`, `SC-SLS-02` | `Orders`, `Order Details` |

---

## 在庫分析（`INV`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-INV-01` | 在庫アラート一覧 | 集計 | 在庫切れ・低在庫の商品を一覧表示する | `SC-INV-01` | `Products`, `Categories`, `Suppliers` |
| `FN-INV-02` | カテゴリ別在庫金額 | 集計 | カテゴリ別の在庫金額と構成比を表示する | `SC-INV-02` | `Products`, `Categories` |
| `FN-INV-03` | 在庫回転率分析 | 集計 | 期間を指定し、商品別の在庫回転率を表示する | `SC-INV-02` | `Products`, `Order Details`, `Orders` |
| `FN-INV-04` | 滞留在庫の可視化 | 集計 | 指定期間に出荷実績がなく在庫がある商品を表示する | `SC-INV-02` | `Products`, `Order Details`, `Orders` |
| `FN-INV-05` | 発注候補一覧 | 集計 | 発注が必要な商品を仕入先とあわせて一覧表示する | `SC-INV-03` | `Products`, `Suppliers` |

---

## パフォーマンス分析（`PRF`）

| 機能 ID | 機能名 | 種別 | 概要 | 関連画面 | 主要テーブル |
| :--- | :--- | :--- | :--- | :--- | :--- |
| `FN-PRF-01` | 担当者別売上ランキング | 集計 | 期間を指定し、売上金額の降順に担当者を順位付けする | `SC-PRF-01` | `Orders`, `Order Details`, `Employees` |
| `FN-PRF-02` | 受注件数・客単価比較 | 集計 | 担当者別の受注件数と客単価を比較表示する | `SC-PRF-01` | `Orders`, `Order Details`, `Employees` |
| `FN-PRF-03` | テリトリー別実績集計 | 集計 | テリトリー別・地域別に実績を集計表示する | `SC-PRF-02` | `Orders`, `Order Details`, `EmployeeTerritories`, `Territories`, `Region` |
| `FN-PRF-04` | 売上目標設定 | 登録／更新 | 担当者別・年月別の売上目標を設定・更新する | `SC-PRF-03` | `SalesTargets`, `Employees` |
| `FN-PRF-05` | 目標進捗トラッキング | 集計 | 目標に対する実績の達成率と進捗を表示する | `SC-PRF-01`, `SC-PRF-02` | `SalesTargets`, `Orders`, `Order Details` |

---

## 集計定義の共通事項

分析系モジュール（`SLS` / `INV` / `PRF`）および集計機能は、次の定義を共通とする。

| 項目 | 定義 |
| :--- | :--- |
| 売上金額 | `Σ (Order Details.UnitPrice × (1 - Discount) × Quantity)`。**送料を含めない** |
| 集計の基準日 | `Orders.OrderDate`（出荷日ではない） |
| 集計対象の受注 | 期間内の全受注（未出荷を含む） |
| 受注件数 | `Orders` の件数（明細行数ではない） |
| 平均受注単価 | `売上金額 ÷ 受注件数` |
| 客単価 | `売上金額 ÷ 受注件数`（担当者別に算出） |
| 期間未指定時 | 直近 12 か月を既定とする |
| 該当データ 0 件 | 空の一覧と「該当するデータがありません。」を表示する（エラーとしない） |
