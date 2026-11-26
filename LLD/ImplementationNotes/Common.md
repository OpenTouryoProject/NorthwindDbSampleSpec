# 実装の記録：共通（CMN）

[実装の記録](../ImplementationNotes.md) / [決定記録：共通](../Decisions/Common.md) / [共通仕様](../../HLD/Common.md)

**実装入力ではない**（[読み方](../ImplementationNotes.md#読み方)）。記録した実装：OpenTouryoProject/VerifyCaTddForOT@4a4d362（ブランチ `verify`。2026-11-26）。

## IMP-CMN-01 メッセージ ID

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-CMN-01](../Decisions/Common.md#dec-cmn-01-メッセージの定め方)（メッセージは文言で定め、ID は実装で決める） |
| 実装 | モジュールごとに B層の定数で持つ。受注管理は `ORDTF001`〜`ORDTF008`（[IMP-ORD-X01](./Orders.md#imp-ord-x01-メッセージ-id)）。画面に出すのは文言だけで、ID は出さない |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`MsgId*` の定数） |
| テスト | ID は期待にしていない（文言を期待にする） |

## IMP-CMN-06 共通メッセージ領域に前の知らせがあるときのエラー

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-CMN-06](../Decisions/Common.md)（前の知らせを残すか消すかは定めない） |
| 実装 | 共通メッセージ領域は 1 つの文言だけを持つ。関連チェックのエラー（例：受注日の開始 > 終了）は、前の情報（例：0 件の「該当するデータがありません。」）を**置き換える**。<br>項目単位のエラー（例：日付の形式）は項目の直下に出し、共通メッセージ領域は直前の一覧の状態から作り直す（直前が 0 件なら、情報がもう一度出る）。ケース 1・2・3 とも同じ作り |
| 場所 | ケース 2：`MVC_Sample_Core/MVC_Sample/Controllers/OrdTfController.cs`（`Search`・`ShowError`・`ShowList`） |
| テスト | 期待にしていない（エラーがエラーとして区別されることだけを確かめる） |

## IMP-CMN-07 DB への接続・実行の失敗（ERR-DB）

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-CMN-07](../Decisions/Common.md)（画面での振る舞いは定めない） |
| 実装 | 画面のコード（コントローラ・コードビハインド）は DB の例外を捕まえず、OpenTouryo の基盤の異常終了の処理に任せる（基盤のエラー画面へ移る）。共通仕様 7 節の文言「データベースに接続できませんでした。…」は出さない |
| 場所 | 各画面のコントローラ（例外の処理を書いていない） |
| テスト | 期待にしていない（DB を落とせない） |
