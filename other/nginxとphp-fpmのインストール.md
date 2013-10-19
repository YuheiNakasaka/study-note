# nginxとphp-fpmのインストール

環境: CentOS 5.8

## nginx

yumのリポジトリ追加

```
$vim /etc/yum.repo.d/nginx.repo

[nginx]
name=nginx repo
baseurl=http://nginx.org/packages/centos/$releasever/$basearch/
gpgcheck=0
enabled=1
```

インストール

```
$yum install nginx
```

confファイルの設定。serverとlocationのブロックだけはじめは変更すれば良い。fastcgiの設定はlocationで。

```
$vim /etc/nginx/conf.d/default.conf

server {
	listen 80;
	server_name test.com;
	location ~ \.php$ {
	fastcgi_pass   127.0.0.1:9000;
	fastcgi_index  index.php;
	fastcgi_param  SCRIPT_FILENAME  /www/html/test/www$fastcgi_script_name;
	include        fastcgi_params;
	}
}
```

## php-fpm

インストール

```
$vim --enablerepo=remi install php-fpm
```

## 起動

```
$/etc/init.d/php-fpm start
$/etc/init.d/nginx start
```
