# backbone.js

![構成](http://appkitbox.com/appkitbox/wp-content/uploads/2013/03/ID003_backbone-500x281.jpg "backbone.jsの構成")

## Model

- modelはデータをセットする
- データをリスト化して複数保持

## collection

- modelを引き渡す
- modelを操作する
- cidかidで操作
- get,add,remove基本
- underscore系譜の便利関数(eachとかmap,fileter,find,where,reduce,pluckとか)
    - [参考](http://backbonejs.org/#Collection)

## view

- modelのデータをバインドする
- templateを作成もしくはhtmlから取得
- renderでmodelのデータをバインド
- viewにeventを仕込む。セレクタ指定化。
- htmlにappend
- eventsに設定されたアクションを定義

### event

- htmlでのイベントを取得し、アクションを決める

## 他

- underscorejsの便利関数を多用する
- initializeとeventsが似てて役割がわかりづらい
