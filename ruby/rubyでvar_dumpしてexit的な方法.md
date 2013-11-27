# Rubyでvar_dumpしてexitするような方法

オブジェクトをinspectで詳しく表示してraiseでRuntimeError出す。こんな感じ。

```ruby
raise <dumpしたいオブジェクト>.inspect
```

フレームワーク内で使用するなら、以下のようなメソッドをライブラリに定義しておく。

```ruby
def vd(x)
    raise x.inspect
end
```
