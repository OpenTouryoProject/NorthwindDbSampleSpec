# NorthwindDbSampleSpec
- NorthwindDbを用いたSampleアプリケーションのSpecをコーディング・エージェントでフォワード
- NorthwindDbもMIT提供：
  - https://github.com/microsoft/sql-server-samples/blob/master/license.txt
  - https://github.com/microsoft/sql-server-samples/tree/master/samples/databases/northwind-pubs

## 成果物

| 工程 | 成果物 | 範囲 |
| :--- | :--- | :--- |
| 要件定義 | [RDD/Home.md](./RDD/Home.md) | 全 9 モジュール |
| 基本設計 | [HLD/Home.md](./HLD/Home.md)（[共通仕様](./HLD/Common.md) / [機能一覧](./HLD/FeatureList.md) / [テーブル一覧](./HLD/TableList.md) / [画面一覧](./HLD/UI_List.md) / [画面遷移](./HLD/UI_FlowList.md)） | 全 9 モジュール |
| 詳細設計 | [HLD/LLD.md](./HLD/LLD.md)（[テーブル定義書](./HLD/TableSchema.md) / [画面定義書](./HLD/UI_ElementsAndEventList.md) / [イベント仕様書](./HLD/EventSpec.md)） | テーブル定義書は全 14 テーブル、画面定義書・イベント仕様書は受注管理 |

コーディング・エージェントへ渡すのは[詳細設計](./HLD/LLD.md)。まず[共通仕様](./HLD/Common.md)を読むこと。

## 元ネタ
[開発基盤部会 Wiki > 生成AIを活用した設計書のブレークダウン](https://dotnetdevelopmentinfrastructure.osscons.jp/index.php?%E7%94%9F%E6%88%90AI%E3%82%92%E6%B4%BB%E7%94%A8%E3%81%97%E3%81%9F%E8%A8%AD%E8%A8%88%E6%9B%B8%E3%81%AE%E3%83%96%E3%83%AC%E3%83%BC%E3%82%AF%E3%83%80%E3%82%A6%E3%83%B3)

コレはあくまで当初の出発点なので、分析結果によって最終成果物は左右される。
確定した要件は [RDD/Home.md](./RDD/Home.md) を正とする。

### モジュール一覧

| モジュール | 主要テーブル |
| :--- | :--- |
| **受注管理** | Orders / Order Details |
| **顧客管理** | Customers / Contacts |
| **商品管理** | Products / Categories |
| **仕入先管理** | Suppliers |
| **担当者管理** | Employees |
| **配送管理** | Shippers |
| **売上分析** | Sales Dashboard |
| **在庫分析** | Inventory Alerts |
| **パフォーマンス分析** | Employee Performance |

### 各モジュールの詳細
- **受注管理（Orders / Order Details）**
  - 受注一覧・検索・絞り込み・受注詳細 (明細・小計・送料)
  - ステータス管理 (出荷・配送)
  - 帳票出力 (納品書・請求書)
- **顧客管理（Customers / Contacts）**
  - 顧客一覧・検索 (国・地域別)
  - 顧客詳細・連絡先管理・購買履歴・取引サマリ・顧客ランキング分析
- **商品管理（Products / Categories）**
  - 商品一覧・カテゴリ絞り込み・商品詳細・仕入先情報・在庫数・発注点アラート・廃番 (Discontinued) 管理
- **仕入先管理（Suppliers）**
  - 仕入先一覧・国別フィルタ・担当者・連絡先管理・取扱商品一覧・発注書の生成
- **担当者管理（Employees）**
  - 社員一覧・上司/部下ツリー・担当受注・売上実績・地域テリトリー管理・個人別パフォーマンス
- **配送管理（Shippers）**
  - 運送会社一覧・実績比較・配送コスト・遅延率分析・出荷ステータス追跡・配送先国別の実績集計・分析・ダッシュボード
- **売上分析（Sales Dashboard）**
  - 月次・四半期・年次売上推移・商品カテゴリ別売上比率・国別・地域別売上マップ・前年同期比・成長率
- **在庫分析（Inventory Alerts）**
  - 在庫切れ・低在庫アラート一覧・カテゴリ別在庫金額・回転率・滞留在庫の可視化・自動発注トリガー候補
- **パフォーマンス分析（Employee Performance）**
  - 担当者別売上ランキング・受注件数・客単価の比較・テリトリー別達成率・目標設定・進捗トラッキング
