### gem pristineとは
gem pristineとはgemの隠し場所にあるファイルからインストールしたgemを初期状態へ戻す、ことができる。

つまり、gemのcacheを消して元の初期状態としてインストールし直すという意味。

RMagickをインストールしたあと以下のようなエラーがでたので

    WARNING: Nokogiri was built against LibXML version 2.8.0, but has dynamically loaded 2.7.8

    $gem pristine nokogiri

を実行して回避した。
