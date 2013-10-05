### DLL(ダイナミックリンクライブラリ)とは
複数プログラムから共通で利用できるように様々な機能をプログラムから分離させた共有ライブラリのこと。

windowsだと.dllのやつ。Unix系では/usr/libや/usr/local/lib以下にある。.soのファイルがそれ。

ImageMagickを使う時のlibMagickWand.soとかがそれ。

ちなみにCentOS6.3でImageMagickを使用するときに/etc/ld.so.confに/usr/local/libを追加しないとDLLが読み込めずエラーになる。
