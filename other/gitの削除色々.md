# gitの削除色々

addを取り消す
```
$git rm --cached file名
```

直前のcommitを取り消す。ワーキングツリーの変更はそのまま。
```
$git reset --soft HEAD^
```

直前のcommitを取り消す。ワーキングツリーの変更も取り消す。
```
$git reset --hard HEAD^
```

pushした内容を取り消す
```
$git push -f origin HEAD^:master
```

過去のある時点のcommitまでローカル／リモート共に戻したい
```
$git reset --hard HEAD^//ある時点に戻るまで何度も戻す
$git push origin -f//望みのcommitまで戻ったらリモートにも反映
```