# MS-Japan Agent TOP デザイン案

GitHub Pages: https://myoneyama-svg.github.io/MS-Japan-Agent-TOP/

上部のタブでサイトを切り替えて確認できます。各タブの「別タブで開く」で単体ページを開けます。

## サイトを追加する

`sites.json` に名前とURLを1行追加するだけです。

```json
{ "name": "新しいサイト", "url": "new-site.html" }
```

- `url` はこのリポジトリ内のファイル名（例: `xxx.html`）でも、外部URLでもかまいません。
- 外部サイトで埋め込み表示ができない場合は `"embed": false` を付けると、「別タブで開く」ボタンだけを表示します。

## サイトを最新版に更新する

`sites.json` の `url` と同じファイル名で上書きして push すると、同じURLに反映されます。
Mac から更新する場合は、Downloads に最新版を保存してから次を実行します（`sites.json` の `source` で対象ファイルを判定）。

```bash
./update.sh --push
```
