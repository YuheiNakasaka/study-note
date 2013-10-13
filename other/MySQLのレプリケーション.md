# MySQLのレプリケーション

## EC2でマスターが既存、スレーブを新たにEC2インスタンスを立ち上げて作成する場合

マスター

- 123.456.789.10
- master
- master_password
- 3306(セキュリティグループで外部からアクセスできるようにする)

スレーブ

- 123.456.789.11
- slave
- slave_password
- 3306(セキュリティグループで外部からアクセスできるようにする)

### masterをコピーして、slaveを作成

- masterのDBをstopしとく
- EC2なのでtarで固めて丸コピとかせず、AMIを作成
- AMIから新規のインスタンスを作成
- EIPを割り当てる

### masterの設定

- masterでスレーブ用の登録を行なう

```
# mysql -u master -p
Enter password
->GRANT REPLICATION SLAVE, REPLICATION CLIENT ON *.* TO slave@"123.456.789.11" IDENTIFIED BY 'slave_password';//パスワードが32文字以上だとエラーになる
->FLUSH PRIVILEGES;
```

- 設定ファイルを編集

```
# mkdir /var/db/repl
# chmod 766 /var/db/repl
# chown mysql:mysql /var/db/repl
# vim /etc/my.cnf
[mysqld]
...
log-bin = /var/db/repl/binary-log
server-id = 1
```

### slaveの設定

- masterを指定

```
# mysql -u slave -p
Enter Password
->CHANGE MASTER TO
  ->MASTER_HOST='123.456.789.10',//masterのDBのあるホスト
  ->MASTER_USER='slave',
  ->MASTER_PASSWORD='slave_password',
  ->MASTER_PORT=3306,
->exit
```

### master→slaveでrestart

```
# /etc/init.d/mysqld restart
```

### 確認

- スレーブが機能しているか確認

```
# mysql -u slave -p
Enter Password
->SHOW SLAVE STATUS \G;
...
Slave_IO_Running: Yes
Slave_SQL_Running: Yes
...
```

どちらもyesじゃないとだめ。もし、NoやConnectingと表示されている場合はエラー。エラーはLast_IO_Errno、Last_IO_Errnoに書いてある。

```
# mysql -u slave -p
Enter Password
->SHOW SLAVE STATUS \G;
...
Last_IO_Errno: 番号
Last_IO_Error: 〜
...
```

番号が1236ならマスターのdumpファイルがないということなので、logの指定方法が間違っている。[参考](http://k-1-ne-jp.blogspot.jp/2012/12/change-master-to-master.html)

番号が1045ならマスターで作成したスレーブユーザーのパスワードが長過ぎるということ。[参考](http://nerdherd.com/archives/524)



### その他参考

- [MySQLの負荷分散の基本、レプリケーションの設定](http://blog.flatlabs.net/20100423_064232/)
- [EC2でMySQL(リージョン間レプリケーション編)](http://memocra.blogspot.jp/2011/08/ec2mysql_16.html)