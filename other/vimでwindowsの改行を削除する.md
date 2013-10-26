# vimでwindowsの改行を削除する

```
:e ++ff=unix
:%s/^M//g
```

^Mは<c-v><c-m>で入力
