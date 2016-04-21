---
layout: post
title: Apache + Passenger + Rails で send_file がファイルサイズ0になる時の対処
date: 2013-06-26 18:47:28 +0900
categories: tech
---

send_file でファイルを送信するRailsを通すため大量のメモリが必要になる。
なので x-sendfile を使って、Apacheからファイルを送信するようにする。

## Rails 側の設定

`config/environments/production.rb` の config.action_dispatch.x_sendfile_header をコメントアウトする。

```
# Specifies the header that your server uses for sending files
config.action_dispatch.x_sendfile_header = "X-Sendfile"
```

これだけだと、X-Sendfileを使うようになるが、肝心のApache側が対応していないので、ダウンロードされるファイルのサイズが０になり正しく保存されない。なのでモジュールを入れる必要がある。

## mod_xsendfile for Apache2/Apache2.2 のインストール

<https://tn123.org/mod_xsendfile/> からファイルをダウンロードしコンパイルする。

```
# curl -O https://tn123.org/mod_xsendfile/mod_xsendfile-0.12.tar.gz
# tar xzvf mod_xsendfile-0.12.tar.gz
# cd mod_xsendfile-0.12
# /usr/local/apache2/bin/apxs -cia mod_xsendfile.c
/usr/local/apache2/build/libtool --silent --mode=compile gcc -prefer-pic -m64 -fstack-protector-all  -DLINUX=2 -D_REENTRANT -D_GNU_SOURCE -pthread -I/usr/local/apache2/include  -I/usr/local/apache2/include   -I/usr/local/apache2/include   -c -o mod_xsendfile.lo mod_xsendfile.c &amp;&amp; touch mod_xsendfile.slo
/usr/local/apache2/build/libtool --silent --mode=link gcc -o mod_xsendfile.la  -rpath /usr/local/apache2/modules -module -avoid-version    mod_xsendfile.lo
/usr/local/apache2/build/instdso.sh SH_LIBTOOL='/usr/local/apache2/build/libtool' mod_xsendfile.la /usr/local/apache2/modules
/usr/local/apache2/build/libtool --mode=install cp mod_xsendfile.la /usr/local/apache2/modules/
cp .libs/mod_xsendfile.so /usr/local/apache2/modules/mod_xsendfile.so
cp .libs/mod_xsendfile.lai /usr/local/apache2/modules/mod_xsendfile.la
cp .libs/mod_xsendfile.a /usr/local/apache2/modules/mod_xsendfile.a
chmod 644 /usr/local/apache2/modules/mod_xsendfile.a
ranlib /usr/local/apache2/modules/mod_xsendfile.a
PATH="$PATH:/sbin" ldconfig -n /usr/local/apache2/modules
----------------------------------------------------------------------
Libraries have been installed in:
   /usr/local/apache2/modules

If you ever happen to want to link against installed libraries
in a given directory, LIBDIR, you must either use libtool, and
specify the full pathname of the library, or use the `-LLIBDIR'
flag during linking and do at least one of the following:
   - add LIBDIR to the `LD_LIBRARY_PATH' environment variable
     during execution
   - add LIBDIR to the `LD_RUN_PATH' environment variable
     during linking
   - use the `-Wl,--rpath -Wl,LIBDIR' linker flag
   - have your system administrator add LIBDIR to `/etc/ld.so.conf'

See any operating system documentation about shared libraries for
more information, such as the ld(1) and ld.so(8) manual pages.
----------------------------------------------------------------------
chmod 755 /usr/local/apache2/modules/mod_xsendfile.so
[activating module `xsendfile' in /usr/local/apache2/conf/httpd.conf]
```

## 設定の確認


/usr/local/apache2/conf/httpd.conf に以下が追加されているか確認

```
LoadModule xsendfile_module   /usr/lib64/httpd/modules/mod_xsendfile.so
```

## VertialHost に設定を追加

httpd-ssl.conf or httpd-vhosts.conf に設定を追加する。
XSendFilePath はファイルが置いてある対象のディレクトリを指定。

```
XSendFile on
XSendFilePath /opt/projects/project_name
```

## Apache の再起動

```
# /etc/init.d/httpd configtest
# /etc/init.d/httpd restart
```