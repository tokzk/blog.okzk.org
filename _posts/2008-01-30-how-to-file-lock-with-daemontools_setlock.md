---
layout: post
title:  setlockを用いてバッチ処理の排他制御を行う
date:   2008-01-30 12:00:00 +0900
categories: tech
---
setlockを用いてバッチ処理の排他制御を行うための色々を記録しておきます。

daemontools
===========
## ダウンロード
/package ディレクトリが必要なので作成しStickyビットを立てる

    # mkdir -p /package
    # chmod 1755 /package
    
<http://cr.yp.to/daemontools/install.html> から daemontools-0.76.tar.gz をダウンロード

    # cd /package
    # wget http://cr.yp.to/daemontools/daemontools-0.76.tar.gz

## 展開する
    # tar xzvfp ./daemontools-0.76.tar.gz
    # cd admin/daemontools-0.76

## パッチを当てる
<http://qmail.org/moni.csi.hu/pub/glibc-2.3.1/> からパッチ(daemontools-0.76.errno.patch)をダウンロード

    # cd admin/daemontools-0.76
    # wget http://qmail.org/moni.csi.hu/pub/glibc-2.3.1/daemontools-0.76.errno.patch

パッチを当てる。
    
    # patch -p1 < ./daemontools-0.76.errno.patch

## インストールする

    # ./package/install


setlock の実行
==============

setlock を用いて、排他制御を行う。<http://cr.yp.to/daemontools/setlock.html>

    $ /usr/local/bin/setlock -nx /tmp/hoge.lock hogecommand

