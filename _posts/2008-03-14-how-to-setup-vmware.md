---
layout: post
title:  VMWare でテスト環境構築
date:   2008-03-14 12:00:00 +0900
categories: tech
---

VMWareでテスト環境を構築したあとの設定を記録しておきます。

## ダウンロード
<http://register.vmware.com/content/download.html> からダウンロードします。

## インストール
カスタムインストールして vmware server のみチェック。

## イメージのダウンロード
<http://www.thoughtpolice.co.uk/vmware/> からDebian Etch minimal をダウンロード

torrent downloads の設定してない場合は、Opera で落とす。
イメージのzip を展開し、ディレクトリごと、C:\Virtual Machines\ にコピーする。

## VMWareの起動
レジストレーションコードを取得して、入力する必要あり。
<http://register.vmware.com/content/registration.html>

## Linuxの設定
root, notroot アカウントがあり、パスワードは thoughtpolice

  - passwd root #パスワードの変更
  - useradd -D -s /bin/bash  #デフォルトのシェルをbashに
  - dpkg-reconfigure console-data # キーボード設定。
  - dpkg-reconfigure locales #ロケールのインストール `ja_JP.EUC-JP`, `ja_JP.UTF-8` を追加、デフォルトを`ja_JP.EUC-JP`に
  - aptitude update # aptitude リスト更新
  - aptitude upgrade # システムの安全なアップグレード
  - aptitude install openssh-server # OpenSSH のインストール
  - /etc/init.d/ssh start # OpenSSHd の起動
  - useradd -m -p xxxxxxxx &lt;username&gt; # &lt;username&gt; をパスワードxxxxxxxx で追加。

これでSSHクライアントからゲストサーバにログインできる。

  - aptitude install gcc
  - aptitude install make
  - aptitude install libreadline5-dev
  - aptitude install zlib1g-dev
  - aptitude install emacs 
  - aptitude install patch
  - aptitude install cvs
  - aptitude install unzip
  - aptitude install lynx
  - aptitude install ncftp
  - aptitude install ftp

## CPANの設定
適当にEnterですすめる。ftp.perl.orgに繋がらなかったらCtrl-Cで止めると
他のサイトを聞かれるのでkddilabsとかミラーを入力する。

    Please enter your CPAN site: [] ftp://ftp.kddilabs.jp/CPAN/

    $ perl -MCPAN -e shell

    > install Bundle::CPAN
