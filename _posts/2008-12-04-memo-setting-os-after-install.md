---
layout: post
title:  CentOS5をインストールしたあとの設定
date:   2008-12-04 12:00:00 +0900
categories: tech
---

テスト環境にCentOS5をインストールしたあとの、簡単な設定を記録しておきます。

インストール後設定
------------------

以下のパッケージをインストール。

	# yum install yum-fastestmirror
  
yum updateする。

	# yum check-update
	# yum update

さらに以下のパッケージをインストール。

	# yum install which
    # yum install yum-utils
    # yum install ntp
	# yum install man
	# yum install gcc
	# yum install make
	# yum install cvs
	# yum install lynx
	# yum install wget
	# yum install unzip
	# yum install ftp
    
日付設定

	# ntpdate ntp.nict.jp

cronで定期実行

	# vi /etc/cron.daily/ntpdate.cron

以下のファイルを作る

	#!/bin/sh
	/usr/sbin/ntpdate ntp.nict.jp

実行権限の付与

	# chmod 755 /etc/cron.daily/ntpdate.cron

一般ユーザを追加。

	# useradd -m <username>
	# passwd <username>
	New UNIX password: ********
	Retype new UNIX password: ********
	passwd: all authentication tokens updated successfully
	

