# プロジェクト ポリシー
README.mdを参照

## Git 操作は行わない（状態を変える操作をしない）

**成果物の検収は人が行う。** エージェントは作業結果をワーキング ツリーに残すところまでを担当し、
Git 操作は人が手動で行う。

したがって、指示がない限り次を実行してはならない。

- `git add` / `commit` / `push`（検収前・未レビューの変更を確定・送信しない）
- `git checkout` / `switch` / `branch` / `reset` / `restore` / `stash`（人の作業状態や未保存の作業を壊す）

**参照系は制限しない。** 何を変更したかを正確に報告するために必要なため、次は自由に実行してよい。

- `git status` / `diff`（`--cached` 含む）/ `log` / `show` / `ls-files` / `check-ignore` / `blame`

作業が完了したら**何を変更したかを報告するに留める**。コミットの要否とタイミングは人が判断する。

<!--
  補足（執筆者向け）:
  インストラクションは「文脈」であって強制力を持たない。上記は遵守されやすい書き方に
  しているが、確実に阻止したい場合は仕組み側で塞ぐ必要がある。
    - Claude Code : PreToolUse フックで Bash(git commit:*) 等を deny する
    - 各プロダクト: 同等の機構があればそれを使う
-->


## コンテンツ作成
 （要件定義から詳細設計の）ドキュメント・フォワード作業を行う。

### 作成成果物
作成成果物は以下の通り（参考：[生成AIを活用した設計書のブレークダウン - 開発基盤部会 Wiki](https://dotnetdevelopmentinfrastructure.osscons.jp/index.php?%E7%94%9F%E6%88%90AI%E3%82%92%E6%B4%BB%E7%94%A8%E3%81%97%E3%81%9F%E8%A8%AD%E8%A8%88%E6%9B%B8%E3%81%AE%E3%83%96%E3%83%AC%E3%83%BC%E3%82%AF%E3%83%80%E3%82%A6%E3%83%B3)）。

- [要件定義](./RDD/Home.md)
  - モジュール一覧
  - 各モジュールの詳細

- [基本設計](./HLD/Home.md)：機能要件・画面仕様
  - [機能一覧](./HLD/FeatureList.md)
  - [テーブル一覧](./HLD/TableList.md)
  - [画面一覧](./HLD/UI_List.md)
  - [画面遷移](./HLD/UI_FlowList.md)

- [詳細設計](./LLD/Home.md)
  - [テーブル定義書](./LLD/TableSchema.md)
  - [画面定義書](./LLD/UI_ElementsAndEventList.md)
  - [イベント仕様書](./LLD/EventSpec.md)

※ 実際にコーディング・エージェントに渡すのは詳細設計になる。

### 作成ポイント
- テーブル定義には必要な列やテーブルを足すことは許可する。例えば、Web向けに、楽観排他サポート用のタイムスタンプ列を足す等。
- ただし、ワークテーブル、採番テーブル、変更履歴、論理削除、非同期（印刷）処理、データ・キャッシュ、ドメイン駆動設計（DDD）など、サンプルとして過剰な設計実装はしないこと。
- 詳細設計は、この様な記載レベルで書く：https://raw.githubusercontent.com/OpenTouryoProject/CodingAgentPlayground/refs/heads/main/Copilot/NorthwindWebForms/SPEC1.md
