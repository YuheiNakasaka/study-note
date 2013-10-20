# rmagickがインストールできないとき

環境:Mac OSX10.8.4

Homebrewにて、ImagaMagick6.8.6-3はすでにインストール済み

# ①PKG_CONFIG_PATHが通ってない

```
export PKG_CONFIG_PATH=/usr/local/lib/pkgconfig
```

# ②.dylibの前に6.Q16があるから正常に読み込まれない

シンボリックリンクで対処

```
$cd /usr/local/Cellar/imagemagick/6.8.6-3/lib/
$ln -s libMagick++-6.Q16.dylib libMagick++.dylib
$ln -s libMagickWand-6.Q16.dylib libMagickWand.dylib
$ln -s libMagickCore-6.Q16.dylib libMagickCore.dylib
```
これでgem install rmagickできるはず