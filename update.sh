#!/bin/zsh
# サイトを最新版に更新する:
#   sites.json の "source" があるサイトは、~/Downloads/<source>_embedded*.html のうち
#   いちばん新しいファイルを sites.json の "url" の場所にコピーします（noindex を付与）。
#   そのあと commit して push すると、GitHub Pages の同じURLに反映されます。
set -e
cd "${0:A:h}"
python3 -I - sites.json <<'PY'
import json, sys, glob, os
dl = os.path.expanduser("~/Downloads")
tag = '<meta name="robots" content="noindex,nofollow">'
for s in json.load(open(sys.argv[1], encoding="utf-8")):
    src, url = s.get("source"), s.get("url", "")
    if not src or "://" in url:
        continue
    files = glob.glob(os.path.join(dl, f"{src}_embedded*.html"))
    if not files:
        print(f"{s['name']}: Downloads に {src}_embedded*.html がありません"); continue
    newest = max(files, key=os.path.getmtime)
    t = open(newest, encoding="utf-8").read()
    if tag not in t:
        t = t.replace("<head>", "<head>" + tag, 1)
    os.makedirs(os.path.dirname(url) or ".", exist_ok=True)
    open(url, "w", encoding="utf-8").write(t)
    print(f"{s['name']} <- {os.path.basename(newest)}")
PY
if [[ "$1" == "--push" ]]; then
  git add -A sites sites.json
  git diff --cached --quiet && { echo "変更はありません"; exit 0; }
  git commit -m "サイトを最新版に更新"
  git push
fi
