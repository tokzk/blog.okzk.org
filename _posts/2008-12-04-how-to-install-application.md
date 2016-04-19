---
layout: post
title:  アプリケーションのインストール
date:   2008-12-04 12:00:00 +0900
categories: tech
---

テスト環境構築後の各種ソフトウェアのインストールメモを記録しておきます。

## 各種ソフトウエアのインストール


### Emacs22のインストール
 
	$ wget ftp://ftp.gnu.org/pub/gnu/emacs/emacs-22.2.tar.gz
	$ ./configure --prefix=/usr/local \
 	              --build=i386-pc-linux-gnu \
                  --mandir=/usr/local/share/man \
                  --with-x

	$ make
	# make install

### Anthyのインストール

    http://sourceforge.jp/projects/anthy/

展開する。

    $ ./configure
	$ make
	# make install

### Apache


実行ユーザ/グループの作成

	# /usr/sbin/groupadd -g 80 www
	# /usr/sbin/useradd -d /dev/null -u 80 -g 80  -s /sbin/nologin www

ダウンロード

	$ wget http://ftp.riken.jp/net/apache/httpd/httpd-2.2.10.tar.gz
	$ tar xzvf httpd-2.2.10.tar.gz

	# yum install openssl-devel

config とコンパイル

	$ ./configure --prefix=/usr/local/apache2 \
                  --build=i386-pc-linux \
                  --localstatedir=/var \
                  --enable-so \
                  --enable-ssl \
                  --enable-usertrack \
                  --enable-rewrite \
                  --enable-proxy \
                  --enable-proxy_ajp \
                  --enable-proxy_balancer

インストール前にスーパユーザで以下の作業を行なう。

	# cd /usr/local/
	# mkdir apache2.2.10
	# ln -s ./apache2.2.10 ./apache2

pid ファイルは /var/run/httpd.pid に配置するようにhttpd.confを変更しました。


## PHPのインストール
 
### 依存関係のあるもの

下記パッケージを予めインストールしておく。

	# yum install libxml2-devel.i386
	# yum install libmcrypt-devel.i386
	# yum install libjpeg-devel.i386
	# yum install gd-devel.i386
	# yum install mysql-devel

ダウンロード

	$ wget http://ftp.gnu.org/pub/gnu/libiconv/libiconv-1.12.tar.gz

config のオプション

	$ ./configure --prefix=/usr/local \
                  --build=i386-pc-linux \
                  --mandir=/usr/local/share/man \
                  --disable-nls \
                  --with-libiconv-prefix=/usr/local \
                  --enable-shared --enable-static --with-pic


	$ make
	# make install

/usr/local/lib をライブラリの検索対象に追加

    # echo "/usr/local/lib" > /etc/ld.so.conf.d/local.conf
    # /sbin/ldconfig -v


### PHP本体のインストール

ダウンロード

 	$ wget http://jp.php.net/get/php-5.2.9.tar.gz/from/this/mirror
	$ tar xzvf php-5.2.9.tar.gz

config のオプション

 ※ --with-gd より --with-jpeg を先に指定すること。そうしないと
    jpeg 未サポートになるとのこと。

    $ ./configure --prefix=/usr/local \
                  --sysconfdir=/etc \
                  --with-mysql \
                  --with-jpeg-dir=/usr \
                  --enable-mbstring \
                  --with-gd \
                  --with-zlib-dir=/usr \
                  --with-freetype-dir=/usr \
                  --with-mcrypt \
                  --with-apxs2=/usr/local/apache2/bin/apxs \
                  --enable-zend-multibyte \
                  --with-iconv=/usr/local \
                  --enable-shared --enable-static --with-pic

 	$ make
 	$ make test
 	# make install

 	# cp php.ini-dist /usr/local/lib/php.ini


## パッケージでインストールしたソフトウエア

    $ /bin/rpm -qa
    で一覧が表示されます。

