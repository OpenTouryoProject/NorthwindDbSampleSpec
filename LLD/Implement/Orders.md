# 実装の記録：受注管理（ORD）

[実装の記録](../Implement.md) / [決定記録：受注管理](../Decisions/Orders.md) / [イベント仕様書](../EventSpec/Orders.md)

**実装入力ではない**（[読み方](../Implement.md#読み方)）。記録した実装：OpenTouryoProject/VerifyCaTddForOT@4a4d362（ブランチ `verify`。2026-11-26）。

- ケース 1（MVC_Sample・net48）とケース 3（WebForms_Sample）は受注一覧（SC-ORD-01）だけを作った。ケース 2（MVC_Sample_Core・net10.0）は SC-ORD-01〜05 を作った。
- B層（`Shared/Business/OrdTfBusiness.cs`）と SQL（`resource/Sql/OrdTf*`）は 3 つのケースで共用する。並べ替え（`EV-ORD-105`）はケース 2 だけ。
- **まだ実装に入っていない決定**：DEC-ORD-24・66（決め直し）、DEC-ORD-27（決め直し。IMP-ORD-27 の実装は合わない）、DEC-ORD-44（補い）と DEC-ORD-73〜78・DEC-CMN-08（ページ番号の入力。2026-11-26 のレビューで決めた）。規約（OpenTouryoCodingAgentAssets の `cmn-framework.md`）の日付の入力（`<input type="date">`）も、まだ入っていない（この版は `type="text"`）。この版の実装は、商品マスタに無い明細を詳細・編集・帳票・出荷の内訳に出さず（`Products` と内部結合）、出荷済の受注も削除でき、在庫超過の警告をほかの行が超えていても消す（IMP-ORD-44）。直す回で、ここも直す。

## 「定めない」とした決定の実装

### IMP-ORD-10 datetime の下限より前の受注日の検索条件

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-10](../Decisions/Orders.md#dec-ord-10-datetime-の下限より前の受注日の検索条件) |
| 実装 | 形式（`yyyy/MM/dd` の存在する日付）の検査だけを行い、下限の検査はしない。値はそのまま SQL のパラメタに渡す。<br>**確かめていない**：`datetime` の範囲外の値で、パラメタの設定か実行で例外になり、基盤のエラー画面へ移る（IMP-CMN-07）と見込む |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`TryParseDate`・`SetConditions`） |
| テスト | 期待にしていない |

### IMP-ORD-11 検証エラーの直後の一覧と、他の利用者による変更

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-11](../Decisions/Orders.md#dec-ord-11-検証エラーの直後の一覧と他の利用者によるデータの変更) |
| 実装 | 「直前の表示」は、**保持した直前の条件・ページで取り直した結果**。検証エラーのとき、直前の条件（ケース 1・2 は hidden の `P*`、ケース 3 は ViewState）で検索し直して一覧を出す。そのため、間に他の利用者が受注を足す・消すと、件数・行が変わる。ケース 1・2・3 とも同じ |
| 場所 | ケース 1・2：`OrdTfController.Search`、ケース 3：`Aspx/OrdTf/OrdTf.aspx.cs` |
| テスト | 期待にしていない |

### IMP-ORD-12 並べ替えで、並べ替えた列の値が同じ行の並び

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-12](../Decisions/Orders.md#dec-ord-12-一覧の並べ替えで並べ替えた列の値が同じ行の並び) |
| 実装 | どの列で並べ替えても、最後のキーを受注 ID の**降順**にする（昇順で並べ替えたときも降順）。ページが重ならず抜けないため。ケース 2 だけ |
| 場所 | `resource/Sql/OrdTfSearch.xml`（`ORDER BY` の `SELECT name="SortKey"`） |
| テスト | 期待にしていない |

### IMP-ORD-13 並べ替える列に NULL があるときの並び

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-13](../Decisions/Orders.md#dec-ord-13-一覧の並べ替えで並べ替える列に-null-があるときの並び) |
| 実装 | SQL Server の既定のまま：昇順で NULL が先頭、降順で末尾。ケース 2 だけ |
| 場所 | `resource/Sql/OrdTfSearch.xml` |
| テスト | 期待にしていない |

### IMP-ORD-18 受注詳細の顧客住所の区切り

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-18](../Decisions/Orders.md#dec-ord-18-受注詳細の顧客住所の区切り)、DEC-ORD-45（編集）、DEC-ORD-65（帳票の宛先） |
| 実装 | 区切りは半角空白。NULL と空白だけの要素を除いて連結する。受注詳細・編集の顧客住所と、帳票の宛先で同じ関数を使う |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`JoinAddress`・`AddressSeparator`） |
| テスト | 要素の順と、空の要素を詰めることだけを期待にする（区切りの文字は期待にしない） |

### IMP-ORD-21 受注 ID の無い・数値でない受注詳細の URL

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-21](../Decisions/Orders.md#dec-ord-21-受注-id-の無い数値でない受注詳細の-url) |
| 実装 | アクションの引数は `int id` で、値が無い・数値でないと 0 になる。受注 0 は無いので `ERR-NOTFOUND` になり、保持された一覧状態で一覧へ戻ってエラーを出す |
| 場所 | `MVC_Sample_Core/MVC_Sample/Controllers/OrdTfController.cs`（`Detail`） |
| テスト | 期待にしていない |

### IMP-ORD-27 状況の判定で、出荷日と要求納期を時刻まで比べるか

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-27](../Decisions/Orders.md#dec-ord-27-状況の判定で出荷日と要求納期を時刻まで比べるか) |
| 実装 | 出荷済：`出荷日 > 要求納期` を**時刻まで**比べる（同じ日でも出荷日の時刻が後なら納期遅延）。<br>未出荷：`要求納期 < 当日`（当日はアプリの日付の 0 時）。要求納期が当日なら、時刻があっても遅延にしない |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`JudgeStatus`） |
| テスト | 期待にしていない（時刻の無いデータだけで確かめる） |

### IMP-ORD-30 受注詳細（登録・編集）の項目単位の検証の文言

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-30](../Decisions/Orders.md#dec-ord-30-受注詳細登録編集の項目単位の検証の文言)、DEC-ORD-56（出荷ダイアログ） |
| 実装 | 項目の直下に出す文言（「〈項目〉は必須です。」の形を基本にした）：<br>・必須：「顧客は必須です。」「担当者は必須です。」「受注日は必須です。」「商品は必須です。」「単価は必須です。」「割引率は必須です。」「数量は必須です。」「出荷日は必須です。」「配送業者は必須です。」<br>・存在：「指定された顧客は存在しません。」「指定された担当者は存在しません。」「指定された配送業者は存在しません。」「指定された商品は存在しません。」<br>・形式：「受注日は yyyy/MM/dd の形式で指定してください。」「要求納期は yyyy/MM/dd の形式で指定してください。」「出荷日は yyyy/MM/dd の形式で指定してください。」<br>・数値：「送料は 0 以上の数値で指定してください。」「単価は 0 以上の数値で指定してください。」「割引率は 0 以上 1 以下の数値で指定してください。」「数量は 1 以上の整数で指定してください。」<br>・桁数：「最大 n 文字で入力してください。」 |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`ValidateSave`・出荷の検証・`CheckLength`） |
| テスト | 期待にしていない（どの項目に違反が出るかを確かめる） |

### IMP-ORD-31 受注日が要求納期より後のときの文言

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-31](../Decisions/Orders.md#dec-ord-31-受注日が要求納期より後のときの文言) |
| 実装 | 「要求納期は受注日以降の日付を指定してください。」（関連チェック。共通メッセージ領域） |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`MsgDateRelation`） |
| テスト | 期待にしていない |

### IMP-ORD-33 出荷先の上書きの確認の文言

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-33](../Decisions/Orders.md#dec-ord-33-出荷先の上書きの確認の文言) |
| 実装 | 「入力済みの出荷先を、選択した顧客の住所で上書きします。よろしいですか？」（ブラウザの `window.confirm`） |
| 場所 | `MVC_Sample_Core/MVC_Sample/Views/OrdTf/Edit.cshtml`（`MSG_OVERWRITE`） |
| テスト | 期待にしていない（確認が出ることと、取り消すと上書きしないことを確かめる） |

### IMP-ORD-38 受注詳細（登録・編集）の数値の上限と小数の桁

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-38](../Decisions/Orders.md#dec-ord-38-受注詳細登録編集の数値の上限と小数の桁)、DEC-ORD-56 ③（出荷ダイアログ） |
| 実装 | 上限は DB の型の範囲：送料・単価は `money` の上限（922337203685477）、数量は `smallint` の上限（32767）、割引率は 1。超えると数値の違反（IMP-ORD-30 の文言）。<br>小数の桁は検査しない（DB の型に渡したときの丸めに任せる。**丸め方は確かめていない**） |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`MaxMoney`・`MaxQuantity`） |
| テスト | 期待にしていない |

### IMP-ORD-41 編集で、廃番商品の行の選択肢に「（廃番）」を付けるか

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-41](../Decisions/Orders.md#dec-ord-41-編集で廃番商品の行の選択肢に廃番を付けるか) |
| 実装 | 付けない。その行の選択肢に、商品マスタの商品名をそのまま足す |
| 場所 | `MVC_Sample_Core/MVC_Sample/Views/OrdTf/Edit.cshtml`（`ProductOptionsFor`） |
| テスト | 期待にしていない |

### IMP-ORD-42 商品の単価が NULL のときの明細の単価の初期値

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-42](../Decisions/Orders.md#dec-ord-42-商品の単価が-null-のときの明細の単価の初期値) |
| 実装 | 単価の欄を空にする。そのまま保存すると「単価は必須です。」 |
| 場所 | `OrdTfController.ProductInfo`（`unitPrice` を空で返す）、`Edit.cshtml`（商品の選択の script） |
| テスト | 期待にしていない |

### IMP-ORD-44 在庫超過の警告（複数の行が超えたとき）

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-44](../Decisions/Orders.md#dec-ord-44-在庫超過の警告の表示先)（この版の実装の時点では、複数の行が超えたときの出し方は定めない。2026-11-26 に「超える行が残る間は消さない」と補った＝この実装は合わない） |
| 実装 | 共通メッセージ領域に「在庫数を超えています。」を 1 つだけ出す（行ごとには出さない）。<br>ある行を在庫以内に直すと、ほかの行がまだ超えていても警告が消える（行を変えるたびに、その行だけで判定するため） |
| 場所 | `MVC_Sample_Core/MVC_Sample/Views/OrdTf/Edit.cshtml`（`checkStock`・`MSG_STOCK`） |
| テスト | 1 行が超えたときの警告だけを期待にする |

### IMP-ORD-47 保存する日付が 1753/01/01 より前のとき

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-47](../Decisions/Orders.md#dec-ord-47-保存する日付が-17530101-より前のとき)、DEC-ORD-56 ④（出荷日） |
| 実装 | 下限の検査はしない（IMP-ORD-10 と同じ）。出荷日は、受注日がある受注なら「出荷日は受注日以降を指定してください。」の検証で先に止まる。<br>**確かめていない**：受注日・要求納期と、受注日が NULL の受注の出荷日は、DB に渡したときに例外になり、基盤のエラー画面へ移ると見込む |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`ValidateSave`・出荷の検証） |
| テスト | 期待にしていない |

### IMP-ORD-49 編集の保存で、読み込み時の明細を名乗るのに DB に無い行

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-49](../Decisions/Orders.md#dec-ord-49-編集の保存で読み込み時の明細を名乗るのに-db-に無い行を受け取ったとき) |
| 実装 | 保存のトランザクションの中で、受注が今持っている明細の商品 ID を DB から読み、画面が送る「読み込み時の商品 ID」と照らす。DB に無い・ほかの行が先に名乗った商品 ID の名乗りは認めず、**新しい行として扱う**（廃番・重複・存在の検査をそのまま当てる）。<br>名乗りは、商品を変えていない行を先に、次に商品を変えた行を前から順に認める。削除の印は、同じ商品の既存の行が残るときは無視する（明細が 0 行にならない） |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`LoadExistingProducts`・`ResolveOrigins`・`UOC_OrdTfSave`） |
| テスト | 検証を外さないことを期待にする（行の扱いは期待にしない） |

### IMP-ORD-54 在庫不足のときの出荷ダイアログの内訳

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-54](../Decisions/Orders.md#dec-ord-54-在庫不足err-bizのときの出荷ダイアログ)（内訳の在庫を最新にするかは定めない） |
| 実装 | 最新にする。エラーのとき、ダイアログの中身（選択肢・内訳・出荷済／未出荷の別）を DB から読み直して組み直し、入力値と保持した行バージョンだけを残す |
| 場所 | `OrdTfController.ShipSave`（`CallShipInit` で読み直す） |
| テスト | 期待にしていない |

### IMP-ORD-56 出荷ダイアログの入力（④⑤）

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-56](../Decisions/Orders.md#dec-ord-56-出荷ダイアログの入力に受注詳細の入力の決定を広げるか) ④（出荷日が 1753/01/01 より前）・⑤（取消の加算で在庫が `smallint` の上限を超える） |
| 実装 | ④は IMP-ORD-47 のとおり。⑤は検査しない。<br>**確かめていない**：⑤は加算の UPDATE で算術のあふれの例外になり、トランザクションがロールバックされて基盤のエラー画面へ移ると見込む |
| 場所 | `resource/Sql/OrdTfShipIncreaseStock.sql`、`Shared/Business/OrdTfBusiness.cs`（`UOC_OrdTfShipCancel`） |
| テスト | 期待にしていない |

### IMP-ORD-61 在庫不足の商品名を列挙するときの区切りと並び

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-61](../Decisions/Orders.md#dec-ord-61-在庫不足の商品名を列挙するときの区切りと並び) |
| 実装 | 「在庫が不足しています：」の後に、商品名を全角の読点「、」で区切って続ける。並びは商品 ID の昇順（内訳の読み込みの並び） |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`DecreaseStock`・`MsgShortSeparator`）、`resource/Sql/OrdTfShipStockLines.sql` |
| テスト | 不足するすべての商品名が含まれることだけを期待にする |

### IMP-ORD-62 在庫が NULL の商品の出荷の確定・取消

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-62](../Decisions/Orders.md#dec-ord-62-在庫unitsinstockが-null-の商品の出荷の確定取消) |
| 実装 | 在庫不足にしない（内訳でも強調しない）。確定・取消のどちらでも、在庫は NULL のまま（NULL への加減算）。商品の行バージョンは +1 する |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`DecreaseStock`）、`resource/Sql/OrdTfShipDecreaseStock.sql`・`OrdTfShipIncreaseStock.sql` |
| テスト | 期待にしていない |

### IMP-ORD-63 受注日が NULL の受注の「受注日 <= 出荷日」

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-63](../Decisions/Orders.md#dec-ord-63-受注日が-null-の受注で出荷日の受注日--出荷日の検証) |
| 実装 | 比べない（違反にしない） |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`UOC_OrdTfShipSave`） |
| テスト | 期待にしていない |

### IMP-ORD-71 受注 ID・帳票種別が要件に違反する帳票の URL

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-71](../Decisions/Orders.md#dec-ord-71-受注-id帳票種別が要件に違反する帳票の-url) |
| 実装 | 受注 ID：IMP-ORD-21 と同じ（0 になり `ERR-NOTFOUND`、一覧へ戻る）。帳票種別：`invoice` 以外（無い・不正）は納品書として出す |
| 場所 | `OrdTfController.Report` |
| テスト | 期待にしていない |

### IMP-ORD-72 帳票の合計の強調表示

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-ORD-72](../Decisions/Orders.md#dec-ord-72-帳票の合計の強調表示) |
| 実装 | 強調しない（受注詳細の合計は `fw-bold`、帳票の合計には付けない） |
| 場所 | `MVC_Sample_Core/MVC_Sample/Views/OrdTf/Report.cshtml` |
| テスト | 期待にしていない（目で見る確認の対象） |

## 仕様の問いにしなかった実装の決定

### IMP-ORD-X01 メッセージ ID

| 項目 | 内容 |
| :--- | :--- |
| 対象 | [DEC-CMN-01](../Decisions/Common.md#dec-cmn-01-メッセージの定め方)・IMP-CMN-01 |
| 実装 | `ORDTF001` 受注日の形式（一覧）・`ORDTF002` 受注日の前後関係（一覧）・`ORDTF003` `ERR-NOTFOUND`・`ORDTF004` `ERR-CONFLICT`・`ORDTF005` 出荷済は編集できない・`ORDTF006` 保存・出荷の検証の違反（文言は最初の違反）・`ORDTF007` 在庫不足・`ORDTF008` 出荷されていない受注の取消 |
| 場所 | `Shared/Business/OrdTfBusiness.cs`（`MsgId*`） |
| テスト | 期待にしていない |

### IMP-ORD-X02 状態の持ち方

| 項目 | 内容 |
| :--- | :--- |
| 対象 | `EV-ORD-102` 手順 5・共通の処理「一覧状態の保持」、各画面の `RowVersion` の保持 |
| 実装 | ・一覧の直前の条件・ページ・並べ替え：ケース 1・2 は hidden（`P*`）、ケース 3 は ViewState。<br>・一覧状態の画面遷移をまたぐ保持（詳細・編集・帳票から戻る）：ケース 2 は Session（JSON）。<br>・行バージョン：hidden（受注詳細・編集・出荷ダイアログ）。編集の明細の読み込み時の値（商品 ID・単価・割引率・数量・商品名）も hidden に持つが、B層は読み込み時の行かどうかを DB で決める（IMP-ORD-49）。出荷ダイアログの「表示時点の出荷済／未出荷の別」も送るが、B層は DB の `ShippedDate` を使う（DEC-ORD-60）。<br>・完了・エラーのメッセージを持って別の画面へ移るとき（保存の完了・削除の完了・出荷済）：TempData（POST の後にリダイレクトする） |
| 場所 | `OrdTfController`（`SaveState`・`TempData`）、各ビューの hidden |
| テスト | 期待にしていない（振る舞いだけを確かめる） |

### IMP-ORD-X03 トランザクション

| 項目 | 内容 |
| :--- | :--- |
| 対象 | 削除・保存・出荷の確定・取消（`EV-ORD-203`・`308`・`402`・`403`） |
| 実装 | 分離レベルはすべて `ReadCommitted`（OpenTouryo の `DoBusinessLogicAsync` に渡す）。業務例外でフレームワークがロールバックする。出荷の確定は、受注の行を更新用に取ってから在庫を検査し、在庫は読んだ値で書き戻さず `UnitsInStock - Quantity` の条件付き更新で引く（検査の後に他の要求が在庫を変えても負にしない） |
| 場所 | `OrdTfController`（`Iso`）、`Shared/Business/OrdTfBusiness.cs`（`LockShipOrder`・`DecreaseStock`） |
| テスト | 件数と結果だけを期待にする |

### IMP-ORD-X04 画面の作り（ケース 2）

| 項目 | 内容 |
| :--- | :--- |
| 対象 | 確認ダイアログ・メッセージの種類・出荷ダイアログ・印刷 |
| 実装 | ・確認ダイアログ：ブラウザの `window.confirm`（削除・出荷の取消・出荷先の上書き・編集のキャンセル）。<br>・メッセージの種類：class で区別する（エラー `text-danger`・警告 `text-warning`・情報 `text-info`）。<br>・出荷ダイアログ：元の画面に重ねる部分ビュー。確定・取消は POST（`ValidateAntiForgeryToken`）。<br>・印刷の除外：帳票のビューの中の `@media print`（共通のレイアウト・CSS は変えない）。印刷は `window.print` を呼ぶだけ |
| 場所 | `MVC_Sample_Core/MVC_Sample/Views/OrdTf/*.cshtml`、`MVC_Sample_Core/MVC_Sample/wwwroot/js/app/ordtf-ship.js`（出荷ダイアログ） |
| テスト | 確認が出ること・class の区別・印刷の媒体で消えることを期待にする（文言は仕様が決めたものだけ） |

### IMP-ORD-X05 テストが固定した契約

| 項目 | 内容 |
| :--- | :--- |
| 対象 | B層の引数・戻り値の形、画面の id・class |
| 実装 | 各回のテスト仕様の 1 章（「テストが固定する契約」）に決めた形で作った。ここには写さない |
| 場所 | VerifyCaTddForOT の `docs/spec/test3-testfirst-OrdTf*-tests.md`（1 章） |
| テスト | 契約そのもの |
