# MongoDBのインストールと操作

## 環境
MacOSX 10.8.4

## インストール

homebrewで入れる方法もあるが、最新版を入れたいので公式からバイナリでインストールする。

```
$curl -O http://fastdl.mongodb.org/osx/mongodb-osx-x86_64-2.4.6.tgz
$tar xvzf mongodb-osx-x86_64-2.4.6.tgz
```

DBのファイルを格納するディレクトリ作成

```
$mkdir -p data/db
```

DBを起動する。

```
$cd mongodb-osx-x86_64-2.4.6
$./bin/mongod --dbpath=../data/db
.
.
.
~~~~~ connection accepted from 127.0.0.1:59387 #1 (1 connection now open)
```

DBを起動した状態でクライアントから操作してみる。

```
$./bin/mongo
.
.
.
//sampleのDBが作成される
> use sample
switched to db sample
//使用してるDB名
> db
sample
//DBの一覧。sampleはまだデータがないので表示されない。
> show dbs
local	0.078125GB
//データのinsert
> db.test_col.insert({"key":"value1","key2":"value2"})
//データが入ったのでdb一覧に表示された
> show dbs
local	0.078125GB
sample	0.203125GB
//collection(mysqlでいうところのtable)の表示
> show collections
test_col
system.indexes
//データの表示。insertすると自動でユニークなIDがつく
> db.test_col.find()
{ "_id" : ObjectId("525e978ced7421b572ecaadf"), "key" : "value1", "key2" : "value2" }
//さらにデータの追加
> db.test_col.insert({"key3":"value3","key4":"value4"})
//表示確認
> db.test_col.find()
{ "_id" : ObjectId("525e978ced7421b572ecaadf"), "key" : "value1", "key2" : "value2" }
{ "_id" : ObjectId("525e98eded7421b572ecaae0"), "key3" : "value3", "key4" : "value4" }
//簡単な検索
> db.sample_coll.find({"key":"value1"})
{ "_id" : ObjectId("525e978ced7421b572ecaadf"), "key" : "value1", "key2" : "value2" }
//検索用にさらにデータ追加
> db.sample_coll.insert({"key":"value1_1","key4":"value4"})
//keyでvalue1じゃないデータを全て取得
> db.sample_coll.find({"key":{$ne:"value1"}})
{ "_id" : ObjectId("525e98eded7421b572ecaae0"), "key3" : "value3", "key4" : "value4" }
{ "_id" : ObjectId("525e995eed7421b572ecaae1"), "key" : "value1_1", "key4" : "value4" }
//keyでvalue1_1じゃないデータを取得
> db.sample_coll.find({"key":{$ne:"value1_1"}})
{ "_id" : ObjectId("525e978ced7421b572ecaadf"), "key" : "value1", "key2" : "value2" }
{ "_id" : ObjectId("525e98eded7421b572ecaae0"), "key3" : "value3", "key4" : "value4" }
//keyでvalue1_1じゃないデータの最初の１つだけ表示
> db.sample_coll.findOne({"key":{$ne:"value1_1"}})
{
	"_id" : ObjectId("525e978ced7421b572ecaadf"),
	"key" : "value1",
	"key2" : "value2"
}
```




(参考)

- [MongoDBのインストールと基本操作](http://codezine.jp/article/detail/6982)
