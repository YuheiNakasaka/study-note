# svnで間違ったcommitを元に戻す

```
$svn up
$svn merge -r HEAD:戻したいリビジョン番号 ./
$svn commit -m 'Merged HEAD to revision'
```
