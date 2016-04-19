---
layout: post
title:  OpenPNE インストールまでの設定
date:   2008-12-02 12:00:00 +0900
categories: tech
---

OpenPNEインストールまでの設定を記録しておきます。。

## Emacs22のインストール
UTF-8用

	$ wget ftp://ftp.gnu.org/pub/gnu/emacs/emacs-22.2.tar.gz
	$ ./configure --prefix=/usr/local/emacs-22.2
	$ make
	$ su
	# make install

## OpenPNEアカウントの作成

	# useradd -m -s /bin/bash openpne
	# chmod 755 /home/openpne

## PHPのインストール

依存関係のあるもの
	# yum install libxml2-devel.i386
	# yum install libmcrypt-devel.i386
	# yum install gd-devel

	$ wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.12.tar.gz
	$ ./configure
	$ make
	# make install
	# ln -s /usr/local/lib/libiconv.so.2.4.0 /usr/lib/libiconv.so.2

/usr/local/lib をライブラリの検索対象に追加
	$ cat /etc/ld.so.conf
	include ld.so.conf.d/*.conf
	/usr/local/lib
	# /sbin/ldconfig

PHP本体のインストール
	$ wget http://www.php.net/get/php-5.2.6.tar.gz/from/a/mirror
	$ tar xzvf php-5.2.6.tar.gz

	$./configure \
		--with-mysql \
		--enable-mbstring \
		--with-jpeg-dir=/usr/local/lib \
		--with-gd \
		--with-jpeg-dir=/usr \
		--with-zlib-dir=/usr \
		--with-freetype-dir=/usr \
		--with-mcrypt \
		--with-apxs2=/usr/local/apache2/bin/apxs \
		--enable-zend-multibyte \
		--with-iconv=/usr/local 

iconvはディレクトリを指定するとこでエラーが出なくなった。
画像(jpg)関連がOpenPNEでUploadできなかった。
GDのjpeg関連の設定がおかしかったぽいのでオプションを追加した。


	$ make
	$ make test
	# make install
	
	# cp php.ini-dist /usr/local/lib/php.ini


## Apache
ハンドラの追加
    # vi /usr/local/apache2/conf/httpd.conf
    AddHandler application/x-httpd-php .php

VirtualHostの設定

    # vi /usr/local/apache2/conf/extra/httpd-vhosts.conf

	<VirtualHost 10.1.0.22:80>
	    ServerName        xxxx.localnet
	    DocumentRoot      "/home/openpne/work/OpenPNE/public_html"
	    DirectoryIndex    index.html index.php
	    <Directory "/">
	      Options Indexes FollowSymLinks
	      AllowOverride None
	      Order deny,allow
	      Allow from all
	    </Directory>
	</VirtualHost>

Apache2.2のデフォルトはDeny allなので権限ついて変更する

## OpenPNE

	$ wget http://downloads.sourceforge.net/openpne/OpenPNE-2.12.0.tar.gz
	$ work/OpenPNE-2.12.0
	$ ln -s OpenPNE-2.12.0 OpenPNE
	$ cp config.php.sample config.php
	$ chmod -R 0777 var
	
	[openpne@ OpenPNE]$ diff config.php.sample config.php
	7c7
	< define('OPENPNE_URL', 'http://sns.example.com/');
	---
	> define('OPENPNE_URL', 'http://xxxx.localnet/');
	13c13
	<     'username' => '',
	---
	>     'username' => 'openpne',
	16c16
	<     'database' => '',
	---
	>     'database' => 'openpne',
	22c22
	< define('ENCRYPT_KEY', '');
	---
	> define('ENCRYPT_KEY', 'xxxxxxxx');
	26c26
	< define('MAIL_SERVER_DOMAIN', 'mail.example.com');
	---
	> define('MAIL_SERVER_DOMAIN', 'mail.localnet');
	

## MySQLにテーブル作成

	$ mysql -u root -p
	mysql> GRANT ALL PRIVILEGES ON *.* TO 'openpne'@'localhost';
	
	$ mysql -u openpne
	mysql> create database `openpne` default character set utf8;
	
	$ mysql -u openpne --default-character-set=utf8 openpne < setup/sql/mysql41/install/install-2.12-create_tables.sql 
	
	$ mysql -u openpne --default-character-set=utf8 openpne < setup/sql/mysql41/install/install-2.12-insert_data.sql
	

	mysql> GRANT ALL PRIVILEGES ON *.* TO openpne@"%"
    	-> IDENTIFIED BY 'パスワード' WITH GRANT OPTION;
	mysql> GRANT ALL PRIVILEGES ON *.* TO openpne@localhost
	    -> IDENTIFIED BY 'パスワード' WITH GRANT OPTION;
	mysql> FLUSH PRIVILEGES;
